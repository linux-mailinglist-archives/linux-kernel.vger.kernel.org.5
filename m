Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A7F7ABC7C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 02:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjIWAFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 20:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjIWAFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 20:05:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857C51A5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 17:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695427497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nRQ3+p4XcET1bcqGNVOLqwdH4/wR+jQ5PPEPDi382mU=;
        b=RhVCi26TMQb+smv4eQ8tK4f1JcbnVUGlWLQsXn1RcjqCYpnwV5m/8I+nNe7wENUgoas7X5
        0X8wmeb2gdS3NS67F+ci4MCv1zgA9mb3o693PkUueonq3JfvWlV83wwEQWEqLwvmg2618D
        wvVsGB2UjrpXgg6QvBKUF3NMzjccqpQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-GS7LEWNiP8ihW9ffbmUtzg-1; Fri, 22 Sep 2023 20:04:54 -0400
X-MC-Unique: GS7LEWNiP8ihW9ffbmUtzg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99C54801779;
        Sat, 23 Sep 2023 00:04:53 +0000 (UTC)
Received: from localhost (unknown [10.72.112.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BF08851E3;
        Sat, 23 Sep 2023 00:04:52 +0000 (UTC)
Date:   Sat, 23 Sep 2023 08:04:49 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, vgoyal@redhat.com, dyoung@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kexec: change locking mechanism to a mutex
Message-ID: <ZQ4rofBmfl/dn3x5@MiWiFi-R3L-srv>
References: <20230921215938.2192-1-eric.devolder@oracle.com>
 <xhsmh7coiuq8z.mognet@vschneid.remote.csb>
 <0ec5f56e-6b55-627a-39c0-ff0a1680794d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ec5f56e-6b55-627a-39c0-ff0a1680794d@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22/23 at 12:35pm, Eric DeVolder wrote:
> 
> 
> On 9/22/23 11:28, Valentin Schneider wrote:
> > On 21/09/23 17:59, Eric DeVolder wrote:
> > > The design decision to use the atomic lock is described in the comment
> > > from kexec_internal.h, cited above. However, examining the code of
> > > __crash_kexec():
> > > 
> > >          if (kexec_trylock()) {
> > >                  if (kexec_crash_image) {
> > >                          ...
> > >                  }
> > >                  kexec_unlock();
> > >          }
> > > 
> > > reveals that the use of kexec_trylock() here is actually a "best effort"
> > > due to the atomic lock.  This atomic lock, prior to crash hotplug,
> > > would almost always be assured (another kexec syscall could hold the lock
> > > and prevent this, but that is about it).
> > > 
> > > So at the point where the capture kernel would be invoked, if the lock
> > > is not obtained, then kdump doesn't occur.
> > > 
> > > It is possible to instead use a mutex with proper waiting, and utilize
> > > mutex_trylock() as the "best effort" in __crash_kexec(). The use of a
> > > mutex then avoids all the lock acquisition problems that were revealed
> > > by the crash hotplug activity.
> > > 
> > 
> > @Dave thanks for the Cc, I'd have missed this otherwise.
> > 
> > 
> > Prior to the atomic thingie, we actually had a mutex and did
> > mutex_trylock() in __crash_kexec(). I'm a bit confused as this looks like a
> > revert of
> >    05c6257433b7 ("panic, kexec: make __crash_kexec() NMI safe")
> > with just the helpers kept in - this doesn't seem to address any of the
> > original issues regarding NMIs?
> > 
> > Sebastian raised some good points in [1] regarding these issues.
> > The main hurdle pointed out there is, if we end up in the slowpath during
> > the unlock, then we can can up acquiring the ->wait_lock which isn't NMI
> > safe.
> > 
> > This is even worse on PREEMPT_RT, as both trylock and the unlock can end up
> > acquiring the ->wait_lock.
> > 
> > [1]: https://lore.kernel.org/all/YqyZ%2FUf14qkYtMDX@linutronix.de/
> > 
> Having reviewed the references, it would seem that Baoquan's approach of a new
> lock to handle the hotplug activity is the way to go?

If so, I have posted a formal one. It's simple and should work to fix
the issue.

