Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC86A7F4B1E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344669AbjKVPiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344667AbjKVPia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:38:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E29E1BD0;
        Wed, 22 Nov 2023 07:35:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DFBC433BA;
        Wed, 22 Nov 2023 15:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700667330;
        bh=dVqBzGcCjDV2Q/et/moBqR85/eGP57EpdKJAS9tf8pk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h+/H//P9t+2/Yhzt68cMRHXKciQYYVYO7FGtprHM4SFbnaGY97CVJ7/nU0D/5oHmB
         MWqBZ+nUIrdos23eQOMTF31KkOQKBtXAj+g+J9JnRxYY0tea3L5adHjPmMvNfMoJH6
         LzW3f7+wF0M+c4ZVIXZuihl80DPDaviizj//bA5pcBDpQiCR27MdxXyOnMeMO+csMF
         ps1biCgCsmBEosP4jYe7Yp4F+xTOgwvAMJAQUQyhKw6EeMj+QrLvduMi36R4jtj4gf
         LATnR53iUd056sOZXw4G/mRgwsyPPB/iumb38RZQpvxAe5lT5f3L6HygwGRIBCb8li
         VeNwHmT1UhbBg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 6/7] kconfig: fix memory leak from range properties
Date:   Wed, 22 Nov 2023 10:35:06 -0500
Message-ID: <20231122153512.853015-6-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122153512.853015-1-sashal@kernel.org>
References: <20231122153512.853015-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.139
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit ae1eff0349f2e908fc083630e8441ea6dc434dc0 ]

Currently, sym_validate_range() duplicates the range string using
xstrdup(), which is overwritten by a subsequent sym_calc_value() call.
It results in a memory leak.

Instead, only the pointer should be copied.

Below is a test case, with a summary from Valgrind.

[Test Kconfig]

  config FOO
          int "foo"
          range 10 20

[Test .config]

  CONFIG_FOO=0

[Before]

  LEAK SUMMARY:
     definitely lost: 3 bytes in 1 blocks
     indirectly lost: 0 bytes in 0 blocks
       possibly lost: 0 bytes in 0 blocks
     still reachable: 17,465 bytes in 21 blocks
          suppressed: 0 bytes in 0 blocks

[After]

  LEAK SUMMARY:
     definitely lost: 0 bytes in 0 blocks
     indirectly lost: 0 bytes in 0 blocks
       possibly lost: 0 bytes in 0 blocks
     still reachable: 17,462 bytes in 20 blocks
          suppressed: 0 bytes in 0 blocks

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/kconfig/symbol.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 5844d636d38f4..7f8013dcef002 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -122,9 +122,9 @@ static long long sym_get_range_val(struct symbol *sym, int base)
 static void sym_validate_range(struct symbol *sym)
 {
 	struct property *prop;
+	struct symbol *range_sym;
 	int base;
 	long long val, val2;
-	char str[64];
 
 	switch (sym->type) {
 	case S_INT:
@@ -140,17 +140,15 @@ static void sym_validate_range(struct symbol *sym)
 	if (!prop)
 		return;
 	val = strtoll(sym->curr.val, NULL, base);
-	val2 = sym_get_range_val(prop->expr->left.sym, base);
+	range_sym = prop->expr->left.sym;
+	val2 = sym_get_range_val(range_sym, base);
 	if (val >= val2) {
-		val2 = sym_get_range_val(prop->expr->right.sym, base);
+		range_sym = prop->expr->right.sym;
+		val2 = sym_get_range_val(range_sym, base);
 		if (val <= val2)
 			return;
 	}
-	if (sym->type == S_INT)
-		sprintf(str, "%lld", val2);
-	else
-		sprintf(str, "0x%llx", val2);
-	sym->curr.val = xstrdup(str);
+	sym->curr.val = range_sym->curr.val;
 }
 
 static void sym_set_changed(struct symbol *sym)
-- 
2.42.0

