Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EA0759FA1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjGSUZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjGSUZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:25:00 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E5E189;
        Wed, 19 Jul 2023 13:24:59 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so40290f8f.2;
        Wed, 19 Jul 2023 13:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689798297; x=1692390297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=II4pOhAnZLbg1QPz0IT2mUqTloT5mz679IpkRa1kSJQ=;
        b=AFxPFR/oO/HhsNhrO5884JQFc3TCMBQUJ2FEJLkpfpr9YBmx8N7DF4GspbC6J/eJf4
         oScwuHHkPwHEipOiXu7WSIqbJchztvgw1njxABZmbjLvnqi/GxFPYV09L7HbjevwBGPq
         8nsc73tXAfnIA9JbSk7M0sv57N78lVexdTEcI7ZdLCYQWNpp9K8lrpbVFVlvgTgotqAs
         4TKpH8u1UX2i2Qk2TvzwwMjhgsg0rQE0Z8rvUUTXG9f4PV6jOkOUrpbXIAybDvqEXM+5
         7vM6jQ9/2TUSd5KbSWySp77Nx7CUYv8sOUHIg5gCsCS/GEDS7ClO/Qub/aMUYiyI3B4A
         mUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689798297; x=1692390297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=II4pOhAnZLbg1QPz0IT2mUqTloT5mz679IpkRa1kSJQ=;
        b=O0EqxQPRHXEZ5jEDZUd1FrvFStQ1wnT1eVczWeC87TMk/yRiqCK39PWMGAWB9eHtH2
         acH5MXdNl/iKY1E4acCDDojrTGwgSntrcw2uJxqvxiXa1je2xrUklNWHpIqJ1JR71Efp
         /HaJ+oTKoybCteiLfsMaeTPbnQn+Xqg9DOdCu722+eDwAXWesyViDc33RXC8Uxi6kaNz
         2VRPep0mmIjBR8OjENJrkBz4rkk+wsrbc4MXi0Z3KegVBCoG3zuNYePrRk/TF+y+yKWd
         i26qePqBbHnnvajhHR7bPsGsI+slW5p/aRk8SuGy+sB5tfycByoI4jjdN6ElUX6bM1Ya
         AKXg==
X-Gm-Message-State: ABy/qLYGR9xhIaLHcYCCPcWfURTOtomfrAZ4J27/2F9KphZL+6LEwxWj
        MMW4gfDbwu+ONZ7gpbDNWLM=
X-Google-Smtp-Source: APBJJlFczgG4DcFeW4Cbe7JzqBZx5Q8PFpv6TkXeA8vuVWSPw0TIwWH7PPJAodcjhRj6fRZR3p9orA==
X-Received: by 2002:a5d:51d1:0:b0:313:f957:bf29 with SMTP id n17-20020a5d51d1000000b00313f957bf29mr726554wrv.65.1689798297287;
        Wed, 19 Jul 2023 13:24:57 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id x6-20020adff0c6000000b0030fb828511csm6075388wro.100.2023.07.19.13.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 13:24:56 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Hugh Dickins <hughd@google.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] thermal/drivers/sun8i: Don't fail probe due to zone registration
 failure
Date:   Wed, 19 Jul 2023 22:24:55 +0200
Message-ID: <3240466.aeNJFYEL58@jernej-laptop>
In-Reply-To: <20230718-thermal-sun8i-registration-v1-1-c95b1b070340@kernel.org>
References: <20230718-thermal-sun8i-registration-v1-1-c95b1b070340@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 18. julij 2023 ob 17:04:22 CEST je Mark Brown napisal(a):
> Currently the sun8i thermal driver will fail to probe if any of the
> thermal zones it is registering fails to register with the thermal core.
> Since we currently do not define any trip points for the GPU thermal
> zones on at least A64 or H5 this means that we have no thermal support
> on these platforms:
> 
> [    1.698703] thermal_sys: Failed to find 'trips' node
> [    1.698707] thermal_sys: Failed to find trip points for thermal-sensor
> id=1
> 
> even though the main CPU thermal zone on both SoCs is fully configured.
> This does not seem ideal, while we may not be able to use all the zones
> it seems better to have those zones which are usable be operational.
> Instead just carry on registering zones if we get any non-deferral
> error, allowing use of those zones which are usable.
> 
> This means that we also need to update the interrupt handler to not
> attempt to notify the core for events on zones which we have not
> registered, I didn't see an ability to mask individual interrupts and
> I would expect that interrupts would still be indicated in the ISR even
> if they were masked.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
> I noticed this while trying to debug an issue with memory corruption on
> boot which since the merge window has prevented Pine64 Plus (an A64)
> from booting at all:
> 
>   
> https://storage.kernelci.org/mainline/master/v6.5-rc2/arm64/defconfig/gcc-1
> 0/lab-baylibre/baseline-sun50i-a64-pine64-plus.txt
> 
> (which I bisected to a random memory management change that clearly
> wasn't at fault) and has been causing less consistent but still very
> severe boot issues on Libretech Tritium (a H3).  The corruption appears
> to happen when unbinding a the one thermal zone that does register, I've
> not figured out exactly where.
> 
> The memory corruption issue obviously needs to be dealt with properly
> (I'm still digging into it) but this does allow both platforms to boot
> reliably and seems like a sensible thing to do independently, ideally we
> could get this in as a fix.
> ---
>  drivers/thermal/sun8i_thermal.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/sun8i_thermal.c
> b/drivers/thermal/sun8i_thermal.c index 195f3c5d0b38..b69134538867 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -190,6 +190,9 @@ static irqreturn_t sun8i_irq_thread(int irq, void *data)
> int i;
> 
>  	for_each_set_bit(i, &irq_bitmap, tmdev->chip->sensor_num) {
> +		/* We allow some zones to not register. */
> +		if (IS_ERR(tmdev->sensor[i].tzd))
> +			continue;
>  		thermal_zone_device_update(tmdev->sensor[i].tzd,
>  					   
THERMAL_EVENT_UNSPECIFIED);
>  	}
> @@ -465,8 +468,17 @@ static int sun8i_ths_register(struct ths_device *tmdev)
> i,
>  						      
&tmdev->sensor[i],
>  						      
&ths_ops);
> -		if (IS_ERR(tmdev->sensor[i].tzd))
> -			return PTR_ERR(tmdev->sensor[i].tzd);
> +
> +		/*
> +		 * If an individual zone fails to register for reasons
> +		 * other than probe deferral (eg, a bad DT) then carry
> +		 * on, other zones might register successfully.
> +		 */
> +		if (IS_ERR(tmdev->sensor[i].tzd)) {
> +			if (PTR_ERR(tmdev->sensor[i].tzd) == -
EPROBE_DEFER)
> +				return PTR_ERR(tmdev-
>sensor[i].tzd);
> +			continue;
> +		}
> 
>  		devm_thermal_add_hwmon_sysfs(tmdev->dev, tmdev-
>sensor[i].tzd);
>  	}
> 
> ---
> base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
> change-id: 20230718-thermal-sun8i-registration-df3a136ccafa
> 
> Best regards,




