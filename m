Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E1976423A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 00:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjGZWk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 18:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjGZWkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 18:40:25 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FD42680
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 15:40:24 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-66c729f5618so357438b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 15:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690411224; x=1691016024;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9caknxSMLJ8/I6yMwEAauRGM8KCY4LpGz9gaodd75Y4=;
        b=z9E4wYAl7Kbyd0MpW30QeQz71g8gC1KvQPuBLAlk4L7sx45+1e+yocHJ9W5oLLhO36
         FN3OSyDOAdoEOLn/6d4XHlejXbW0vSu1JFhGFBkeGHsvEAaP5K6+ELq7sLl6WQEkXIEU
         gpisYolH4vdNjHhmeUFwoGGH1GQQ+eaADPEpMiPf431fMk2khFcowQDrDoOHjEcIBkp9
         OaOrMnDy3//QThWP9jmzlrnkDA7Y7GAg4pDQ4aLZgy7vgw02IPrqYHwn1to1/dLhMjTi
         jfhodLf3dzMfCZ215I4dDfuhux2j7dpO5N/kAZQESLod08LD49TTNJCLNJ0clsEy/0Bl
         k2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690411224; x=1691016024;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9caknxSMLJ8/I6yMwEAauRGM8KCY4LpGz9gaodd75Y4=;
        b=PbO7kvUVCOF878xB9MQkiPieylZYd32u0B1rnw9PEBRMgdPkQojBRrunF7KsCzvfU6
         9FK0Ju4R29pZF19PZp2lBijqoSljKs+KtyFBF/HrHK4PeBgWmhayaFnCeyqOGLdVGfnl
         xJMm+SUHT7jNzVcBGb1JDP8YyaxACP2r0r3aPtcf5229G2Bc3qB7cFZsoDTdyWbyTRBo
         SOi/0ttA3zy3Z1B7ND1MHqnRdiBYa3/d0ChjoxuIEG7qwHg8O39ivlyuSqtgsswTWXes
         8JLs7XkVI8a3Izl+ucxHRAQmrhqydaAxPdvQZzRZ5EvP5RL77mrPHrJyTLqwhMigoBjC
         Sclg==
X-Gm-Message-State: ABy/qLZo3kHjnstsmy2fc+huo6Kp7z+jjUwzV5uAnv2dtR5YaRY4MOS1
        o50JxzdgbNlGq9nRemccZeGcEL7OcXSTB7gaF0/+QuQe
X-Google-Smtp-Source: APBJJlELtzA6yQFjcOkGA+IAseqrN3tDU/89TVRlDOYX3rh6eyHu5Q+Cam0M5MOKnrjt0RfM4YUbDQ==
X-Received: by 2002:a17:90b:885:b0:268:4142:2ee1 with SMTP id bj5-20020a17090b088500b0026841422ee1mr3073258pjb.11.1690411224265;
        Wed, 26 Jul 2023 15:40:24 -0700 (PDT)
Received: from localhost ([75.172.135.98])
        by smtp.gmail.com with ESMTPSA id ep11-20020a17090ae64b00b00262eccfa29fsm1673297pjb.33.2023.07.26.15.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 15:40:23 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: Re: [PATCH V2 3/4] soc: c3: Add support for power domains controller
In-Reply-To: <20230707003710.2667989-4-xianwei.zhao@amlogic.com>
References: <20230707003710.2667989-1-xianwei.zhao@amlogic.com>
 <20230707003710.2667989-4-xianwei.zhao@amlogic.com>
Date:   Wed, 26 Jul 2023 15:40:23 -0700
Message-ID: <7ha5vii9ew.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xianwei Zhao <xianwei.zhao@amlogic.com> writes:

> Add support for C3 Power controller. C3 power control
> registers are in secure domain, and should be accessed by SMC.
>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
> V1 -> V2: Fixed some formatting.
> ---
>  drivers/soc/amlogic/meson-secure-pwrc.c | 26 +++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/soc/amlogic/meson-secure-pwrc.c
> index c11d65a3e3d9..a1ffebf70de3 100644
> --- a/drivers/soc/amlogic/meson-secure-pwrc.c
> +++ b/drivers/soc/amlogic/meson-secure-pwrc.c
> @@ -11,6 +11,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <dt-bindings/power/meson-a1-power.h>
> +#include <dt-bindings/power/amlogic,c3-pwrc.h>
>  #include <dt-bindings/power/meson-s4-power.h>
>  #include <linux/arm-smccc.h>
>  #include <linux/firmware/meson/meson_sm.h>
> @@ -120,6 +121,22 @@ static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
>  	SEC_PD(RSA,	0),
>  };
>  
> +static struct meson_secure_pwrc_domain_desc c3_pwrc_domains[] = {
> +	SEC_PD(C3_NNA,	0),
> +	SEC_PD(C3_AUDIO,	GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(C3_SDIOA,	GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(C3_EMMC,	GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(C3_USB_COMB, GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(C3_SDCARD,	GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(C3_ETH,	GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(C3_GE2D,	GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(C3_CVE,	GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(C3_GDC_WRAP,	GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(C3_ISP_TOP,		GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(C3_MIPI_ISP_WRAP, GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(C3_VCODEC,	0),
> +};

All of these domains being hard-coded to ALWAYS_ON looks suspicious, and
can also be an indicator that the drivers for these domains are not
(properly) using runtime PM, or not connected to the correct domains the DT.

Similar to the tables for s4 and a1 in this same file, please describe
the reason that each of these domains needs to be hard coded to be
always on.

Thanks,

Kevin
