Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5427FDAF4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbjK2PRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjK2PRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:17:21 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF8FA3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:17:27 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-41cd4cc515fso37925661cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1701271047; x=1701875847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ki5eAeZpOcI54YbTPSCFwp5UJ2eI9c3pK5uL2lEEtZM=;
        b=t45yazmdyT7D3V75tVpLMivlCMgeR/JvS/+C/lc7BHmzaprkmFWcankS3PQr7flX5U
         iro9DZmFQLFpz1giKu33Gx3a0hs2o5P0fXJ3nePPDmHNHJBITL4OvksYckJlpZuq6x/t
         KXpt4mDsz/Men8Xe0f6AnBNSr+ipGBke/yG6hy5keISNVDeIbmnlj0iDfO6k4wEV9XwL
         tO4AaMXr1vXUfpzmjVkE5JkVyr0ZdvPfDf38HIbti5rcMxqkXLJsocTDGnQU0Yl0KSu2
         GyQmwozT25v4QB4gsFDL0PDXLh3atKDMZbJPIKzDVL5prK9VcM1yGRM4LnUwqvYt+3N0
         wOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701271047; x=1701875847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ki5eAeZpOcI54YbTPSCFwp5UJ2eI9c3pK5uL2lEEtZM=;
        b=i54IrLZTv7GbA+6IdYYSBw1vUOuo1XE6foYP1t0uFA9mmFq7TJpLRXAzB8ZCiSTPtC
         Hkqc96AXvbuMhhs18hp5tSqQxstFW3hQKRG8jYqZl/j4gOk7jGAvdDzN7REnnFD24/mq
         +q4vQBP0+ktYizRfCyIU3m/OXNddwpz79lpYawFa8rKD016Zp5SLG1Ap+ysErXImpPYS
         niteNllM3DoHZwFSLdXyG3hNGXBmhzfKu9Fx8qYOhFrGjj4iCBpkrvgeQPd1BXoGgXQW
         425LX3pv8mivdE2Jht1f5SefHi8HlosPRGnS/N45sHefRTXZBDirk4lqIvKF64S2C1mz
         Ir7Q==
X-Gm-Message-State: AOJu0YwbhbNINFse9XBJ1ZjW4Ion84iKA+wUT/4vdLpR9iz6fVeeOMan
        /xPi4L3wzIks9UPDCou7EP9Ubg==
X-Google-Smtp-Source: AGHT+IEZIE1AM5E8zn+REarKZMAnlku7irhSBH7MhlpFKWn2MeAvwTjAn78X+XkDrH28XBpWMoOlEQ==
X-Received: by 2002:ac8:7d12:0:b0:423:792f:d5ca with SMTP id g18-20020ac87d12000000b00423792fd5camr24998108qtb.63.1701271046994;
        Wed, 29 Nov 2023 07:17:26 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id ay30-20020a05622a229e00b00423a0d10d4csm4386593qtb.62.2023.11.29.07.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 07:17:26 -0800 (PST)
Date:   Wed, 29 Nov 2023 10:17:21 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v7 3/6] zswap: make shrinking memcg-aware
Message-ID: <20231129151721.GC135852@cmpxchg.org>
References: <20231127234600.2971029-1-nphamcs@gmail.com>
 <20231127234600.2971029-4-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127234600.2971029-4-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 03:45:57PM -0800, Nhat Pham wrote:
>  static void shrink_worker(struct work_struct *w)
>  {
>  	struct zswap_pool *pool = container_of(w, typeof(*pool),
>  						shrink_work);
> +	struct mem_cgroup *memcg;
>  	int ret, failures = 0;
>  
> +	/* global reclaim will select cgroup in a round-robin fashion. */
>  	do {
> -		ret = zswap_reclaim_entry(pool);
> -		if (ret) {
> -			zswap_reject_reclaim_fail++;
> -			if (ret != -EAGAIN)
> -				break;
> +		spin_lock(&zswap_pools_lock);
> +		memcg = pool->next_shrink =
> +			mem_cgroup_iter_online(NULL, pool->next_shrink, NULL, true);
> +
> +		/* full round trip */
> +		if (!memcg) {
> +			spin_unlock(&zswap_pools_lock);
>  			if (++failures == MAX_RECLAIM_RETRIES)
>  				break;
> +
> +			goto resched;
>  		}
> +
> +		/*
> +		 * Acquire an extra reference to the iterated memcg in case the
> +		 * original reference is dropped by the zswap offlining callback.
> +		 */
> +		css_get(&memcg->css);

struct mem_cgroup isn't defined when !CONFIG_MEMCG. This needs a
mem_cgroup_get() wrapper and a dummy function for no-memcg builds.

With that fixed, though, everything else looks good to me:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
