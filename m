Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA107BCAEB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 02:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbjJHAuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 20:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbjJHAt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 20:49:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98CAD6F;
        Sat,  7 Oct 2023 17:49:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5E8C433C8;
        Sun,  8 Oct 2023 00:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696726174;
        bh=NhWxuNLTp7GYGxdpj3kshyvhnq8sbcconl2ofdo1sBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bYGBCRfBfMTT3zlzk05eHPrmYqS5w7KTOZONc9PDTfBVyQCc0pMmOGW9mmWKs9vWg
         34/yKo7Vzhqo6bG9TXgOQoDwCo02yf2mVtlebqo2ZjtPxH0ezo+tP5n+oSPvKSEHMY
         RWVPeCrq/7fPF6uXfPDojolrPxXGSaZBa4A7zZHXyleaAjzsrmElPdV32dYnXwBTdz
         FJf9AeL9nON673mqWZA1ziTIy8d/r6DirRAFaCqeBTpG03ETS0AKp7LNd35DCfsqB7
         n6cPB/JZ+lv8q6DreqGNmvY8pB2H90umFEvxLHZuzrN8jY6EqsPkQD8Ymr+DNpQGVp
         VzCf7sWarJVOQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 02/12] ARM: dts: ti: omap: Fix noisy serial with overrun-throttle-ms for mapphone
Date:   Sat,  7 Oct 2023 20:49:19 -0400
Message-Id: <20231008004929.3767992-2-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231008004929.3767992-1-sashal@kernel.org>
References: <20231008004929.3767992-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.56
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 5ad37b5e30433afa7a5513e3eb61f69fa0976785 ]

On mapphone devices we may get lots of noise on the micro-USB port in debug
uart mode until the phy-cpcap-usb driver probes. Let's limit the noise by
using overrun-throttle-ms.

Note that there is also a related separate issue where the charger cable
connected may cause random sysrq requests until phy-cpcap-usb probes that
still remains.

Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Carl Philipp Klemm <philipp@uvos.xyz>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/motorola-mapphone-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/motorola-mapphone-common.dtsi b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
index c7a1f3ffc48ca..bd4731b929da5 100644
--- a/arch/arm/boot/dts/motorola-mapphone-common.dtsi
+++ b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
@@ -640,6 +640,7 @@ &uart1 {
 &uart3 {
 	interrupts-extended = <&wakeupgen GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH
 			       &omap4_pmx_core 0x17c>;
+	overrun-throttle-ms = <500>;
 };
 
 &uart4 {
-- 
2.40.1

