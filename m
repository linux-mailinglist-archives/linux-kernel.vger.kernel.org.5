Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EE2805BB6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345374AbjLEQvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbjLEQvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:51:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F3AD66
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:51:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E66C433C7;
        Tue,  5 Dec 2023 16:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701795097;
        bh=TRfwOBP1ct8dRqN5onbbksp9izfKksijyA3SFS57tL8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=GJJAN/sdgW9lhyQnig67GRbm2cbkYg1U4DWRVPeKYiM3i/TYzLd3fPVDrGJgix8Mm
         FuBQLMzYOSaV+7mhEBTPz/D64h/z+OILnf7FGbGHoIoS2O9bTg+jtz3Zr8Llno4q37
         ehtoCLl5oGh1RMHo+nQnFi0A9hV+8MxUj9jDgjsOz0jasV4/l4WrTT/uVpL+PXCSdS
         fyN/Ns30isTwXbF+AXafUWgi7Xkar4nRgzMZVDEETy2hX/GE/X51ze4nH4NP1EgXhS
         Nj9hc00IafLWlUWBqfe7M6fzCkhGFjhCg/QCFPqCoQPxLCSAyJxerAGHlFMgjjjJmV
         LR9AITvK6EAUQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 05 Dec 2023 16:48:06 +0000
Subject: [PATCH v3 08/21] arm64/sysreg: Add definition for FPMR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-arm64-2023-dpisa-v3-8-dbcbcd867a7f@kernel.org>
References: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
In-Reply-To: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=975; i=broonie@kernel.org;
 h=from:subject:message-id; bh=TRfwOBP1ct8dRqN5onbbksp9izfKksijyA3SFS57tL8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlb1TvVsjO+1Ho6qAlj6qwCmPte6Bb7DMChC7dyCkd
 PySIUMuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZW9U7wAKCRAk1otyXVSH0Kt6B/
 9CefQbQVJNo9MwymwwWXuS68fFeyVNw2SeJiyB6yG6JaaIldk3ZEoHjyKVwthWwBkAlh0D+F4BgnSI
 0uqu35O4JMVRTn55wEe1Kz2+3C3g5n7/jfPsDfvEfdR+p3taYvvSJxUbMDoAGuorPot3y6ADVHTeMF
 Rb/Ui71ogWxW1R+hAD9us2c1MluIM69SXC7SIxsdQDLWH/SZho9p5j1f6pXxiJ9081AQva7XhRR2j8
 5GRdYVyr1rQpclvsx4lsqZUjeZJWzER+bQSmPiAc17iKf27jKVmnjB6bhop2TipQYaohmgIyAOivVh
 cK5nL8FVat4M64Cv/mMfygRV7eQlEV
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

