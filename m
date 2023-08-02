Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAACA76C571
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjHBGnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjHBGnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:43:16 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A579230DD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 23:42:48 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 4745B24E248;
        Wed,  2 Aug 2023 14:42:17 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 2 Aug
 2023 14:42:17 +0800
Received: from ubuntu.localdomain (183.27.98.54) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 2 Aug
 2023 14:42:16 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Conor Dooley <conor@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Dao Lu <daolu@rivosinc.com>,
        "Heiko Stuebner" <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        "Minda Chen" <minda.chen@starfivetech.com>
Subject: [PATCH v1] riscv: Using TOOLCHAIN_HAS_ZIHINTPAUSE marco replace zihintpause
Date:   Wed, 2 Aug 2023 14:42:15 +0800
Message-ID: <20230802064215.31111-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.98.54]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually it is a part of Conor's
commit aae538cd03bc ("riscv: fix detection of toolchain
Zihintpause support").
It is looks like a merge issue. Samuel's
commit 0b1d60d6dd9e ("riscv: Fix build with
CONFIG_CC_OPTIMIZE_FOR_SIZE=y") do not base on Conor's commit and
revert to __riscv_zihintpause. So this patch can fix it.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 arch/riscv/include/asm/vdso/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/riscv/include/asm/vdso/processor.h
index 14f5d27783b8..96b65a5396df 100644
--- a/arch/riscv/include/asm/vdso/processor.h
+++ b/arch/riscv/include/asm/vdso/processor.h
@@ -14,7 +14,7 @@ static inline void cpu_relax(void)
 	__asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
 #endif
 
-#ifdef __riscv_zihintpause
+#ifdef CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE
 	/*
 	 * Reduce instruction retirement.
 	 * This assumes the PC changes.
-- 
2.17.1

