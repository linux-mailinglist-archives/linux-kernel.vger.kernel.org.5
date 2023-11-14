Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11D57EB22D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbjKNOfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbjKNOfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:35:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089B61A5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:35:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD53C43395;
        Tue, 14 Nov 2023 14:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699972536;
        bh=9pvl6RJ+p+9jph69b/rCGpkJ7MZ4wRu40V+N9vMPcAQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=bFW3jGGrX99CyL0qi9olo9EfX11xLdNZ9fEu7dCGbEJmzqnccxQWBJEZbfo6agP0U
         1I/GDBwNS4TB59trVs5rlIyYAfXqf6681CuPfrXp20aozLma9Le2XoOhaMzLVdkKct
         Gkc+Voik1z209A38TYuU0N/c1TZbt/4X+qHSFo81fNrVhwHT5oH+xxbvuB+BPJEnYJ
         4ZROoyNgXVZj61JbkKJtFYHSKSYUDQDBKKM/zRlnp10WCiPePmKNaVR8GKriMakDI9
         rv+gY2Pq2Bqj5DZ2P153940soaIGbiZX3PfamGCa/aewAngYi4hwD22tOvRC3ycnZ1
         UewPB5cADvHnA==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 14 Nov 2023 14:34:49 +0000
Subject: [PATCH v2 04/21] arm64/sysreg: Add definition for ID_AA64FPFR0_EL1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-arm64-2023-dpisa-v2-4-47251894f6a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1020; i=broonie@kernel.org;
 h=from:subject:message-id; bh=9pvl6RJ+p+9jph69b/rCGpkJ7MZ4wRu40V+N9vMPcAQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlU4WXI0i29C4AWZW/YdvOD1Lh7Tx09sVecB9ewLYw
 +MdTa+WJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVOFlwAKCRAk1otyXVSH0AOSB/
 9bMf1Cmxor0PH3zuV67Z5stn5fPhpnE6Hbzy2PO6/Cf+idns/JP6EScwnEM1CadFTBeTA+mGZbzElI
 5fnvqB0PE6JyNrmHnJgoHvOFge30QTpfQ8ZcsVBzS8mMSeuLp3jbs770uB7olgd+8FcnFfOry86/wp
 ZoRcFrP0mKXG/E3t1vxfTVqogS+rXEYWLH4i8AihyT+Iqt1OqrvsarSOrg8GqWBwOghwCMTtW3UPMG
 gaOY/mkL0FKJx+STQ+TzdGefd+nAtcRLVdCKuNdaKSE7LDJWtcYynryXPCswotihzmXQiLW4rbdYx6
 jLAYSF4xsyEmAU+G2Se/Zv/JR27DZt
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

DDI0601 2023-09 defines a new feature register ID_AA64FPFR0_EL1 which
enumerates a number of FP8 related features. Add a definition for it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 3d623a04934c..c9bb49d0ea03 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1131,6 +1131,35 @@ EndEnum
 Res0	31:0
 EndSysreg
 
+Sysreg	ID_AA64FPFR0_EL1	3	0	0	4	7
+Res0	63:32
+UnsignedEnum	31	F8CVT
+	0b0	NI
+	0b1	IMP
+EndEnum
+UnsignedEnum	30	F8FMA
+	0b0	NI
+	0b1	IMP
+EndEnum
+UnsignedEnum	29	F8DP4
+	0b0	NI
+	0b1	IMP
+EndEnum
+UnsignedEnum	28	F8DP2
+	0b0	NI
+	0b1	IMP
+EndEnum
+Res0	27:2
+UnsignedEnum	1	F8E4M3
+	0b0	NI
+	0b1	IMP
+EndEnum
+UnsignedEnum	0	F8E5M2
+	0b0	NI
+	0b1	IMP
+EndEnum
+EndSysreg
+
 Sysreg	ID_AA64DFR0_EL1	3	0	0	5	0
 Enum	63:60	HPMN0
 	0b0000	UNPREDICTABLE

-- 
2.30.2

