Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2417FEEB4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjK3MPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjK3MPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:15:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069F2D4A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 04:15:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124E7C433C9;
        Thu, 30 Nov 2023 12:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701346547;
        bh=HmEvOH8Vmsy9AJOG2aGCmYoPEIzruRbAiBD2YtmkRA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f9Q5rmh9aU+KSwsXTUbDjhEslkwGTLJuD4YuvMKZRNk1vid8BLmrfcxYmm5rGC3Sv
         3AeVL2U4xQD8iGEf5sdIVwqG8VKvcfyZToF3GOVR1N4xhpz29fHpZm5WjQkfPxU/oa
         NCIH9i21TD6fDUvf90zs0Vqn3/6daJEmcrRSwFQ8oI+U15yf5TPwVfQ+GFsAvZ5xB9
         98WoVjgKVInr3rBkHlBzIN1C3133mWV+BOx8BiXkxuU6OA5K0fL28TAZGaO+4cntvL
         IzXdGCWDKjhi25Jgr7pupYTgq9xbvkppQ6jSgaejO4vPumm4hCoJIer45JZzZLvtKq
         q6hQGZqNk3T1Q==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Song Shuai <suagrfillet@gmail.com>,
        Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        songshuaishuai@tinylab.org,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v12 for-next 1/4] riscv: select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
Date:   Thu, 30 Nov 2023 13:15:28 +0100
Message-Id: <20231130121531.1178502-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231130121531.1178502-1-bjorn@kernel.org>
References: <20231130121531.1178502-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Shuai <suagrfillet@gmail.com>

In commit afc76b8b8011 ("riscv: Using PATCHABLE_FUNCTION_ENTRY instead
of MCOUNT") RISC-V added support for -fpatchable-function-entry, which
removes the need for recordmcount.

Select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY to tell the build
system not to run recordmcount.

Link: https://lore.kernel.org/linux-riscv/CAAYs2=j3Eak9vU6xbAw0zPuoh00rh8v5C2U3fePkokZFibWs2g@mail.gmail.com/T/#t
Link: https://lore.kernel.org/linux-riscv/Y4jtfrJt+%2FQ5nMOz@spud/
Signed-off-by: Song Shuai <suagrfillet@gmail.com>
Tested-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@kernel.org>
Acked-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 95a2a06acc6a..69c95e42be9f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -68,6 +68,7 @@ config RISCV
 	select CPU_PM if CPU_IDLE || HIBERNATION
 	select EDAC_SUPPORT
 	select FRAME_POINTER if PERF_EVENTS || (FUNCTION_TRACER && !DYNAMIC_FTRACE)
+	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_FTRACE
 	select GENERIC_ARCH_TOPOLOGY
 	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
-- 
2.40.1

