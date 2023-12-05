Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40202805B6F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjLEQvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345207AbjLEQvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:51:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7607D1BF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:51:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EB4C433CD;
        Tue,  5 Dec 2023 16:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701795091;
        bh=tnXYFwh5n0qNcsRXurtqbaVARrY3vmLHqYkv+SC46VU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=or8NS/lIiiPb+Ox4HoxbwR/M43khZcE3NB/V8ZMDL52ZNkvdLQ3gXXql+jYrhObfS
         PSxX7yBYfoia2SuWoAlXDiXlMXdmrDGHMEKEiu2jj94fVr9EQC4LB8rryNVIv5Yw93
         OtTNq7nx0Fb1eO+CyPI5ALIQxN84d2n8Kq1QeJKsnRaTdI09M2UwixZWvKNgVx37/N
         FPDQzJRqAc8sv04+3Vn1T53kTAnEIoc4AxCq3zb2/ZHXu7+DHui0t6IziUzUGTeiPB
         bQFQC81Z73tNP+3fkbkF3tGbdiKZrzr2EN/B/btjJBI+6F5Uv42jSks/MkNkH+bVQv
         ZCe+JfOhoWWPg==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 05 Dec 2023 16:48:04 +0000
Subject: [PATCH v3 06/21] arm64/sysreg: Update SCTLR_EL1 for DDI0601
 2023-09
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-arm64-2023-dpisa-v3-6-dbcbcd867a7f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=817; i=broonie@kernel.org;
 h=from:subject:message-id; bh=tnXYFwh5n0qNcsRXurtqbaVARrY3vmLHqYkv+SC46VU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlb1Tt+MU8UN4NHN0+s9UCS1BON2jT/gqU9v/mIok0
 xaVCdHuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZW9U7QAKCRAk1otyXVSH0JKxB/
 99uZPdcZFWCto/Ulu54dapGdYxX7ULcMwSlNjA3UIlhcgqs9/LB2LQrxzM0IqlTwhWI/LbTf8gO2w/
 tIv6mIuH2bIY49WyACEo3MYxSsOwxaFgh+xpLumD7eHzZ964y40a5aPPeXQx1z7BcITnKJbDgsZSdh
 8Euh32VYyIuTO+LUj+dhwHIYM9dApkYG+mteEkIgsWZOxSmWiXC4UzEIKXPkmZGkWS2sgq9i6Q8AWr
 4YMSIzOauc4lEJQMSXBRz1HAgpykhxXyOM+LdorbPDxXM06+d65GcvgATsC2edMC+okljyGqVZtdDo
 IvqWXHE+zuoqr7Gz8DiYD2RUVUWMSe
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

