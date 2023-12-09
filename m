Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A2B80B12F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 02:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574931AbjLIBDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 20:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235943AbjLIBD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 20:03:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73011989
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 17:03:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA19C433C9;
        Sat,  9 Dec 2023 01:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702083815;
        bh=NLnstho9TZMAuGZC1AyQ4uL9JsFRiHz6zhf2LuQlth0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=d8J5zPI7o460ibfi86ExzoYKdZ41uqhXrgrep3NSrmMwek3AK2A2lV+o5r5289pDn
         ArxEopSC3OJaWu2LZA3mr6pHoUKHp01T6l9+kUv6JbT4GePYExjUvqDxfDzR6wuZVE
         6grytX1F5ZqCdRCPfAmKacSH2MY9g7U+ndceHAZxzosU5nR/JGMNGQLgI7Z3gtA8Mn
         MSvGIg/+Y0A86eMkmGS5hIxhp29ONUFjoKGlincFF9xV5Ad+aUwxR+i5LrTW9DwadS
         6GAJqUF0vIZyrinkZDjAv3DFo/glnSzWl00+9fjcgVZuCKZyNrTnSPq5PGgkpakxgL
         UB9UYpuIPI0gA==
From:   broonie@kernel.org
Date:   Sat, 09 Dec 2023 01:02:49 +0000
Subject: [PATCH 03/13] arm64/sysreg: add system register POR_EL{0,1}
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231209-b4-arm64-sysreg-additions-v1-3-45284e538474@kernel.org>
References: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
In-Reply-To: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1604; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Y7wOgrcdWJDjjn38wbxfS55li1OPtRiVkuJyGT9Tcf0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlc7zWJnKEblR1//sGHcy8RrgJctbbVZLFflvph
 n+N1Blhrz+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZXO81gAKCRAk1otyXVSH
 0AXwB/9oxXLFgdJX6RNwDHdKf+V3C24f2K9afenKJpT2/uAFxL0gFprJbk7tuPrQSWSRXIclgO5
 iEihN5LmhRKY97CKAB7oG+sABhAFcNoc+3Koi7BieFIiaoydwHtoJpumudU74tQXvxcEOw1YUZd
 WDx5+wr6JmbGn6gVaaFlXUgdoCeoW8xqdoKh4mYz+K9c3bj8pEaNSoekcROE9WYwDpnWoYpWreq
 3a3Z8fslwyQg1V8omS9h/+4BCH+OqIAmKiuGSI3KdflhyMkuw3QFHWbYNviw6AmnmeP/mPOF0fN
 eDxvvSm6wHHA42Tmj0bZYuUGsDKsb4kF9RHRXeCNrOzjEhx5
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

From: Joey Gouly <joey.gouly@arm.com>

Add POR_EL{0,1} according to DDI0601 2023-03.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/sysreg.h | 13 +++++++++++++
 arch/arm64/tools/sysreg         | 12 ++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 5e65f51c10d2..9c2caf0efdc7 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -1039,6 +1039,19 @@
 
 #define PIRx_ELx_PERM(idx, perm)	((perm) << ((idx) * 4))
 
+/*
+ * Permission Overlay Extension (POE) permission encodings.
+ */
+#define POE_NONE	UL(0x0)
+#define POE_R		UL(0x1)
+#define POE_X		UL(0x2)
+#define POE_RX		UL(0x3)
+#define POE_W		UL(0x4)
+#define POE_RW		UL(0x5)
+#define POE_XW		UL(0x6)
+#define POE_RXW		UL(0x7)
+#define POE_MASK	UL(0xf)
+
 #define ARM64_FEATURE_FIELD_BITS	4
 
 /* Defined for compatibility only, do not add new users. */
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 145b33f75a96..1d371a24da6e 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2555,6 +2555,18 @@ Sysreg	PIR_EL2		3	4	10	2	3
 Fields	PIRx_ELx
 EndSysreg
 
+Sysreg	POR_EL0		3	3	10	2	4
+Fields	PIRx_ELx
+EndSysreg
+
+Sysreg	POR_EL1		3	0	10	2	4
+Fields	PIRx_ELx
+EndSysreg
+
+Sysreg	POR_EL12	3	5	10	2	4
+Fields	PIRx_ELx
+EndSysreg
+
 Sysreg	LORSA_EL1	3	0	10	4	0
 Res0	63:52
 Field	51:16	SA

-- 
2.39.2

