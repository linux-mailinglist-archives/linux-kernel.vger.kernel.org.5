Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B446A7E0CE4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 01:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjKDAns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 20:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjKDAnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 20:43:43 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A99B10DD;
        Fri,  3 Nov 2023 17:43:34 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cc30bf9e22so21544065ad.1;
        Fri, 03 Nov 2023 17:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699058614; x=1699663414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cqSceVMXD1eHi5hLYGzwTv7cs9JC+pKNY2zouKZDISI=;
        b=Yb+vMqkWOcXHEFfsi8+l+0XIxMLRWdy86j89xFwnFHHe8YDMQ8CaVP52xs6gwrVS4R
         Xc/c2mDYX7Dt5XgJ9OCYvl83LxALw4yt4SWT8S5Uza8Q0drbIcr8QOmalWNsVKAy8pRw
         u4PaF1axienXcutZBqT9LNcYpCKXsjBDpzbkMwqjBb25vNh8vBVn0pWrYUx6mPfYXhVN
         w/lKsQqpXFqkjzhKuZGm/fHozU5hyvwww8/QTrZsHlxI4s0S/6nQ3CGvTMVr0vQtkrr3
         IXu6PdaFQz1Hku1WA6WLUEguNwy/ItjUEFVCgfTYn1Tk9sF2vU90A4eavZuVjI4iTV4G
         8Lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699058614; x=1699663414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqSceVMXD1eHi5hLYGzwTv7cs9JC+pKNY2zouKZDISI=;
        b=eTRnesjsuawDwn+zvnQKg6YkQF9CmGbRPmFAyDaHMWyuMVsQCmROW8AIIuKbktycky
         2NcKe1+aeZSmfSG2TXgWMQvBf8NNXnDo30tmCmP52JCIVNgAJCV3m9FNh2B1V2G0kUQo
         rrXkm7P+qWQbZmviBTMLnVXgaAGs1PIMAdQdm7eG8IdtCuduqVL5EJCVDt83Z9o/ifqI
         OU0UCpUOJ1+yoONr68/1pi2KpP/Atjqtuw0tjgQYVai1KD7On2U8uOYNErwR4NIvaJa7
         hh4Of9vElNJYpQHrUj3B38wGB3i/TA9uIMWr++Atc6PLgzx4g4Hx1Ls7zr/DXGF1p8Zm
         PrJw==
X-Gm-Message-State: AOJu0YxaZVu23ifYO0CoR2T9psHs0RIV2IdwEsyGoNOTUbid2Rz2Pf0q
        8liBB820s5d2M6uXjEeO0+4=
X-Google-Smtp-Source: AGHT+IG6Fcj8HMBeEPe8SjwnPs/d3R2uXD6gqiDw3+8NVAkMYGcDgLXpZDSu2+S2rO2SE77bp2mEBA==
X-Received: by 2002:a17:902:e548:b0:1cc:4488:afba with SMTP id n8-20020a170902e54800b001cc4488afbamr5668798plf.6.1699058613946;
        Fri, 03 Nov 2023 17:43:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y7-20020a170902b48700b001bf52834696sm1886037plr.207.2023.11.03.17.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 17:43:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 3 Nov 2023 17:43:32 -0700
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
Subject: Re: [PATCH 9/9] dt-bindings: watchdog: qcom-wdt: Make the interrupt
 example edge triggered
Message-ID: <85f1d69b-99e0-4782-8a1d-6804c893f055@roeck-us.net>
References: <20231103163434.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
 <20231103163434.9.Ie30c1d3f780666f6906fd2fd7c437632c229d987@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103163434.9.Ie30c1d3f780666f6906fd2fd7c437632c229d987@changeid>
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

On Fri, Nov 03, 2023 at 04:34:35PM -0700, Douglas Anderson wrote:
> As described in the patch ("arm64: dts: qcom: sc7180: Make watchdog
> bark interrupt edge triggered"), the Qualcomm watchdog timer's bark
> interrupt should be configured as edge triggered.
> 
> Update the example in the bindings.
> 
> Fixes: 7c631cdff391 ("dt-bindings: watchdog: qcom-wdt: allow interrupts")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
>  Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> index 5046dfa55f13..681d1efbaf2f 100644
> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> @@ -121,7 +121,7 @@ examples:
>          compatible = "qcom,apss-wdt-sm8150", "qcom,kpss-wdt";
>          reg = <0x17c10000 0x1000>;
>          clocks = <&sleep_clk>;
> -        interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
>          timeout-sec = <10>;
>      };
>  
> -- 
> 2.42.0.869.gea05f2083d-goog
> 
