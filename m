Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9F4782B83
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbjHUOUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbjHUOUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:20:15 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E682E195
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:19:49 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99c1c66876aso446824066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692627583; x=1693232383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QA/KSrt9iM+QMdG2n7v/CmLVgp4cmpYQYaKiaSBQzoo=;
        b=bP43zkD4Vq7tnbGED0gMmZDsccmfTDS3wRTD3kUNxBLMNfuoux6u2NBna5CE57TWQK
         AvZgDIi3pg51BvAoWB7MgdqfkoQb17jVPJ6HOtK5TokkNxP6lSVw9CDpiZP7MkcT4TBg
         ntgFSAOvUnJxdnh11iAQWembemhXTywF7RlIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692627583; x=1693232383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QA/KSrt9iM+QMdG2n7v/CmLVgp4cmpYQYaKiaSBQzoo=;
        b=hUlII/++tbiPrLdUDNMvcqqWX6bSlrNg/bagrJqwBDebY2hd/Yoy/5hiMJAWxp5Eku
         G/vwMVkPw+/UVf1uHJmnCL9Kw3o9GVrGyu5di1XHaM9PrcbNV0BnjSZhyjoP0C6N28oC
         c6XGN253poOafOzbUZIXr6FFGtFkrgBUz48UyJCr0CvFVdWPYb4njjYtpZ0M/SIqP+BD
         Vq0F+tTSKf5yoxR4F6wvZQ4es0cXvYOrnle6JoyZucX7nVO2R9gIk4QrE3DV4oN4M2ST
         kKmaOVOIMBeYkhrIRYMlRLK7JHfHi1HhlMR+qybSHMUW1GaQR5TsnA/6gjdxMe0mAbgQ
         IzFw==
X-Gm-Message-State: AOJu0YxDSP33CJQ/R+dHYVYnVqN2Nm2F6bVDMIgDEhRHaMBwjcvY6Lv9
        dh6/jRkxrCmcnt0SG+e4EsDP5D+3SGHN85IbFQ6l+A==
X-Google-Smtp-Source: AGHT+IFS0pOvpSG6L5THCZ7nZGo3eStxkv3Enc1QkDfFaiggHdugQCRM9ZmZmfUmZIPFe40pe9khug==
X-Received: by 2002:a17:907:7714:b0:99b:4a29:fb6a with SMTP id kw20-20020a170907771400b0099b4a29fb6amr5124089ejc.59.1692627583421;
        Mon, 21 Aug 2023 07:19:43 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id h3-20020a170906260300b00992afee724bsm6529685ejc.76.2023.08.21.07.19.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 07:19:42 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3fef2fafee2so57635e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:19:42 -0700 (PDT)
X-Received: by 2002:a05:600c:3b85:b0:3fd:e15:6d5 with SMTP id
 n5-20020a05600c3b8500b003fd0e1506d5mr279636wms.2.1692627582227; Mon, 21 Aug
 2023 07:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230820075626.22600-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230820075626.22600-1-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 21 Aug 2023 07:19:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V=0RDo0UPBr4PcWE5jgmMg_HXYxXyG1WoLkjYOh4_gCw@mail.gmail.com>
Message-ID: <CAD=FV=V=0RDo0UPBr4PcWE5jgmMg_HXYxXyG1WoLkjYOh4_gCw@mail.gmail.com>
Subject: Re: [PATCH RFT v2] arm64: dts: qcom: sc7280: drop incorrect EUD port
 on SoC side
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
        linux-kernel@vger.kernel.org,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Aug 20, 2023 at 12:56=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Qualcomm Embedded USB Debugger (EUD) second port should point to Type-C
> USB connector.  Such connector was defined directly in root node of
> sc7280.dtsi which is clearly wrong.  SC7280 is a chip, so physically it
> does not have USB Type-C port.  The connector is usually accessible
> through some USB switch or controller.
>
> Doug Anderson said that he wasn't ever able to use EUD on Herobrine
> boards, probably because of invalid or missing DTS description - DTS is
> saying EUD is on usb_2 node, which is connected to a USB Hub, not to the
> Type-C port.
>
> Correct the EUD/USB connector topology by removing the top-level fake
> USB connector and EUD port pointing to it, and disabling the incomplete
> EUD device node.
>
> This fixes also dtbs_check warnings:
>
>   sc7280-herobrine-crd.dtb: connector: ports:port@0: 'reg' is a required =
property
>
> Link: https://lore.kernel.org/all/CAD=3DFV=3DXt26=3DrBf99mzkAuwwtb2f-jnKt=
nHaEhXnthz0a5zke4Q@mail.gmail.com/
> Fixes: 9ee402ccfeb1 ("arm64: dts: qcom: sc7280: Fix EUD dt node syntax")
> Cc: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Not tested on hardware.
>
> Changes in v2:
> 1. Disable the EUD node and do not add ports/connector in boards, as
>    discussed with Doug.
>
> v1: https://lore.kernel.org/all/CAD=3DFV=3DXt26=3DrBf99mzkAuwwtb2f-jnKtnH=
aEhXnthz0a5zke4Q@mail.gmail.com/
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 21 ++-------------------
>  1 file changed, 2 insertions(+), 19 deletions(-)

I have no objections, but also no objections if someone who actually
knows how the EUD is setup wants to respond and tell you the right way
for this to get setup. Thus, I guess:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
