Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FC17DB118
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjJ2X3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjJ2X23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:28:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499673277;
        Sun, 29 Oct 2023 15:56:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D1AC04E60;
        Sun, 29 Oct 2023 22:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620195;
        bh=ns2PKopBoIS79sjmwtSqYl5R1c41T9jtDzXaqxR3lyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cQ+VMYnpf1Rll9/4gOgHEKxo0EVKpfPr65QxTcKO8/XcAwALQiW99phziSWZP8Ylg
         P4tPyKroSBbhTqSkPxoLSfLoMFi2Kbq/k1eIMP3cyxtIWIo48Kn5fou2fsyGw1pfmL
         7xoNo2UMuiKiWY95F1C73eQoKwGSd9qUMkVQ3d58JPSGsOqQ0ShQ7Ph9S9Hhr3G2KW
         YfuSSdJDETN/XdLVKJLUhHhfuypP2wSRzHP1Kia7h9c4IJ29q2Neuz8HjD2TW/r1Z9
         Kzpq+MqRN0pjym0SbKUPR3tgRHI6ntzrfA9UHZRNA/Uhc2y1ovhKydkikCYz65eJgP
         o/rUhZzA0gT4A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tianrui Zhao <zhaotianrui@loongson.cn>,
        Sasha Levin <sashal@kernel.org>, chenhuacai@kernel.org,
        maobibo@loongson.cn, akpm@linux-foundation.org,
        chenfeiyang@loongson.cn, arnd@arndb.de, loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.5 41/52] LoongArch: Export symbol invalid_pud_table for modules building
Date:   Sun, 29 Oct 2023 18:53:28 -0400
Message-ID: <20231029225441.789781-41-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225441.789781-1-sashal@kernel.org>
References: <20231029225441.789781-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.9
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit 449c2756c2323c9e32b2a2fa9c8b59ce91b5819d ]

Export symbol invalid_pud_table for modules building (such as the KVM
module) if 4-level page tables enabled. Otherwise we get:

ERROR: modpost: "invalid_pud_table" [arch/loongarch/kvm/kvm.ko] undefined!

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/mm/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index 3b7d8129570b8..51c9a6c90a169 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -267,6 +267,7 @@ pgd_t swapper_pg_dir[_PTRS_PER_PGD] __section(".bss..swapper_pg_dir");
 pgd_t invalid_pg_dir[_PTRS_PER_PGD] __page_aligned_bss;
 #ifndef __PAGETABLE_PUD_FOLDED
 pud_t invalid_pud_table[PTRS_PER_PUD] __page_aligned_bss;
+EXPORT_SYMBOL(invalid_pud_table);
 #endif
 #ifndef __PAGETABLE_PMD_FOLDED
 pmd_t invalid_pmd_table[PTRS_PER_PMD] __page_aligned_bss;
-- 
2.42.0

