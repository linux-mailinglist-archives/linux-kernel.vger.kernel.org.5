Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2ADB7E8ECC
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 07:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbjKLGTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 01:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjKLGTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 01:19:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFF155BF
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 22:18:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3362C433C7;
        Sun, 12 Nov 2023 06:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699769922;
        bh=bS9zYu4p2fDX0v+IO9ccI6gNcdJmQYX5Su7I11BAbz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eds0Ikvb4knSS+2emy3RCxl6MssNc5zSLI7TvAgF41P6aLGxzvhumme+tfoiJbZYR
         E64mIZD3foSewobLLFWM8uEAYS2F7Kh6RRauO69qm7oFrRLBiW5gcTGx7lQquDH1H4
         pyGzBxPO8sU1e4R2qo6ecYZVx0NP7Pn6xurHDlH/Gr544GTZVrrt/ofParw6Qb0Tpm
         9o78tX8Aa4k8+RKVvEClQE4oPy776KWO5tvkrU2H3+Gs4WcLuzV1r+qVRi/fQ/GK8P
         B5sTrI/oBj3IU/2VjqZLyF7Cy/1WyISInWnMyztHVxlQ5TsnAF6GPIStsmJkrSURHC
         7/S9+w2Jg0xbg==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, conor.dooley@microchip.com, heiko@sntech.de,
        apatel@ventanamicro.com, atishp@atishpatra.org, bjorn@kernel.org,
        paul.walmsley@sifive.com, anup@brainfault.org, jiawei@iscas.ac.cn,
        liweiwei@iscas.ac.cn, wefu@redhat.com, U2FsdGVkX1@gmail.com,
        wangjunqiang@iscas.ac.cn, kito.cheng@sifive.com,
        andy.chiu@sifive.com, vincent.chen@sifive.com,
        greentime.hu@sifive.com, wuwei2016@iscas.ac.cn, jrtc27@jrtc27.com,
        luto@kernel.org, fweimer@redhat.com, catalin.marinas@arm.com,
        hjl.tools@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH V2 32/38] riscv: s64ilp32: Validate harts by architecture name
Date:   Sun, 12 Nov 2023 01:15:08 -0500
Message-Id: <20231112061514.2306187-33-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231112061514.2306187-1-guoren@kernel.org>
References: <20231112061514.2306187-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

When rv64ilp32 was introduced, the 32BIT would work with rv64,isa. So
use the architecture name instead of the ABI width name. This is an
addition to the commit: 069b0d517077 ("RISC-V: validate riscv,isa at
boot, not during ISA string parsing").

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/kernel/cpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index bc39fd16ab64..3c06ffc00fe0 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -66,10 +66,11 @@ int riscv_early_of_processor_hartid(struct device_node *node, unsigned long *har
 		return -ENODEV;
 	}
 
-	if (IS_ENABLED(CONFIG_32BIT) && strncasecmp(isa, "rv32ima", 7))
+	if (IS_ENABLED(CONFIG_RV32I) && strncasecmp(isa, "rv32ima", 7))
 		return -ENODEV;
 
-	if (IS_ENABLED(CONFIG_64BIT) && strncasecmp(isa, "rv64ima", 7))
+	if ((IS_ENABLED(CONFIG_RV64I) || IS_ENABLED(CONFIG_RV64IILP32))
+				     && strncasecmp(isa, "rv64ima", 7))
 		return -ENODEV;
 
 	return 0;
-- 
2.36.1

