Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD4380227E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 11:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjLCKZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 05:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCKZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 05:25:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69475D5F
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 02:25:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2763C433C8;
        Sun,  3 Dec 2023 10:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701599134;
        bh=Oxu1+DS1jbu9WvPR52tw/o+GCX/xwK7ZLpJvE+EAR00=;
        h=From:To:Cc:Subject:Date:From;
        b=JDdpwq8WWdLnxwYRpZ9zuiYmg7je1V5eX0RzpdTO8N9MS94+aPjZl6kTXipw/ajTu
         7hCG7YIl0KC54zLsWqFKb4Inu/Rc5yXLvNlaffKW/XOT3v3NwNvd5Znz8wcTF6klIY
         Ra8oxlSP02YlGDXRWxIk04+YC9mP6zYbNNdQogqINcMRf1ZoHWVC+BgQ5w3dILLAzv
         u8kgvR89ZNQuH7vPosKXWRD9/FL9yNYzeVikUZVRI21VhdlhLizwMcx1jkT0YU9iVg
         5roj9FK3BZeWDqewZ/+6zHV4urJLlmlXiGzjXumU6ES6KIfbEeN2fheXTR5Fks71UF
         +QCtjziFXLrkQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] kconfig: factor out common code shared by mconf and nconf
Date:   Sun,  3 Dec 2023 19:25:23 +0900
Message-Id: <20231203102528.1913822-1-masahiroy@kernel.org>
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

Separate out the duplicated code to mnconf-common.c.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/Makefile        |  4 +--
 scripts/kconfig/mconf.c         | 54 +--------------------------------
 scripts/kconfig/mnconf-common.c | 53 ++++++++++++++++++++++++++++++++
 scripts/kconfig/mnconf-common.h | 18 +++++++++++
 scripts/kconfig/nconf.c         | 53 +-------------------------------
 5 files changed, 75 insertions(+), 107 deletions(-)
 create mode 100644 scripts/kconfig/mnconf-common.c
 create mode 100644 scripts/kconfig/mnconf-common.h

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 322c061b464d..7c025f82718e 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -174,7 +174,7 @@ conf-objs	:= conf.o $(common-objs)
 
 # nconf: Used for the nconfig target based on ncurses
 hostprogs	+= nconf
-nconf-objs	:= nconf.o nconf.gui.o $(common-objs)
+nconf-objs	:= nconf.o nconf.gui.o mnconf-common.o $(common-objs)
 
 HOSTLDLIBS_nconf       = $(call read-file, $(obj)/nconf-libs)
 HOSTCFLAGS_nconf.o     = $(call read-file, $(obj)/nconf-cflags)
@@ -187,7 +187,7 @@ $(obj)/nconf.o $(obj)/nconf.gui.o: | $(obj)/nconf-cflags
 hostprogs	+= mconf
 lxdialog	:= $(addprefix lxdialog/, \
 		     checklist.o inputbox.o menubox.o textbox.o util.o yesno.o)
-mconf-objs	:= mconf.o $(lxdialog) $(common-objs)
+mconf-objs	:= mconf.o $(lxdialog) mnconf-common.o $(common-objs)
 
 HOSTLDLIBS_mconf = $(call read-file, $(obj)/mconf-libs)
 $(foreach f, mconf.o $(lxdialog), \
diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index 3795c36a9181..5df32148a869 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -21,6 +21,7 @@
 
 #include "lkc.h"
 #include "lxdialog/dialog.h"
+#include "mnconf-common.h"
 
 static const char mconf_readme[] =
 "Overview\n"
@@ -286,7 +287,6 @@ static int single_menu_mode;
 static int show_all_options;
 static int save_and_exit;
 static int silent;
-static int jump_key_char;
 
 static void conf(struct menu *menu, struct menu *active_menu);
 
@@ -378,58 +378,6 @@ static void show_help(struct menu *menu)
 	str_free(&help);
 }
 
