Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBAA76B9E5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 18:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjHAQs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 12:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjHAQsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:48:53 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ECF2114;
        Tue,  1 Aug 2023 09:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690908532; x=1722444532;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iQ1UhrvtfoymH4yRf6lJpyLLvTEhqq+BWrC7UVoVMJQ=;
  b=iMkFLSb/CcMScAKkSdbA+adeU1cHWJyk8wBkcMcfanbZAK7ZlTnPqZee
   y4mOhlDZxb4MxoV9VM1uFcTwYu4x2qvMHF0RXTxA20ZeBG1wmGG8bpU1e
   asfag4hz7/II3zkDaXJjl+tUk3S+zseMSiFR6d52lC0s5uCuT6LVIH5Pb
   KcXZ5QRLROsNV4ZBsDo2+RS9RyFnNTTk7LantpaASzdaLzSGWO6WBNl4s
   +acY52TMy+4BXLh3oKhTNNHORTc5dKdvaNdihCKPwKi1iiu/iAkVQ7pP4
   JR3ebGmmOHCz6UOqa/G68HZHaxZvf/Gxr6rUALSNmVwmOjY7wdB7KIL4B
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="372992368"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="372992368"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 09:48:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="818863644"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="818863644"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.38.126])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 09:48:48 -0700
Message-ID: <5a53c617-fcea-50c6-c595-750a4e12f97a@intel.com>
Date:   Tue, 1 Aug 2023 19:48:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.1
Subject: Re: [PATCH] mmc: block: Fix in_flight[issue_type] value error
Content-Language: en-US
To:     Yunlong Xing <yunlong.xing@unisoc.com>, CLoehle@hyperstone.com,
        hare@suse.de, jinpu.wang@ionos.com, asuk4.q@gmail.com,
        avri.altman@wdc.com, f.fainelli@gmail.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        hongyu.jin@unisoc.com, zhiguo.niu@unisoc.com,
        yunlong.xing23@gmail.com, Ulf Hansson <ulf.hansson@linaro.org>
References: <20230801081327.1309669-1-yunlong.xing@unisoc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230801081327.1309669-1-yunlong.xing@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/08/23 11:13, Yunlong Xing wrote:
> From: Yibin Ding <yibin.ding@unisoc.com>
> 
> For a completed request, after the mmc_blk_mq_complete_rq(mq, req)
> function is executed, the bitmap_tags corresponding to the
> request will be cleared, that is, the request will be regarded as
> idle. If the request is acquired by a different type of process at
> this time, the issue_type of the request may change. It further
> caused the value of mq->in_flight[issue_type] to be abnormal,
> and a large number of requests could not be sent.
> 
> p1:					      p2:
> mmc_blk_mq_complete_rq
>   blk_mq_free_request
> 					      blk_mq_get_request
> 					        blk_mq_rq_ctx_init
> mmc_blk_mq_dec_in_flight
>   mmc_issue_type(mq, req)
> 
> This strategy can ensure the consistency of issue_type
> before and after executing mmc_blk_mq_complete_rq.
> 
> Signed-off-by: Yibin Ding <yibin.ding@unisoc.com>

One cosmetic comment below, otherwise:

Fixes: 81196976ed94 ("mmc: block: Add blk-mq support")
Cc: stable@vger.kernel.org
Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thank you!

> ---
>  drivers/mmc/core/block.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index f701efb1fa78..5b750311f638 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2097,14 +2097,14 @@ static void mmc_blk_mq_poll_completion(struct mmc_queue *mq,
>  	mmc_blk_urgent_bkops(mq, mqrq);
>  }
>  
> -static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, struct request *req)
> +static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, enum mmc_issue_type issue_type)
>  {
>  	unsigned long flags;
>  	bool put_card;
>  
>  	spin_lock_irqsave(&mq->lock, flags);
>  
> -	mq->in_flight[mmc_issue_type(mq, req)] -= 1;
> +	mq->in_flight[issue_type] -= 1;
>  
>  	put_card = (mmc_tot_in_flight(mq) == 0);
>  
> @@ -2120,6 +2120,7 @@ static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req,
>  	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
>  	struct mmc_request *mrq = &mqrq->brq.mrq;
>  	struct mmc_host *host = mq->card->host;
> +	enum mmc_issue_type issue_type = mmc_issue_type(mq, req);

It looks slightly neater to put the local declarations in
descending order of line length if possible e.g.

+	enum mmc_issue_type issue_type = mmc_issue_type(mq, req);
	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
	struct mmc_request *mrq = &mqrq->brq.mrq;
	struct mmc_host *host = mq->card->host;

>  
>  	mmc_post_req(host, mrq, 0);
>  
> @@ -2136,7 +2137,7 @@ static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req,
>  			blk_mq_complete_request(req);
>  	}
>  
> -	mmc_blk_mq_dec_in_flight(mq, req);
> +	mmc_blk_mq_dec_in_flight(mq, issue_type);
>  }
>  
>  void mmc_blk_mq_recovery(struct mmc_queue *mq)

