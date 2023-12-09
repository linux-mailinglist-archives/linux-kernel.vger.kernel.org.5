Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724BE80B138
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 02:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574951AbjLIBES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 20:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbjLIBD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 20:03:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2CB19B6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 17:03:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CAEAC433C8;
        Sat,  9 Dec 2023 01:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702083829;
        bh=wYTPG58kQ3FTU8fuSGUlR164oLsc26KfTISwslk9hHk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Xeh3NdGJy1IJraAca/gHymqUp3KVdY6xjvbZO0x5C9gD7YX5AC42uUm6k0xAafLWK
         2hDSAnGMDbM65d2uKwkSDgCrSq5ezkCR2zkuHbH8ozU+NFyxBc39C2CMwKjcN2UaR6
         UgvM+YYdyxFiGWk/tqPoLiXfZ1Y+nk4r3se3cpl3ZMJDciWKqPy1nzbUk7hoaSvoyz
         zoNlmQLzKWpJDu3iIjhaCMgKguD2PvBnfRewZC5cEHUJIlcAkQZY1/CiGDWiDQDEz/
         24Mb8NVx1W/RdWiaj/gimnzvGo1bmJHZZjge1vC8pCU2n+PM4pJtRTJ9O+skqDYMZb
         Ls2pJjao7alxQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Sat, 09 Dec 2023 01:02:56 +0000
Subject: [PATCH 10/13] arm64/sysreg: Update SCTLR_EL1 for DDI0601 2023-09
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231209-b4-arm64-sysreg-additions-v1-10-45284e538474@kernel.org>
References: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
In-Reply-To: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=817; i=broonie@kernel.org;
 h=from:subject:message-id; bh=wYTPG58kQ3FTU8fuSGUlR164oLsc26KfTISwslk9hHk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlc7zb8cmOGjJ3AaJAeTjk1pQxuD2AT1KBoGUOj
 AQPe+3hQmyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZXO82wAKCRAk1otyXVSH
 0CQLB/0YO9YfMvf9m7k/YY4XbuG5DtcdPGbQH64aa76p5b5VRyDgXuEoswbmcCfSvGKcw2OjHce
 4d2nu77iiZVwBdDPtXylZ6gRd9Bhuj4ECU+POfRuej1bxOkAREMFcaR0pY+KAz8GxcM0e2EF0Kq
 llZbmjWeGjvsTD+dUAzjOyA3jp2KWpGQ2ioUyLKP0RN70hIptQkQw0lR2H0BDEBz6+neb4bVPTZ
 2D3ojHIgJ60Rma7sNZ2ipqZaoxldqKFkpWxGPJxfOHty3PNFv4p9+e3wtzP6NduIfvXrOd9zz7g
 lmQOSuOuXNPE/Ybv7TolS3+4/5EwkqHwdO2brCP9Wd/sRjZ2
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
index 839f7cca53e0..4137179e7570 100644
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
2.39.2

