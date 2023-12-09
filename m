Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198ED80B137
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 02:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574970AbjLIBEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 20:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236009AbjLIBD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 20:03:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161291723
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 17:03:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23993C433C9;
        Sat,  9 Dec 2023 01:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702083833;
        bh=ToeIxreJG1oFngsB43OoIIYhq6GawMkLFPrR11wb8nQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=BGHJw4XOBGHXxqeKqXFyOutafgxSGHn552443+zpZnsA/8Z/yX+oW7w9NF8nQ6pNt
         wKozGIxsImzOExR9GfL2iuGNPwsQPYv+kK+LCQ9FbJ2i7mtIbjVF9RrykCO+0epW3n
         U4PirW4bXSsPVrUPh1bLXUuC/yPCiNP81wUS1lHUe6TQpxbugULik9pSjxuhr+x3Sw
         FGFPhoiSVD2rKV+Lma3qioAiTzWhGq4CANnLrcqLa3OQxKZvic2DOzAgOzYceiAWHb
         9D5YS4Ss0Sg5UscZ3jwSJIZ2VqVcWy371cSOAXbO+YJv9qaG3D9Nj8wM8f0mvM64gt
         /4DaIJzbOC6GQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Sat, 09 Dec 2023 01:02:58 +0000
Subject: [PATCH 12/13] arm64/sysreg: Add definition for FPMR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231209-b4-arm64-sysreg-additions-v1-12-45284e538474@kernel.org>
References: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
In-Reply-To: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=975; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ToeIxreJG1oFngsB43OoIIYhq6GawMkLFPrR11wb8nQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlc7zdK6o8VYqFAgCXK9TeHf95XQTHnBtIunkid
 vfiKxtDTcaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZXO83QAKCRAk1otyXVSH
 0FFVB/sEWzv1FgqPe+kSCSPsyel79VWIUWB+ZHFp5BGi/LfB8vtBULVWNs/17e0A2Tpqvwgav8A
 WTZX/bBw10t23bT9pvuaL1gOwCq+QntST4TY8V86avOllJLd0EES3QPfu2Kqtz5DY2tG0ijk3/c
 WrxdHBxEDQm1bIFbJ2mtnC/PYlJkeQAS64jFb0oLrJkFExC8vBeghVYgtX+Sh9OxHhAVkCr3XKN
 Kpwl/iR0pMd41rnZqYhfXMlkAll8fQSDLy+W37venH7bcwRr7xhOufNOhOOssd4DSR0wSY5hBbR
 P0V3MTP8efigTzK7b7O+4sWVHxUzfqG/kuiLxfz4HY6+BZuW
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
index 1acec8f5c37d..1c6d1c904750 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2139,6 +2139,29 @@ Field	1	ZA
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
2.39.2

