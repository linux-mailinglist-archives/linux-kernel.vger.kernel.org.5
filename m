Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C467FC89B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346645AbjK1VIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346689AbjK1VHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:07:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4B326B3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:07:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97921C433B9;
        Tue, 28 Nov 2023 21:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205628;
        bh=wcm4H3Bz9opg/df7UWnvcNaQFQL0hlCtn1KKyt0l1aA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=okOGT+3RhOu6ThU8ctgn56/UGhfi4vMIQICZNn8SIiEv6HFJZ/8NAMaxsmrfIjbAW
         C3lOVdjxxh4CZ2JD3yXzHboL4X5S5WSloA/dEyJKDkLNIKxLBjKOnl6GMh2iL2JFAB
         I8JHbQI3/hS53rQ656daroHxhNl92jWT85qgTBJhBZsS9z74ghoHm6rq89r1r5Q8sf
         /hw3Pc+40niGF9AgvgY2nuQ0sWX5PAbNzWkkydThwdi5iBewhkhj5j57h/sgEwQkBj
         nYdx009++PLLM4iucfAVpVLRrXO4R9nFNCoOB3fTVnStThtrBFV2C/8i7wRGwBylw9
         Z1Z5k8GM/+tAA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Haowu Ge <gehaowu@bitmoe.com>, Sasha Levin <sashal@kernel.org>,
        chenhuacai@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
        lienze@kylinos.cn, philmd@linaro.org, vishal.moola@gmail.com,
        willy@infradead.org, chenfeiyang@loongson.cn,
        loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 21/40] LoongArch: Mark {dmw,tlb}_virt_to_page() exports as non-GPL
Date:   Tue, 28 Nov 2023 16:05:27 -0500
Message-ID: <20231128210615.875085-21-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
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

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit 19d86a496233731882aea7ec24505ce6641b1c0c ]

Mark {dmw,tlb}_virt_to_page() exports as non-GPL, in order to let
out-of-tree modules (e.g. OpenZFS) be built without errors. Otherwise
we get:

ERROR: modpost: GPL-incompatible module zfs.ko uses GPL-only symbol 'dmw_virt_to_page'
ERROR: modpost: GPL-incompatible module zfs.ko uses GPL-only symbol 'tlb_virt_to_page'

Reported-by: Haowu Ge <gehaowu@bitmoe.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/mm/pgtable.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/mm/pgtable.c b/arch/loongarch/mm/pgtable.c
index 71d0539e2d0b0..2aae72e638713 100644
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
2.42.0

