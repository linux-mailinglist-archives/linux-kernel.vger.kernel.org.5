Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D456275B306
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbjGTPhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjGTPg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:36:58 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703C52D63;
        Thu, 20 Jul 2023 08:36:25 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-666ed230c81so826886b3a.0;
        Thu, 20 Jul 2023 08:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689867385; x=1690472185;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WAH5uVbj4cISjvxjDJ8RnYVMFAN3vFg4rHluAx9qI60=;
        b=UwuSxxnzmEITuF1/K26bbXtkGU0eZa7BFQoPnCyEQbZOITbSYiME9trU0y5mtjKX3y
         TKJ9fxHS70QbJoVhZYFVpa8aFyIRR3lfySU5Ze9/0qIyLOdlvmHyAFOysof7kqEbzS2G
         juqHH8cq1Lo2HH5dZCH+/I29r9EAbMBcyIGm0yrNXXLzDaO5Fg5BKS/vV5KAjniPToVZ
         aogZPFuBWnPTEAMcdx1KHBzXZWEgqhjLS7u7h1ooMUal+kFOQhgRXBAcJX2Zo5yNQPgM
         la28xia5pS6Cfn/Zn0DrsNQlD7hVzUSBSFpBCnOsh02Hi0pTjI2b1jbwpEJjJxAk3YSb
         8YJQ==
X-Gm-Message-State: ABy/qLbA0estmU/qZ+8E6Jr8B3fU5EjcNpMLRBo/9qSlFou0ESRlLUgM
        ixCOTMRm1K98s8DND89sN3vHkWO6N08=
X-Google-Smtp-Source: APBJJlEaxCOtZgwuFqogIkZt/M9p/MnAUBwhOu42B4PqtG2v43BlHbpYyuEZAMmwOrsG7lcwGGeKOg==
X-Received: by 2002:a05:6a20:8403:b0:137:3803:332 with SMTP id c3-20020a056a20840300b0013738030332mr7409969pzd.22.1689867384687;
        Thu, 20 Jul 2023 08:36:24 -0700 (PDT)
Received: from ?IPV6:2601:642:4c05:35c7:a9f2:f55:cb5b:263a? ([2601:642:4c05:35c7:a9f2:f55:cb5b:263a])
        by smtp.gmail.com with ESMTPSA id y8-20020a62b508000000b00663b712bfbdsm1343280pfe.57.2023.07.20.08.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 08:36:24 -0700 (PDT)
Message-ID: <c2d10567-cfc6-de6b-cc08-21ab00604d51@acm.org>
Date:   Thu, 20 Jul 2023 08:36:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] blk-mq: delete dead struct blk_mq_hw_ctx->queued field
Content-Language: en-US
To:     chengming.zhou@linux.dev, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
References: <20230720095512.1403123-1-chengming.zhou@linux.dev>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230720095512.1403123-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/23 02:55, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> This counter is not used anywhere, so delete it.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>   include/linux/blk-mq.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 01e8c31db665..958ed7e89b30 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -393,8 +393,6 @@ struct blk_mq_hw_ctx {
>   	 */
>   	struct blk_mq_tags	*sched_tags;
>   
> -	/** @queued: Number of queued requests. */
> -	unsigned long		queued;
>   	/** @run: Number of dispatched requests. */
>   	unsigned long		run;

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
