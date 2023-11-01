Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCAF7DDA86
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 02:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376931AbjKABNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 21:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbjKABNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 21:13:36 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB5CC1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 18:13:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VvIuXn3_1698801206;
Received: from 30.221.128.154(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VvIuXn3_1698801206)
          by smtp.aliyun-inc.com;
          Wed, 01 Nov 2023 09:13:27 +0800
Message-ID: <204108bc-8d74-6bab-a8fd-5598aa3e5cdd@linux.alibaba.com>
Date:   Wed, 1 Nov 2023 09:13:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] ocfs2: call ocfs2_abort when journal abort
Content-Language: en-US
To:     Srivathsa Dara <srivathsa.d.dara@oracle.com>, mark@fasheh.com,
        jlbec@evilplan.org
Cc:     rajesh.sivaramasubramaniom@oracle.com, junxiao.bi@oracle.com,
        ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231030120057.928280-1-srivathsa.d.dara@oracle.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20231030120057.928280-1-srivathsa.d.dara@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/30/23 8:00 PM, Srivathsa Dara wrote:
> From: Ryan Ding <ryan.ding@oracle.com>
> 
> 
> journal can not recover from abort state, so we should take following 
> action to prevent file system from corruption:
> 
> 1. change to readonly filesystem when local mount. We can not afford 
>    further write, so change to RO state is reasonable.
> 
> 2. panic when cluster mount. Because we can not release lock resource in
>    this state, other node will hung when it require a lock owned by this
>    node. So panic and remaster is a reasonable choise.
> 
> ocfs2_abort() will do all the above work.
> 
> Signed-off-by: Ryan Ding <ryan.ding@oracle.com>
> Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
> ---
>  fs/ocfs2/journal.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
> index ce215565d061..6dace475f019 100644
> --- a/fs/ocfs2/journal.c
> +++ b/fs/ocfs2/journal.c
> @@ -14,7 +14,6 @@
>  #include <linux/kthread.h>
>  #include <linux/time.h>
>  #include <linux/random.h>
> -#include <linux/delay.h>
>  #include <linux/writeback.h>
>  
>  #include <cluster/masklog.h>
> @@ -2326,7 +2325,7 @@ static int __ocfs2_wait_on_mount(struct ocfs2_super *osb, int quota)
>  
>  static int ocfs2_commit_thread(void *arg)
>  {
> -	int status;
> +	int status = 0;
>  	struct ocfs2_super *osb = arg;
>  	struct ocfs2_journal *journal = osb->journal;
>  
> @@ -2340,21 +2339,25 @@ static int ocfs2_commit_thread(void *arg)
>  		wait_event_interruptible(osb->checkpoint_event,
>  					 atomic_read(&journal->j_num_trans)
>  					 || kthread_should_stop());
> +		if (status < 0) {
> +			/* As we can not terminate by ourself, just enter an
> +			 * empty loop to wait for stop.
> +			 */
> +			continue;
> +		}
>  
>  		status = ocfs2_commit_cache(osb);
>  		if (status < 0) {
> -			static unsigned long abort_warn_time;
> -
> -			/* Warn about this once per minute */
> -			if (printk_timed_ratelimit(&abort_warn_time, 60*HZ))
> -				mlog(ML_ERROR, "status = %d, journal is "
> -						"already aborted.\n", status);
>  			/*
> -			 * After ocfs2_commit_cache() fails, j_num_trans has a
> -			 * non-zero value.  Sleep here to avoid a busy-wait
> -			 * loop.
> +			 * journal can not recover from abort state, there is
> +			 * no need to keep commit cache. So we should either
> +			 * change to readonly(local mount) or just panic
> +			 * (cluster mount).
> +			 * We should also clear j_num_trans to prevent further
> +			 * commit.
>  			 */
> -			msleep_interruptible(1000);
> +			atomic_set(&journal->j_num_trans, 0);

Unconditionally clear 'j_num_trans' here seems buggy.
This may cause other nodes corrupt filesystem.

Thanks,
Joseph

> +			ocfs2_abort(osb->sb, "Detected aborted journal");
>  		}
>  
>  		if (kthread_should_stop() && atomic_read(&journal->j_num_trans)){
