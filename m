Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B0979739D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238969AbjIGP2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242660AbjIGP0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:26:46 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5F8170F;
        Thu,  7 Sep 2023 08:26:26 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-401b5516104so12098135e9.2;
        Thu, 07 Sep 2023 08:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694100367; x=1694705167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HfJRvGG1+8tzxY0msM4PeR5IqsDQRVgMRK4cu1iRcR4=;
        b=Z3Fp5b6Pv3wogacYHVnytBpaKZ725LQZTNw4aoICPmepWJxVixYdv4LhdF4kQBvd0b
         d9M0SCbDSAeqkJS3j3qxnBnQj+qtg/h2vxdu/btwvu5RYcbzATUkMmVBEyXdyD04/ivM
         k2P5mhX2dc9Bk1w4fm/jiK9vFeURQ2CwIigp8UL/Nndn1G8n9htIuXlYsKLxeObHbyWq
         RDH+yuyJlrTKoCwFdOw5II+BGynDM0QLOI3IWP+cDLezBGFEZq6w1K+gHfvq9iYjoFUs
         rFlW0sUBkM01TpkRm5zUPg5IRNwUYyUU8nLgEuclsgGL0spHTiPMCm7LxqKMdhAIRPl5
         Yqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100367; x=1694705167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HfJRvGG1+8tzxY0msM4PeR5IqsDQRVgMRK4cu1iRcR4=;
        b=Jo+ljEs6PnAlkxpLSyxggX1QWvS33714nKwuUF7fVXfw6nA1KsM6JiNds0f7XOQr0O
         OPNyV+7EAZXpZz369qLXk2aD6Kv8x5tZizk8ADlikDm3lSnHJAitWjC0XTO34EsPH0qP
         S08j8Y0itcQAJKH0DobH7lEP3FXRFwXZT4phK3zb+IRhC8/nCPTvHhWIjAACVTEgFvpP
         CXqa4cTvELA0PdSXVZ/Rv07D8d+xNl3kgnX31gQx2Rk81PDZpFAQnLteaG4J0f4lzBHS
         cliZp9BFv0+wNMu637LyiBu/NgY4KtR1HjzkXtn2MSQgy00TrPgnxa6F/DSWLZoQG6vN
         nx4A==
X-Gm-Message-State: AOJu0YzC5Z23aYjx/lhUkDzSaXS0m/C0NyxM5FwNJN+PMucCSZxdwKIQ
        1LYJg9RFNt9zXt1MjSoFGeLrTBAsLYPutQ==
X-Google-Smtp-Source: AGHT+IEWg4FplZCvEqhV5FF+ef0iLgRk5TOFXN3+CPcXJLIjMTAIazbHqeW6H02I5cYNKK/M1AKx3Q==
X-Received: by 2002:a5d:6846:0:b0:319:8a21:6f9a with SMTP id o6-20020a5d6846000000b003198a216f9amr4825426wrw.63.1694099884935;
        Thu, 07 Sep 2023 08:18:04 -0700 (PDT)
Received: from opti3050-1.lan (ip092042140082.rev.nessus.at. [92.42.140.82])
        by smtp.gmail.com with ESMTPSA id l16-20020adfe9d0000000b00317e77106dbsm23511973wrn.48.2023.09.07.08.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 08:18:04 -0700 (PDT)
From:   Jakob Unterwurzacher <jakobunt@gmail.com>
X-Google-Original-From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>,
        Ermin Sunj <ermin.sunj@theobroma-systems.com>,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc:     stable@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] arm64: dts: rockchip: use codec as clock master on px30-ringneck-haikou
Date:   Thu,  7 Sep 2023 17:17:15 +0200
Message-Id: <20230907151725.198347-1-jakob.unterwurzacher@theobroma-systems.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ermin Sunj <ermin.sunj@theobroma-systems.com>

If the codec is not the clock master, the MCLK needs to be
synchronous to both I2S_SCL ans I2S_LRCLK. We do not have that
on Haikou, causing distorted audio.

Before:

 Running an audio test script on Ringneck, 1kHz
 output sine wave is not stable and shows distortion.

After:

 10h audio test script loop failed only one time.
 That is 0.00014% failure rate.

Cc: stable@vger.kernel.org
Fixes: c484cf93f61b ("arm64: dts: rockchip: add PX30-µQ7 (Ringneck) SoM with Haikou baseboard")
Signed-off-by: Ermin Sunj <ermin.sunj@theobroma-systems.com>
Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
---

Notes:
    v1: https://lore.kernel.org/lkml/20230823122000.585787-1-jakob.unterwurzacher@theobroma-systems.com/
    v2: https://lore.kernel.org/lkml/20230823131651.586934-1-jakob.unterwurzacher@theobroma-systems.com/

 arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
index 08a3ad3e7ae9..8792fae50257 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
@@ -68,15 +68,15 @@ i2s0-sound {
 		simple-audio-card,format = "i2s";
 		simple-audio-card,name = "Haikou,I2S-codec";
 		simple-audio-card,mclk-fs = <512>;
+		simple-audio-card,frame-master = <&sgtl5000_codec>;
+		simple-audio-card,bitclock-master = <&sgtl5000_codec>;
 
-		simple-audio-card,codec {
+		sgtl5000_codec: simple-audio-card,codec {
 			clocks = <&sgtl5000_clk>;
 			sound-dai = <&sgtl5000>;
 		};
 
 		simple-audio-card,cpu {
-			bitclock-master;
-			frame-master;
 			sound-dai = <&i2s0_8ch>;
 		};
 	};
-- 
2.39.2

