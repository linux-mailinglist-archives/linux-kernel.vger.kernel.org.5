Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D582280B131
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 02:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574906AbjLIBDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 20:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbjLIBDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 20:03:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5BB1997
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 17:03:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA731C433CB;
        Sat,  9 Dec 2023 01:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702083817;
        bh=LsDnlF3meFuafld1/AmeRtyE6f3SLoycjaZo8IadggI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=IVWoFZy75aPytf+gTs72cjqeTYTD1v6I033ALvtYqTiRWtFV9xBfWDiaDEau/2Fcl
         LLzMIZGweSSeN+q0w7Nx/cV8mJll5A1bok1FJLjFssnEjJAUeCGmv2EddXSFmDUwnf
         1AeZq9f78UqECxAW4Vs5hkvgcCXvmYb7uSsyOp8nf7qqJa5QMpTdtpJ2vF5sDir58I
         n8B0qmo/Wib6UJFPrjQ09H+UmpNvH8bAUPTM5huwEAw8K70MBPWOTdrh+XRkXch/sI
         5qyqrbqDHtd/dXV6Kb4cshqN4jCMIq3BdZWMiAhHppVeImMmg3zxqX2ncX/yaQiJsL
         CxYcm3qOALXLw==
From:   broonie@kernel.org
Date:   Sat, 09 Dec 2023 01:02:50 +0000
Subject: [PATCH 04/13] arm64/sysreg: update CPACR_EL1 register
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231209-b4-arm64-sysreg-additions-v1-4-45284e538474@kernel.org>
References: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
In-Reply-To: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=727; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ddBI7oNX2wSpZp4S5aePe7JfhXouK6odZuq+54o3Gt0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlc7zXwoh9l2NqVLvqwoVDtYcp/b5059osiap5u
 HNPmMo78QqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZXO81wAKCRAk1otyXVSH
 0Dx6B/9eqPveqAsNIBb+SI+gCfAezrAU4s1CJezrcG10ea10D2q5iiI210gpxbCxfbRbRGa0pfS
 6GlXzTrU3ocBogs+7cXhVika26xamPUBhJfZsQy5CUgzOlIGTnOiIWSGe0jlv3YmP8Pwn3jWFCP
 Oeyu2izHh0hVhRa0b5nnj40dGOnkX2BatjeBbStkd8BqJJStXbP+N28X0adiC6H41xxd+7OjYYH
 zXH1DaZzkzK4XqzgTU515S9Cc6dsORwmRX2pAS/3yYfS4hPUiQPys+p42tTBXGCJoy7sYkm/o5O
 4gbdcXNb+UdxgMfzJynj0G4ulU3PNdKynSGTc+yj7OBaCqVU
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

Add E0POE bit that traps accesses to POR_EL0 from EL0.
Updated according to DDI0601 2023-03.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 1d371a24da6e..c2dbbaa22620 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1747,7 +1747,8 @@ Field	0	M
 EndSysreg
 
 SysregFields	CPACR_ELx
-Res0	63:29
+Res0	63:30
+Field	29	E0POE
 Field	28	TTA
 Res0	27:26
 Field	25:24	SMEN

-- 
2.39.2

