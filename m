Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11ACA77D689
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 01:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240560AbjHOXLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 19:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240582AbjHOXLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 19:11:35 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAF72113;
        Tue, 15 Aug 2023 16:11:28 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-790cc395896so252774839f.1;
        Tue, 15 Aug 2023 16:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692141087; x=1692745887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFuVWEZAayPE5YmN8cygrBYhtB1NcKCdwRoP31NzXkw=;
        b=CVr3SmK6yMXlTFfFbcWxbD7vs61Yp3FziYtTuX9eSZgR0j7klupfKh4IbQEysjTD2H
         tiHKlQROjAtYA8SA6K3PPODpyuh9KFhVXJulC3pW1bNNPn2NXIzTNUlUdMC6mzMXpUD7
         5XKlsVXl94faQGiWq1MicusRDdGChbGlO7p/oPiXc8xznayhTSgfWxL5sOIEgc4hN+Ps
         Ojm3rLJ6SJquiSdA4QLbUPsctb/tQ4qfS6oxN4uc5vCWSaLRCG/VCTvLWajQUJn8LfM8
         6MIi+giRt6ZrbvxjiawrD2mjV4SfNzMQwMMCvRlvqqU/ay9OHnH3jZvdbcv06Jhm5r36
         QYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692141087; x=1692745887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFuVWEZAayPE5YmN8cygrBYhtB1NcKCdwRoP31NzXkw=;
        b=kS6XCskHgIJouii6rWzmvGLpMyWR7+vndNK5axKJT51TgD1BTcSTTdNKWg0a7xKIUS
         JgEwXEJfuFmQ3Wv24RntrCifDrkIS0A9Hfh4JQhDkWGNVFqM1TG9OIl6dnsR18TFc546
         TPZbEmCBMonbKz8HguWlvfzkXt4dyYYb/uZ9SP6oaaloxuCizCkgxSjN8dhPJlYceHid
         Aoc6JJQwkNF5xHEY6gT+BA//UNrhpDtZJOPhJ7/mWcmgt3EdEJs5ZPIV5gDkZ7Gto3o9
         Kk4YSW9jyoDgr6iuHzUGqjJElsUUK2XjY1WJUEVgjZ2jKYyunSLczBvxQJ8YdrXY8jLG
         u7HQ==
X-Gm-Message-State: AOJu0YzK0TPzoyYO5+HYfpExFjihFPjp9Fc2O23vlDW5L0zk5o9inJgf
        0xfrerAnD6SND5KjhIKigmo=
X-Google-Smtp-Source: AGHT+IGDZoXS/wW3wFfvPCaoY5jxROtdqRC78WsHWjiv5QtkDcgtP4GMYgZteHS26ZdVKydZa2P4cQ==
X-Received: by 2002:a05:6e02:194e:b0:348:999b:2c44 with SMTP id x14-20020a056e02194e00b00348999b2c44mr551971ilu.26.1692141087360;
        Tue, 15 Aug 2023 16:11:27 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:9622:3fc0:6e75:a6c0])
        by smtp.gmail.com with ESMTPSA id i14-20020a056e02054e00b003421231fb8csm4190093ils.74.2023.08.15.16.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 16:11:26 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/2] arm64: dts: imx8mp-beacon-kit: Fix audio_pll2 clock
Date:   Tue, 15 Aug 2023 18:11:17 -0500
Message-Id: <20230815231117.15169-2-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230815231117.15169-1-aford173@gmail.com>
References: <20230815231117.15169-1-aford173@gmail.com>
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

A previous patch removed the audio PLL configuration from the clk
node, which resulted in an incorrect clock rate when attempting
to playback audio.  Fix this by setting the AUDIO_PLL2 rate inside
the SAI3 node since it's the SAI3 that needs it.

Fixes: 16c984524862 ("arm64: dts: imx8mp: don't initialize audio clocks from CCM node")
Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
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

