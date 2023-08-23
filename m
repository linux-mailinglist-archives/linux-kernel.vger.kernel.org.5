Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C9F785C7A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbjHWPsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjHWPsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:48:43 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB04E70;
        Wed, 23 Aug 2023 08:48:41 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bf092a16c9so45228965ad.0;
        Wed, 23 Aug 2023 08:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692805721; x=1693410521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8RVO8QqpSGvwCTtzSEj1vfVHlrvdmi9jWM0i/g4wXFg=;
        b=pFLPKKwwMuUPRgUdp4DrC6Adp1yFskvPhC81gUI0SfmHdYwuaQ3Zc0rtitfPoqHiU2
         Ow7Nd4FKMzDl98iOvlNKlpwIJDxZ1wYtVmo9M7WTy+XmtlH7Z9quUIjsumGpRU4KzF1C
         15pAaCCUy0CDetch15cjXjH+rwQ+iiQO7hqJr4fmcMRylFV1YbHIfJqT+cqxPPrQZOLt
         GojFmYTP7VwCn6koRRlrorAxUMKqEyQkzOiy5O2IEOUus2YvaMtD3VDgiV+5Jphj9e3L
         oXpAQvYirKWho7zdxOSOJGdNDrTqfYCRGOx0uoASHqDSRWiv8okkCpYcXxN5ybn0ITrX
         czLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692805721; x=1693410521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RVO8QqpSGvwCTtzSEj1vfVHlrvdmi9jWM0i/g4wXFg=;
        b=NlmTFbwziGF1BV8tbWI5ShoN28tN0kOvzWwEkxtHKbuaUG5CaWiAsRO7PwwBvAFiyx
         2e+efncQCoTyBJz7l7MsTPFlJAX9faWzRN216h/sXZkYJsmxFSBSVccE+bjPDz06m6uX
         3OcXsyXZTUCJzEgubeaumlrlh//S371wTI69ekAWIJJWlxoIAX4Yf8tgiNTyjvkp7K4C
         R3EQA2jhhjz8vzMsrqOaWKSg2MBhETeXRm6nzbEKk9N5+ZSZ1/R+ti5IoyXOSNXOvEeM
         dooUzNFP8FdrUnlSUASY2f+FwYFH90zmvNk5JdI/KKcE2Y4dCckLhPFbFfwZdOrUaIFN
         Hssg==
X-Gm-Message-State: AOJu0YxNqz3WmzpzPv9ffZfMIMUjINada6056Otg3vVs/OFv02MfjOn6
        b3jEUnF23hnxrKfoNuEKWUE=
X-Google-Smtp-Source: AGHT+IHC16OTLZ0+ivhmKDzK81Q3Wf6FkNYZuDjC80GdNQmrIoepiTGx2xDRTvxp8HL6cwI0AwNAug==
X-Received: by 2002:a17:902:c943:b0:1bf:25a0:f874 with SMTP id i3-20020a170902c94300b001bf25a0f874mr15655824pla.65.1692805720977;
        Wed, 23 Aug 2023 08:48:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902ee4d00b001b8a3e2c241sm11144912plo.14.2023.08.23.08.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 08:48:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 23 Aug 2023 08:48:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Huqiang Qin <huqiang.qin@amlogic.com>
Cc:     wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/4] watchdog: Add support for Amlogic-T7 SoCs
Message-ID: <ceabbef7-e952-4e74-af10-e49946cb9c62@roeck-us.net>
References: <20230802033222.4024946-1-huqiang.qin@amlogic.com>
 <20230802033222.4024946-4-huqiang.qin@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802033222.4024946-4-huqiang.qin@amlogic.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 11:32:21AM +0800, Huqiang Qin wrote:
> Compared with the previous Amlogic-GXBB, the watchdog of Amlogic-T7
> has a different reset enable bit.
> 
> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
> Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> V1 -> V2: Use the BIT() macro to build rst initial value.
> 
>  drivers/watchdog/meson_gxbb_wdt.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
> index 18180d91543e..a48622d11ad7 100644
> --- a/drivers/watchdog/meson_gxbb_wdt.c
> +++ b/drivers/watchdog/meson_gxbb_wdt.c
> @@ -147,8 +147,13 @@ static const struct wdt_params gxbb_params = {
>  	.rst = BIT(21),
>  };
>  
> +static const struct wdt_params t7_params = {
> +	.rst = BIT(22),
> +};
> +
>  static const struct of_device_id meson_gxbb_wdt_dt_ids[] = {
>  	 { .compatible = "amlogic,meson-gxbb-wdt", .data = &gxbb_params, },
> +	 { .compatible = "amlogic,t7-wdt", .data = &t7_params, },
>  	 { /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, meson_gxbb_wdt_dt_ids);
