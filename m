Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A54A77D68A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 01:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240552AbjHOXLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 19:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240571AbjHOXLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 19:11:30 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3541FDD;
        Tue, 15 Aug 2023 16:11:26 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-3490f207680so27179595ab.2;
        Tue, 15 Aug 2023 16:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692141086; x=1692745886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sVdCFRYiJluvXWxrH/bota2puhBJeIdTwsLdcgILr6M=;
        b=UDFmY7Zqkf4s4cJm00FKh5lhVcBZZtabEE0vGRsWZ78EuhJv1rAqiqfaVUWL/gsJJc
         yzE/WTiKNmUN0KwQl2oYwhbNOKVvScKuuVoDSy+kVKyxL69++uXLbf0OqeM1WmSrxu6f
         qpAvNvJB8+dFNQXm32TjCtGccpzaLqa3O0+zloQNVhgm8J0XJOgHpqMY5lQxdEafa8mu
         u31bALakkbTiKlfo4XDsjRRMlBCtEes0uFpW9CyrbmP9bSJDU5WqoYrKVPNAJHyRo3Kj
         NPhqDE0Pyc8cVXhwTb8CmAPEPQVbi2EVYu+e/RrZdhlRYAlO0PpiJiL/QLB0fV+JdVyE
         xSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692141086; x=1692745886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sVdCFRYiJluvXWxrH/bota2puhBJeIdTwsLdcgILr6M=;
        b=QQV9MyP085h/4igaMiPGePR0qbV2Tor9nnLpNUOU+4lEhw4oYzdl3x5U3loMeEjaA0
         +yaU1VZH6FboM9+zSBipllUTKz+FshRCNRSYxgtmTY1SE0VXd0haIErXDage6O0jPW38
         JL42RZWMCifzGZwpfxtmm/ZHTcLiJu/DJuRc4hLV/V/0/FrJg0Gr1FRMpFA7564ZpgzE
         wkpRz6lmwQOnKoR0OgrVeX0VjhQY02F2JEtXIppOvLLTst9LoQSlfOz2NVrazoW7dB0p
         AW0RZtrNOpSOsXXy9HiUbmnucZaqXm56/uHa4W+6cj6g8UzsXxZnn26uWi/YO+TgRYQU
         ZZvQ==
X-Gm-Message-State: AOJu0Yx7/ae5Yo4MK47aKnW2e3Mm0FAQJZoU9TETyPQJ27kywV2F8qZG
        rovdcykI/+ZvifmKvcb1U/jrVIXn3Ik=
X-Google-Smtp-Source: AGHT+IEzDIy1xWM1KBwFCTPOhXP87WVXa4Q2qMpRmZ/zZQQi4zLUupVmh31rhtd13AZSfwvDIeZKUg==
X-Received: by 2002:a05:6e02:12e8:b0:349:8a8b:70ca with SMTP id l8-20020a056e0212e800b003498a8b70camr518752iln.14.1692141085720;
        Tue, 15 Aug 2023 16:11:25 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:9622:3fc0:6e75:a6c0])
        by smtp.gmail.com with ESMTPSA id i14-20020a056e02054e00b003421231fb8csm4190093ils.74.2023.08.15.16.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 16:11:25 -0700 (PDT)
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
Subject: [PATCH V2 1/2] arm64: dts: imx8mp: Fix SDMA2/3 clocks
Date:   Tue, 15 Aug 2023 18:11:16 -0500
Message-Id: <20230815231117.15169-1-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
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

A previous patch to remove the Audio clocks from the main clock node
was intended to force people to setup the audio PLL clocks per board
instead of having a common set of rates since not all boards may use
the various audio PLL clocks for audio devices.

Unfortunately, with this parenting removed, the SDMA2 and SDMA3
clocks were slowed to 24MHz because the SDMA2/3 clocks are controlled
via the audio_blk_ctrl which is clocked from IMX8MP_CLK_AUDIO_ROOT,
and that clock is enabled by pgc_audio.

Per the TRM, "The SDMA2/3 target frequency is 400MHz IPG and 400MHz
AHB, always 1:1 mode, to make sure there is enough throughput for all
the audio use cases."

Instead of cluttering the clock node, place the clock rate and parent
information into the pgc_audio node.

With the parenting and clock rates restored for  IMX8MP_CLK_AUDIO_AHB,
and IMX8MP_CLK_AUDIO_AXI_SRC, it appears the SDMA2 and SDMA3 run at
400MHz again.

Fixes: 16c984524862 ("arm64: dts: imx8mp: don't initialize audio clocks from CCM node")
Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---

V2:  Slow AUDIO_AXI to 600MHz for nominal drive.  Individual boards can increase
     this to 800MHz if they have the proper voltage configured.

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 6f2f50e1639c..83d907294fbc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -790,6 +790,12 @@ pgc_audio: power-domain@5 {
 						reg = <IMX8MP_POWER_DOMAIN_AUDIOMIX>;
 						clocks = <&clk IMX8MP_CLK_AUDIO_ROOT>,
 							 <&clk IMX8MP_CLK_AUDIO_AXI>;
+						assigned-clocks = <&clk IMX8MP_CLK_AUDIO_AHB>,
+								  <&clk IMX8MP_CLK_AUDIO_AXI_SRC>;
+						assigned-clock-parents =  <&clk IMX8MP_SYS_PLL1_800M>,
+									  <&clk IMX8MP_SYS_PLL1_800M>;
+						assigned-clock-rates = <400000000>,
+								       <600000000>;
 					};
 
 					pgc_gpu2d: power-domain@6 {
-- 
2.39.2

