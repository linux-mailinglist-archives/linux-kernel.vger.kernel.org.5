Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BBF7E8ECF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 07:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjKLGUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 01:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjKLGUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 01:20:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2163B5B87
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 22:19:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F1EC433CC;
        Sun, 12 Nov 2023 06:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699769941;
        bh=qRqp7QPejGbBbu5oKyIM5RFWyLdo559Kq9GxnASTbi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ggOZX2kRI1MtgdsU3XRYcle/m3IZf5lFlvSEYa0dAcFri8lmz9B12mIjqRdjlTXpT
         9eFDzbRis6FA35srzfdsZ1u+hdrQQVMKimjV/uEL8gk48FIJWD4Fq7mAEAar6U9BQA
         UO4a6fHPSuSWXP7Uof/glDnhRF6GmGUcc2ukCjlha4UnHfycJl2E7Vmx63uepFbtX2
         eSwGWL6bq0W+YoWoC5OdGwLBR3dmmolU6lxAdTgevj6QQ9NDteYmG5XgzL4wGhXiFx
         mJWrDq5z/7tZHCpCSiEhZE6dgetUMoigTXmlWHhxf6Q40hsyiNK/Qs5ODE9ZGl3gwW
         COGIgXRKibzXA==
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
Subject: [RFC PATCH V2 35/38] clocksource: riscv: s64ilp32: Use __riscv_xlen instead of CONFIG_32BIT
Date:   Sun, 12 Nov 2023 01:15:11 -0500
Message-Id: <20231112061514.2306187-36-guoren@kernel.org>
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

When s64ilp32 enabled, CONFIG_32BIT=y but __riscv_xlen=64. So we
must use __riscv_xlen to detect real machine XLEN for CSR access.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 drivers/clocksource/timer-riscv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index da3071b387eb..fe83b4e2005a 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -38,7 +38,7 @@ static int riscv_clock_next_event(unsigned long delta,
 
 	csr_set(CSR_IE, IE_TIE);
 	if (static_branch_likely(&riscv_sstc_available)) {
-#if defined(CONFIG_32BIT)
+#if __riscv_xlen == 32
 		csr_write(CSR_STIMECMP, next_tval & 0xFFFFFFFF);
 		csr_write(CSR_STIMECMPH, next_tval >> 32);
 #else
-- 
2.36.1

