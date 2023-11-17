Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57337EED17
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 09:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjKQIGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 03:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQIGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 03:06:13 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B59FC4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:05:45 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6ce31c4a653so888537a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700208345; x=1700813145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MngCMTTePjlt9N1aPSQuwHXLMa/gWTJ9XLM60sAqaII=;
        b=Y58uwznOpWdVsYTYBA2p4iZZBMtPvO4xbveP5s0+QccM1zgzkZXCLMaS2TPA3i4cBH
         oQ8jU0SrWlN7LK++Ovm5ricbNuCBjFt98fpecyKptJdAHKdAZO4Bl8i79/Eyusn0UVBF
         6YDmvomytGm/ZpDatHtLDprZxc6WhTYwbNgtXmx609htwQditdvnZB2BPvwsk71oShe2
         G6b8/9zlGOaVAbJMwCerRnncD6ZPvirh7O4MDLBgRURDtlL4bVuUnA6T37zA15j5R5UW
         1LTrenX3hkPwdpjitJtm6cgNsIKEBA3NuaYyu1pb4NNNY4z/xmcmMDoeqstmmITOMMR8
         78+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700208345; x=1700813145;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MngCMTTePjlt9N1aPSQuwHXLMa/gWTJ9XLM60sAqaII=;
        b=jmGfEJ4BrRt8E1uyWUXjwrOnWZy/cb+rWBsQFdmg8I09Rbs36/o7bs4W3lZfML9sHM
         TD9xZek1mAKVd8tYT4SW3AMyxhAb3odELeW4265pG/D2ExX8zO2ZwubCb8xfkIThyIyF
         8Fjp8QGm92tKBoXx57KNnagz1u9UP9rFxghfxxDcPwqBB16qsf0MtCEbirHiAnY2fhWN
         CZismP+lyxg6qt9K5GG94YrFl3TX5R0C1VVQST3/nHOlmBPhwrl0UGyBN/KxWcGlvG08
         ApNFdZtITEMbojN4D3q8pK90uWlTi8N7w5RiF0+WipYVS7liVjqZvIZ/e08kij2BpRgo
         cZHQ==
X-Gm-Message-State: AOJu0YzlP1/BqY/5tGB98m9GDajRCSroly9FB2SEvCijY/CH224JASoc
        vXHeLuPZoQY28qNOoQZchmzJVA==
X-Google-Smtp-Source: AGHT+IGMFbfkiWGXXp+u4RXA9doroZ+u6dItjTTf8jXC6ir9Sccr1Vfj1TV3J275XG17VI4KPeXnXw==
X-Received: by 2002:a05:6870:806:b0:1ea:2506:3e90 with SMTP id fw6-20020a056870080600b001ea25063e90mr23611884oab.35.1700208344782;
        Fri, 17 Nov 2023 00:05:44 -0800 (PST)
Received: from [10.254.46.51] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id fa16-20020a056a002d1000b006c3069547bfsm892011pfb.79.2023.11.17.00.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 00:05:44 -0800 (PST)
Message-ID: <9d06e027-9ce5-48b5-b3e7-5516ef62958e@bytedance.com>
Date:   Fri, 17 Nov 2023 16:05:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Update min_vruntime for reweight_entity()
 correctly
Content-Language: en-US
To:     Yiwei Lin <s921975628@gmail.com>, peterz@infradead.org,
        mingo@redhat.com
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, s921975627@gmail.com
References: <20231117080106.12890-1-s921975628@gmail.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20231117080106.12890-1-s921975628@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/23 4:01 PM, Yiwei Lin Wrote:
> Since reweight_entity() may have chance to change the weight of
> cfs_rq->curr entity, we should also update_min_vruntime() if
> this is the case
> 
> Fixes: eab03c23c2a1 ("sched/eevdf: Fix vruntime adjustment on reweight")
> Signed-off-by: Yiwei Lin <s921975628@gmail.com>
> ---
>   kernel/sched/fair.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 07f555857..6fb89f4a3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3815,17 +3815,17 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>   	enqueue_load_avg(cfs_rq, se);
>   	if (se->on_rq) {
>   		update_load_add(&cfs_rq->load, se->load.weight);
> -		if (!curr) {
> -			/*
> -			 * The entity's vruntime has been adjusted, so let's check
> -			 * whether the rq-wide min_vruntime needs updated too. Since
> -			 * the calculations above require stable min_vruntime rather
> -			 * than up-to-date one, we do the update at the end of the
> -			 * reweight process.
> -			 */
> +		if (!curr)
>   			__enqueue_entity(cfs_rq, se);
> -			update_min_vruntime(cfs_rq);
> -		}
> +
> +		/*
> +		 * The entity's vruntime has been adjusted, so let's check
> +		 * whether the rq-wide min_vruntime needs updated too. Since
> +		 * the calculations above require stable min_vruntime rather
> +		 * than up-to-date one, we do the update at the end of the
> +		 * reweight process.
> +		 */
> +		update_min_vruntime(cfs_rq);
>   	}
>   }
>   

Reviewed-by: Abel Wu <wuyun.abel@bytedance.com>

Thanks!
