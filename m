Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A0776539F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbjG0MWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbjG0MWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:22:33 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF4A2D51
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 05:22:20 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52256241b76so1133951a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 05:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690460539; x=1691065339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBcPaBCD15GVUt1t8fe+n3lTCxT4h0u6r6X0oXlZlwc=;
        b=e081yBpEl6WUyQ7DrRPgXBrwcqwu4Zlr+puzBZS56IJgd0T++PdR0LhMQQP9+eGBJh
         vPp2ek8dutLOQ45EtSbH11eENOOFmTYHYPNub1vraSKWz5mXM8gJEBy/MTOuCXtqrXRC
         tUa06KALw5Q4Qzz9oDT5BK81+Mk0yoWq7dvHwgQZvkgGS10I6gUXftd6LCfAUO6lE0aR
         b2SefsYc+gYmH/yfi2HAGUuP460jJ89FaOtEgtKbWo3FteTCJhNTjwhDSeYxyEoVbNaR
         WSg2mfD3JYetOQu43w+k9PyfmRvgcrMmw3lM9SteyO+TLxiNEr7Q8+oBstysJ//7cqW+
         l73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690460539; x=1691065339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBcPaBCD15GVUt1t8fe+n3lTCxT4h0u6r6X0oXlZlwc=;
        b=HBTxL74lYU+NJFMjnKZSWhwTU4eYJrvPPqvHL+iYbaaF78zS9udOu/cFSkMogNcPkg
         egQeDDWjMhdY5UswXTmUsQJuBVLdYg3xtTD1V8qOVYCveF+ShaJjEsbLkH8xmeJw/OOk
         mCUPw7x8TWvg7jWCmvD6GAli5wKNO0bcAoAWov0/+zCTYUY1Jxq/lSJi0651QhRHCHpk
         tZqhEJl0ekiPQ+7EadvelSm1hFzthO+xO2ueQ7wL0GS6ZeagSiBEfS2LOh6OFUh9JM2/
         aGXCkHe0DwgC0LGvgQiHrjC6iNwPOVjlY9hwRxyoxpHhndB0rzb89Qt2U/xcMkN7jPxA
         mBaw==
X-Gm-Message-State: ABy/qLYnMcIBI6jBMHx9uw0E0Q/UbxjoY8EUZGq8t8tL7kbZO3ytWUIx
        GJ4XL2LYiocn0j/p8NEdKRHa0w==
X-Google-Smtp-Source: APBJJlG8c4LaXOrZrh8NyuL1H8V9TCwkuizDCvPywRcH0BHTiQ4d0Yy80J1WZnSmA2GAgK4iabH5rA==
X-Received: by 2002:a17:907:a075:b0:99b:64ca:6999 with SMTP id ia21-20020a170907a07500b0099b64ca6999mr1967077ejc.7.1690460538803;
        Thu, 27 Jul 2023 05:22:18 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709067d9700b00993860a6d37sm717844ejo.40.2023.07.27.05.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 05:22:18 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 00/17] drm/msm: Add SM6125 MDSS/DPU hardware and enable Sony Xperia 10 II panel
Date:   Thu, 27 Jul 2023 15:22:15 +0300
Message-Id: <169046051039.1413710.12901529844343078449.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230723-sm6125-dpu-v4-0-a3f287dd6c07@somainline.org>
References: <20230723-sm6125-dpu-v4-0-a3f287dd6c07@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Jul 2023 18:08:38 +0200, Marijn Suijten wrote:
> Bring up the SM6125 DPU now that all preliminary series (such as INTF
> TE) have been merged (for me to test the hardware properly), and most
> other conflicting work (barring ongoing catalog *improvements*) has made
> its way in as well or is still being discussed.
> 
> The second part of the series complements that by immediately utilizing
> this hardware in DT, and even enabling the MDSS/DSI nodes complete with
> a 6.0" 1080x2520 panel for Sony's Seine PDX201 (Xperia 10 II).
> 
> [...]

Applied, thanks!

[01/17] drm/msm/dsi: Drop unused regulators from QCM2290 14nm DSI PHY config
        https://gitlab.freedesktop.org/lumag/msm/-/commit/a7e3fda5948a
[02/17] arm64: dts: qcom: sm6125: Pad APPS IOMMU address to 8 characters
        https://gitlab.freedesktop.org/lumag/msm/-/commit/b7d35a8eae54
[03/17] arm64: dts: qcom: sm6125: Sort spmi_bus node numerically by reg
        https://gitlab.freedesktop.org/lumag/msm/-/commit/2be52ca96a71
[04/17] dt-bindings: display/msm: Remove DSI1 ports from SM6350/SM6375 example
        https://gitlab.freedesktop.org/lumag/msm/-/commit/4be2c19261fc
[05/17] dt-bindings: clock: qcom,dispcc-sm6125: Require GCC PLL0 DIV clock
        https://gitlab.freedesktop.org/lumag/msm/-/commit/4f86e343f3c6
[06/17] dt-bindings: clock: qcom,dispcc-sm6125: Allow power-domains property
        https://gitlab.freedesktop.org/lumag/msm/-/commit/91043642f28c
[07/17] dt-bindings: display/msm: dsi-controller-main: Document SM6125
        https://gitlab.freedesktop.org/lumag/msm/-/commit/cf5859476e5d
[08/17] dt-bindings: display/msm: sc7180-dpu: Describe SM6125
        https://gitlab.freedesktop.org/lumag/msm/-/commit/04a664dffd19
[09/17] dt-bindings: display/msm: Add SM6125 MDSS
        https://gitlab.freedesktop.org/lumag/msm/-/commit/3bde3b8f8a04
[10/17] drm/msm/dpu: Add SM6125 support
        https://gitlab.freedesktop.org/lumag/msm/-/commit/76c5dffd0bc4
[11/17] drm/msm/mdss: Add SM6125 support
        https://gitlab.freedesktop.org/lumag/msm/-/commit/de50357565d3
[12/17] dt-bindings: msm: dsi-phy-14nm: Document SM6125 variant
        https://gitlab.freedesktop.org/lumag/msm/-/commit/cdac445883cc
[13/17] drm/msm/dsi: Reuse QCM2290 14nm DSI PHY configuration for SM6125
        https://gitlab.freedesktop.org/lumag/msm/-/commit/7638d8059ace

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
