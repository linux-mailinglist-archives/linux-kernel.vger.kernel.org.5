Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1852A7DE3CC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjKAPFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbjKAPFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:05:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE3010C;
        Wed,  1 Nov 2023 08:04:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0BCC43215;
        Wed,  1 Nov 2023 15:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698851099;
        bh=JtLodipaGPF999feXSGnDvTxAtoqNAWxEAUjQUNvakM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kHNj6pS4OyGwkRF8mHZhF+YVeLtrDGwcNAKX1Zwq7SVqBaUinKfojmeq61mmW93ue
         aVZXMQkUH5pLMuQ5Kaelo4ooNejJ4jksN2d+Eg+0ZScv15cLJtcyrPWqxeTVetNlMF
         8UEea089U8sUyU2HgFFoW0N2fkE8oPSB/2a39oBZB+PAJbkaKQ/zAfsGkMOCWaGnBQ
         qAtFnwgPLInYKcwp/41z8I3GoQIioOh9eMbz337H/zRIWgMInDlVQ94hyP+irQNR3c
         L69698PAr+M/CkRp15c3q7x50/j2wAwzNnrWPFXHqiqFu1ZymFoUrrj/IQJwbeBQCn
         zId1tz02kA3sw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Greg Ungerer <gerg@kernel.org>,
        Jack Brennen <jbrennen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 4/7] modpost: introduce a filtering feature to symsearch
Date:   Thu,  2 Nov 2023 00:04:01 +0900
Message-Id: <20231101150404.754108-5-masahiroy@kernel.org>
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

If adjacent table entries have the same section index and address,
symsearch_fixup() modifies the entries so the symbol lookup returns
the first symbol entry in the original .symtab section, but it may
not be the optimal result.

Add the filter() callback for more flexible symbol selection.

After the binary search is finished, a linear search begins to determine
the best symbol. Typically, the one found in the first iteration is the
closest, but the linear search continues as long as it sees another
symbol on the same distance. In each iteration, filter() is called to
determine if the current symbol should be taken.

Here are some useful scenarios:

 - When multiple entries share the same section index and address,
   filter() can be used to break a tie.

 - When there is an unwanted symbol depending on the search context,
   filter() can return false to skip it.

Currently, there is one hard-coded policy: if the target address falls
perfectly in the middle of the two neighbors, the lower address is
preferred. Let's move this preference to the filter function because it
is not directly related to the binary search algorithm.

This commit does not introduce any functional change, but more useful
filtering policies will be added in subsequent commits.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/symsearch.c | 102 ++++++++++++++++++++++++++++++----------
 1 file changed, 77 insertions(+), 25 deletions(-)

diff --git a/scripts/mod/symsearch.c b/scripts/mod/symsearch.c
index 97566aee0979..4549c5b0bb81 100644
--- a/scripts/mod/symsearch.c
+++ b/scripts/mod/symsearch.c
@@ -5,6 +5,8 @@
  * to a given address.
  */
 
+#include <stdbool.h>
+
 #include "modpost.h"
 
 struct syminfo {
@@ -142,17 +144,11 @@ void symsearch_finish(struct elf_info *elf)
 	elf->symsearch = NULL;
 }
 
-/*
- * Find the syminfo which is in secndx and "nearest" to addr.
- * allow_negative: allow returning a symbol whose address is > addr.
- * min_distance: ignore symbols which are further away than this.
- *
- * Returns a pointer into the symbol table for success.
- * Returns NULL if no legal symbol is found within the requested range.
- */
-Elf_Sym *symsearch_find_nearest(struct elf_info *elf, Elf_Addr addr,
-				unsigned int secndx, bool allow_negative,
-				Elf_Addr min_distance)
+static Elf_Sym *symsearch_find(struct elf_info *elf, Elf_Addr addr,
+			       unsigned int secndx, bool allow_negative,
+			       Elf_Addr min_distance,
+			       bool (*filter)(const Elf_Sym *, const Elf_Sym *, void *),
+			       void *filter_data)
 {
 	const struct syminfo *table = elf->symsearch->table;
 	unsigned int table_size = elf->symsearch->table_size;
@@ -178,22 +174,78 @@ Elf_Sym *symsearch_find_nearest(struct elf_info *elf, Elf_Addr addr,
 	 * entry in the array which comes before target, including the
 	 * case where it perfectly matches the section and the address.
 	 *
-	 * Note -- if the address we're looking up falls perfectly
-	 * in the middle of two symbols, this is written to always
-	 * prefer the symbol with the lower address.
+	 * If there are multiple candidates, the filter() callback can be used
+	 * to break a tie. filter() is provided with the current symbol and the
+	 * best one so far. If it returns true, the current one is selected.
+	 * Only a few iterations are expected, hence the linear search is fine.
 	 */
-	Elf_Sym *result = NULL;
+	Elf_Addr distance;
+	Elf_Sym *best = NULL;
+	Elf_Sym *sym;
+	int i;
 
-	if (allow_negative && hi < table_size &&
-	    table[hi].section_index == secndx &&
-	    table[hi].addr - addr <= min_distance) {
-		min_distance = table[hi].addr - addr;
-		result = &elf->symtab_start[table[hi].symbol_index];
+	/* Search to the left. */
+	for (i = hi - 1; i >= 0; i--) {
+		if (table[i].section_index != secndx)
+			break;
+
+		distance = addr - table[i].addr;
+		if (distance > min_distance)
+			break;
+
+		sym = &elf->symtab_start[table[i].symbol_index];
+		if (filter(sym, best, filter_data)) {
+			min_distance = distance;
+			best = sym;
+		}
 	}
-	if (hi > 0 &&
-	    table[hi - 1].section_index == secndx &&
-	    addr - table[hi - 1].addr <= min_distance) {
-		result = &elf->symtab_start[table[hi - 1].symbol_index];
+
+	if (!allow_negative)
+		return best;
+
+	/* Search to the right if allow_negative is true. */
+	for (i = hi; i < table_size; i++) {
+		if (table[i].section_index != secndx)
+			break;
+
+		distance = table[i].addr - addr;
+		if (distance > min_distance)
+			break;
+
+		sym = &elf->symtab_start[table[i].symbol_index];
+		if (filter(sym, best, filter_data)) {
+			min_distance = distance;
+			best = sym;
+		}
 	}
-	return result;
+
+	return best;
+}
+
+/* Return true if sym1 is preferred over sym2. */
+static bool symsearch_nearest_filter(const Elf_Sym *sym1, const Elf_Sym *sym2,
+				     void *data)
+{
+	/* If sym2 is NULL, this is the first occurrence, always take it. */
+	if (sym2 == NULL)
+		return true;
+
+	/* Prefer lower address. */
+	return sym1->st_value < sym2->st_value;
+}
+
+/*
+ * Find the syminfo which is in secndx and "nearest" to addr.
+ * allow_negative: allow returning a symbol whose address is > addr.
+ * min_distance: ignore symbols which are further away than this.
+ *
+ * Returns a pointer into the symbol table for success.
+ * Returns NULL if no legal symbol is found within the requested range.
+ */
+Elf_Sym *symsearch_find_nearest(struct elf_info *elf, Elf_Addr addr,
+				unsigned int secndx, bool allow_negative,
+				Elf_Addr min_distance)
+{
+	return symsearch_find(elf, addr, secndx, allow_negative, min_distance,
+			      symsearch_nearest_filter, NULL);
 }
-- 
2.40.1

