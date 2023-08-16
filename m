Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3B677DF18
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243944AbjHPKnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243764AbjHPKm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:42:59 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB34E212B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:42:58 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bc0d39b52cso39522815ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692182578; x=1692787378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cub/3WoMWvIiQsdbQrE3OYpvx3EStTjQpVkye0ZIEPY=;
        b=X+2roLU96FnUjC4UMH/RZzcPdjIQC7q3PfaiuYrl23IUrM5F/OtlaFd+SbRcoumS24
         /JbhmuX8yLikjrYNkG+eOKcWRFlLL0NWoRcZQ1vgSTHQ+TVZXOw9RM+Vt33UA9Krn5H3
         PF2LeNNjRnjzk+Kfl3Fg4yxytfvGrl/qQP1KU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692182578; x=1692787378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cub/3WoMWvIiQsdbQrE3OYpvx3EStTjQpVkye0ZIEPY=;
        b=JzxtWhZ7aoUouxZ1CTwYcsKs4Ahug3UzHFSqEl8ufitzeVSgSF26OsSB0eiF40TzmU
         TDkyt5b4YaUJY2+rRbmc6RPrDhKR1idkNm8mDSiv5YKeC9JZdcYgJ2SPs7px56pri7/h
         lpu+fM459mmExE8wzAdFhjA9rJVjN9NcO+VmiYPkuVDTx1h+o4S2d6zBDZhGmkB+ybc6
         SrzIBGp0GGG93EQaB8F92tyJIDs4zen0ly9npLFkx3ZFqNDvuskjN7+4Q6208IsERuYd
         IJtjWeLn6e+P19f5mm/jqADPa/xBCvdnW4Kl01GS9mOzwfSH4insJPd0kApgyHdRtTxw
         GrSA==
X-Gm-Message-State: AOJu0Yw5zBmFLlVvC1D2/Q5WtSlvZ9qLAp4Os5Fu4YFaQ1YopTqcO/bm
        AwYg4POb6zTy4rOc97uFSjxJtA==
X-Google-Smtp-Source: AGHT+IHvVQX8EoXpLKpCr/t52+6jeFgafZ76HEeFbRCi5SpSu2BnPfp6dIpbpqFaTJpaDOuKBalzOA==
X-Received: by 2002:a17:902:6b86:b0:1bc:56c3:ebb7 with SMTP id p6-20020a1709026b8600b001bc56c3ebb7mr1052794plk.20.1692182578396;
        Wed, 16 Aug 2023 03:42:58 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:40cf:3807:f8c8:2d76])
        by smtp.gmail.com with ESMTPSA id kx14-20020a170902f94e00b001b8a3dd5a4asm2899270plb.283.2023.08.16.03.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 03:42:58 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        "Miquel Raynal )" <miquel.raynal@bootlin.com>,
        "Richard Weinberger )" <richard@nod.at>,
        "Vignesh Raghavendra )" <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2,2/2] arm64: dts: mediatek: mt8183: set bus rx width to disable quad mode
Date:   Wed, 16 Aug 2023 18:38:33 +0800
Message-ID: <20230816104245.2676965-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
In-Reply-To: <20230816104245.2676965-1-hsinyi@chromium.org>
References: <20230816104245.2676965-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the SKUs are using gigadevice gd25lq64c flash chip. The chip
default enables quad mode, which results in the write protect pin set to
IO pin. In mt8183 kukui, we won't use quad enable for all SKUs, so apply
the property to disable spi nor's quad mode.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 6ce16a265e053..ef472b522f2e7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -877,6 +877,7 @@ w25q64dw: flash@0 {
 		compatible = "winbond,w25q64dw", "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <25000000>;
+		spi-rx-bus-width = <2>;
 	};
 };
 
-- 
2.41.0.694.ge786442a9b-goog

