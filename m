Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB50762257
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjGYTf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGYTf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:35:57 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5191FE5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 12:35:56 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-98377c5d53eso938986566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 12:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690313753; x=1690918553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gclOxOI7R55sgWeaMlz/Z0n4pJQKGgWmP/XSgabn5CQ=;
        b=Y9R+Cxepw00O08yzgAeyVjwFQZsM/JKs0HLJC9v/ANZbVyQQDrkaZtmiEIW1poNrhJ
         Hze00kw8vtlXD4HgWQ0qKFEyGp5kAr0FhWEVSbm/gHqGL2yOBAIRp+KgGo/1S560+axl
         ln+NRnGFcpt3zVcoW43vg0PKdm6oZNQJc97jQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690313753; x=1690918553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gclOxOI7R55sgWeaMlz/Z0n4pJQKGgWmP/XSgabn5CQ=;
        b=H40YScFnS/oJVl+2hDG6TwTGR1DCc2ihj4ABoa6cat74Z7uOMvl3yn9HhrWoPhCd72
         355TrHGI6RZjHYi3/DYKsFCjjqstatvdtXvH1ao/2sDkxug3oik83oY/41ZokHAiKhat
         e296Re8hk24IJfLuzEVyiZ6Wv2THCsurlDbB0K/bbf/Ia7hOZEZBYrM9T68UBbzRRqXp
         0OeZ/DA+BzToVNFrhLseTMCAYqPq+GhWVb1uPD3TfD6NT7M8u+aOXgNhVjfYoiF9smMe
         iiytIXjSkwo8qHRpd+8NsY+a9AJRZYbAym+KMbz4ZGqU+VbDm48AefVeg8PJWrwvyo1p
         GpWA==
X-Gm-Message-State: ABy/qLbkZl8zCLinSM9Xenj6x2iCEVrUDAqFBsiXQTZqICVj4ugM67wt
        hxzdeUvYCBSXRz13gDzFVw3iADC7cSyi30UsMFhi5VfW
X-Google-Smtp-Source: APBJJlGbYlwMlBLEGkNycnQdZHBTktU/Nyg1iExpuLx+PZ/fLIytf161v92ushD6yOlmy8dINwrwiw==
X-Received: by 2002:a17:906:3f5d:b0:99b:6e54:bd6e with SMTP id f29-20020a1709063f5d00b0099b6e54bd6emr10376782ejj.56.1690313753376;
        Tue, 25 Jul 2023 12:35:53 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a5-20020a170906274500b009932337747esm8549707ejd.86.2023.07.25.12.35.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 12:35:52 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5223910acf2so3136a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 12:35:52 -0700 (PDT)
X-Received: by 2002:a50:9514:0:b0:519:7d2:e256 with SMTP id
 u20-20020a509514000000b0051907d2e256mr170514eda.0.1690313752109; Tue, 25 Jul
 2023 12:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230725084633.67179-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230725084633.67179-1-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Jul 2023 12:35:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xt26=rBf99mzkAuwwtb2f-jnKtnHaEhXnthz0a5zke4Q@mail.gmail.com>
Message-ID: <CAD=FV=Xt26=rBf99mzkAuwwtb2f-jnKtnHaEhXnthz0a5zke4Q@mail.gmail.com>
Subject: Re: [PATCH RFT] arm64: dts: qcom: sc7280: drop incorrect EUD port on
 SoC side
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 25, 2023 at 1:46=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Qualcomm Embedded USB Debugger (EUD) second port should point to Type-C
> USB connector.  Such connector was defined directly in root node of
> sc7280.dtsi which is clearly wrong.  SC7280 is a chip, so physically it
> does not have USB Type-C port.  The connector is usually accessible
> through some USB switch or controller.
>
> Correct the EUD/USB connector topology by removing the top-level fake
> USB connector and adding appropriate ports in boards having actual USB
> Type-C connector defined (Herobrine, IDP).  All other boards will have
> this EUD port missing.
>
> This fixes also dtbs_check warnings:
>
>   sc7280-herobrine-crd.dtb: connector: ports:port@0: 'reg' is a required =
property
>
> Fixes: 9ee402ccfeb1 ("arm64: dts: qcom: sc7280: Fix EUD dt node syntax")
> Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Not tested on hardware.
> ---
>  .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 15 +++++++++++++
>  .../arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi | 15 +++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi          | 21 +------------------
>  3 files changed, 31 insertions(+), 20 deletions(-)

FWIW, I've always been very intrigued about the embedded USB port but
never managed to find any way to get it actually enabled. :( ...so I'm
probably not the best person to actually review this. That being said:

1. I'm nearly certain that this is completely unusable on herobrine
boards. Specifically on herobrine there's a USB hub between the SoC
and all the physical ports on the device and (I think?) that prevents
EUD from working. It is possible that hoglin/zoglin is an exception
here and Qualcomm might have some backdoor way to access EUD on these
devices since this is hardware that they built.

2. I've always been pretty baffled about the sc7280 EUD stuff since
the device tree shows the EUD on "usb_2". For some background: there
are two USB controllers on sc7280. There's "usb_1" which is USB
2.0/3.0 capable and, at an SoC level, is the "Type C" port.
Specifically the pins on the SoC for the USB 3.0 signals are the same
pins on the SoC as two of the DisplayPort lanes. Then there's "usb_2"
which is USB 2.0 only. If you'll notice, "usb_2" is not set to status
"okay" on any boards except "sc7280-idp.dts".

I asked Qualcomm at least a few times in the past if the EUD is truly
on the USB 2.0 port (which means it isn't connected to anything on
herobrine boards) or if it's actually on the "type C" port (which
means there's a hub in between) and never got a ton of clarify...

Given how baffling everything is, I wouldn't be opposed to just
deleting the EUD from the device tree until there is more clarity
here. If you don't want to just delete it, at least I'd say that it
shouldn't be hooked up for herobrine.

-Doug
