Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9787B9F17
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbjJENyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 09:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244090AbjJENvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:51:15 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0920023D11
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 04:02:59 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c5bf7871dcso6357435ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 04:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696503778; x=1697108578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yLNoHDbJ10mcu0IVX/StKsMp6qzKf98pbXCXR9Rqaug=;
        b=s9Z4fSo8xs76+r26MIk/ML/9RwWrGchAxKPlmDE7cv0XEN7zEMY5w0dkWhlDFcNBwZ
         MggkFfDjiey4bHaYN2VxFlVBS9H4/KMMe9whilPutPmkkRI+YM2qDhsHd8uAoHkeozcm
         z5uKTtBXD34w9273pzT6E8244YafH8G9nd+8iyqbTqGNNUWQce8VTKjmq9eW/eNfIgRG
         NRrOFYAEDac+nLOA+hxLiGPQK/azF8xfdbVErqFqKAsl6J0++BkSdtzFjhwviA+SGv8B
         NAdbK1wXdgpEB9XJd0NjJnH3cUsH61tRpypJ3OttkItv2OaKsj305fv8JQtvPSyClLU1
         4hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696503778; x=1697108578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLNoHDbJ10mcu0IVX/StKsMp6qzKf98pbXCXR9Rqaug=;
        b=aQdCqVlQYuTIvY90FRqFNk0I8P5KGWtm0BnWQxe/kAAby7Amn4BpqM4shyFA93Fywj
         GDnhy30fRJkWKfHHKwwT4ZaL/ovFiAuD4Qu/TOXiqA+2K+4GiwhXeEBcLa5DjhnIlXdS
         TxKvDBhU+NS4TYVJBnlW6Fs4WKBFURSG2U0uM99tnqDzq0Yz4avoEx03PpTUJPs5QSpl
         KYeUaT8cOg+gB7YIjDFSA1fQPEVsHxHgO/u0tu0JHYTGmppRBrjyntAFvvAugfGdrPmA
         zLJUJSxcJXvQ9A8mrU00bUMtHg9mIDjfwokZMuxzYKNqfkqRnWN0+4+3hJHeMMtB6w/h
         tLIg==
X-Gm-Message-State: AOJu0YyHFCUWs2M3EwRPNGCWX13312pBcTr225XR8hTQewFhSduyRG7L
        mxuTW9dHHp8u32GrtFFy7+4iMQ==
X-Google-Smtp-Source: AGHT+IFitTju8/l9sr0q4R16qW7R2WVCwX4ieaIe75MpfZdWGZ14MogwGx2vrjkDjgzr4HUe6wzd7Q==
X-Received: by 2002:a17:902:f80a:b0:1c0:cb4d:df7c with SMTP id ix10-20020a170902f80a00b001c0cb4ddf7cmr4476950plb.1.1696503778489;
        Thu, 05 Oct 2023 04:02:58 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090301d200b001b89b1b99fasm1345702plh.243.2023.10.05.04.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 04:02:57 -0700 (PDT)
Date:   Thu, 5 Oct 2023 16:32:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: userspace: Use fine-grained mutex in
 userspace governor
