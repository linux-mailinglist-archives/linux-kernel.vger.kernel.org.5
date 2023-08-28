Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B143778A637
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbjH1HAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 03:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjH1HAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:00:12 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E531A6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:00:03 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a88e1a5286so2300825b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693206003; x=1693810803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TcvDWImdRFz5jCiU++2QTtVKsjAo9nhqa75faNfZ0Kk=;
        b=SJ5o4ovS9lhckyxuxHtr83OpMUr4s24UJSs2LXZj70aWfby1dkCOcTN9cj3d3LxdYT
         YI8hobvxjzwqFljlJTs5LwuQ7NnPvFP8YkqKXK6Tqm+pmwkEGWuwh7ez5Q8nFbOsaRdG
         GQ0D3vnzR+JgRaSoPD/tTeBmY4W5sYpWFh2JSfZc+7TfadwxsyUvXFUPLkmSxzt0g+4/
         Fz5HO+sTxiaZa10gNxq6kg3Kf5rz/4aH1q6/RuntnPW7jL3FaDn6XKoLwvr12DwsSJQu
         k5QlJ0urjRc/6RgIy3/2lK8Zt0X8xawbiDl3ssng42wo/9H0lDYN93/kcsNQoTyzOLSl
         hL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693206003; x=1693810803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcvDWImdRFz5jCiU++2QTtVKsjAo9nhqa75faNfZ0Kk=;
        b=CF1qOVGymrnRMXZzsUT4IjjFX0VmPxrSY0BOBllWhapLfzUNmREsm+B/f70+hjd9am
         jbcJ5qwmEOZKFUAAW3uKNTyhFzv9oRZ4jj5qdjQ2YfAdV7Uvj5YnyWfF23kW/YABNH1b
         fb42SYcDpnqApOTABq2uhmKbMQM9ZpfeIe86hJnb9NWaJ4l+GGm4VMuQ7fw3/rI3SstE
         TZsLH+hHusvpNX+ToVPwvA3domun85U1nHFv3830p7t1jLvwGE0fPuYE24FumeUsmusp
         TqxAWwbrtVxXU4YZY9RVVtqD7IUQjZW2Uj14jwo6FOWer4lx883slwXuFuCJGw8rYPUH
         gXRg==
X-Gm-Message-State: AOJu0YzcsYrf4uogWbcKDQA9j0ax5LvoTl9Ng/3L0P3OmmNcOcwWSn4P
        6bpWlmV8zvcZiH1crH7i3tDS3VJhsIZ+JTgwtjU=
X-Google-Smtp-Source: AGHT+IG8ceQ3DNz1itVtRa0Gbp3Hl/oH8yZjPPYTmA2VmclhNWasPUuE57b/6wPAyCZBfoAkz/9+5A==
X-Received: by 2002:aca:1719:0:b0:3a4:4b42:612b with SMTP id j25-20020aca1719000000b003a44b42612bmr10049764oii.42.1693206003310;
        Mon, 28 Aug 2023 00:00:03 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id t25-20020aa79399000000b0068be4ce33easm6046003pfe.96.2023.08.28.00.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 00:00:02 -0700 (PDT)
Date:   Mon, 28 Aug 2023 12:30:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Fix inconsistency in error messages of
 cpufreq_resume/suspend()
Message-ID: <20230828070000.ooymfbw3qhs5xl5y@vireshk-i7>
References: <20230826095201.1137288-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230826095201.1137288-1-liaochang1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-08-23, 09:52, Liao Chang wrote:
> The error message printed by cpufreq_resume() currently is the pointer
> value of the policy structure, while the error message printed by
> cpufreq_suspend() is the name of the driver. In order to make the error
> messages more consistent and easier to understand, change the error
> message printed by cpufreq_resume() to the name of driver.

Also I don't think printing kernel addresses will help much anyway,
and it also may not be recommended.

> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index c835ff117386..2199c04ac64d 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1943,8 +1943,8 @@ void cpufreq_resume(void)
>  
>  	for_each_active_policy(policy) {
>  		if (cpufreq_driver->resume && cpufreq_driver->resume(policy)) {
> -			pr_err("%s: Failed to resume driver: %p\n", __func__,
> -				policy);
> +			pr_err("%s: Failed to resume driver: %s\n", __func__,
> +				cpufreq_driver->name);
>  		} else if (has_target()) {
>  			down_write(&policy->rwsem);
>  			ret = cpufreq_start_governor(policy);

There is another print down here which prints policy, please update
that too in a similar way.

-- 
viresh
