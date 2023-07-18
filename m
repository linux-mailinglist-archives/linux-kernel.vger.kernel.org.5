Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D90C7585B9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjGRTp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGRTpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:45:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1EC198D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 12:45:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 191C360B99
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 19:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7117BC433C9;
        Tue, 18 Jul 2023 19:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689709552;
        bh=0rN5CSxJDnCuMqJvHrYdXsQ52WEJJPMcuK7y/yvyczU=;
        h=From:Date:Subject:To:Cc:From;
        b=Dd1v3n+a46acUabS0xtg5DS8Lg8HgQOsArtsn8JEgsgIJTTY+kgTrzj0lhTD1feQu
         1FdCLetRzF6IRtLXMtEab928tNwrda5BgJ3yznq8IxZwUAckrtBTIbwMxjXWw7CMOv
         TI08ZdJEpNTEm8LfJ4xU0PG57/1RUbi/zB6aNmTvthIx5HlpIFl8a1gIMx63v5vSWO
         U8qwuyOweh7ErMpAaBAaD+zPbiLLKlVF5sQOq5D/l+q16eqJr189JLMUMeXitHOR81
         jpVdjeTzONIj/aDsJVEBTJuw3iwQgKvTCDjCFLZF51XJyfLnSomLklxnP8dRojqCSy
         jDLCx1fNUaU+w==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 18 Jul 2023 20:45:44 +0100
Subject: [PATCH] arm64/cpufeature: Use ARM64_CPUID_FIELD() to match EVT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230718-arm64-evt-cpuid-helper-v1-1-68375d1e6b92@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOjrtmQC/x3MSQqAMAxA0atI1gYcqkGvIi5KjRpwKKmKIN7d4
 vIt/n8gsAoHaJMHlC8Jsm8ReZqAm+02McoQDUVWlBnlhFbX2iBfBzp/yoAzL54VK0NkyZm6GUu
 IsVce5f7HXf++H5lI1PVoAAAA
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1160; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0rN5CSxJDnCuMqJvHrYdXsQ52WEJJPMcuK7y/yvyczU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBktuvuoNn0zPzmd2bZeawg85F4MyZ+ktLaO8JSzmO1
 0Vm0WUOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLbr7gAKCRAk1otyXVSH0KsUB/
 9vRmOUHdOjFGPbQF4xn07mtjEXbTQTNFiHnKkF3H3l7z/XcoL9l5ijeFM96zxJXgypi08YhoNuX0cj
 dae1/zPklYnFMF/5rS3sxDmCueojaLPUhWUw9oMyemzE2aOxACVcro+xaN7J6cox1Pg0YWrGPs3QD/
 JLMpMoQ+u+lPpmqBrF+79IBOtCGQfmEMtjRHZM9Iw9mSdRlDyZPaRTc10JODu/kBAa91fKThOJr9O5
 v2zBDuCY3JABS55z7Ro2iUD9zMBDYR5fy3QgcnF/8DRJ5QG7DwQvCAnEHktjuKYXY9vwwdxx0EDDr+
 obguEajiLzs1MWGVTAM9mofa7y2Vdg
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recently added Enhanced Virtualization Traps cpufeature does not use
the ARM64_CPUID_FIELDS() helper, convert it to do so. No functional
change.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index f9d456fe132d..bcb006390e55 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2708,12 +2708,8 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.desc = "Enhanced Virtualization Traps",
 		.capability = ARM64_HAS_EVT,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
-		.sys_reg = SYS_ID_AA64MMFR2_EL1,
-		.sign = FTR_UNSIGNED,
-		.field_pos = ID_AA64MMFR2_EL1_EVT_SHIFT,
-		.field_width = 4,
-		.min_field_value = ID_AA64MMFR2_EL1_EVT_IMP,
 		.matches = has_cpuid_feature,
+		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, EVT, IMP)
 	},
 	{},
 };

---
base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
change-id: 20230717-arm64-evt-cpuid-helper-5477a7c469f3

Best regards,
-- 
Mark Brown <broonie@kernel.org>