-struct search_data {
-	struct list_head *head;
-	struct menu *target;
-};
-
-static int next_jump_key(int key)
-{
-	if (key < '1' || key > '9')
-		return '1';
-
-	key++;
-
-	if (key > '9')
-		key = '1';
-
-	return key;
-}
-
-static int handle_search_keys(int key, size_t start, size_t end, void *_data)
-{
-	struct search_data *data = _data;
-	struct jump_key *pos;
-	int index = 0;
-
-	if (key < '1' || key > '9')
-		return 0;
-
-	list_for_each_entry(pos, data->head, entries) {
-		index = next_jump_key(index);
-
-		if (pos->offset < start)
-			continue;
-
-		if (pos->offset >= end)
-			break;
-
-		if (key == index) {
-			data->target = pos->target;
-			return 1;
-		}
-	}
-
-	return 0;
-}
-
-int get_jump_key_char(void)
-{
-	jump_key_char = next_jump_key(jump_key_char);
-
-	return jump_key_char;
-}
-
 static void search_conf(void)
 {
 	struct symbol **sym_arr;
diff --git a/scripts/kconfig/mnconf-common.c b/scripts/kconfig/mnconf-common.c
new file mode 100644
index 000000000000..18cb9a6c5aaa
--- /dev/null
+++ b/scripts/kconfig/mnconf-common.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "expr.h"
+#include "list.h"
+#include "mnconf-common.h"
+
+int jump_key_char;
+
+int next_jump_key(int key)
+{
+	if (key < '1' || key > '9')
+		return '1';
+
+	key++;
+
+	if (key > '9')
+		key = '1';
+
+	return key;
+}
+
+int handle_search_keys(int key, size_t start, size_t end, void *_data)
+{
+	struct search_data *data = _data;
+	struct jump_key *pos;
+	int index = 0;
+
+	if (key < '1' || key > '9')
+		return 0;
+
+	list_for_each_entry(pos, data->head, entries) {
+		index = next_jump_key(index);
+
+		if (pos->offset < start)
+			continue;
+
+		if (pos->offset >= end)
+			break;
+
+		if (key == index) {
+			data->target = pos->target;
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+int get_jump_key_char(void)
+{
+	jump_key_char = next_jump_key(jump_key_char);
+
+	return jump_key_char;
+}
diff --git a/scripts/kconfig/mnconf-common.h b/scripts/kconfig/mnconf-common.h
new file mode 100644
index 000000000000..ab6292cc4bf2
--- /dev/null
+++ b/scripts/kconfig/mnconf-common.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef MNCONF_COMMON_H
+#define MNCONF_COMMON_H
+
+#include <stddef.h>
+
+struct search_data {
+	struct list_head *head;
+	struct menu *target;
+};
+
+extern int jump_key_char;
+
+int next_jump_key(int key);
+int handle_search_keys(int key, size_t start, size_t end, void *_data);
+int get_jump_key_char(void);
+
+#endif /* MNCONF_COMMON_H */
diff --git a/scripts/kconfig/nconf.c b/scripts/kconfig/nconf.c
index 8cd72fe25974..1148163cfa7e 100644
--- a/scripts/kconfig/nconf.c
+++ b/scripts/kconfig/nconf.c
@@ -12,6 +12,7 @@
 #include <stdlib.h>
 
 #include "lkc.h"
+#include "mnconf-common.h"
 #include "nconf.h"
 #include <ctype.h>
 
@@ -279,7 +280,6 @@ static const char *current_instructions = menu_instructions;
 
 static char *dialog_input_result;
 static int dialog_input_result_len;
-static int jump_key_char;
 
 static void selected_conf(struct menu *menu, struct menu *active_menu);
 static void conf(struct menu *menu);
@@ -691,57 +691,6 @@ static int do_exit(void)
 	return 0;
 }
 
-struct search_data {
-	struct list_head *head;
-	struct menu *target;
-};
-
-static int next_jump_key(int key)
-{
-	if (key < '1' || key > '9')
-		return '1';
-
-	key++;
-
-	if (key > '9')
-		key = '1';
-
-	return key;
-}
-
-static int handle_search_keys(int key, size_t start, size_t end, void *_data)
-{
-	struct search_data *data = _data;
-	struct jump_key *pos;
-	int index = 0;
-
-	if (key < '1' || key > '9')
-		return 0;
-
-	list_for_each_entry(pos, data->head, entries) {
-		index = next_jump_key(index);
-
-		if (pos->offset < start)
-			continue;
-
-		if (pos->offset >= end)
-			break;
-
-		if (key == index) {
-			data->target = pos->target;
-			return 1;
-		}
-	}
-
-	return 0;
-}
-
-int get_jump_key_char(void)
-{
-	jump_key_char = next_jump_key(jump_key_char);
-
-	return jump_key_char;
-}
 
 static void search_conf(void)
 {
-- 
2.40.1

