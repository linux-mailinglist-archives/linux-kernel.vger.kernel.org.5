Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F73A7F8C7A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 17:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjKYQgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 11:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjKYQgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 11:36:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595E018C
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 08:36:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1C3C433CA;
        Sat, 25 Nov 2023 16:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700930167;
        bh=snAd2gXiU18UJUY/4dnU7CGitVyQiD9gCk0F0qZU16g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JSTkkAP710e1BVX6uUzgeCcFCBX0PDgDkZy5hMyswz1EYBTjSm8mIj4yMRyQjdYwC
         3PMxs4Je5aZwyIR2DiAmDZ0X2gm5WRYXn3ZtqnQFc+/+0oQRcGLv0NTfPp8HCAxLph
         O3nwMVOoLHf5ZqxhFkrc0tltr8NQISsCsVVt53FvaJDqfA53EnRVbkv+GnEkl/3OLc
         oCiwJHiUiareSq9JXo+ij0YsvCCM4lLaJB7CElquhrDqkh0gPEdogxW+ASrb10SnG0
         meLeekLlh+kbPZcIl3q3kyZ6/7JUlNs5qzYlm91d8CJuSziUgdvtjr4Vo4V5rmfcta
         Tw87XNbUhaI1g==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kconfig: default to zero if int/hex symbol lacks default property
Date:   Sun, 26 Nov 2023 01:35:59 +0900
Message-Id: <20231125163559.824210-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231125163559.824210-1-masahiroy@kernel.org>
References: <20231125163559.824210-1-masahiroy@kernel.org>
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

When a default property is missing in an int or hex symbol, it defaults
to an empty string, which is not a valid symbol value.

It results in a incorrect .config, and can also lead to an infinite
loop in scripting.

Use "0" for int and "0x0" for hex as a default value.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/symbol.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index f7075d148ac7..a5a4f9153eb7 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -338,7 +338,11 @@ void sym_calc_value(struct symbol *sym)
 
 	switch (sym->type) {
 	case S_INT:
+		newval.val = "0";
+		break;
 	case S_HEX:
+		newval.val = "0x0";
+		break;
 	case S_STRING:
 		newval.val = "";
 		break;
@@ -746,14 +750,17 @@ const char *sym_get_string_default(struct symbol *sym)
 		case yes: return "y";
 		}
 	case S_INT:
+		if (!str[0])
+			str = "0";
+		break;
 	case S_HEX:
-		return str;
-	case S_STRING:
-		return str;
-	case S_UNKNOWN:
+		if (!str[0])
+			str = "0x0";
+		break;
+	default:
 		break;
 	}
-	return "";
+	return str;
 }
 
 const char *sym_get_string_value(struct symbol *sym)
-- 
2.40.1

