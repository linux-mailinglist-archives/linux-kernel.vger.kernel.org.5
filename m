Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD547852E9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbjHWIna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbjHWIcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:32:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B567210F5;
        Wed, 23 Aug 2023 01:28:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ABAE614BE;
        Wed, 23 Aug 2023 08:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA90C433C7;
        Wed, 23 Aug 2023 08:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692779333;
        bh=sgE48NtgP4eQen2ml46+iGXN2pZhCvwsUI3qxh709IA=;
        h=From:To:Cc:Subject:Date:From;
        b=B8XeCEiyNqSPMfc/NUpIMPqso5AROFao4byCojwbb5El1u6vSLFULDLvh/AQ9J9TP
         xYC4h2NCGDg1FNfUwHHbeRWhOJooIm4+18XN/Zy4G43BH0sr6vXTenjM5wA8rE7Imt
         fXncqCcjvg9fhu8gG9hy/3DATr+TuHwLPfzJxmsMishCx3lHyZuu/G7OjN1kAw1EHE
         I+nfxzy/zZ88AweOIeQHsgntA6vUTPBFDsyDnlsAs8aKjWUWAs9Btg8oLiuiahMdG5
         cqMPbl0IfTurajBVvnWCCPWMFxx/8xrF99N9+NeOfPI7T3Ewe0NH9TNfwt2yCS2bJs
         PBxkutaUE1+BA==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Drew Fustini <dfustini@baylibre.com>,
        linux-next@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] riscv: Require FRAME_POINTER for some configurations
Date:   Wed, 23 Aug 2023 10:28:45 +0200
Message-Id: <20230823082845.354839-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

Some V configurations implicitly turn on '-fno-omit-frame-pointer',
but leaving FRAME_POINTER disabled. This makes it hard to reason about
the FRAME_POINTER config, and also triggers build failures introduced
in by the commit in the Fixes: tag.

Select FRAME_POINTER explicitly for these configurations.

Fixes: ebc9cb03b21e ("riscv: stack: Fixup independent softirq stack for CONFIG_FRAME_POINTER=n")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/Kconfig  | 1 +
 arch/riscv/Makefile | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 10e7a7ad175a..cd8075c092c3 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -62,6 +62,7 @@ config RISCV
 	select COMMON_CLK
 	select CPU_PM if CPU_IDLE || HIBERNATION
 	select EDAC_SUPPORT
+	select FRAME_POINTER if PERF_EVENTS || (FUNCTION_TRACER && !DYNAMIC_FTRACE)
 	select GENERIC_ARCH_TOPOLOGY
 	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 6ec6d52a4180..1329e060c548 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -87,9 +87,6 @@ endif
 ifeq ($(CONFIG_CMODEL_MEDANY),y)
 	KBUILD_CFLAGS += -mcmodel=medany
 endif
-ifeq ($(CONFIG_PERF_EVENTS),y)
-        KBUILD_CFLAGS += -fno-omit-frame-pointer
-endif
 
 # Avoid generating .eh_frame sections.
 KBUILD_CFLAGS += -fno-asynchronous-unwind-tables -fno-unwind-tables

base-commit: 89bf6209cad66214d3774dac86b6bbf2aec6a30d
-- 
2.39.2

