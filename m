Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736597DE373
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjKAPFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbjKAPFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:05:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B5F11A;
        Wed,  1 Nov 2023 08:05:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929FFC43395;
        Wed,  1 Nov 2023 15:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698851101;
        bh=u2/0EZmNkhteR9yqHKg+ZM6He3MW48mMvU+dc7j/N/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ugFZRDltk5Ji75WF2kM1nw4DV4QMsmp3Ew6NnanEH/76zirT1kWCLAImIsZSrtore
         mDrjURw25SZK383ubVdsB10y+bUZR+MXkcgX9qBz/q8cIv6Ow0EsBqzkyy6KwRVteZ
         521C7+4u2SAkkyK7YTNheuZDDAKHrQx1cC+knHjGuYOjv7GcACDkQzhNVWZ2ehJvN6
         pOm9jSMdPPPd9KnTGQT9ZhBrj/D59Rn/yxR/mMz3zr7W3oNHCcoobf/Shm5dSUVPU+
         Ub1zn+MRgY7RKWYi/08hUxahwdkcaIVwwSdDXjYOiM1AwgQgoimtnBP4tHOhUAZKbv
         t844YUt4cyqWQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Greg Ungerer <gerg@kernel.org>,
        Jack Brennen <jbrennen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 5/7] modpost: prefer global symbols in symsearch_find_nearest()
Date:   Thu,  2 Nov 2023 00:04:02 +0900
Message-Id: <20231101150404.754108-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231101150404.754108-1-masahiroy@kernel.org>
References: <20231101150404.754108-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there are multiple symbols that share the same section index and
address, symsearch_find_nearest() returns the first occurrence in the
original .symtab section. We can add more rules to break a tie based
on symbol attributes.

Kallsyms does this; compare_symbols() in scripts/kallsyms.c first sorts
symbols by address, then by weakness and by underscore-prefixing in
order to provide users with the most desirable symbol.

This commit gives the following preference, in this order:

  1. lower address
  2. global symbol
  3. no underscore prefix

If two symbols still tie, the first one encounterd in the linear search
is selected. This does not match the order in the original .symtab
section, but it is not a significant issue.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/symsearch.c | 57 +++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 33 deletions(-)

diff --git a/scripts/mod/symsearch.c b/scripts/mod/symsearch.c
index 4549c5b0bb81..13464e4f4d72 100644
--- a/scripts/mod/symsearch.c
+++ b/scripts/mod/symsearch.c
@@ -20,9 +20,7 @@ struct syminfo {
  * Entries in table are ascending, sorted first by section_index,
  * then by addr, and last by symbol_index.  The sorting by
  * symbol_index is used to ensure predictable behavior when
- * multiple symbols are present with the same address; all
- * symbols past the first are effectively ignored, by eliding
- * them in symsearch_fixup().
+ * multiple symbols are present with the same address.
  */
 struct symsearch {
 	unsigned int table_size;
@@ -97,32 +95,6 @@ static void symsearch_populate(struct elf_info *elf,
 		fatal("%s: size mismatch\n", __func__);
 }
 
-/*
- * Do any fixups on the table after sorting.
- * For now, this just finds adjacent entries which have
- * the same section_index and addr, and it propagates
- * the first symbol_index over the subsequent entries,
- * so that only one symbol_index is seen for any given
- * section_index and addr.  This ensures that whether
- * we're looking at an address from "above" or "below"
- * that we see the same symbol_index.
- * This does leave some duplicate entries in the table;
- * in practice, these are a small fraction of the
- * total number of entries, and they are harmless to
- * the binary search algorithm other than a few occasional
- * unnecessary comparisons.
- */
-static void symsearch_fixup(struct syminfo *table, unsigned int table_size)
-{
-	/* Don't look at index 0, it will never change. */
-	for (unsigned int i = 1; i < table_size; i++) {
-		if (table[i].addr == table[i - 1].addr &&
-		    table[i].section_index == table[i - 1].section_index) {
-			table[i].symbol_index = table[i - 1].symbol_index;
-		}
-	}
-}
-
 void symsearch_init(struct elf_info *elf)
 {
 	unsigned int table_size = symbol_count(elf);
@@ -134,8 +106,6 @@ void symsearch_init(struct elf_info *elf)
 	symsearch_populate(elf, elf->symsearch->table, table_size);
 	qsort(elf->symsearch->table, table_size,
 	      sizeof(struct syminfo), syminfo_compare);
-
-	symsearch_fixup(elf->symsearch->table, table_size);
 }
 
 void symsearch_finish(struct elf_info *elf)
@@ -226,12 +196,33 @@ static Elf_Sym *symsearch_find(struct elf_info *elf, Elf_Addr addr,
 static bool symsearch_nearest_filter(const Elf_Sym *sym1, const Elf_Sym *sym2,
 				     void *data)
 {
+	struct elf_info *elf = data;
+	unsigned int bind1, bind2, unscores1, unscores2;
+
 	/* If sym2 is NULL, this is the first occurrence, always take it. */
 	if (sym2 == NULL)
 		return true;
 
 	/* Prefer lower address. */
-	return sym1->st_value < sym2->st_value;
+	if (sym1->st_value < sym2->st_value)
+		return true;
+	if (sym1->st_value > sym2->st_value)
+		return false;
+
+	bind1 = ELF_ST_BIND(sym1->st_info);
+	bind2 = ELF_ST_BIND(sym2->st_info);
+
+	/* Prefer global symbol. */
+	if (bind1 == STB_GLOBAL && bind2 != STB_GLOBAL)
+		return true;
+	if (bind1 != STB_GLOBAL && bind2 == STB_GLOBAL)
+		return false;
+
+	/* Prefer less underscores. */
+	unscores1 = strspn(sym_name(elf, sym1), "_");
+	unscores2 = strspn(sym_name(elf, sym2), "_");
+
+	return unscores1 < unscores2;
 }
 
 /*
@@ -247,5 +238,5 @@ Elf_Sym *symsearch_find_nearest(struct elf_info *elf, Elf_Addr addr,
 				Elf_Addr min_distance)
 {
 	return symsearch_find(elf, addr, secndx, allow_negative, min_distance,
-			      symsearch_nearest_filter, NULL);
+			      symsearch_nearest_filter, elf);
 }
-- 
2.40.1

