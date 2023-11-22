Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64047F4B66
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344692AbjKVPq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344797AbjKVPpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:45:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFC6468F;
        Wed, 22 Nov 2023 07:36:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12678C433B8;
        Wed, 22 Nov 2023 15:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700667410;
        bh=6ZoHN0iibOyM751thDgV3ean1uRWh6q1kOki5dHPK+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=olzeNtQrwXyleycJgF+vCUvbF6roaKKSiIuZqPWzFDUld5UFywKAjJb7IDOQws1jL
         jXK7OC58kdgUR6Lq7kgVnidhbWmsKk1JPiCvHvlLhsWx6M56TRZFFVeXdfVSdY7wHv
         QDglklE6tAIa7pOnfIoVmaRHkRszbxtuTyDL9+xy0qXthQ08ZvLPNQEw4lTdjLPSyy
         Vde5l2x4VbRRYMY5Zvu3xGZilQkzR+7o28S/9XZb0n+CrgHgI/Z3Z14X5t80JE86KN
         nIYzjgW5eQp4IPvS0pyNNle2ZMCcNo/AvCQcm33cISmcCccWceyrKcIe7HAhd0sOY0
         V+zhjWZAG+YRw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 5/6] kconfig: fix memory leak from range properties
Date:   Wed, 22 Nov 2023 10:36:29 -0500
Message-ID: <20231122153635.853495-5-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122153635.853495-1-sashal@kernel.org>
References: <20231122153635.853495-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.299
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 703b9b899ee9c..5adb60b7e12f3 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -119,9 +119,9 @@ static long long sym_get_range_val(struct symbol *sym, int base)
 static void sym_validate_range(struct symbol *sym)
 {
 	struct property *prop;
+	struct symbol *range_sym;
 	int base;
 	long long val, val2;
-	char str[64];
 
 	switch (sym->type) {
 	case S_INT:
@@ -137,17 +137,15 @@ static void sym_validate_range(struct symbol *sym)
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

