Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530117EBC93
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 05:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbjKOERE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 23:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjKOERC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 23:17:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26CBD1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 20:16:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4118C433C8;
        Wed, 15 Nov 2023 04:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700021818;
        bh=/1FcBLs1hLiytG5R0uRZWQsitdWl5MH3/p3/R0vq29g=;
        h=From:To:Cc:Subject:Date:From;
        b=Nr6jwsb6G9+rldWECfXMHUK76RjLPUC1wK/zZdp2adxov0rRXmAjrnoflDPIO1fGu
         ilpD+61LWG/V3CARg07E2tTe9oqSdpPNgzE6rn3Z/WVlkEsJKKQMmY/XYaIRZCTzRf
         tGYCqNzDfHmBJhPtE4h/8sp+3B3QxqifzNV8fP72LPhu3Xl6Dpl5LFX2Qy/Ox1nSye
         cTbdkCAwS/TMS3TY7hZxaLVrgaWBjTLlY8gQX4W+3e64HLiMVEfzYKV4RoHu/nc6CY
         jbrRxCEgNb1lgbYI6d86amo3o8KRiYhPC8fbza8LOKzPJKKlRo8FoErKUSip2C8tEl
         /kgsGXDtjR23w==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] kconfig: fix memory leak from range properties
Date:   Wed, 15 Nov 2023 13:16:53 +0900
Message-Id: <20231115041653.810045-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
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
---

 scripts/kconfig/symbol.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 0572330bf8a7..a76925b46ce6 100644
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
2.40.1

