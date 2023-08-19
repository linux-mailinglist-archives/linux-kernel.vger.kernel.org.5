Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCC7781921
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 12:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjHSKwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 06:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjHSKw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 06:52:27 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BDE1B339;
        Sat, 19 Aug 2023 03:50:15 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-34baeb01942so6188505ab.1;
        Sat, 19 Aug 2023 03:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692442215; x=1693047015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOHGrFpVbV94GxW582V7S/Br8+c79FnQLF+z0S/cUIg=;
        b=YackG/t5OxFEpw9bAOamPufsVnsxP/OwqNEwAPvBqI3Pso/gq7E+VnCHZ1D789B2km
         U598r70iSEb3fPqVFCG504V1gpJnaiBO8rL3Mbe6pXfXyHGAW0Zrg5v+o/EhQXBFsoPK
         gywGyTBZBxqZhQE/cDt/bTmt2KVNRpDtavjrLoBSluAJpTkN3yl+YtWps1HWR3mv/N3S
         YLvPX3h32Rnkw/Nw2jrqS3OVYrUI+fFhuIDzLiFYKQylSJKKTdrNX3HLCyeR/TfBtJdQ
         LI89t/RAvr22J9QtL32vAmVPZjWS9LwWiT70oqdotqROlr81Q7koS4eoRbcuAtMzT81U
         9j9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692442215; x=1693047015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOHGrFpVbV94GxW582V7S/Br8+c79FnQLF+z0S/cUIg=;
        b=B8HPLOUYYofmHs9t9zanPQFgmOOzTzxC2GYKIMF/d2ZTUGuh6mmYj9/ewzx7N+AFyZ
         Sl93cuiuT7a/Bu7zn2L5MgH7oqEIsVFAMV6uRiAJAlWBJ4Pm4Gr27kBDPQeTaeyULY+S
         MpP+oty4APb0BJs/fg/MKY+UNX/76LmS4oC5lEJ/voDhglSvtHWk2O1bwRAdgH1oyX+s
         hWASxqtnnHhO9yYSfXCo31qOWcMgb3WRoLe0gqBnECOzrg7BigykSj4ca23DZ+cIYOqo
         mo+38zEZhkd/v1BjyABlZVV9nN5rJ3cW1Hi+70n9dwqTNLLok5T2HnCZLIaHeG+8/n4G
         SJSA==
X-Gm-Message-State: AOJu0Yxfso7zvIf7zA73U/TZsJfmynStobzzQn174pcHvW1WI8g5tUxo
        Fbt9YetWTtPtfAPl+g2MMhI=
X-Google-Smtp-Source: AGHT+IGltsqOxipCI150IIex3vtDvzFIfLDHldGuBnX0OVoo2BOEdiVNS0N+e7jqCQFJL5ID4GY4cg==
X-Received: by 2002:a05:6e02:106f:b0:34b:ad7a:384f with SMTP id q15-20020a056e02106f00b0034bad7a384fmr2155350ilj.20.1692442215113;
        Sat, 19 Aug 2023 03:50:15 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:4a28:99c7:cf07:4f94])
        by smtp.gmail.com with ESMTPSA id h16-20020a92d090000000b0034ac4ccd097sm1116470ilh.33.2023.08.19.03.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 03:50:14 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/2] arm64: dts: imx8mp-beacon-kit: Fix audio_pll2 clock
Date:   Sat, 19 Aug 2023 05:50:02 -0500
Message-Id: <20230819105002.132750-2-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230819105002.132750-1-aford173@gmail.com>
References: <20230819105002.132750-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 16c984524862 ("arm64: dts: imx8mp: don't initialize audio clocks
from CCM node") removed the Audio clocks from the main clock node, because
the intent is to force people to setup the audio PLL clocks per board
instead of having a common set of rates since not all boards may use
the various audio PLL clocks for audio devices.

This resulted in an incorrect clock rate when attempting to playback
audio, since the AUDIO_PLL2 wasn't set any longer. Fix this by
setting the AUDIO_PLL2 rate inside the SAI3 node since it's the SAI3
that needs it.

Fixes: 16c984524862 ("arm64: dts: imx8mp: don't initialize audio clocks from CCM node")
Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
V3:  Update commit message wording.  No functional change

V2:  No change

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
index 06e91297fb16..acd265d8b58e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
@@ -381,9 +381,10 @@ &pcie_phy {
 &sai3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai3>;
-	assigned-clocks = <&clk IMX8MP_CLK_SAI3>;
+	assigned-clocks = <&clk IMX8MP_CLK_SAI3>,
+			  <&clk IMX8MP_AUDIO_PLL2> ;
 	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL2_OUT>;
-	assigned-clock-rates = <12288000>;
+	assigned-clock-rates = <12288000>, <361267200>;
 	fsl,sai-mclk-direction-output;
 	status = "okay";
 };
-- 
2.39.2

