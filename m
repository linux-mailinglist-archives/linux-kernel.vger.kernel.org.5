Return-Path: <linux-kernel+bounces-84548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE95086A828
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52CCCB22A20
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9DD219E1;
	Wed, 28 Feb 2024 06:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IYSZKBg/"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9CE22309
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 06:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709100015; cv=none; b=YJd9TNyBP1fILqfF6sbwKLX3G2bgZ9yGvQM23cLbxyUuZBcwFuIhDHqC2pmzI8Sblz9HAOtFyjyG52B94RUl/RVb9MJRyLSiuWX/JzzUUn/tbRqfjhs4nXJNqJmYs3skbPVghpnwpKuiP8dPVLpBrdL5dr0Z6eK9o0cTSZQ6Et4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709100015; c=relaxed/simple;
	bh=yUQIHYhnLFzKqi/GqgxNqYNZUiO5u5FqvuB4BoVLyHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=krlWhUArnPrFuBLiSRGU1Ma0u9IYHifkeH7sUgyyOFqRmacBxDSOo1yR1tbyFc3o+e/M54rIJ5QGb+oz0CnVy3YvmJrVzl7S8nAR0MY8HgNzqEoTw2wRAKLN1/1DmNKJcgeffcVYnPIAYGABfX3jKuBEGmdWSAOL9Erw4hd6E6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IYSZKBg/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc13fb0133so38227605ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709100013; x=1709704813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D7/P13A8mI2QI8qRNxxLcQxekbkRlI/G0HGgz7fxN30=;
        b=IYSZKBg/Sjlf80jOLmLz5GJ7sftXW8TKaeVlnSONxXeOCGbGYMT+7Osnb9hPUNtsnY
         s+aqq/VatuydoG7nxCnPPYJTrDat8hlWxEqTQCsY8yNrdnVi81KQXoHVQ6qZkXRYtObe
         1D2m24wtiVd02QBjh8G83ziRH0fcPqlwalxsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709100013; x=1709704813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D7/P13A8mI2QI8qRNxxLcQxekbkRlI/G0HGgz7fxN30=;
        b=AgzBiyPUXpONVKfPKBNwL+RXMDiLHigFT03/EOpR4HpT60GVC2LpDcIlcQ3KGzTVeo
         ts+/cnzXUevPTiH1+4ep4jJLHHWqMvAufrhazcQxydiyFRD1bvhdOxffK5pY6ly0oyNw
         HebnYY973wa3xF9W+w2iFt+jGk7oxlyxbodMQO9NkkDqPV+lZ+43E8xk/Qk/M4Mtrfrk
         51LsqUl74lIa+qmCqSuFfZUMFCWbM46KcG4ds7bSEYFP0UVD/7wa+8mZ9ldeZXAQ84HL
         84ZUkh1jsGOvMXEi3GXraL5+TyO7/+dRy5T5+ZGQGQhE4Nms3Nv1IcJyNbi28eZLbos8
         xtRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5ufQi1rwhfgcfqSQejH/zY4zLrFpDxIAbp0eV3iNzLuVARcTlH5c3wPhPBQj2UhvhF1rQjQjeZp4daVFxtfKWocJPW2dablOOx4U9
X-Gm-Message-State: AOJu0YxGADb5UORLaEsbq2Lzpsk6Np5H/0ut0TKrx54J2XHkD1I87bQ9
	in5aLff0xFG1yfOyyj/7VuWCGbjqfr1U9/SjXgXmUCXGvzZbPE9Q5lhWUNm9fw==
X-Google-Smtp-Source: AGHT+IG7qSrEYFdm9bCpnUTbeglKZeXfE41eNK9x8gQe5JngQEiOfkmgl7n1UgmOAheCZIPUEYd6MA==
X-Received: by 2002:a17:903:26c9:b0:1db:55cc:d226 with SMTP id jg9-20020a17090326c900b001db55ccd226mr9895206plb.66.1709100012707;
        Tue, 27 Feb 2024 22:00:12 -0800 (PST)
