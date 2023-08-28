Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED10678A665
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjH1HYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 03:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjH1HXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:23:53 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A198C115
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:23:50 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c1e3a4a06fso1820525ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693207430; x=1693812230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CDHtlUKc0j7Q6lV6B5AgbW4Du27Uz8pjMuIX48zgRQM=;
        b=zVe9PriBO0mzdqmpyQmC5t0sM+N5i50p9yljdC3wcrl9cogBdiqFqp2QM7Gtijgj7f
         +HQ3RY3NpzhoS6ira/q5W8e37EP2l5E1AyXY3Hevbpv5Hhe5NRZjrnrAETQKdhe+Jprm
         RcXDn660vXCoTWyNLpGWeGpSuc9bh0+czz79u9N8refd6RZPKnjPeDlssOsfdTpNMeEI
         X7mEW0CpLNkGRd/HgTT053fPqOnhi6S/N1dyianv+KTV3Y+w+LEHeWp1LeirGg4Nb9xu
         /yKovsc3dYpKxIvMM2VeaXXJU/RfGVBUUY0CgOfE+DCo/yqx6f+1e7/kZ44kZB6XPrbh
         NCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693207430; x=1693812230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDHtlUKc0j7Q6lV6B5AgbW4Du27Uz8pjMuIX48zgRQM=;
        b=He0po8U9R2TTZ94Te/2Oob5e9ie0z7M+JAmBKYmWSpBrFl//ulYJKb+uD5TBghognP
         R4clkGtzxeC25l8Fupm3nztWUPZqFk73VF1PtjDnf1H/RIKbuPXZG9wYBKAk4Ej3mqMx
         +mYcF3fzZYixlIFlcMR9crho3ZdWdkmEiR6CLCL/TpbyN4TuukgYaj1I/rD/t7Toj+tR
         hO+wZLvK/HBK0/qYovtC1JpoDAIs6DoIDTlQv8A9ro22e+QmPSz1J1V8oYNZv0N7s3/J
         WrnYqjjNQI0wV3ymLkkeGwq4P8527bke/8dq2NWjNDouWIjuYSNJlUcRfPz9KqyqxUCE
         VIMQ==
X-Gm-Message-State: AOJu0YzYIAhYKpscusbLVo5qTiO/2a5nlu0QZV7pFFauS5pq4m5Hl+1a
        Vq4KGrptb6eJ2swAO9Ar+Twj3g==
X-Google-Smtp-Source: AGHT+IHZQilU+CWN49nN5rwoTIjvrnAgNV36NLb130EBcgvrkdhb35rHH+L4PEIAEw9zx8Y6RxOsPg==
X-Received: by 2002:a17:902:e54c:b0:1bb:c7bc:ceb4 with SMTP id n12-20020a170902e54c00b001bbc7bcceb4mr23857204plf.60.1693207430129;
        Mon, 28 Aug 2023 00:23:50 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id g20-20020a170902869400b001bbbbda70ccsm6506191plo.158.2023.08.28.00.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 00:23:49 -0700 (PDT)
Date:   Mon, 28 Aug 2023 12:53:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     rafael@kernel.org, srivatsa.bhat@linux.vnet.ibm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Fix the race condition while updating the
 transition_task of policy
Message-ID: <20230828072347.ly23mbptu3yw4zkv@vireshk-i7>
References: <20230826095836.1138608-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230826095836.1138608-1-liaochang1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-08-23, 09:58, Liao Chang wrote:
> The field 'transition_task' of policy structure is used to track the
> task which is performing the frequency transition. Using this field to
> print a warning once detect a case where the same task is calling
> _begin() again before completing the preivous frequency transition via
> the _end().
> 
> However, there is a potential race condition in _end() and _begin() APIs
> while updating the field 'transition_task' of policy, the scenario is
> depicted below:
> 
>              Task A                            Task B
> 
>         /* 1st freq transition */
>         Invoke _begin() {
>                 ...
>                 ...
>         }
>                                         /* 2nd freq transition */
>                                         Invoke _begin() {
>                                                 ... //waiting for A to
>                                                 ... //clear
>                                                 ... //transition_ongoing
>                                                 ... //in _end() for
>                                                 ... //the 1st transition
>                                                         |
>         Change the frequency                            |
>                                                         |
>         Invoke _end() {                                 |
>                 ...                                     |
>                 ...                                     |
>                 transition_ongoing = false;             V
>                                                 transition_ongoing = true;
>                                                 transition_task = current;

Task B here won't move ahead until "wake_up(&policy->transition_wait)"
is called, isn't it ?

Also I think the CPU is free to change the order of the two
instructions and so this commit won't make a difference. Also I don't
feel there is a race here as wake_up() hasn't happened.

>                 transition_task = NULL;
>                 ... //A overwrites the task
>                 ... //performing the transition
>                 ... //result in error warning.
>         }
> 
> To fix this race condition, the order of the updates to the
> 'transition_task' and 'transition_ongoing' fields has been changed, the
> 'transition_task' field is now cleared before the 'transition_ongoing'
> field, which ensure that only one task can update the 'transition_task'
> field at a time.
> 
> Fixes: ca654dc3a93d ("cpufreq: Catch double invocations of cpufreq_freq_transition_begin/end")
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index a757f90aa9d6..f8eb6dde57f2 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -455,8 +455,8 @@ void cpufreq_freq_transition_end(struct cpufreq_policy *policy,
>  			    policy->cur,
>  			    policy->cpuinfo.max_freq);
>  
> -	policy->transition_ongoing = false;
>  	policy->transition_task = NULL;
> +	policy->transition_ongoing = false;
>  
>  	wake_up(&policy->transition_wait);
>  }
> -- 
> 2.34.1

-- 
viresh
