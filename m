Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA997E8E98
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 07:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjKLGQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 01:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjKLGQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 01:16:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C214790
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 22:16:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F82C43391;
        Sun, 12 Nov 2023 06:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699769770;
        bh=DKk902dUzJRu+EpHJ3Wk2xXFN2nL8OoR25SRcqCxR2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c59OtDgxKoaL5H+8t/esEfV4kKvicRpVLj8v1lnhz3siL7SoX+2IByEa0bFClwdAn
         gWRKRChuD0ELQzyxEhYYTrZ2c111YRbKdTtjo5SAXQ7zbrerldn80owtj+w72YJl8o
         XyBcE5AGmM3J9GulU7mgINeZo+r9aq4447aDD8rL7aO3bGorg4INoFvR5ly2W5eWa/
         PGT6kAuUzfr9kOZVP9bqms7r2XiNrBnF3kWDsm3W6ESHZ9jx35kFCdp06buDcYrX2T
         idUnQF9oVyN4PTA5ImVxyC9kkYF+rJYoA+Xbsf33gcQdiYEuMw0BkhIdKmJkuKVy2l
         qZ113gkQTjpoA==
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
Subject: [RFC PATCH V2 07/38] riscv: u64ilp32: Add ptrace interface support
Date:   Sun, 12 Nov 2023 01:14:43 -0500
Message-Id: <20231112061514.2306187-8-guoren@kernel.org>
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

The pt_regs of u64ilp32 is the same as the 64-bit kernel's. So, change
to use native_view instead.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/kernel/ptrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 1d572cf3140f..5471b12127da 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -369,7 +369,8 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 {
 #ifdef CONFIG_COMPAT
-	if (test_tsk_thread_flag(task, TIF_32BIT))
+	if (test_tsk_thread_flag(task, TIF_32BIT) &&
+	   !test_tsk_thread_flag(task, TIF_64ILP32))
 		return &compat_riscv_user_native_view;
 	else
 #endif
-- 
2.36.1

