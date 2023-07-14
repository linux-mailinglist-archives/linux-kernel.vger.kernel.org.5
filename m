Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200F9753F73
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 18:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbjGNQEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 12:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbjGNQEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 12:04:08 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBAA272E;
        Fri, 14 Jul 2023 09:04:08 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-67ef5af0ce8so2001792b3a.2;
        Fri, 14 Jul 2023 09:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689350647; x=1691942647;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AnUrl6Q/Hto3//n85eF7eIeo3rvuQaf3jDZjE91G6t8=;
        b=jSYrZYxSTnPqWqPJoTSh8bednthSu00uSK/qWCzSewUFh3wj+icWl4hr5I8g4h2W1f
         NUQtbiPjxRIZm+EJdxbtlXe+7HQaL2+LgR1+cqtHGoDpl7pe8kJ72pZmCM2BXoUtQIIP
         YLPrTasggMjkV5FU7z7p66E1BvNV+KXm3OX/v6ByzKZuG31Di9b/yVlVHzTPTuwcQu5J
         bAO/7aCCCTY848O3LI4KhTr0bLEUGvAw8M4Yc0FH5Jk/bwkNZ/cfAsMPBk6YMGD0gpog
         Gd18difk4oZClDfYfuCW0JM9S6SSMnii81HtAyOuuzD1W8a5NvolOqADJtrEpYKhsqdD
         ljsg==
X-Gm-Message-State: ABy/qLY77NOhWSkRypBZeBm9R8w1R/hcCbmDSS/JGQubbWmsIPqWBgLQ
        Axi8g07qubxmbXGG4PVASsw=
X-Google-Smtp-Source: APBJJlHwEDQHVQ/R2PNFfinFvfMnsI7qs49uwmzjZ43FdR+sbiA7Vjf2Eivs7Yj7NlOJga2sI7qZ9w==
X-Received: by 2002:a17:90a:5916:b0:263:e122:a692 with SMTP id k22-20020a17090a591600b00263e122a692mr3807022pji.49.1689350647303;
        Fri, 14 Jul 2023 09:04:07 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a59b:27e7:a062:fd32? ([2620:15c:211:201:a59b:27e7:a062:fd32])
        by smtp.gmail.com with ESMTPSA id jx17-20020a17090b46d100b00265d023c233sm1278686pjb.6.2023.07.14.09.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 09:04:06 -0700 (PDT)
Message-ID: <4399bb4f-8127-f9fb-fe47-ab02ec3566c9@acm.org>
Date:   Fri, 14 Jul 2023 09:04:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] blk-mq: Fix stall due to recursive flush plug
Content-Language: en-US
To:     Ross Lagerwall <ross.lagerwall@citrix.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230714101106.3635611-1-ross.lagerwall@citrix.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230714101106.3635611-1-ross.lagerwall@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/23 03:11, Ross Lagerwall wrote:
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 99d8b9812b18..90de50082146 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1144,8 +1144,7 @@ void __blk_flush_plug(struct blk_plug *plug, bool from_schedule)
>   {
>   	if (!list_empty(&plug->cb_list))
>   		flush_plug_callbacks(plug, from_schedule);
> -	if (!rq_list_empty(plug->mq_list))
> -		blk_mq_flush_plug_list(plug, from_schedule);
> +	blk_mq_flush_plug_list(plug, from_schedule);
>   	/*
>   	 * Unconditionally flush out cached requests, even if the unplug
>   	 * event came from schedule. Since we know hold references to the
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 5504719b970d..e6bd9c5f42bb 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2742,7 +2742,14 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>   {
>   	struct request *rq;
>   
> -	if (rq_list_empty(plug->mq_list))
> +	/*
> +	 * We may have been called recursively midway through handling
> +	 * plug->mq_list via a schedule() in the driver's queue_rq() callback.
> +	 * To avoid mq_list changing under our feet, clear rq_count early and
> +	 * bail out specifically if rq_count is 0 rather than checking
> +	 * whether the mq_list is empty.
> +	 */
> +	if (plug->rq_count == 0)
>   		return;
>   	plug->rq_count = 0;

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
