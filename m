Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73571805B63
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjLEQw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbjLEQv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:51:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E241723
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:51:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4C9C433CA;
        Tue,  5 Dec 2023 16:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701795117;
        bh=p49U0rB8BLfyvHeTkXNyujHDJxY2xWglioVFZrQRPgM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=sTX3dENKdeRtF1TDCs8y57CuUdUdUV5Yqpq5pLii19eel6UrnhjYhv5UnGJS2tBay
         5/lTorQnHuv8is7/WteqnSigSIq77qN3CkNimW/tbcXtMj8JGqgsNpfCOBzP3XQvRo
         3CPUg3WaB60kqDu9Cpg49eVRpYf1PHj8ZqWkDiYH1jajKI4Ahi4+H8+Lcrwgwi5azs
         eSm4AqphZvLmUWUm2Cph7COO57fAjNDLW1GI2baCzas0jTdoPT3C7ST/kYCoFuDup6
         qVkr8j+SvqCaqn5nf6pR76ZO7WA0f9nluGszCs55PTqC3kW1AduuhIT3cuKuXWlI1j
         nanSykD90FmCQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 05 Dec 2023 16:48:12 +0000
Subject: [PATCH v3 14/21] KVM: arm64: Add newly allocated ID registers to
 register descriptions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-arm64-2023-dpisa-v3-14-dbcbcd867a7f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1330; i=broonie@kernel.org;
 h=from:subject:message-id; bh=p49U0rB8BLfyvHeTkXNyujHDJxY2xWglioVFZrQRPgM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlb1TzUP2tOulmt+GKIoNK7BO5wHeBgmWKBL4O1ycG
 4rmKAeaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZW9U8wAKCRAk1otyXVSH0AieB/
 4rwciN5ooMI0noRDiHmL9dDZOgV1MCc98TuDr0afwIp8KUrLGPP6enL09fvLvOWjemPVd5t4G4qwZ+
 LWTYIsa25r3+FLOdSBtYdXOLgTBaNejQ2+EG/Pz0XPIxPFfqipKSyIRpfpmFPHrQVec7tUB84IGYyF
 aGBwC/mp1F0jInr0dyRaz5cqf8dqe2TikDK6F1vWdQFo7iB8UorTzs+DWZinCzpmFJmpMYjg5r40h9
 q0Cd4Ime3WScOJ5VpnDi99dPEm97JmAFYrAPzbjPl8ZIIEPWOpc47q7LcaIDToeIgAJ/04vzti/ax8
 Qn/TAdhRc3H5vSE23w+F1tMia1tG6K
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

The 2023 architecture extensions have allocated some new ID registers, add
them to the KVM system register descriptions so that they are visible to
guests.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/sys_regs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 4735e1b37fb3..b843da5e4bb9 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2139,12 +2139,12 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 		   ID_AA64PFR0_EL1_AdvSIMD |
 		   ID_AA64PFR0_EL1_FP), },
 	ID_SANITISED(ID_AA64PFR1_EL1),
-	ID_UNALLOCATED(4,2),
+	ID_SANITISED(ID_AA64PFR2_EL1),
 	ID_UNALLOCATED(4,3),
 	ID_WRITABLE(ID_AA64ZFR0_EL1, ~ID_AA64ZFR0_EL1_RES0),
 	ID_HIDDEN(ID_AA64SMFR0_EL1),
 	ID_UNALLOCATED(4,6),
-	ID_UNALLOCATED(4,7),
+	ID_SANITISED(ID_AA64FPFR0_EL1),
 
 	/* CRm=5 */
 	{ SYS_DESC(SYS_ID_AA64DFR0_EL1),
@@ -2171,7 +2171,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	ID_WRITABLE(ID_AA64ISAR2_EL1, ~(ID_AA64ISAR2_EL1_RES0 |
 					ID_AA64ISAR2_EL1_APA3 |
 					ID_AA64ISAR2_EL1_GPA3)),
-	ID_UNALLOCATED(6,3),
+	ID_WRITABLE(ID_AA64ISAR3_EL1, ~ID_AA64ISAR3_EL1_RES0),
 	ID_UNALLOCATED(6,4),
 	ID_UNALLOCATED(6,5),
 	ID_UNALLOCATED(6,6),

-- 
2.30.2

