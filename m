Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5835B7F8949
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 09:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjKYIeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 03:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjKYIeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 03:34:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F2AE6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 00:34:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6381C433C7;
        Sat, 25 Nov 2023 08:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700901249;
        bh=sULvz/WSntLYIuz8arrxbKY+JbBMr2OcovMfkGjh65Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uHQ/QCsenj6f9OJf8bInnyQuHu8Hf0uFEnDtugC8O9iL8r0q4Brx28gsrovvT3FAs
         LhawTxe3j5d8scxzMzbQiGyJZfkVMXpK82I/5XqTPoZ6u3pTdxsvLqRvezbWhDAW2o
         LVd+SooqmlELp+W3QibQsEqlJfY86m5+zw9VlZNPYDsZ7csQTMorfHtMvpIS+Dq9pe
         M0dRry6v0rhKpgRVei8IUl7Pcs3dA36MV468JtfYNLs4CN6PPE5CqUCLhI5Hd3bIFv
         Fbys8DjygX7Hus6H+yoTHr45M9gj5Hyu00GZb7Ow0LkMXz3xwA/WIKfQI2CgQwPJWh
         TNym1R38OWYZQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] riscv: select ARCH_USE_CMPXCHG_LOCKREF
Date:   Sat, 25 Nov 2023 16:21:43 +0800
Message-Id: <20231125082144.311-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231125082144.311-1-jszhang@kernel.org>
References: <20231125082144.311-1-jszhang@kernel.org>
MIME-Version: 1.0
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

Select ARCH_USE_CMPXCHG_LOCKREF to enable the cmpxchg-based lockless lockref
implementation for riscv.

Using Linus' test case[1] on TH1520 platform, I see a 11.2% improvement.
On JH7110 platform, I see 12.0% improvement.

Link: http://marc.info/?l=linux-fsdevel&m=137782380714721&w=4 [1]
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 433ec617703e..7f8aa25457ba 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -51,6 +51,7 @@ config RISCV
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
 	select ARCH_SUPPORTS_PER_VMA_LOCK if MMU
 	select ARCH_SUPPORTS_SHADOW_CALL_STACK if HAVE_SHADOW_CALL_STACK
+	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USES_CFI_TRAPS if CFI_CLANG
-- 
2.42.0

