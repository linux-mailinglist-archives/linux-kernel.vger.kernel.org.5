Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA04D7EB24E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjKNOgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbjKNOgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:36:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D61D5D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:35:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FD6C433A9;
        Tue, 14 Nov 2023 14:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699972549;
        bh=TRfwOBP1ct8dRqN5onbbksp9izfKksijyA3SFS57tL8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=u8EGpCwP2YDwTsdhnCuWNRR3ET4cBwlGPOMNDjDi7MyBerlIwMvfr9/Re4WP+Tu2W
         E3r0tuz9FDWCe5vZRDtnbDwxgtWbVlHa7lriiZOEKRO2bouvvisBzdJ9/1FSIYgS8A
         nKlvuw1wMHtsutJX74iVJNWv59Angpc0RmjXhL0g9Uem9qclL190adwrdcTzIsLNbS
         Wf2ANZgx3bCFFKHdKUiga7bbgvbxwa9ZZ7ajEfw2wMTnvxVBtmp20IiwYoo21YJNzO
         wAKSSEqc09xkvffhauB6TRhdv+aPi/m81q2iBRwZ4iedMGidiu423066hgGRzHapRO
         71e5nUyBmf1Gw==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 14 Nov 2023 14:34:53 +0000
Subject: [PATCH v2 08/21] arm64/sysreg: Add definition for FPMR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-arm64-2023-dpisa-v2-8-47251894f6a8@kernel.org>
References: <20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org>
In-Reply-To: <20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=975; i=broonie@kernel.org;
 h=from:subject:message-id; bh=TRfwOBP1ct8dRqN5onbbksp9izfKksijyA3SFS57tL8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlU4WbxAeU82L4RUHrAd9Oxy2f0PMZPzQhBtz2zavq
 mLdMhCOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVOFmwAKCRAk1otyXVSH0H1GB/
 wPSxydoLDmEph6vxq4HTgSiwCFR5ow+x1m0GsC/hw4ixQz4T6U8KuOY/T5Rl6r9rBYyBegyWmsezp9
 qb/bGB2w2sNU0Ixiiq9tUd9X/MaJLWzJ52D4WjQPLEIyRCU9+Mmvvd7CJm/ZKhwtTQ15ZWiyDHfmwu
 o9RLCcAiwDzmoFwuYD7vJjLGJOtcfJ/dY3G4quJkRPHIbgt3IubEYivPU+5q6pL3SIwUYIaNbRU0KY
 KFLXbNmJNNJKEx1dEDkGQwnm1osxKtzuhwg9jMtSC+UPqBSAGkLkyHrr7NhcGh/KrFqCGqNiA+F4ZX
 NbONDrwLeCffjD/8nRdaIrn19O5O3h
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DDI0601 2023-09 defines a new sysrem register FPMR (Floating Point Mode
Register) which configures the new FP8 features. Add a definition of this
register.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 0b1a33a77074..67173576115a 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2138,6 +2138,29 @@ Field	1	ZA
 Field	0	SM
 EndSysreg
 
+Sysreg	FPMR	3	3	4	4	2
+Res0	63:38
+Field	37:32	LSCALE2
+Field	31:24	NSCALE
+Res0	23
+Field	22:16	LSCALE
+Field	15	OSC
+Field	14	OSM
+Res0	13:9
+UnsignedEnum	8:6	F8D
+	0b000	E5M2
+	0b001	E4M3
+EndEnum
+UnsignedEnum	5:3	F8S2
+	0b000	E5M2
+	0b001	E4M3
+EndEnum
+UnsignedEnum	2:0	F8S1
+	0b000	E5M2
+	0b001	E4M3
+EndEnum
+EndSysreg
+
 SysregFields	HFGxTR_EL2
 Field	63	nAMAIR2_EL1
 Field	62	nMAIR2_EL1

-- 
2.30.2

