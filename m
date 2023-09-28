Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165697B14BC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjI1HY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjI1HYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:24:24 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2149499
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:24:22 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-405361bba99so123804605e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695885860; x=1696490660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+UA9uHWWeYBOdu4MsloFMHQ1l07sPdcS1vaYRXSvUR8=;
        b=HcKSu2ffDMyf2m/+ZhRD5BKwWRMUnWt3xkFekzABD2LT9XhxMBDlg2E35GXOtsD1mq
         lR/zYCnbMIeVczvaAz9U2bqgQh+HFyP6z64V3oULZTC2BPjou/pFILeE6cPp/yAnnjnT
         rcDuXLnSqgOVJOubhK4oC84xKZcImgpZiuzYdJwBsRGIFGED1AUKHiYgLwMpEDveYzMm
         eocladxAXfHAcHhJzUbN28tUmofGJjOM3hKfqMy978uCsy2RnZFaBvecYH2T/d4H4MXB
         kKOZ9Ga5XBLGXv7eTOR+O+sytiL0HifPLVWebo0uspYuTSCD8UAuIKC0KANTd03ibWg+
         Te5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695885860; x=1696490660;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+UA9uHWWeYBOdu4MsloFMHQ1l07sPdcS1vaYRXSvUR8=;
        b=cJkuKGepOnMmc1DxTj7k8PpYEXaddFz/tXzucFfjpztiQuGWBoDJ1byM+ckCEcUJHx
         LqIr5/Vnb3wIqgpB3xYreAR1QU+9W07K9rDPU0pCg3AkXZ2zS8DvkmTv0xJNr4zib2DW
         xAC5iodPCt3HKHFTiG3bNMse/k50CWvn42/Y9BggknxkchUnpuGBLOsbLONMjfwfRfJP
         H5veDT9TEclVvjiCeX6clWvSvwLWB6R8Kyzspc+NcTNSQXFMt+w0fVPjw7dpTkog6rm2
         3f4Hj01r4TicbBxOgoIn48GD+iUG9FZme+vXZGej2HXuwhxRSx2sbTmSZr83lbjdy8nq
         EReA==
X-Gm-Message-State: AOJu0Yxv5w721UodLPyrrsHea68HdJh70j4jZcWPpPEYkNJt832b3YO0
        Km0rIUHzKz9ULAx7Vjd7JnnI9Ehi3DADp7gYa8U=
X-Google-Smtp-Source: AGHT+IEcIlXAmdvv9WcCA53AfD+QpBf5eGEwdf+8z26e7iBPCWPvls3jal7oS+TqSFQzP2rJYRmDnQ==
X-Received: by 2002:a1c:6a09:0:b0:401:b76d:3b8b with SMTP id f9-20020a1c6a09000000b00401b76d3b8bmr406862wmc.16.1695885860422;
        Thu, 28 Sep 2023 00:24:20 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id u17-20020a05600c00d100b00405935b417asm9400467wmm.2.2023.09.28.00.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 00:24:20 -0700 (PDT)
Message-ID: <87dd2af9-ea1f-7995-2b3b-eaed356c659e@linaro.org>
Date:   Thu, 28 Sep 2023 09:24:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 11/13] ACPI: thermal: Do not use trip indices for
 cooling device binding
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <1957441.PYKUYFuaPT@kreacher> <113039009.nniJfEyVGO@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <113039009.nniJfEyVGO@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2023 20:02, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Rearrange the ACPI thermal driver's callback functions used for cooling
> device binding and unbinding, acpi_thermal_bind_cooling_device() and
> acpi_thermal_unbind_cooling_device(), respectively, so that they use trip
> pointers instead of trip indices which is more straightforward and allows
> the driver to become independent of the ordering of trips in the thermal
> zone structure.
> 
> The general functionality is not expected to be changed.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

