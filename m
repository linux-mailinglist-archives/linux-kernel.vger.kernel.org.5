Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489BD7DE38B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbjKAPFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbjKAPFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:05:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2885E12B;
        Wed,  1 Nov 2023 08:05:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8EEC433C7;
        Wed,  1 Nov 2023 15:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698851102;
        bh=J9TDTTp5Th8l4Sk4Cvv9hQrUXmMuJKZ9hBfQCH+y39o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mForM/ElSg9nfUfHoSsS9u0waPf4ExfykoG7pn8Q3XaEFgsuytu/ouZBmYcqQY8rw
         mBCLgYXYsf/9nsFDRochpXiVbM1DwA2OtewmFI4or+JDh0c8/cnOXG1n9KvZPrO34R
         XR3XxeLrPAqnnn3W3aaXyYsWXUdRH2RsWT8+z5XWQAtZ2dFQdViSHXC//r9Aa7d9n/
         r/L053pdsVpMNa65QHfpWWceGMtD27/WRDnLzz9u1jsm+cnaMmvTfc9ENNegOoaUfY
         e2eSn8UCofIHVcgoEC8GrhEsPMr5SHW7ge7vA1krBOKkEgAaV+Xi+9vmk0tvA4Kv5C
         pHhg1GVhlpXWw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Greg Ungerer <gerg@kernel.org>,
        Jack Brennen <jbrennen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 6/7] modpost: add symsearch_find_with_name() helper function
Date:   Thu,  2 Nov 2023 00:04:03 +0900
Message-Id: <20231101150404.754108-7-masahiroy@kernel.org>
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

This helper function searches for a symbol with the provided name.
The symbol must be located in the specified section and within the
given distance from the target address.

In the expected use case, the min_distance is very small, so the
linear search will finish within a few iterations.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.h   |  3 +++
 scripts/mod/symsearch.c | 44 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 9834ac44846d..43148b1a762b 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -186,6 +186,9 @@ void symsearch_finish(struct elf_info *elf);
 Elf_Sym *symsearch_find_nearest(struct elf_info *elf, Elf_Addr addr,
 				unsigned int secndx, bool allow_negative,
 				Elf_Addr min_distance);
+Elf_Sym *symsearch_find_with_name(struct elf_info *elf, Elf_Addr addr,
+				  unsigned int secndx, bool allow_negative,
+				  Elf_Addr min_distance, const char *name);
 
 /* file2alias.c */
 void handle_moddevtable(struct module *mod, struct elf_info *info,
diff --git a/scripts/mod/symsearch.c b/scripts/mod/symsearch.c
index 13464e4f4d72..9101bb9584a4 100644
--- a/scripts/mod/symsearch.c
+++ b/scripts/mod/symsearch.c
@@ -240,3 +240,47 @@ Elf_Sym *symsearch_find_nearest(struct elf_info *elf, Elf_Addr addr,
 	return symsearch_find(elf, addr, secndx, allow_negative, min_distance,
 			      symsearch_nearest_filter, elf);
 }
+
+struct name_filter_data {
+	struct elf_info *elf;
+	const char *name;
+};
+
+static bool symsearch_name_filter(const Elf_Sym *sym1, const Elf_Sym *sym2,
+				  void *_data)
+{
+	struct name_filter_data *data = _data;
+	const char *name;
+
+	/* Check the symbol name. */
+	name = sym_name(data->elf, sym1);
+	if (strcmp(name, data->name))
+		return false;
+
+	/* If sym2 is NULL, this is the first occurrence, always take it. */
+	if (!sym2)
+		return true;
+
+	/* Prefer lower address. */
+	return sym1->st_value < sym2->st_value;
+}
+
+/*
+ * Find the symbol which is in secndx and has the given name, and is located
+ * close enough to the given address.
+ * allow_negative: allow returning a symbol whose address is > addr.
+ * min_distance: ignore symbols which are further away than this.
+ * name: the name of the symbol to search for.
+ *
+ * Returns a pointer into the symbol table for success.
+ * Returns NULL if no legal symbol is found within the requested range.
+ */
+Elf_Sym *symsearch_find_with_name(struct elf_info *elf, Elf_Addr addr,
+				  unsigned int secndx, bool allow_negative,
+				  Elf_Addr min_distance, const char *name)
+{
+	struct name_filter_data data = { .elf = elf, .name = name };
+
+	return symsearch_find(elf, addr, secndx, allow_negative, min_distance,
+			      symsearch_name_filter, &data);
+}
-- 
2.40.1

