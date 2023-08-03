Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AD976F045
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbjHCRBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbjHCRBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:01:16 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF88DA;
        Thu,  3 Aug 2023 10:01:13 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1bba48b0bd2so8279165ad.3;
        Thu, 03 Aug 2023 10:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691082072; x=1691686872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jqz8cwZu0PK+dgkvluHlvbTGiv1F2/PKojJAJvfE+nw=;
        b=RNJ03CHdi0WaJsSsjaosza9bQaZ24Zs9jQ5iIvK0AA+IdvssTtfkZ3OZERia3Rjwuw
         qbYEmHkmR1fEcMdspDwrbMa6Zkit+FSJdWqQmfpwfsOZNnRpiNlIg9roxiw5/cjzDK1h
         WjtIKyWvJdjEf1nsD2dLm6ZmeoPvF+/YFw/CA61kCkz9GLepdRbHy0D+AKOFqfGul5dH
         2sgyPZg5PKDLRnxAMnVZRtgya0o0dwSBdw23GToyQqLqRZTrUAtu27TbOmZl6wPZZ8jz
         rJjP+YTueMp3DlX8RcTWZoi95jEOcbtdm24bwC7sYXLN/vnQ4kn2k6ySWWgHJfGWrN+P
         W9Wg==
X-Gm-Message-State: ABy/qLaW3krN+yBmEn7kqbeZxAkO8drB5YswwRSv+uE9bWMHLZFGW9Nh
        ZNMfNTvys2e38cN7+BCh1ak=
X-Google-Smtp-Source: APBJJlHYLu9R80o2qnTWaGq3FoWKXgM1zLqjJCpC8OB+wEv54xekAGg1oWiA1F9TMGtlPMiVNf9S8w==
X-Received: by 2002:a17:902:7b89:b0:1b8:a3e8:51d0 with SMTP id w9-20020a1709027b8900b001b8a3e851d0mr16384439pll.45.1691082072336;
        Thu, 03 Aug 2023 10:01:12 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:b168:5a8:480e:1a0b? ([2620:15c:211:201:b168:5a8:480e:1a0b])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902eb4c00b001b8ad8382a4sm93709pli.216.2023.08.03.10.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 10:01:11 -0700 (PDT)
Message-ID: <f5e3a283-8f0a-12c0-94f0-19263bb3883d@acm.org>
Date:   Thu, 3 Aug 2023 10:01:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] block/mq-deadline: use correct way to throttling write
 requests
Content-Language: en-US
To:     Zhiguo Niu <zhiguo.niu@unisoc.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        niuzhiguo84@gmail.com, hongyu.jin@unisoc.com,
        yunlong.xing@unisoc.com
References: <1691061162-22898-1-git-send-email-zhiguo.niu@unisoc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1691061162-22898-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/23 04:12, Zhiguo Niu wrote:
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 5839a027e0f0..7e043d4a78f8 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -620,8 +620,9 @@ static void dd_depth_updated(struct blk_mq_hw_ctx *hctx)
>   	struct request_queue *q = hctx->queue;
>   	struct deadline_data *dd = q->elevator->elevator_data;
>   	struct blk_mq_tags *tags = hctx->sched_tags;
> +	unsigned int shift = tags->bitmap_tags.sb.shift;
>   
> -	dd->async_depth = max(1UL, 3 * q->nr_requests / 4);
> +	dd->async_depth = max(1U, 3 * (1U << shift)  / 4);
>   
>   	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, dd->async_depth);
>   }

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