Received: from basement.c.googlers.com.com (237.198.80.34.bc.googleusercontent.com. [34.80.198.237])
        by smtp.gmail.com with ESMTPSA id y11-20020a170902d64b00b001db94bead0asm2476311plh.193.2024.02.27.22.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 22:00:12 -0800 (PST)
From: Tomasz Figa <tfiga@chromium.org>
To: linux-kbuild@vger.kernel.org
Cc: Nicolas Schier <n.schier@avm.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	Jesse Taube <Mr.Bossman075@gmail.com>,
	Tomasz Figa <tfiga@chromium.org>
Subject: [PATCH v2] kconfig: menuconfig: Make hidden options show with different color
Date: Wed, 28 Feb 2024 15:00:05 +0900
Message-ID: <20240228060006.13274-1-tfiga@chromium.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When hidden options are toggled on (using 'z'), the number of options
on the screen can be overwhelming and may make it hard to distinguish
between available and hidden ones. Make them easier to distinguish by
displaying the hidden one with a different color (COLOR_YELLOW for color
themes and A_DIM for mono).

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
---
 scripts/kconfig/lxdialog/dialog.h  |  5 +++++
 scripts/kconfig/lxdialog/menubox.c | 12 ++++++++----
 scripts/kconfig/lxdialog/util.c    | 19 +++++++++++++++++++
 scripts/kconfig/mconf.c            | 18 ++++++++++++++++++
 4 files changed, 50 insertions(+), 4 deletions(-)

