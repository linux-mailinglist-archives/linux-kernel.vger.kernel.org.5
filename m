Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE347F0419
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 03:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjKSCde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 21:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKSCdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 21:33:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8603CD5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 18:33:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21CEC433C7;
        Sun, 19 Nov 2023 02:33:25 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Mark {dmw,tlb}_virt_to_page() exports as non-GPL
Date:   Sun, 19 Nov 2023 10:33:17 +0800
Message-Id: <20231119023317.3359647-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark {dmw,tlb}_virt_to_page() exports as non-GPL, in order to let
out-of-tree modules (e.g. OpenZFS) be built without errors. Otherwise
we get:

ERROR: modpost: GPL-incompatible module zfs.ko uses GPL-only symbol 'dmw_virt_to_page'
ERROR: modpost: GPL-incompatible module zfs.ko uses GPL-only symbol 'tlb_virt_to_page'

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/mm/pgtable.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/mm/pgtable.c b/arch/loongarch/mm/pgtable.c
index 71d0539e2d0b..2aae72e63871 100644
--- a/arch/loongarch/mm/pgtable.c
+++ b/arch/loongarch/mm/pgtable.c
@@ -13,13 +13,13 @@ struct page *dmw_virt_to_page(unsigned long kaddr)
 {
 	return pfn_to_page(virt_to_pfn(kaddr));
 }
-EXPORT_SYMBOL_GPL(dmw_virt_to_page);
+EXPORT_SYMBOL(dmw_virt_to_page);
 
 struct page *tlb_virt_to_page(unsigned long kaddr)
 {
 	return pfn_to_page(pte_pfn(*virt_to_kpte(kaddr)));
 }
-EXPORT_SYMBOL_GPL(tlb_virt_to_page);
+EXPORT_SYMBOL(tlb_virt_to_page);
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-- 
2.39.3

