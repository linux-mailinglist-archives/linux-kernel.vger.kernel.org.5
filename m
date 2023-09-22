Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0E17AA625
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 02:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjIVAgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 20:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjIVAgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 20:36:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD6E114
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 17:36:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B58CC433C8;
        Fri, 22 Sep 2023 00:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1695342412;
        bh=kfFmrRzad/TqOSvNuoiBiDpy6r9bqNBbz7/tgMVKhUQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UjGCycgtL1VEO5i1HTKdbjPQnuvU4q6PO640E68jPSQHG3rN8G05h0tNLxjCI8XIo
         4iVo553ITeqavUDKbB2XEeYuvWGbmHX1iWNm4ariIoLFDi8B6DYiUEPxvV0fUEQLvg
         YnD8Xn6AcJ0mDL5cLz7bE/4ODJS1/iiuC6AhVpZU=
Date:   Thu, 21 Sep 2023 17:26:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, ebiederm@xmission.com,
        kexec@lists.infradead.org, sourabhjain@linux.ibm.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH] kexec: change locking mechanism to a mutex
Message-Id: <20230921172650.aeacc5de4f45d13e5671d7b2@linux-foundation.org>
In-Reply-To: <20230921215938.2192-1-eric.devolder@oracle.com>
References: <20230921215938.2192-1-eric.devolder@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2023 17:59:38 -0400 Eric DeVolder <eric.devolder@oracle.com> wrote:

> Scaled up testing has revealed that the kexec_trylock()
> implementation leads to failures within the crash hotplug
> infrastructure due to the inability to acquire the lock,
> specifically the message:
> 
>  crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> 
> When hotplug events occur, the crash hotplug infrastructure first
> attempts to obtain the lock via the kexec_trylock(). However, the
> implementation either acquires the lock, or fails and returns; there
> is no waiting on the lock. Here is the comment/explanation from
> kernel/kexec_internal.h:kexec_trylock():
> 
>  * Whatever is used to serialize accesses to the kexec_crash_image needs to be
>  * NMI safe, as __crash_kexec() can happen during nmi_panic(), so here we use a
>  * "simple" atomic variable that is acquired with a cmpxchg().
> 
> While this in theory can happen for either CPU or memory hoptlug,
> this problem is most prone to occur for memory hotplug.
> 
> When memory is hot plugged, the memory is converted into smaller
> 128MiB memblocks (typically). As each memblock is processed, a
> kernel thread and a udev event thread are created. The udev thread
> tries for the lock via the reading of the sysfs node
> /sys/devices/system/memory/crash_hotplug node, and the kernel
> worker thread tries for the lock upon entering the crash hotplug
> infrastructure.
> 
> These threads then compete for the kexec lock.
> 
> For example, a 1GiB DIMM is converted into 8 memblocks, each
> spawning two threads for a total of 16 threads that create a small
> "swarm" all trying to acquire the lock. The larger the DIMM, the
> more the memblocks and the larger the swarm.
> 
> At the root of the problem is the atomic lock behind kexec_trylock();
> it works well for low lock traffic; ie loading/unloading a capture
> kernel, things that happen basically once. But with the introduction
> of crash hotplug, the traffic through the lock increases significantly,
> and more importantly in bursts occurring at roughly the same time. Thus
> there is a need to wait on the lock.
> 
> A possible workaround is to simply retry the lock, say up to N times.
> There is, of course, the problem of determining a value of N that works for
> all implementations, and for all the other call sites of kexec_trylock().
> Not ideal.
> 
> The design decision to use the atomic lock is described in the comment
> from kexec_internal.h, cited above. However, examining the code of
> __crash_kexec():
> 
>         if (kexec_trylock()) {
>                 if (kexec_crash_image) {
>                         ...
>                 }
>                 kexec_unlock();
>         }
> 
> reveals that the use of kexec_trylock() here is actually a "best effort"
> due to the atomic lock.  This atomic lock, prior to crash hotplug,
> would almost always be assured (another kexec syscall could hold the lock
> and prevent this, but that is about it).
> 
> So at the point where the capture kernel would be invoked, if the lock
> is not obtained, then kdump doesn't occur.
> 
> It is possible to instead use a mutex with proper waiting, and utilize
> mutex_trylock() as the "best effort" in __crash_kexec(). The use of a
> mutex then avoids all the lock acquisition problems that were revealed
> by the crash hotplug activity.
> 
> Convert the atomic lock to a mutex.
> 
> ...
>
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -47,7 +47,7 @@
>  #include <crypto/hash.h>
>  #include "kexec_internal.h"
>  
> -atomic_t __kexec_lock = ATOMIC_INIT(0);
> +DEFINE_MUTEX(__kexec_lock);
>  
>  /* Flag to indicate we are going to kexec a new kernel */
>  bool kexec_in_progress = false;
> @@ -1057,7 +1057,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
>  	 * of memory the xchg(&kexec_crash_image) would be
>  	 * sufficient.  But since I reuse the memory...
>  	 */
> -	if (kexec_trylock()) {
> +	if (mutex_trylock(&__kexec_lock)) {
>  		if (kexec_crash_image) {
>  			struct pt_regs fixed_regs;

What's happening here?  If someone else held the lock we silently fail
to run the kexec?  Shouldn't we at least alert the user to what just
happened?