Changes from v1:
(https://patchwork.kernel.org/project/linux-kbuild/patch/20231228054630.3595093-1-tfiga@chromium.org/)
 * Replaced A_DIM for color themes with COLOR_YELLOW, because the former
   has no effect to black text on some commonly used terminals, e.g.
   gnome-terminal, foot. Reported by Masahiro Yamada and Nicolas Schier.
   I ended up with COLOR_YELLOW, as it seems to look comparatively dim
   with mutliple light and dark color themes in Chromium hterm and
   gnome-terminal.

diff --git a/scripts/kconfig/lxdialog/dialog.h b/scripts/kconfig/lxdialog/dialog.h
index a501abf9fa31..2bba0c406038 100644
--- a/scripts/kconfig/lxdialog/dialog.h
+++ b/scripts/kconfig/lxdialog/dialog.h
@@ -100,6 +100,8 @@ struct dialog_info {
 	struct dialog_color menubox_border;
 	struct dialog_color item;
 	struct dialog_color item_selected;
+	struct dialog_color item_hidden;
+	struct dialog_color item_hidden_selected;
 	struct dialog_color tag;
 	struct dialog_color tag_selected;
 	struct dialog_color tag_key;
@@ -128,6 +130,7 @@ void item_add_str(const char *fmt, ...);
 void item_set_tag(char tag);
 void item_set_data(void *p);
 void item_set_selected(int val);
+void item_set_hidden(int val);
 int item_activate_selected(void);
 void *item_data(void);
 char item_tag(void);
@@ -139,6 +142,7 @@ struct dialog_item {
 	char tag;
 	void *data;	/* pointer to menu item - used by menubox+checklist */
 	int selected;	/* Set to 1 by dialog_*() function if selected. */
+	int hidden;	/* Set to 1 if hidden. */
 };
 
 /* list of lialog_items */
@@ -157,6 +161,7 @@ int item_n(void);
 const char *item_str(void);
 int item_is_selected(void);
 int item_is_tag(char tag);
+int item_is_hidden(void);
 #define item_foreach() \
 	for (item_cur = item_head ? item_head: item_cur; \
 	     item_cur && (item_cur != &item_nil); item_cur = item_cur->next)
diff --git a/scripts/kconfig/lxdialog/menubox.c b/scripts/kconfig/lxdialog/menubox.c
index 0e333284e947..3bff89eb8cdf 100644
--- a/scripts/kconfig/lxdialog/menubox.c
+++ b/scripts/kconfig/lxdialog/menubox.c
@@ -51,9 +51,9 @@ static int menu_width, item_x;
  * Print menu item
  */
 static void do_print_item(WINDOW * win, const char *item, int line_y,
-			  int selected, int hotkey)
+			  int selected, int hotkey, int hidden)
 {
-	int j;
+	int j, attrs;
 	char *menu_item = malloc(menu_width + 1);
 
 	strncpy(menu_item, item, menu_width - item_x);
@@ -64,7 +64,11 @@ static void do_print_item(WINDOW * win, const char *item, int line_y,
 	wattrset(win, dlg.menubox.atr);
 	wmove(win, line_y, 0);
 	wclrtoeol(win);
-	wattrset(win, selected ? dlg.item_selected.atr : dlg.item.atr);
+	if (hidden)
+		attrs = selected ? dlg.item_hidden_selected.atr : dlg.item_hidden.atr;
+	else
+		attrs = selected ? dlg.item_selected.atr : dlg.item.atr;
+	wattrset(win, attrs);
 	mvwaddstr(win, line_y, item_x, menu_item);
 	if (hotkey) {
 		wattrset(win, selected ? dlg.tag_key_selected.atr
@@ -81,7 +85,7 @@ static void do_print_item(WINDOW * win, const char *item, int line_y,
 #define print_item(index, choice, selected)				\
 do {									\
 	item_set(index);						\
-	do_print_item(menu, item_str(), choice, selected, !item_is_tag(':')); \
+	do_print_item(menu, item_str(), choice, selected, !item_is_tag(':'), item_is_hidden()); \
 } while (0)
 
 /*
diff --git a/scripts/kconfig/lxdialog/util.c b/scripts/kconfig/lxdialog/util.c
index 3f78fb265136..161224dd6fb5 100644
--- a/scripts/kconfig/lxdialog/util.c
+++ b/scripts/kconfig/lxdialog/util.c
@@ -38,6 +38,8 @@ static void set_mono_theme(void)
 	dlg.menubox_border.atr = A_NORMAL;
 	dlg.item.atr = A_NORMAL;
 	dlg.item_selected.atr = A_REVERSE;
+	dlg.item_hidden.atr = A_NORMAL | A_DIM;
+	dlg.item_hidden_selected.atr = A_REVERSE | A_DIM;
 	dlg.tag.atr = A_BOLD;
 	dlg.tag_selected.atr = A_REVERSE;
 	dlg.tag_key.atr = A_BOLD;
@@ -78,6 +80,8 @@ static void set_classic_theme(void)
 	DLG_COLOR(menubox_border,        COLOR_WHITE,  COLOR_WHITE,  true);
 	DLG_COLOR(item,                  COLOR_BLACK,  COLOR_WHITE,  false);
 	DLG_COLOR(item_selected,         COLOR_WHITE,  COLOR_BLUE,   true);
+	DLG_COLOR(item_hidden,           COLOR_YELLOW,  COLOR_WHITE,  false);
+	DLG_COLOR(item_hidden_selected,  COLOR_WHITE,  COLOR_BLUE,   true);
 	DLG_COLOR(tag,                   COLOR_YELLOW, COLOR_WHITE,  true);
 	DLG_COLOR(tag_selected,          COLOR_YELLOW, COLOR_BLUE,   true);
 	DLG_COLOR(tag_key,               COLOR_YELLOW, COLOR_WHITE,  true);
@@ -118,6 +122,9 @@ static void set_blackbg_theme(void)
 	DLG_COLOR(item,             COLOR_WHITE, COLOR_BLACK, false);
 	DLG_COLOR(item_selected,    COLOR_WHITE, COLOR_RED,   false);
 
+	DLG_COLOR(item_hidden,          COLOR_YELLOW, COLOR_BLACK, false);
+	DLG_COLOR(item_hidden_selected, COLOR_YELLOW, COLOR_RED,   false);
+
 	DLG_COLOR(tag,              COLOR_RED,    COLOR_BLACK, false);
 	DLG_COLOR(tag_selected,     COLOR_YELLOW, COLOR_RED,   true);
 	DLG_COLOR(tag_key,          COLOR_RED,    COLOR_BLACK, false);
@@ -198,6 +205,8 @@ static void init_dialog_colors(void)
 	init_one_color(&dlg.menubox_border);
 	init_one_color(&dlg.item);
 	init_one_color(&dlg.item_selected);
+	init_one_color(&dlg.item_hidden);
+	init_one_color(&dlg.item_hidden_selected);
 	init_one_color(&dlg.tag);
 	init_one_color(&dlg.tag_selected);
 	init_one_color(&dlg.tag_key);
@@ -635,6 +644,11 @@ void item_set_selected(int val)
 	item_cur->node.selected = val;
 }
 
+void item_set_hidden(int val)
+{
+	item_cur->node.hidden = val;
+}
+
 int item_activate_selected(void)
 {
 	item_foreach()
@@ -698,3 +712,8 @@ int item_is_tag(char tag)
 {
 	return (item_cur->node.tag == tag);
 }
+
+int item_is_hidden(void)
+{
+	return (item_cur->node.hidden != 0);
+}
diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index f4bb391d50cf..b7e08ec98717 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -488,6 +488,8 @@ static void build_conf(struct menu *menu)
 						  menu_is_empty(menu) ? "----" : "--->");
 				item_set_tag('m');
 				item_set_data(menu);
+				if (!visible)
+					item_set_hidden(TRUE);
 				if (single_menu_mode && menu->data)
 					goto conf_childs;
 				return;
@@ -497,6 +499,8 @@ static void build_conf(struct menu *menu)
 					item_make("   %*c*** %s ***", indent + 1, ' ', prompt);
 					item_set_tag(':');
 					item_set_data(menu);
+					if (!visible)
+						item_set_hidden(TRUE);
 				}
 				break;
 			default:
@@ -505,6 +509,8 @@ static void build_conf(struct menu *menu)
 					item_make("---%*c%s", indent + 1, ' ', prompt);
 					item_set_tag(':');
 					item_set_data(menu);
+					if (!visible)
+						item_set_hidden(TRUE);
 				}
 			}
 		} else
@@ -540,10 +546,14 @@ static void build_conf(struct menu *menu)
 			}
 			item_set_tag('t');
 			item_set_data(menu);
+			if (!visible)
+				item_set_hidden(TRUE);
 		} else {
 			item_make("   ");
 			item_set_tag(def_menu ? 't' : ':');
 			item_set_data(menu);
+			if (!visible)
+				item_set_hidden(TRUE);
 		}
 
 		item_add_str("%*c%s", indent + 1, ' ', menu_get_prompt(menu));
@@ -564,6 +574,8 @@ static void build_conf(struct menu *menu)
 			item_make("---%*c%s", indent + 1, ' ', menu_get_prompt(menu));
 			item_set_tag(':');
 			item_set_data(menu);
+			if (!visible)
+				item_set_hidden(TRUE);
 			goto conf_childs;
 		}
 		child_count++;
@@ -581,6 +593,8 @@ static void build_conf(struct menu *menu)
 					item_make("-%c-", val == no ? ' ' : '*');
 				item_set_tag('t');
 				item_set_data(menu);
+				if (!visible)
+					item_set_hidden(TRUE);
 				break;
 			case S_TRISTATE:
 				switch (val) {
@@ -597,6 +611,8 @@ static void build_conf(struct menu *menu)
 					item_make("-%c-", ch);
 				item_set_tag('t');
 				item_set_data(menu);
+				if (!visible)
+					item_set_hidden(TRUE);
 				break;
 			default:
 				tmp = 2 + strlen(sym_get_string_value(sym)); /* () = 2 */
@@ -609,6 +625,8 @@ static void build_conf(struct menu *menu)
 					     "" : " (NEW)");
 				item_set_tag('s');
 				item_set_data(menu);
+				if (!visible)
+					item_set_hidden(TRUE);
 				goto conf_childs;
 			}
 		}
-- 
2.39.2


