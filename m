Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B89807B3A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 23:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377426AbjLFWQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 17:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLFWQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 17:16:10 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F75DE;
        Wed,  6 Dec 2023 14:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1701900965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DeOfiwPqUJFIvt+4ZOkSbwzl+rjE80SmmjKvk0CB4Ks=;
        b=Qwz79I/VCFDPi94zJjv74DUJAf1YJuPc7LpjnG7RQlkzqrRFAAPIR9wO5LaD+csZ5jmWFI
        zgztbxfKKGx9TadvY0Lg+7n0GO0mFR7Ty4LlC2254p7pY11r9PejoZD54IvuJPJh7H3w3l
        rr89iXVhaZxp1FODgHczgMbtSP7Y7WU=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>, stable@vger.kernel.org
Subject: [PATCH 1/3] ARM: dts: samsung: exynos4210-i9100: Unconditionally enable LDO12
Date:   Wed,  6 Dec 2023 23:15:54 +0100
Message-ID: <20231206221556.15348-2-paul@crapouillou.net>
In-Reply-To: <20231206221556.15348-1-paul@crapouillou.net>
References: <20231206221556.15348-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel hangs for a good 12 seconds without any info being printed to
dmesg, very early in the boot process, if this regulator is not enabled.

Force-enable it to work around this issue, until we know more about the
underlying problem.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Fixes: 8620cc2f99b7 ("ARM: dts: exynos: Add devicetree file for the Galaxy S2")
Cc: <stable@vger.kernel.org> # v5.8+
---
 arch/arm/boot/dts/samsung/exynos4210-i9100.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/samsung/exynos4210-i9100.dts b/arch/arm/boot/dts/samsung/exynos4210-i9100.dts
index a9ec1f6c1dea..a076a1dfe41f 100644
--- a/arch/arm/boot/dts/samsung/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/samsung/exynos4210-i9100.dts
@@ -527,6 +527,14 @@ vtcam_reg: LDO12 {
 				regulator-name = "VT_CAM_1.8V";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+
+				/*
+				 * Force-enable this regulator; otherwise the
+				 * kernel hangs very early in the boot process
+				 * for about 12 seconds, without apparent
+				 * reason.
+				 */
+				regulator-always-on;
 			};
 
 			vcclcd_reg: LDO13 {
-- 
2.42.0

