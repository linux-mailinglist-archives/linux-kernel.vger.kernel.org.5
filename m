Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326047EB248
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbjKNOgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbjKNOfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:35:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E9F10CE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:35:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F851C433CA;
        Tue, 14 Nov 2023 14:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699972542;
        bh=tnXYFwh5n0qNcsRXurtqbaVARrY3vmLHqYkv+SC46VU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=F2qsC+hYRzp+zkl0cu+7wANu/Kg6DJ2+Osfeb6Y+ZhcNB6ONN5g2kBsYqSheH3/dZ
         rBh1J3R7SgBi6FZqPVGP6hrdc7d+pp2ERrMxqAnYaTRxWJ+cqmIwTN3Ric5QDaRjWR
         142cPWHrRfwVVbwl3bG6byEhgC0ZItoVBjQAdvzym/WfyieIcDENl4eGbbRq6GsY9j
         SJwuNdrX0Irs9KAXol/8m6x+JN0mJQd5BzYxQcuit4DK6Vo7DWJX+IVE3rGA8U6Bvl
         oVWGN3SJheOAfGXuvQjEDNS1dcWzsEAqI0CsbleL8PRFMUDQVi3NSPi3vkv3ZY3FUR
         hijiL1ASziW5g==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 14 Nov 2023 14:34:51 +0000
Subject: [PATCH v2 06/21] arm64/sysreg: Update SCTLR_EL1 for DDI0601
 2023-09
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-arm64-2023-dpisa-v2-6-47251894f6a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=817; i=broonie@kernel.org;
 h=from:subject:message-id; bh=tnXYFwh5n0qNcsRXurtqbaVARrY3vmLHqYkv+SC46VU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlU4WZQLjjlJnDG6sLMYbbDE8khFwcKUOr3r1xSwhg
 Tn3j2uGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVOFmQAKCRAk1otyXVSH0HacB/
 4tdRseQb8KW8QSZ53F1aeLRN6HJJXEqHZvfffd8e9793kNW1hft7Gk05vbS3TkhjaVk3cqcb9F8PzB
 RpAb6DOkvap2BBdh2gkIHqEBbZe+Pcr9Xrzj5N9eEO5eoDBBPDuDSaNPAISwM13AaibLrXJv8wxaFP
 hPBMG6G7WWvnC1jOTJnnl5Ae3WSYfzkKIsRnaRjK4vOxgNNGQajMYUqWv7p52pH9q2HESPzgkaGKBC
 MFhC+vLmO/zZuDCRL6tEuwE3BqvYwgpRBxV4RN1dGwUTHNEhDf51tRnbFnVZV6DUJyC9rW/LITIxQx
 hjUJSZY1PbZiioeGwZ/+8yC8OPxMn8
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

DDI0601 2023-09 defines some new fields in SCTLR_EL1 controlling new MTE
and floating point features. Update our sysreg definition to reflect these.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index aee9ab4087c1..eea69bb48fa7 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1791,7 +1791,8 @@ Field	63	TIDCP
 Field	62	SPINTMASK
 Field	61	NMI
 Field	60	EnTP2
-Res0	59:58
+Field	59	TCSO
+Field	58	TCSO0
 Field	57	EPAN
 Field	56	EnALS
 Field	55	EnAS0
@@ -1820,7 +1821,7 @@ EndEnum
 Field	37	ITFSB
 Field	36	BT1
 Field	35	BT0
-Res0	34
+Field	34	EnFPM
 Field	33	MSCEn
 Field	32	CMOW
 Field	31	EnIA

-- 
2.30.2

