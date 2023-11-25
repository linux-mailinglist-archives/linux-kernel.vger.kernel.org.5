Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB727F8C79
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 17:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjKYQgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 11:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjKYQf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 11:35:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D937107
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 08:36:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F0EC433C7;
        Sat, 25 Nov 2023 16:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700930166;
        bh=fts8SLIgVhLqO6eGUFoOp3dpYL3AguZRASLqnEn6BEE=;
        h=From:To:Cc:Subject:Date:From;
        b=FEd9SbMWzCapCGVZ+4jpMWoK4eQS8yPkj94F713Q+hvBnfjHUNSl4aMHzyjFarDxC
         cbWR0A0f2qg2x+aJrjSHf9uucae4tP3rjxVX+CJibfWYlDppMoVUEQpooHGMjVzrD+
         hpOx+u77ESqDTALTXi+AiKX4bNXeOOJdmmVDyQpt0Q2RbqJZB83a3zcbNWr+DRd8UQ
         EOvfhRa97GdF71iW30ywiagQ0GVbRXjmsxilOf7IE/jz0SOPW2qFCH/xP7cUch1iP/
         JQ5cFbpL5norJUWwB7+PUnAuCgTEuQvmyT2a7QrfMkypcr/W3Bsea1mNkZ4gmPuSei
         HNafJf1OL3eSQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kconfig: remove unneeded symbol_empty variable
Date:   Sun, 26 Nov 2023 01:35:58 +0900
Message-Id: <20231125163559.824210-1-masahiroy@kernel.org>
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

This is used only for initializing other variables.

Use the empty string "".

Please note newval.tri is unused for S_INT/HEX/STRING.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/symbol.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index a76925b46ce6..f7075d148ac7 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -29,12 +29,6 @@ struct symbol symbol_no = {
 	.flags = SYMBOL_CONST|SYMBOL_VALID,
 };
 
-static struct symbol symbol_empty = {
-	.name = "",
-	.curr = { "", no },
-	.flags = SYMBOL_VALID,
-};
-
 struct symbol *modules_sym;
 static tristate modules_val;
 
@@ -346,7 +340,7 @@ void sym_calc_value(struct symbol *sym)
 	case S_INT:
 	case S_HEX:
 	case S_STRING:
-		newval = symbol_empty.curr;
+		newval.val = "";
 		break;
 	case S_BOOLEAN:
 	case S_TRISTATE:
@@ -697,13 +691,12 @@ const char *sym_get_string_default(struct symbol *sym)
 {
 	struct property *prop;
 	struct symbol *ds;
-	const char *str;
+	const char *str = "";
 	tristate val;
 
 	sym_calc_visibility(sym);
 	sym_calc_value(modules_sym);
 	val = symbol_no.curr.tri;
-	str = symbol_empty.curr.val;
 
 	/* If symbol has a default value look it up */
 	prop = sym_get_default_prop(sym);
-- 
2.40.1

