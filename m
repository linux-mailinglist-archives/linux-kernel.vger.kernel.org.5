Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE828052DC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344863AbjLEL3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjLEL3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:29:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D5ED4C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:29:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363CFC433C8;
        Tue,  5 Dec 2023 11:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701775789;
        bh=OGNuzQBG9/CRjR8NodZoOr3c55TMx5WozGpVBqt1EtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rJ6pdTtWfZILatWslgp2ufMMTUx2ifvZIvE47lAurG9qt1aV/veDgkPgtQ0y2XoJe
         r7f1tk8sjry9Bt2w7prfFyXPJkf2rkYUU79WDGO8WWaNCMSwqpTr7xj9dVOxF8ufjO
         Qhls3lUFZFNLd7tr+wAx0ziuxx40N++l3bqs9twoClXjV19gvrxE8AFnNvryD7/3Fm
         zKWzSnHYHEaKlgRZD0FqQaNeso7rItXsdNKV5Kz/Vm/8r7k6PkxYN4qDyuk8kl1EX2
         FdVkrBhZ9JqQqGw7Cf5eqwWl1Y9/hi+weNLBWlGsdcwGfGML8sBU+Xb13AdxyDGE0k
         cxF6+fvH+m5LA==
Date:   Tue, 5 Dec 2023 12:29:43 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] Allow a kthread to declare that it calls
 task_work_run()
Message-ID: <20231205-liedtexte-quantenphysik-804eab7f97d8@brauner>
References: <20231204014042.6754-1-neilb@suse.de>
 <20231204014042.6754-2-neilb@suse.de>
 <ZW7GKku/F2QK9MrC@dread.disaster.area>
 <170176610023.7109.11175368186869568821@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <170176610023.7109.11175368186869568821@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 07:48:20PM +1100, NeilBrown wrote:
> On Tue, 05 Dec 2023, Dave Chinner wrote:
> > On Mon, Dec 04, 2023 at 12:36:41PM +1100, NeilBrown wrote:
> > > User-space processes always call task_work_run() as needed when
> > > returning from a system call.  Kernel-threads generally do not.
> > > Because of this some work that is best run in the task_works context
> > > (guaranteed that no locks are held) cannot be queued to task_works from
> > > kernel threads and so are queued to a (single) work_time to be managed
> > > on a work queue.
> > > 
> > > This means that any cost for doing the work is not imposed on the kernel
> > > thread, and importantly excessive amounts of work cannot apply
> > > back-pressure to reduce the amount of new work queued.
> > > 
> > > I have evidence from a customer site when nfsd (which runs as kernel
> > > threads) is being asked to modify many millions of files which causes
> > > sufficient memory pressure that some cache (in XFS I think) gets cleaned
> > > earlier than would be ideal.  When __dput (from the workqueue) calls
> > > __dentry_kill, xfs_fs_destroy_inode() needs to synchronously read back
> > > previously cached info from storage.
> > 
> > We fixed that specific XFS problem in 5.9.
> > 
> > https://lore.kernel.org/linux-xfs/20200622081605.1818434-1-david@fromorbit.com/
> 
> Good to know - thanks.
> 
> > 
> > Can you reproduce these issues on a current TOT kernel?
> 
> I haven't tried.  I don't know if I know enough details of the work load
> to attempt it.
> 
> > 
> > If not, there's no bugs to fix in the upstream kernel. If you can,
> > then we've got more XFS issues to work through and fix. 
> > 
> > Fundamentally, though, we should not be papering over an XFS issue
> > by changing how core task_work infrastructure is used. So let's deal
> > with the XFS issue first....
> 
> I disagree.  This customer experience has demonstrated both a bug in XFS
> and bug in the interaction between fput, task_work, and nfsd.
> 
> If a bug in a filesystem that only causes a modest performance impact
> when used through the syscall API can bring the system to its knees
> through memory exhaustion when used by nfsd, then that is a robustness
> issue for nfsd.
> 
> I want to fix that robustness issue so that unusual behaviour in
> filesystems does not cause out-of-proportion bad behaviour in nfsd.
> 
> I highlighted this in the cover letter to the first version of my patch:
> 
> https://lore.kernel.org/all/170112272125.7109.6245462722883333440@noble.neil.brown.name/
> 
>   While this might point to a problem with the filesystem not handling the
>   final close efficiently, such problems should only hurt throughput, not
>   lead to memory exhaustion.

I'm still confused about this memory exhaustion claim?
If this is a filesystem problem it's pretty annoying that we have to
work around it by exposing task work to random modules.
