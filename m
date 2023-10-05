Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDA67BA544
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239568AbjJEQPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240476AbjJEQNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:13:07 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EA123537
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 03:59:03 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-27763c2c22eso557228a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 03:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696503543; x=1697108343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JNyCQ67xdT96qFsLCo+WWGtR8HPuUjeLj+uqNqnLI8g=;
        b=Tp5lTQkkRcFT7HVAS5m2wq+oEvkf5NYnCcmBwt8gRlk9H1wsDQNU25D+f+rb7CI8IQ
         XCEjaSXvf9YjMufPTULOByVskjvlLsrut9vlPCVLibdzaEvLOA/Ryucsjfv3JE2QC3DB
         4+4dcq4mVaWK3h6hNG50FVCFQfbntE1WVnfGZqoKOBCeNqNxtypBfCsFtGb2tkArW9Gr
         ZLfGpgt2TAS6S1jCp+cAvgqs+UlgNtoD7da/rAd1N9o4wIe95joiHqz9qaat6tE5HIsW
         tKJLsjkYP6sFWpEvIjvAZpth91OPynBqQoUABQhyLhXhxm7/CR4g8OCvbv7r2vXlF9Jk
         E68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696503543; x=1697108343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNyCQ67xdT96qFsLCo+WWGtR8HPuUjeLj+uqNqnLI8g=;
        b=cz3CWCvdNIVb6IaYN4tKV0jGh+66TlGRDunzFfM5zkjvZx75XR8vn0Uoi91EwWDWhz
         tVaOwl0pG+92EVbAfEKq+3EgBXhy4bwUIdlLFYxGyZMNczZyOtsqFLTQyKhCpjKgKQlX
         zF63ijbg+ketjpPIzm5phlkM/t324zjFrwgzmIheaLY8wcS/7KsV4GQ4ReykX8ht64Cn
         duoBY39Hfo51pianVZ81YKd9EefLKHNVKEhgXrnZFpFpFzUQWM1abYUXaeaq0YxE00XR
         fRGPGrZydFiqe/GPXa8KSHtX8M258XMVwlZopj4xqKhD6WYUQf7ZECQP4gqgi/AAzJeN
         5Y3w==
X-Gm-Message-State: AOJu0Ywox2Tx6kEz8wyE4aF5l/1teYVlfP3mWi7PCSltK4L6gjK8VhCD
        S7KSoW6XQNOWpWr4pzcP/8lyjA==
X-Google-Smtp-Source: AGHT+IEqVdlbNS4vW9mOpsOKz3y7xe+62W+DJy82LP+RQC3oEmT65otErnMxK2N9X98S9Eq1rXS2Yw==
X-Received: by 2002:a17:90a:850b:b0:274:3d7d:e793 with SMTP id l11-20020a17090a850b00b002743d7de793mr4575546pjn.47.1696503543399;
        Thu, 05 Oct 2023 03:59:03 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090ace8400b00274b9dd8519sm1254350pju.35.2023.10.05.03.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 03:59:02 -0700 (PDT)
Date:   Thu, 5 Oct 2023 16:29:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: conservative: Simplify the condition of storing
 'down_threshold'
Message-ID: <20231005105900.uctt4jna4wovt5g6@vireshk-i7>
References: <20230912060942.2516761-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912060942.2516761-1-liaochang1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-09-23, 06:09, Liao Chang wrote:
> The governor currently checks if the input new down_threshold is less
> than 100 before storing it. However, the up_threshold field of dbs_data
> structure is also limited to be less than 100, so this check is
> unnecessary and remove it.
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq_conservative.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index b6bd0ff35323..56500b25d77c 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -187,8 +187,7 @@ static ssize_t down_threshold_store(struct gov_attr_set *attr_set,
>  	ret = sscanf(buf, "%u", &input);
>  
>  	/* cannot be lower than 1 otherwise freq will not fall */
> -	if (ret != 1 || input < 1 || input > 100 ||
> -			input >= dbs_data->up_threshold)
> +	if (ret != 1 || input < 1 || input >= dbs_data->up_threshold)
>  		return -EINVAL;
>  
>  	cs_tuners->down_threshold = input;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
