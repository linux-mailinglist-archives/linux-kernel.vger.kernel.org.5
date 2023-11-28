Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36ED7FC178
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344810AbjK1Nvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344720AbjK1Nvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:51:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B44A1B9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 05:51:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9031C433C7;
        Tue, 28 Nov 2023 13:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701179517;
        bh=rRHGMp9xXOAGGVSwGEsG0ggDC2+rM4ak/KiHR+RJz6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OGHKluY9aEh9DLcNCDsk9AcqCzGUsloN7wkWESGS0oUMS7ZhqFgbIoY8awX6Z0xIv
         tq1mFJnetfJHZlM1woL46zq7RxuTtTEfABXMq0wX4k7zNK4wxxYIZXHJptmN5/P96S
         K7Bl37s9DDkpYp6LsfZuY7w0XBkx2d8BbkUl+l+Y0dWJaqTtolv3oAmr56X8YkOE5l
         7dAutAj0ljiaezGnoGbcWOKC6K7fD+MCK4QAvI9FeEXD5wkiU60gVDgz5TNUfnvJEy
         yN6LpP3zYTBTPeglF0ci0ZRg0gQb7X/Y76N//J3s9HxuteiEVwJBuW693R5Gx3Tz02
         3AFAMQXy/5kKA==
Date:   Tue, 28 Nov 2023 14:51:52 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH/RFC] core/nfsd: allow kernel threads to use task_work.
Message-ID: <20231128-blumig-anreichern-b9d8d1dc49b3@brauner>
References: <170112272125.7109.6245462722883333440@noble.neil.brown.name>
 <ZWUfNyO6OG/+aFuo@tissot.1015granger.net>
 <170113056683.7109.13851405274459689039@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <170113056683.7109.13851405274459689039@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Reusing the trimmed Cc]

On Tue, Nov 28, 2023 at 11:16:06AM +1100, NeilBrown wrote:
> On Tue, 28 Nov 2023, Chuck Lever wrote:
> > On Tue, Nov 28, 2023 at 09:05:21AM +1100, NeilBrown wrote:
> > > 
> > > I have evidence from a customer site of 256 nfsd threads adding files to
> > > delayed_fput_lists nearly twice as fast they are retired by a single
> > > work-queue thread running delayed_fput().  As you might imagine this
> > > does not end well (20 million files in the queue at the time a snapshot
> > > was taken for analysis).
> > > 
> > > While this might point to a problem with the filesystem not handling the
> > > final close efficiently, such problems should only hurt throughput, not
> > > lead to memory exhaustion.
> > 
> > I have this patch queued for v6.8:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=nfsd-next&id=c42661ffa58acfeaf73b932dec1e6f04ce8a98c0
> > 
> 
> Thanks....
> I think that change is good, but I don't think it addresses the problem
> mentioned in the description, and it is not directly relevant to the
> problem I saw ... though it is complicated.
> 
> The problem "workqueue ...  hogged cpu..." probably means that
> nfsd_file_dispose_list() needs a cond_resched() call in the loop.
> That will stop it from hogging the CPU whether it is tied to one CPU or
> free to roam.
> 
> Also that work is calling filp_close() which primarily calls
> filp_flush().
> It also calls fput() but that does minimal work.  If there is much work
> to do then that is offloaded to another work-item.  *That* is the
> workitem that I had problems with.
> 
> The problem I saw was with an older kernel which didn't have the nfsd
> file cache and so probably is calling filp_close more often.  So maybe
> my patch isn't so important now.  Particularly as nfsd now isn't closing
> most files in-task but instead offloads that to another task.  So the
> final fput will not be handled by the nfsd task either.
> 
> But I think there is room for improvement.  Gathering lots of files
> together into a list and closing them sequentially is not going to be as
> efficient as closing them in parallel.
> 
> > 
> > > For normal threads, the thread that closes the file also calls the
> > > final fput so there is natural rate limiting preventing excessive growth
> > > in the list of delayed fputs.  For kernel threads, and particularly for
> > > nfsd, delayed in the final fput do not impose any throttling to prevent
> > > the thread from closing more files.
> > 
> > I don't think we want to block nfsd threads waiting for files to
> > close. Won't that be a potential denial of service?
> 
> Not as much as the denial of service caused by memory exhaustion due to
> an indefinitely growing list of files waiting to be closed by a single
> thread of workqueue.

It seems less likely that you run into memory exhausting than a DOS
because nfsd() is busy closing fds. Especially because you default to
single nfsd thread afaict.

> I think it is perfectly reasonable that when handling an NFSv4 CLOSE,
> the nfsd thread should completely handle that request including all the
> flush and ->release etc.  If that causes any denial of service, then
> simple increase the number of nfsd threads.

But isn't that a significant behavioral change? So I would expect to
make this at configurable via a module- or Kconfig option?

> For NFSv3 it is more complex.  On the kernel where I saw a problem the
> filp_close happen after each READ or WRITE (though I think the customer
> was using NFSv4...).  With the file cache there is no thread that is
> obviously responsible for the close.
> To get the sort of throttling that I think is need, we could possibly
> have each "nfsd_open" check if there are pending closes, and to wait for
> some small amount of progress.
> 
> But don't think it is reasonable for the nfsd threads to take none of
> the burden of closing files as that can result in imbalance.

It feels that this really needs to be tested under a similar workload in
question to see whether this is a viable solution.
