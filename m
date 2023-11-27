Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B9D7FAD75
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbjK0WbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjK0WbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:31:04 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B287EA;
        Mon, 27 Nov 2023 14:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3PzatJTAFuI9AA1q1PyzjD6sj+4//yZnqVg5MvBFhPA=; b=Ki96iRt+2k9IAxyOJxJ69225dH
        3s3CGMlrXW/53HNxRWoBDzzXcnGWu5Ff4/gLdtkaJtQinjTzDpWqihWFUR25cxJRqFS+0UQluG7SR
        0S52ZJhREva+EtvoYVhP/jbOuuWKnTXsj5HEhwqtCNpmLpxgQ1c4L9pqHYrBvzspDphzrZAmK8luR
        OFJVf0yBF0Bxj4qrXQ1GwEUWhW4fXKlxwc0MmJNGS/BBJTCff5TPyNdLFolh5sGo0U2MTz5EgwxO6
        ZAI6uCvgmRosdhvpHCxf3munWLk4SEXl86W/ambCxIHb40BdfE1S7tzfNLE45+EJOsR9z7+M7wEKm
        u1k/McjA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r7k7y-004Ai6-2j;
        Mon, 27 Nov 2023 22:30:54 +0000
Date:   Mon, 27 Nov 2023 22:30:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     NeilBrown <neilb@suse.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH/RFC] core/nfsd: allow kernel threads to use task_work.
Message-ID: <20231127223054.GL38156@ZenIV>
References: <170112272125.7109.6245462722883333440@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170112272125.7109.6245462722883333440@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 09:05:21AM +1100, NeilBrown wrote:

> A simple way to fix this is to treat nfsd threads like normal processes
> for task_work.  Thus the pending files are queued for the thread, and
> the same thread finishes the work.
> 
> Currently KTHREADs are assumed never to call task_work_run().  With this
> patch that it still the default but it is implemented by storing the
> magic value TASK_WORKS_DISABLED in ->task_works.  If a kthread, such as
> nfsd, will call task_work_run() periodically, it sets ->task_works
> to NULL to indicate this.

>  		svc_recv(rqstp);
>  		validate_process_creds();
> +		if (task_work_pending(current))
> +			task_work_run();

What locking environment and call chain do you have here?  And what happens if
you get something stuck in ->release()?

>  
>  	p->pdeath_signal = 0;
> -	p->task_works = NULL;
> +	p->task_works = args->kthread ? TASK_WORKS_DISABLED : NULL;

Umm... why not have them set (by helper in kernel/task_work.c) to
&work_exited?  Then the task_work_run parts wouldn't be needed at all...
