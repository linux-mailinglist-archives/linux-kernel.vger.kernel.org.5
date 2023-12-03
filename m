Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046BD802474
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 15:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbjLCOKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 09:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbjLCOKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 09:10:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091DF90
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 06:10:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C66C433CA;
        Sun,  3 Dec 2023 14:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701612629;
        bh=c3VWF+YhQlWgynBzGD9ffKWLf/aMfGwEbNyjhdaRP3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NbWzBVf/UR4yv5Cp0G8WhSSQ384ppzLv/5r701R/0c1MD0woHqROVMOeNzp4L99/Q
         CXlzhCeO6GssHUvSmheVJtYG0DxrkMlPSppERq60obNeK01/kpaAOY3lZlF/2yR2+d
         RSPiLMVRa/WoaC5jwyiwY+G7boSPOrhzNyYzaavFVC1U8A3nSyHy61q429QY63KQSf
         aSl3DCLDORHSFU+P3LdEOYOKV20PTRv26H1bPIx57US5oeDPcbc3Wwn3iYkP57YSeE
         DWKJaIvCsnMvPkeoveRRzz8hMAUba1Z8HvQO7W8vf7HjepMKfUACJn/IkgXH0Q9Ihn
         hi4xaCGUZvjGg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] riscv: introduce RISCV_EFFICIENT_UNALIGNED_ACCESS
Date:   Sun,  3 Dec 2023 21:57:52 +0800
Message-Id: <20231203135753.1575-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231203135753.1575-1-jszhang@kernel.org>
References: <20231203135753.1575-1-jszhang@kernel.org>
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

Some riscv implementations such as T-HEAD's C906, C908, C910 and C920
support efficient unaligned access, for performance reason we want
to enable HAVE_EFFICIENT_UNALIGNED_ACCESS on these platforms. To
avoid performance regressions on other non efficient unaligned access
platforms, HAVE_EFFICIENT_UNALIGNED_ACCESS can't be globally selected.

To solve this problem, runtime code patching based on the detected
speed is a good solution. But that's not easy, it involves lots of
work to modify vairous subsystems such as net, mm, lib and so on.
This can be done step by step.

So let's take an easier solution: add support to efficient unaligned
access and hide the support under NONPORTABLE.

Now let's introduce RISCV_EFFICIENT_UNALIGNED_ACCESS which depends on
NONPORTABLE, if users know during config time that the kernel will be
only run on those efficient unaligned access hw platforms, they can
enable it. Obviously, generic unified kernel Image shouldn't enable it.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7f8aa25457ba..0a76209e9b02 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -654,6 +654,18 @@ config RISCV_MISALIGNED
 	  load/store for both kernel and userspace. When disable, misaligned
 	  accesses will generate SIGBUS in userspace and panic in kernel.
 
+config RISCV_EFFICIENT_UNALIGNED_ACCESS
+	bool "Use unaligned access for some functions"
+	depends on NONPORTABLE
+	select HAVE_EFFICIENT_UNALIGNED_ACCESS
+	default n
+	help
+	  Say Y here if you want the kernel only run on hardware platforms which
+	  support efficient unaligned access, then unaligned access will be used
+	  in some functions for optimized performance.
+
+	  If unsure what to do here, say N.
+
 endmenu # "Platform type"
 
 menu "Kernel features"
-- 
2.42.0

