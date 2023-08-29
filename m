Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F88078BF06
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjH2HOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjH2HOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:14:08 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F971A2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:14:05 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68a402c1fcdso2771419b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693293245; x=1693898045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I950l3VoifWF5YWQe1wgAiCcJrg5T0pZ6mkbU2jstKs=;
        b=aOrHNgX3NAJSVPdsxPZH5WtHQgL98p4tbQ5mf7uhS4HbDrMMr6V8qANeXGpnr/xZQM
         SHlLOfjWD3hHyfdaeldvd4czo80B9FHyugiyu6JCYJPZdm4snbWW65fnhueVuO5WSbeO
         PjWq20pgpSbo6yl/SSQd73XR2xc6wQCxzKNidnVnkGW879+BhMUq5jmUSx14RDF7VVY9
         0UjyZYBWZMf3fFah5RSy8LMaWXpf8QYChhD3LtybWRnZ2V6bs0i5WhOVziS2q6VeBhO7
         5hSDVSS/rpWc+LwEldp4KxWQaIEUdxYxASsLCPLM0I05GGzvp3JvkyeF9KICkRGcAcAP
         6l9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693293245; x=1693898045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I950l3VoifWF5YWQe1wgAiCcJrg5T0pZ6mkbU2jstKs=;
        b=NQYDFpeTLpS9a5CdyCUgMD4imDajOXEz18wpYs2py7pwhlyi2mdmgmqyKhreklV8Fu
         MZ/lFOm4GkjpJ/dq+y9AojD5ayJYIYFmXZzHLZxniYdBHfRlw7hBO2D9Nm5Z9T/HPE+t
         HnmEtcqLMu+38D4+l8bjPnjk34dh0YQNrEfcZTkI2XQ9OXCOX7dWnffaRe6/rML09uiv
         5bBvsGVZzkKn372ejS38jzS1owI2qgjF4fqrcbsPtlnu2GVOHv36DXwl8WI5JsVXdAbL
         bSZiQVQHHKfDyQa0k2fARIi7rKwpiCVgarN2g229M517Vvp46d2P0qH7Y2Fs0HCjRFem
         3yww==
X-Gm-Message-State: AOJu0YzkcyWYgfhQae3uf1oRVNksdsZvrJoN4YfC8oMycUfLCjVpS7KK
        P1rix+IzM4z43SjNrdaIGSjQzg==
X-Google-Smtp-Source: AGHT+IGCqa1ZDpC2oyeWpi+cN9ZOaVSEMi9rb/SiQHJZAiTOkVc54AMPSuz3KWDjuTNNU3OWEy535w==
X-Received: by 2002:a05:6a20:3ca1:b0:13d:5b70:17da with SMTP id b33-20020a056a203ca100b0013d5b7017damr27572356pzj.26.1693293245140;
        Tue, 29 Aug 2023 00:14:05 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id cl7-20020a056a0032c700b006887be16675sm1978955pfb.205.2023.08.29.00.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 00:14:04 -0700 (PDT)
Date:   Tue, 29 Aug 2023 12:44:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: governor: Free dbs_data directly when
 gov->init() fails
Message-ID: <20230829071402.o5prtd3ww42hfffb@vireshk-i7>
References: <20230829070346.1217699-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829070346.1217699-1-liaochang1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-08-23, 07:03, Liao Chang wrote:
> Due to the kobject embedded in the dbs_data doest not has a release()
> method yet, it needs to use kfree() to free dbs_data directly when
> governor fails to allocate the tunner field of dbs_data.
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 85da677c43d6..af44ee6a6430 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -439,7 +439,7 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
>  
>  	ret = gov->init(dbs_data);
>  	if (ret)
> -		goto free_policy_dbs_info;
> +		goto free_dbs_data;
>  
>  	/*
>  	 * The sampling interval should not be less than the transition latency
> @@ -474,6 +474,8 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
>  	if (!have_governor_per_policy())
>  		gov->gdbs_data = NULL;
>  	gov->exit(dbs_data);
> +
> +free_dbs_data:
>  	kfree(dbs_data);
>  
>  free_policy_dbs_info:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