Message-ID: <20231005110255.fk736npzqsrffl2c@vireshk-i7>
References: <20230912061057.2516963-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912061057.2516963-1-liaochang1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-09-23, 06:10, Liao Chang wrote:
> The userspace governor currently uses a big global mutex to avoid the
> race condition on the governor_data field of cpufreq_policy structure.
> This leads to a low concurrency if multiple userspace applications are
> trying to set the speed of different policies at the same time. This
> patch introduces a per-policy mutex to allow the updating of different
> policies to be performed concurrently, improving overall concurrency.
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq_userspace.c | 69 +++++++++++++++++------------
>  1 file changed, 40 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_userspace.c b/drivers/cpufreq/cpufreq_userspace.c
> index 50a4d7846580..442e31060d62 100644
> --- a/drivers/cpufreq/cpufreq_userspace.c
> +++ b/drivers/cpufreq/cpufreq_userspace.c
> @@ -16,7 +16,11 @@
>  #include <linux/slab.h>
>  
>  static DEFINE_PER_CPU(unsigned int, cpu_is_managed);
> -static DEFINE_MUTEX(userspace_mutex);
> +
> +struct userspace_policy {
> +	unsigned int setspeed;
> +	struct mutex mutex;
> +};
>  
>  /**
>   * cpufreq_set - set the CPU frequency
> @@ -28,19 +32,19 @@ static DEFINE_MUTEX(userspace_mutex);
>  static int cpufreq_set(struct cpufreq_policy *policy, unsigned int freq)
>  {
>  	int ret = -EINVAL;
> -	unsigned int *setspeed = policy->governor_data;
> +	struct userspace_policy *userspace = policy->governor_data;
>  
>  	pr_debug("cpufreq_set for cpu %u, freq %u kHz\n", policy->cpu, freq);
>  
> -	mutex_lock(&userspace_mutex);
> +	mutex_lock(&userspace->mutex);
>  	if (!per_cpu(cpu_is_managed, policy->cpu))
>  		goto err;
>  
> -	*setspeed = freq;
> +	userspace->setspeed = freq;
>  
>  	ret = __cpufreq_driver_target(policy, freq, CPUFREQ_RELATION_L);
>   err:
> -	mutex_unlock(&userspace_mutex);
> +	mutex_unlock(&userspace->mutex);
>  	return ret;
>  }
>  
> @@ -51,67 +55,74 @@ static ssize_t show_speed(struct cpufreq_policy *policy, char *buf)
>  
>  static int cpufreq_userspace_policy_init(struct cpufreq_policy *policy)
>  {
> -	unsigned int *setspeed;
> +	struct userspace_policy *userspace;
>  
> -	setspeed = kzalloc(sizeof(*setspeed), GFP_KERNEL);
> -	if (!setspeed)
> +	userspace = kzalloc(sizeof(*userspace), GFP_KERNEL);
> +	if (!userspace)
>  		return -ENOMEM;
>  
> -	policy->governor_data = setspeed;
> +	mutex_init(&userspace->mutex);
> +
> +	policy->governor_data = userspace;
>  	return 0;
>  }
>  
> +/*
> + * Any routine that writes to the policy struct will hold the "rwsem" of
> + * policy struct that means it is free to free "governor_data" here.
> + */
>  static void cpufreq_userspace_policy_exit(struct cpufreq_policy *policy)
>  {
> -	mutex_lock(&userspace_mutex);
>  	kfree(policy->governor_data);
>  	policy->governor_data = NULL;
> -	mutex_unlock(&userspace_mutex);
>  }
>  
>  static int cpufreq_userspace_policy_start(struct cpufreq_policy *policy)
>  {
> -	unsigned int *setspeed = policy->governor_data;
> +	struct userspace_policy *userspace = policy->governor_data;
>  
>  	BUG_ON(!policy->cur);
>  	pr_debug("started managing cpu %u\n", policy->cpu);
>  
> -	mutex_lock(&userspace_mutex);
> +	mutex_lock(&userspace->mutex);
>  	per_cpu(cpu_is_managed, policy->cpu) = 1;
> -	*setspeed = policy->cur;
> -	mutex_unlock(&userspace_mutex);
> +	userspace->setspeed = policy->cur;
> +	mutex_unlock(&userspace->mutex);
>  	return 0;
>  }
>  
>  static void cpufreq_userspace_policy_stop(struct cpufreq_policy *policy)
>  {
> -	unsigned int *setspeed = policy->governor_data;
> +	struct userspace_policy *userspace = policy->governor_data;
>  
>  	pr_debug("managing cpu %u stopped\n", policy->cpu);
>  
> -	mutex_lock(&userspace_mutex);
> +	mutex_lock(&userspace->mutex);
>  	per_cpu(cpu_is_managed, policy->cpu) = 0;
> -	*setspeed = 0;
> -	mutex_unlock(&userspace_mutex);
> +	userspace->setspeed = 0;
> +	mutex_unlock(&userspace->mutex);
>  }
>  
>  static void cpufreq_userspace_policy_limits(struct cpufreq_policy *policy)
>  {
> -	unsigned int *setspeed = policy->governor_data;
> +	struct userspace_policy *userspace = policy->governor_data;
>  
> -	mutex_lock(&userspace_mutex);
> +	mutex_lock(&userspace->mutex);
>  
>  	pr_debug("limit event for cpu %u: %u - %u kHz, currently %u kHz, last set to %u kHz\n",
> -		 policy->cpu, policy->min, policy->max, policy->cur, *setspeed);
> -
> -	if (policy->max < *setspeed)
> -		__cpufreq_driver_target(policy, policy->max, CPUFREQ_RELATION_H);
> -	else if (policy->min > *setspeed)
> -		__cpufreq_driver_target(policy, policy->min, CPUFREQ_RELATION_L);
> +		 policy->cpu, policy->min, policy->max, policy->cur, userspace->setspeed);
> +
> +	if (policy->max < userspace->setspeed)
> +		__cpufreq_driver_target(policy, policy->max,
> +					CPUFREQ_RELATION_H);
> +	else if (policy->min > userspace->setspeed)
> +		__cpufreq_driver_target(policy, policy->min,
> +					CPUFREQ_RELATION_L);
>  	else
> -		__cpufreq_driver_target(policy, *setspeed, CPUFREQ_RELATION_L);
> +		__cpufreq_driver_target(policy, userspace->setspeed,
> +					CPUFREQ_RELATION_L);
>  
> -	mutex_unlock(&userspace_mutex);
> +	mutex_unlock(&userspace->mutex);
>  }
>  
>  static struct cpufreq_governor cpufreq_gov_userspace = {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
