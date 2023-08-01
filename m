Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFE476B5BA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbjHANZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbjHANZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:25:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B379C2116
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 06:24:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E5E8615A3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 13:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF58C433C7;
        Tue,  1 Aug 2023 13:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690896297;
        bh=kRD+z973ymfN8CUInsVsbutA6ADoO6ucBF0+2kGIUy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WQ8ryfpIqxjOXfYyBJzKG4qNR6jyMndhOItuP0gL6Zbgx8+366OyCfJMkg5+BZMFU
         auaat53rdg3hW7VpAIdGX1pYYWZ4yNc/ppnGpvrqLn4F4ZP4fD1FYymoXgwah8cSMT
         uYWt+A+CW+hwn1wiSqnpb5qBSDAv+Ibjqz2u5kSPq5VV/H2Gl6jL7YPMeV/6AkfGuA
         9XuN+ZIvzLOaoddC29YcQln5X8lCsIrY3xThY7Dd6O09l0/a3Ley0FzhflcQBXdx47
         eWINZFRzrKs6nKk3kKDM9viCOE2mroMnZiqreHOWvNJwXxhQX4BTbr6y6LOTwocsVN
         oUDSA7fzB3cWw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Eric Dumazet <edumazet@google.com>
Subject: [RFC PATCH 4/6] x86/softirq: Support softirq disabled mask
Date:   Tue,  1 Aug 2023 15:24:39 +0200
Message-Id: <20230801132441.559222-5-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801132441.559222-1-frederic@kernel.org>
References: <20230801132441.559222-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support the new softirq disabled vectors mask and put in the per-cpu
hot structure along with the pending vectors mask as both are used
closely together.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/x86/Kconfig               | 1 +
 arch/x86/include/asm/current.h | 1 +
 arch/x86/include/asm/hardirq.h | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a2a410d13e39..f1cd68b672dc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -93,6 +93,7 @@ config X86
 	select ARCH_HAS_COPY_MC			if X86_64
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_SET_DIRECT_MAP
+	select ARCH_HAS_SOFTIRQ_DISABLED_MASK
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index a1168e7b69e5..b86ca9c0ddc2 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -23,6 +23,7 @@ struct pcpu_hot {
 			unsigned long		top_of_stack;
 			void			*hardirq_stack_ptr;
 			u16			softirq_pending;
+			u16			softirq_disabled;
 #ifdef CONFIG_X86_64
 			bool			hardirq_stack_inuse;
 #else
diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index 66837b8c67f1..933cf05e5738 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -61,6 +61,7 @@ extern u64 arch_irq_stat(void);
 #define arch_irq_stat		arch_irq_stat
 
 #define local_softirq_pending_ref       pcpu_hot.softirq_pending
+#define local_softirq_disabled_ref       pcpu_hot.softirq_disabled
 
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 static inline void kvm_set_cpu_l1tf_flush_l1d(void)
-- 
2.34.1

