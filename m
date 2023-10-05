Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB7D7BA570
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241991AbjJEQQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241155AbjJEQNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:13:44 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D02A23512
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 03:53:41 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c61acd1285so5429915ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 03:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696503220; x=1697108020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pe8xFyJLCKJi/KhKGcW7VjeNy4RCMTgeeKud37OqgOU=;
        b=L+SAhMPQP1b7vqNvLlJOJ2+ZbCgL2MKj8IBLZROooWmV+96LR9Xx6b7jmJaQeSgui8
         5s3UuTjAOTSHSZ1AalZ43bAEuZZwYWn6NJMD7/sgEOsEcQnpWJzBRKrg2CKdYV4sCssO
         hPpsNypjfG+iQCV+1dChXcMBnSE0IGOkROK/0eSN9z5fQf7L4U8V5N5+oo+XzePD5Vmc
         Mv6Vqn55eAQzWS0bGJ+AFUu82rZR2OURUM513B/Sno+zxXNHRKeoAT6DMCq4FmuheX3p
         +aA8ASZQeR+drix7FSuKKSVuZ82HdVtkLUyMmmvepcQM2orduaPohFvcA6DYS4hUXTQz
         1pBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696503220; x=1697108020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pe8xFyJLCKJi/KhKGcW7VjeNy4RCMTgeeKud37OqgOU=;
        b=qYQwD9VzXOor0IOxHYu/phwvQSzKXWTmR6p8c4lY0fcnaDHt8bMzGmxfPBbtUxgiES
         twqrZEzDC/gBkudyJ9YKdEs67Uw9nECqOOBGGfCRSL8EPqNCAeraBSLTCjX6RMx6CKmR
         3FV/rLRlMzSqhOUbPgtpAf3CduSd10Y/xedqlm0BS1Ynuz4fV4JwUxx2qxgtu+kOkNvD
         APs4iAOjm+hCCF+7+qFMDk0lk7i/Mb+BEpr9ZTy690TR65SQ4HoGhwbfinF7cDhpYVNz
         h61AVX7gxxBEYbd7kftyVDo/1D/Fm1zQ/IeUe9h1pU+emoYdxHwJVn/uccmumpF8bFt2
         jPIg==
X-Gm-Message-State: AOJu0YzmBs5cMm6IUBei5SihEiPZJetr+GgitgSxgG0DK8nscsbbL5kP
        SrWLr/NfbojJ4lebWSYkaxBN8A==
X-Google-Smtp-Source: AGHT+IF8C3jiHLeH9TQdFxyoDdc9T2PYQRtsYCBM21zQ+O35XEF2pklTd9GgZJ2yChUIFrGyWdhB+w==
X-Received: by 2002:a17:902:7084:b0:1b6:649b:92cc with SMTP id z4-20020a170902708400b001b6649b92ccmr3842601plk.69.1696503220565;
        Thu, 05 Oct 2023 03:53:40 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902ab8c00b001c444106bcasm1346984plr.46.2023.10.05.03.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 03:53:39 -0700 (PDT)
Date:   Thu, 5 Oct 2023 16:23:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: ondemand: Allow powersave_bias_target() to bail
 out if freq_table is unsorted
Message-ID: <20231005105337.ozxgstfz45bskca5@vireshk-i7>
References: <20230908031614.2262451-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908031614.2262451-1-liaochang1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-09-23, 03:16, Liao Chang wrote:
> The generic_powersave_bias_target() function uses the
> cpufreq_table_find_index_[h/l]() functions to calculate the frequency
> bounds for the powersave bias target. However, these two functions only
> work on sorted frequency tables. Therefore, the
> generic_powersave_bias_target() function should bail out early if the
> frequency table is unsorted.
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq_ondemand.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> index c52d19d67557..f7ff94f71395 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -71,7 +71,8 @@ static unsigned int generic_powersave_bias_target(struct cpufreq_policy *policy,
>  	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
>  	struct cpufreq_frequency_table *freq_table = policy->freq_table;
>  
> -	if (!freq_table) {
> +	if (!freq_table ||
> +	    WARN_ON_ONCE(policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED)) {
>  		dbs_info->freq_lo = 0;
>  		dbs_info->freq_lo_delay_us = 0;
>  		return freq_next;

Shouldn't we make the governor use the generic functions then ?
cpufreq_frequency_table_target() ?

> -- 
> 2.34.1

-- 
viresh
