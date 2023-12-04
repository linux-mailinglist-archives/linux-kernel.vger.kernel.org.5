Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B442F802A42
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 03:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbjLDCZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 21:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjLDCZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 21:25:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1013101;
        Sun,  3 Dec 2023 18:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SsyO4lSpIna9nQlHkHCb+VcH3551LY+52acm9hFhGCc=; b=CVVlyVrJxEBg2Dlyh4y8vfflT7
        q2uxs8LdAfB6rw6+ZOUhBW5EvZn+htCaCeLPtnK64sYUfOf+boOrTzgABjSap5FtNXKTXTqs01pH+
        TteMtKPJeELKRGpg42mJ1yP65XdMsC/4XIhEPKtku+cCgt/US+Bko0Xzrk4MZicvNpAMZywDWn/1J
        HnUOfGuX+rc/YAojLqIB/NX/oTh7cMZsT5t0u32JYN5OxAhBuzl4DxNfx2MfCbDJAUw0/jNoh1wp1
        unuFQeip7ehpmpPjhFWgewImA3jCgKuYneeAcdfLvj+lg9OgbpWsxqSKiNnnv9d3Ol6YlcLB4TA4w
        60Qae1vw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r9ye0-000FhU-Fi; Mon, 04 Dec 2023 02:25:12 +0000
Date:   Mon, 4 Dec 2023 02:25:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
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
Message-ID: <ZW04iGENbNm3A/Ki@casper.infradead.org>
References: <20231204014042.6754-1-neilb@suse.de>
 <20231204014042.6754-2-neilb@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204014042.6754-2-neilb@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 12:36:41PM +1100, NeilBrown wrote:
> +++ b/fs/namespace.c
> @@ -1328,7 +1328,7 @@ static void mntput_no_expire(struct mount *mnt)
>  
>  	if (likely(!(mnt->mnt.mnt_flags & MNT_INTERNAL))) {
>  		struct task_struct *task = current;
> -		if (likely(!(task->flags & PF_KTHREAD))) {
> +		if (likely((task->flags & PF_RUNS_TASK_WORK))) {

You could lose one set of parens here ...

		if (likely(task->flags & PF_RUNS_TASK_WORK)) {

>  #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
> -#define PF__HOLE__00800000	0x00800000
> +#define PF_RUNS_TASK_WORK	0x00800000	/* Will call task_work_run() periodically */

And you could lose "Will" here:

#define PF_RUNS_TASK_WORK    0x00800000      /* Calls task_work_run() periodically */

> diff --git a/kernel/task_work.c b/kernel/task_work.c
> index 95a7e1b7f1da..aec19876e121 100644
> --- a/kernel/task_work.c
> +++ b/kernel/task_work.c
> @@ -183,3 +183,4 @@ void task_work_run(void)
>  		} while (work);
>  	}
>  }
> +EXPORT_SYMBOL(task_work_run);

_GPL?
