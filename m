Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493E480227F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 11:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbjLCKZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 05:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjLCKZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 05:25:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E08FD
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 02:25:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3ADEC433D9;
        Sun,  3 Dec 2023 10:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701599136;
        bh=xr4qK+/McATkt6q41PjvXqtg2z7HnzV21XZ0nlNgetk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IKMP5z88fzjGpGdCnlKyWmfF+b6BNwd1jdWHy3CARQgDPGEfpSPxyUnfveZzZ5VwM
         UdNtQweYYnU6E3R/t065Yy5ssR4Tq0SxW6QpO2BrYfCw5wLLESe+zeFWdchcUeuamd
         B2OL01AOAjKwc0YuwrDp6JoyzwM+V/CxQaWHd/GWLsNILwoWY0B9LWe7Z2GS3DR88V
         /zg7o0LV9bRcP7TGcbx1Nlgk4jHttWPlPbenCYOgQvxPCvz9/orfaZUdrkfK6jsGjH
         mgNJolZleOnXZv+ScCdbIdkw5UTpq3eN/ZZ/dgZu7mZXRVYew2EtZ3PjIOvNQhrzFC
         y81wxIlKhNtsg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] kconfig: squash menu_has_help() and menu_get_help()
Date:   Sun,  3 Dec 2023 19:25:25 +0900
Message-Id: <20231203102528.1913822-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203102528.1913822-1-masahiroy@kernel.org>
References: <20231203102528.1913822-1-masahiroy@kernel.org>
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

menu_has_help() and menu_get_help() functions are only used within
menu_get_ext_help().

Squash them into menu_get_ext_help(). It revealed the if-conditional
in menu_get_help() was unneeded, as menu_has_help() has already checked
that menu->help is not NULL.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/lkc.h  |  2 --
 scripts/kconfig/menu.c | 17 ++---------------
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index 3908741edf8f..8ca5bbc74df1 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -98,8 +98,6 @@ bool menu_is_visible(struct menu *menu);
 bool menu_has_prompt(struct menu *menu);
 const char *menu_get_prompt(struct menu *menu);
 struct menu *menu_get_parent_menu(struct menu *menu);
-bool menu_has_help(struct menu *menu);
-const char *menu_get_help(struct menu *menu);
 int get_jump_key_char(void);
 struct gstr get_relations_str(struct symbol **sym_arr, struct list_head *head);
 void menu_get_ext_help(struct menu *menu, struct gstr *help);
diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index f07c0d8691af..dc60a9ddc5dd 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -673,19 +673,6 @@ struct menu *menu_get_parent_menu(struct menu *menu)
 	return menu;
 }
 
-bool menu_has_help(struct menu *menu)
-{
-	return menu->help != NULL;
-}
-
-const char *menu_get_help(struct menu *menu)
-{
-	if (menu->help)
-		return menu->help;
-	else
-		return "";
-}
-
 static void get_def_str(struct gstr *r, struct menu *menu)
 {
 	str_printf(r, "Defined at %s:%d\n",
@@ -856,10 +843,10 @@ void menu_get_ext_help(struct menu *menu, struct gstr *help)
 	struct symbol *sym = menu->sym;
 	const char *help_text = nohelp_text;
 
-	if (menu_has_help(menu)) {
+	if (menu->help) {
 		if (sym->name)
 			str_printf(help, "%s%s:\n\n", CONFIG_, sym->name);
-		help_text = menu_get_help(menu);
+		help_text = menu->help;
 	}
 	str_printf(help, "%s\n", help_text);
 	if (sym)
-- 
2.40.1

