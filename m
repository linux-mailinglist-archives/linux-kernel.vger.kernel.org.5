Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF3377CF7A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238257AbjHOPpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238199AbjHOPpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:45:03 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B29810C6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:45:02 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686daaa5f1fso3811126b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692114302; x=1692719102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJmTT5Birsmw3IffSKTzNizstUWs73hZ2XtnCyouma4=;
        b=EmtRFWNxOZBhCSvbwn/tqeAcE99fLpxaVbN7woJu/mWoDOtjxym1jTZkxHhu07Rkyt
         aRrgPSp/P/3sucNU9SeuOykjKSQh3VlqmEj8eU7wU4xRqA6huNIOrfmc4oNT57mf+z5F
         6gU0Vk6XMHXfclV87Ur5S7pFb+TluJkDGSF1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692114302; x=1692719102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJmTT5Birsmw3IffSKTzNizstUWs73hZ2XtnCyouma4=;
        b=lxUPeXWmJ1PdswgqVrcQGnGaLRPoynBj2FFigOluFm89NfAMxSFGU3V2fAUHgP+dAx
         6LrWLaNRz5iOIkcynxgqXFUyYAwYGNr4PEJ5Xx7cFUITyrXnfhp1QofAGPvHl5FBt4Jz
         tGd3ibLdq+mCizQcOk6fmVwfDwTq55L4Hw8TxWqVuP7oy4qzCUTHT3w3Eyr0vTeojKRM
         J3N6BH7fEeXJWD4rw1nXVkXpIwaIM/MF/bdpJLtWZJADVPrOjjLEqAwRhnMAnejL2mu1
         o+rjWYDxGVskwdg7HIuaV461KsDFh/LMx019+8fDaFLUxg5mcXnHpHeg+gn8II7YZsB6
         VGGg==
X-Gm-Message-State: AOJu0YyqAlQv5OHABBGNUPh3TOYCxyCpPAc5+Ez16i6w1lR/nyRZOKoT
        hkVc33Ji1EDA+QVOwhxmtUGncw==
X-Google-Smtp-Source: AGHT+IF1i0bsPTgkJk9HYJHsQ+5ia/nkZZCBU7zl2is+oYE8IhKDNs3GjUWaIoKqVbHs5puDt5BuXg==
X-Received: by 2002:a05:6a00:10cb:b0:688:48be:50b4 with SMTP id d11-20020a056a0010cb00b0068848be50b4mr1899247pfu.16.1692114301925;
        Tue, 15 Aug 2023 08:45:01 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:40cf:3807:f8c8:2d76])
        by smtp.gmail.com with ESMTPSA id n13-20020aa78a4d000000b0065e154bac6dsm9431247pfa.133.2023.08.15.08.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 08:45:01 -0700 (PDT)
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
Subject: [PATCH 4/4] arm64: dts: qcom: sc7180: disable quad mode for spi nor
Date:   Tue, 15 Aug 2023 23:31:55 +0800
Message-ID: <20230815154412.713846-5-hsinyi@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
In-Reply-To: <20230815154412.713846-1-hsinyi@chromium.org>
References: <20230815154412.713846-1-hsinyi@chromium.org>
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
IO pin. In trogdor platforms, we won't use quad enable for all SKUs, so
apply the property to disable spi nor's quad mode.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 5a33e16a8b677..0806ce8e86bea 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -436,6 +436,7 @@ flash@0 {
 		spi-max-frequency = <37500000>;
 		spi-tx-bus-width = <2>;
 		spi-rx-bus-width = <2>;
+		disable-quad-mode;
 	};
 };
 
-- 
2.41.0.694.ge786442a9b-goog

