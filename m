Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6DB77C953
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 10:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbjHOIYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 04:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbjHOIYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 04:24:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B04C19A0;
        Tue, 15 Aug 2023 01:24:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9521E646C8;
        Tue, 15 Aug 2023 08:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB635C433C8;
        Tue, 15 Aug 2023 08:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692087838;
        bh=KEp2FbOOXG08Ft9zPTOFA2Xdae/efXZsOWxYJhsLCBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IBUHbe5sbcFaC3XMCwpnUV3kZFE3f2iRuUndRsvdig8Kugli3fG5OOxjfNWkVn3F9
         jIzCAcRnJzWNUNTce/Gra2+OLCAEKGqx+fbrl/gLpR2Z+aDJiUzjfa31Wp9FIoHZ/6
         STqQLnJic45oSQJOxvzhL6ljM4THwhhdYTXlqZ7aIiJBdEseloFfvw0SbA5tSAW6bw
         SDAkbYvvEbW02BuCwGSvD5nC5tI8xtAdOw1qPldksYU13O3CYo+Owscen6resQbZTJ
         iYNsX7x1s3W57Z95HoNnhg+BUvPCJOsUC7F2LLzBUKyTkac8UB8d5qgtcU0pOH2HXa
         rB2GeBgWvPxUw==
Date:   Tue, 15 Aug 2023 10:23:53 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Franklin =?utf-8?B?4oCcU25haXBl4oCd?= Mathieu <snaipe@arista.com>
Cc:     Hugh Dickins <hughd@google.com>, ovt@google.com, corbet@lwn.net,
        akpm@linux-foundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] shmem: add support for user extended attributes
Message-ID: <20230815-sensibel-weltumsegelung-6593f2195293@brauner>
References: <9b8d38f0-fd22-3f98-d070-16baf976ecb5@google.com>
 <20230814082339.2006418-1-snaipe@arista.com>
 <986c412c-669a-43fe-d72a-9e81bca8211@google.com>
 <CAK8sBDM5aid1vkCKhBxqUHXrG_FbDRN0noLtPkcPv=jXb7NTNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8sBDM5aid1vkCKhBxqUHXrG_FbDRN0noLtPkcPv=jXb7NTNg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 09:46:22AM +0200, Franklin “Snaipe” Mathieu wrote:
> On Tue, Aug 15, 2023 at 5:52 AM Hugh Dickins <hughd@google.com> wrote:
> >
> > Thanks for the encouragement.  At the time that I wrote that (20 July)
> > I did not expect to get around to it for months.  But there happens to
> > have been various VFS-involving works going on in mm/shmem.c recently,
> > targeting v6.6: which caused me to rearrange priorities, and join the
> > party with tmpfs user xattrs, see
> >
> > https://lore.kernel.org/linux-fsdevel/e92a4d33-f97-7c84-95ad-4fed8e84608c@google.com/
> >
> > Which Christian Brauner quickly put into his vfs.git (vfs.tmpfs branch):
> > so unless something goes horribly wrong, you can expect them in v6.6.
> 
> That's great to hear, thanks!
> 
> > There's a lot that you wrote above which I have no understanding of
> > whatsoever (why would user xattrs stop rmdir failing?? it's okay, don't
> > try to educate me, I don't need to know, I'm just glad if they help you).
> >
> > Though your mention of "unprivileged" does make me shiver a little:
> > Christian will understand the implications when I do not, but I wonder
> > if my effort to limit the memory usage of user xattrs to "inode space"
> > can be be undermined by unprivileged mounts with unlimited (or default,
> > that's bad enough) nr_inodes.
> >
> > If so, that won't endanger the tmpfs user xattrs implementation, since
> > the problem would already go beyond those: can an unprivileged mount of
> > tmpfs allow its user to gobble up much more memory than is good for the
> > rest of the system?
> 
> I don't actually know; I'm no expert in that area. That said, these
> tmpfses are themselves attached to an unprivileged mount namespace, so
> it would certainly be my assumption that in the case of an OOM
> condition, the OOM killer would keep trying to kill processes in that
> mount namespace until nothing else references it and all tmpfs mounts
> can be reclaimed, but then again, that's only my assumption and not
> necessarily reality.
> 
> That said, I got curious and decided to experiment; I booted a kernel
> in a VM with 1GiB of memory and ran the following commands:
> 
>     $ unshare -Umfr bash
>     # mount -t tmpfs tmp /mnt -o size=1g
>     # dd if=/dev/urandom of=/mnt/oversize bs=1M count=1000
> 
> After about a second, the OOM killer woke up and killed bash then dd,
> causing the mount namespace to be collected (and with it the tmpfs).
> So far, so good.
> 
> I got suspicious that what I was seeing was that these were the only
> reasonable candidates for the OOM killer, because there were no other
> processes in that VM besides them & init, so I modified slightly the
> experiment:
> 
>     $ dd if=/dev/zero of=/dev/null bs=10M count=10000000000 &
>     $ unshare -Umfr bash
>     # mount -t tmpfs tmp /mnt -o size=1g
>     # dd if=/dev/urandom of=/mnt/oversize bs=1M count=1000
> 
> The intent being that the first dd would have a larger footprint than
> the second because of the large block size, yet it shouldn't be killed
> if the tmpfs usage was accounted for in processes in the mount
> namespace. What happened however is that both the outer dd and the
> outer shell got terminated, causing init to exit and with it the VM.
> 
> So, it's likely that there's some more work to do in that area; I'd
> certainly expect the OOM killer to take the overall memory footprint
> of mount namespaces into account when selecting which processes to
> kill. It's also possible my experiment was flawed and not
> representative of a real-life scenario, as I clearly have interacted
> with misbehaving containers before, which got killed when they wrote
> too much to tmpfs. But then again, my experiment also didn't take
> memory cgroups into account.

So mount namespaces are orthogonal to that and they would be the wrong
layer to handle this.

Note that an unprivileged user (regular or via containers) on the system
can just exhaust all memory in various ways. Ultimately the container or
user would likely be taken down by in-kernel OOM or systemd-oomd or
similar tools under memory pressure.

Of course, all that means is that untrusted workloads need to have
cgroup memory limits. That also limits tmpfs instances and prevents
unprivileged user from using all memory.

If you don't set a memory limit then yes, the container might be able to
exhaust all memory but that's a bug in the container runtime. Also, at
some point the OOM killer or related userspace tools will select the
container init process for termination at which point all the namespaces
and mounts go away. That's probably what you experience as misbehaving
containers. The real bug there is probably that they're allowed to run
without memory limits in the first place.
