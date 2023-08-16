Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DC877ED1E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 00:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346945AbjHPWaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 18:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346926AbjHPW37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 18:29:59 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B751125
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 15:29:58 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99de884ad25so183601066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 15:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692224995; x=1692829795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofsQzKETVgmfPHXQQZon3G3gLHq5Qa7KzbmqfjJ776Q=;
        b=fppwv58HH8+TSUQ6I+ELuDjQ8jWSMUMY19U7ElOvJk2mSvzQTH8IWoJASTvoclFm6G
         eQBQ2XGtpfM3VrGCJOxcBW0PhycRY3UxYrQ2nwlfFUSPDf45TOc6hO61cX8utC2n1Ul5
         xzGhiYI6RkYqWSOLhVV61oVX74fh0XjMVqMX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692224995; x=1692829795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofsQzKETVgmfPHXQQZon3G3gLHq5Qa7KzbmqfjJ776Q=;
        b=DlevZFNYJ5U8uMvqYcmjX0vxpWdHCHHRpu2kdb17+CT4SK+K+qH04HQAIyd9Y2LNPS
         tiSwFxFuKzT66csy+iqNx3js0WXFHfUGIr/b4ATUolyIiYsDZGN8mbKHns2qcepQXOve
         o7fRG1QAAXMztI48Ov7F5BUp9ulRNeiQ7/VwmkJdRJZu6Vh24Nwwe+haPPSZQiMCCFD3
         HeOIDUmleUH6WWJolJukltZcm5SkXQ5B2HJtBqLDRa2l/CYRZcQ5tpnJuTn7M0zHPu8B
         3g5DVIQkyERToR3qkx2/edQBMu9wmy/oSbIZI95QHFXsiwtutTqlHyJ1MvszaaygqeXW
         vQBw==
X-Gm-Message-State: AOJu0Yw1vpku9J40P6O7DPsnSfDcxDyMoguKq5MX0yQZPz0tAs2QDFUj
        dwmt+R2WVaN8xkoIgulo31DCUlYD6wkYfp/z3wsuubbc
X-Google-Smtp-Source: AGHT+IFkaG+ZjCegNXZy0M/0RiZNLDMF1fs+BBq+5IVJmHn2xLalPjwAkTy2GrkLn0xO2BQOIjO88w==
X-Received: by 2002:a17:906:498f:b0:99b:48b9:8e45 with SMTP id p15-20020a170906498f00b0099b48b98e45mr2131094eju.76.1692224994403;
        Wed, 16 Aug 2023 15:29:54 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id b16-20020a170906d11000b00992b7ff3993sm9054722ejz.126.2023.08.16.15.29.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 15:29:53 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5232ce75e26so2114a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 15:29:53 -0700 (PDT)
X-Received: by 2002:a50:cd02:0:b0:519:7d2:e256 with SMTP id
 z2-20020a50cd02000000b0051907d2e256mr43260edi.0.1692224993170; Wed, 16 Aug
 2023 15:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230816060502.16789-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230816060502.16789-1-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 16 Aug 2023 15:29:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VGC6LgcMZBT=5ZQSB2Td3+B4qxyUMzNY0UrfCMHTy21A@mail.gmail.com>
Message-ID: <CAD=FV=VGC6LgcMZBT=5ZQSB2Td3+B4qxyUMzNY0UrfCMHTy21A@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280-crd: add Bluetooth VDDIO supply
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 15, 2023 at 11:05=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Bluetooth requires VDDIO supply and Doug Anderson suggested it is
> vreg_l18b_1p8.  Add one to satisfy `dtbs_check`:
>
>   sc7280-crd-r3.dtb: bluetooth: 'vddio-supply' is a required property
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Changes in v2:
> 1. Use vreg_l18b_1p8 (Doug). Due to such change, don't add Rb tag.
> ---
>  arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts | 4 ++++
>  1 file changed, 4 insertions(+)

Right. Previous discussion was at:

https://lore.kernel.org/r/CAD=3DFV=3DUMqrAU9cLy3Ew5o1MJyNDAAG2TY1mvMkY2-8ki=
w6qpjg@mail.gmail.com

Reviewed-by: Douglas Anderson <dianders@chromium.org>
