Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AA77E0CD3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 01:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjKDAnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 20:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjKDAm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 20:42:58 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B55D68;
        Fri,  3 Nov 2023 17:42:55 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6c32a20d5dbso2303809b3a.1;
        Fri, 03 Nov 2023 17:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699058575; x=1699663375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CUkhFvPBjOwy9Bs9qLyQG2xWHxJg5Ro4utI7JQbNscc=;
        b=huGngEhUHes84qydZJp0HvYjDqmdvel0RNaUJiM7vKTGH3Co6eq/ZUxfD4CgHw3Mqr
         njF+MNDIIIE6V6NnFeBNr8RVxMqUa7k/om8sMaH5AXfksK4OeMEqp05Q6rDBTQRS6Gex
         YVjRx0lQKSU9yExzJa0vXezWSHXtZRUhZoE25l6hUC9qk+MsmdDiZT0oxSUXQpZ3yAAf
         mby9/GdVKkX8+ywlFFaCMp7Mnzs0qxBQ3O5w1kp9Ylcs/w0nQfY9Q1fKYeo7i+dT/LXu
         MGHla7HFVFlkclHSgXrBs7TCbwX2444PrWYg/3cyE2BMzg/2Mqb/sSCZCAjy//dIdxWU
         1VIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699058575; x=1699663375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUkhFvPBjOwy9Bs9qLyQG2xWHxJg5Ro4utI7JQbNscc=;
        b=eTq3g8GvhxoCSkF0Ap9pZiz8x6DdyxGDaafzSPGvA7ygb7VhJVrbD0Ap3UpuEwMF4J
         oZAZ+ELvzaR+Qiu+1Af91SY905yPx2w88wwpuwO8ElcjUIJ5w/F7QF0NA5vSqNyTMLfJ
         A5R/F63WM15bt6C+uzw1bi+V7db84G8SqDqRzz/3mvFsqAVLmYcWznDfW7RQc0uQZ/cW
         cYShYUCCSKz71iZvgomjX8fYKG54Js/skQBQqePJgWr8f3dHgFL0Cet2wkTYMKIVvWF9
         Ul7maL7BirMKJTaZCO9saZVFVOjhfxu1Ecg16tytDRnTdGLK5buxAuFXHonFcZ8K7fyP
         +gvg==
X-Gm-Message-State: AOJu0Yyjpnf2wbCtU+gKeE/sjQq6JPcQIMgV6FfLgsrmbiJTnVzwBWn7
        u93a5YqnZJxYhUqM98laFZJpEMlnsN0=
X-Google-Smtp-Source: AGHT+IHkpMjBFkA447J8MsntSGZ1uDY/CPUDViuu/fNEixP+xT8fguLvw+mGxnGSP5Algk3o16i0WQ==
X-Received: by 2002:a05:6a21:7896:b0:16b:79b3:210b with SMTP id bf22-20020a056a21789600b0016b79b3210bmr23025806pzc.31.1699058574708;
        Fri, 03 Nov 2023 17:42:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w2-20020a1709027b8200b001cc423bd99fsm1904440pll.170.2023.11.03.17.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 17:42:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 3 Nov 2023 17:42:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-watchdog@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        swboyd@chromium.org, Andy Gross <agross@kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] arm64: dts: qcom: sm8250: Make watchdog bark
 interrupt edge triggered
Message-ID: <bb770a4b-18aa-4001-8e79-79ab42324b54@roeck-us.net>
References: <20231103163434.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
 <20231103163434.5.I2910e7c10493d896841e9785c1817df9b9a58701@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103163434.5.I2910e7c10493d896841e9785c1817df9b9a58701@changeid>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 04:34:31PM -0700, Douglas Anderson wrote:
> As described in the patch ("arm64: dts: qcom: sc7180: Make watchdog
> bark interrupt edge triggered"), the Qualcomm watchdog timer's bark
> interrupt should be configured as edge triggered. Make the change.
> 
> Fixes: 46a4359f9156 ("arm64: dts: qcom: sm8250: Add watchdog bark interrupt")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index be970472f6c4..72db75ca7731 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -6018,7 +6018,7 @@ watchdog@17c10000 {
>  			compatible = "qcom,apss-wdt-sm8250", "qcom,kpss-wdt";
>  			reg = <0 0x17c10000 0 0x1000>;
>  			clocks = <&sleep_clk>;
> -			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
>  		};
>  
>  		timer@17c20000 {
> -- 
> 2.42.0.869.gea05f2083d-goog
> 
