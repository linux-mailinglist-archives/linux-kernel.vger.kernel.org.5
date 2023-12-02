Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491EE801D38
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 15:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjLBOPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 09:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbjLBOPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 09:15:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8563A12E
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 06:15:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82F8C433C8;
        Sat,  2 Dec 2023 14:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701526551;
        bh=fwdhwt3eDeqZRwcBFACwkkWnjPtptuE2Wu5b5bty77c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQ72I/i6LN9WRbDkrkT9M9kOLmigG1FyWGGpxqvKDzK8Ed7mBok7Xna5Rno92B6gj
         /XX0nb16HB6UkRBDog/J/WWTPO/5HtSFde3mvKL+Yo4z4M7PJyanFKMRJ0ecX0vpwu
         kW0h6cCwkSUUIOzNSolHE+92AyLd7syaH+iL98NweXOkA4xA5WEnnmMAVNqHUvYlDN
         fYOdl/nIa/HYzblmbtfeba1gDN0VzQEY7gta52VNWuc+y4S4MLdaGLanZV9Ne5H8uM
         yxx/DRCMIs+4u1zB+ol2wV6E7lqNnlKjcWNXa+lYHWlMxDrNxj8nY5kExp7zxqauhT
         62de3GKfgbhDQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] riscv: select ARCH_USE_CMPXCHG_LOCKREF
Date:   Sat,  2 Dec 2023 22:03:22 +0800
Message-Id: <20231202140323.315-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231202140323.315-1-jszhang@kernel.org>
References: <20231202140323.315-1-jszhang@kernel.org>
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

Select ARCH_USE_CMPXCHG_LOCKREF to enable the cmpxchg-based lockless
lockref implementation for riscv.

Using Linus' test case[1] on TH1520 platform, I see a 11.2% improvement.
On JH7110 platform, I see 12.0% improvement.

Link: http://marc.info/?l=linux-fsdevel&m=137782380714721&w=4 [1]
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 433ec617703e..da4ae76a892c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -51,6 +51,7 @@ config RISCV
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
 	select ARCH_SUPPORTS_PER_VMA_LOCK if MMU
 	select ARCH_SUPPORTS_SHADOW_CALL_STACK if HAVE_SHADOW_CALL_STACK
+	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USES_CFI_TRAPS if CFI_CLANG
-- 
2.42.0

