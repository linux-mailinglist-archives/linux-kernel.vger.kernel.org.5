Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08380774FDC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 02:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjHIAcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 20:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjHIAb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 20:31:59 -0400
X-Greylist: delayed 421 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Aug 2023 17:31:53 PDT
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9AF1BCF;
        Tue,  8 Aug 2023 17:31:53 -0700 (PDT)
Received: from localhost.localdomain (unknown [124.16.141.245])
        by APP-01 (Coremail) with SMTP id qwCowACXngbI3NJkKH5NAg--.27121S2;
        Wed, 09 Aug 2023 08:24:41 +0800 (CST)
From:   sunying@nj.iscas.ac.cn
To:     masahiroy@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ying Sun <sunying@nj.iscas.ac.cn>,
        Siyuan Guo <zy21df106@buaa.edu.cn>
Subject: [PATCH] kconfig: add dependency warning print about invalid values in verbose mode
Date:   Wed,  9 Aug 2023 08:24:36 +0800
Message-Id: <20230809002436.18079-1-sunying@nj.iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: qwCowACXngbI3NJkKH5NAg--.27121S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr4DJw1UWry5Ww4kCryrtFb_yoWDJr1fpa
        yUCay7ArsrZF1ayasrKF48Cw1rGas2vr40krs3Cw4UAFy3tws7XrWxGr15tw45Cry8Aw15
        Ca1Y9FWrCFs7GaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkI14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
        6r4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r1j6r
        4UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0wCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjRVbDUUUUU==
X-Originating-IP: [124.16.141.245]
X-CM-SenderInfo: 5vxq5xdqj60y4olvutnvoduhdfq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ying Sun <sunying@nj.iscas.ac.cn>

Add warning about the configuration option's invalid value in verbose mode,
 including error causes, mismatch dependency, old and new values,
 to help users correct them.

Detailed error messages are printed only when the environment variable
 is set like "KCONFIG_VERBOSE=1".
By default, the current behavior is not changed.

Signed-off-by: Siyuan Guo <zy21df106@buaa.edu.cn>
Signed-off-by: Ying Sun <sunying@nj.iscas.ac.cn>
---
 scripts/kconfig/confdata.c | 121 +++++++++++++++++++++++++++++++++++--
 scripts/kconfig/lkc.h      |   3 +
 scripts/kconfig/symbol.c   |  82 +++++++++++++++++++++++--
 3 files changed, 195 insertions(+), 11 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 992575f1e976..fa2ae6f63352 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -154,6 +154,7 @@ static void conf_message(const char *fmt, ...)
 
 static const char *conf_filename;
 static int conf_lineno, conf_warnings;
+const char *verbose;
 
 static void conf_warning(const char *fmt, ...)
 {
@@ -226,7 +227,7 @@ static const char *conf_get_rustccfg_name(void)
 static int conf_set_sym_val(struct symbol *sym, int def, int def_flags, char *p)
 {
 	char *p2;
-
+	static const char * const type[] = {"unknown", "bool", "tristate", "int", "hex", "string"};
 	switch (sym->type) {
 	case S_TRISTATE:
 		if (p[0] == 'm') {
@@ -246,9 +247,14 @@ static int conf_set_sym_val(struct symbol *sym, int def, int def_flags, char *p)
 			sym->flags |= def_flags;
 			break;
 		}
-		if (def != S_DEF_AUTO)
-			conf_warning("symbol value '%s' invalid for %s",
+		if (def != S_DEF_AUTO) {
+			if (verbose)
+				conf_warning("symbol value '%s' invalid for %s\n due to its type is %s",
+				     p, sym->name, type[sym->type]);
+			else
+				conf_warning("symbol value '%s' invalid for %s",
 				     p, sym->name);
+		}
 		return 1;
 	case S_STRING:
 		/* No escaping for S_DEF_AUTO (include/config/auto.conf) */
@@ -274,9 +280,14 @@ static int conf_set_sym_val(struct symbol *sym, int def, int def_flags, char *p)
 			sym->def[def].val = xstrdup(p);
 			sym->flags |= def_flags;
 		} else {
-			if (def != S_DEF_AUTO)
-				conf_warning("symbol value '%s' invalid for %s",
-					     p, sym->name);
+			if (def != S_DEF_AUTO) {
+				if (verbose)
+					conf_warning("symbol value '%s' invalid for %s\n due to its type is %s",
+						p, sym->name, type[sym->type]);
+				else
+					conf_warning("symbol value '%s' invalid for %s",
+						p, sym->name);
+			}
 			return 1;
 		}
 		break;
@@ -528,6 +539,7 @@ int conf_read(const char *name)
 	int conf_unsaved = 0;
 	int i;
 
+	verbose = getenv("KCONFIG_VERBOSE");
 	conf_set_changed(false);
 
 	if (conf_read_simple(name, S_DEF_USER)) {
@@ -559,6 +571,103 @@ int conf_read(const char *name)
 			continue;
 		conf_unsaved++;
 		/* maybe print value in verbose mode... */
+		if (verbose) {
+			if (sym_is_choice_value(sym)) {
+				struct property *prop = sym_get_choice_prop(sym);
+				struct symbol *defsym = prop_get_symbol(prop)->curr.val;
+
+				if (defsym && defsym != sym) {
+					struct gstr gs = str_new();
+
+					str_printf(&gs,
+						"\nERROR : %s[%c => %c] value is invalid\n",
+						sym->name,
+						tristate2char[sym->def[S_DEF_USER].tri],
+						tristate2char[sym->curr.tri]);
+					str_printf(&gs,
+						" due to its not the choice default symbol\n");
+					str_printf(&gs,
+						" the default symbol is %s\n",
+						defsym->name);
+					fputs(str_get(&gs), stderr);
+				}
+			} else {
+				switch (sym->type) {
+				case S_BOOLEAN:
+				case S_TRISTATE:
+					if (sym->dir_dep.tri == no &&
+						sym->def[S_DEF_USER].tri != no) {
+						struct gstr gs = str_new();
+
+						str_printf(&gs,
+							"\nERROR: unmet direct dependencies detected for %s[%c => %c]\n",
+							sym->name,
+							tristate2char[sym->def[S_DEF_USER].tri],
+							tristate2char[sym->curr.tri]);
+						str_printf(&gs,
+							"  Depends on [%c]: ",
+							sym->dir_dep.tri == mod ? 'm' : 'n');
+						expr_gstr_print(sym->dir_dep.expr, &gs);
+						str_printf(&gs, "\n");
+						fputs(str_get(&gs), stderr);
+					} else if (sym->rev_dep.tri != no) {
+						struct gstr gs = str_new();
+
+						str_printf(&gs,
+							"\nERROR : %s[%c => %c] value is invalid\n",
+							sym->name,
+							tristate2char[sym->def[S_DEF_USER].tri],
+							tristate2char[sym->curr.tri]);
+						str_printf(&gs,
+							" due to its invisible and it is selected\n");
+						expr_gstr_print_revdep(sym->rev_dep.expr, &gs, yes,
+									"  Selected by [y]:\n");
+						expr_gstr_print_revdep(sym->rev_dep.expr, &gs, mod,
+									"  Selected by [m]:\n");
+						fputs(str_get(&gs), stderr);
+					} else {
+						sym_validate_default(sym);
+					}
+					break;
+				case S_INT:
+				case S_HEX:
+					if (sym->dir_dep.tri == no &&
+					strcmp((char *)(sym->def[S_DEF_USER].val), "") != 0) {
+						struct gstr gs = str_new();
+
+						str_printf(&gs,
+							"\nERROR: unmet direct dependencies detected for %s\n",
+							sym->name);
+						str_printf(&gs,
+							"  Depends on [%c]: ",
+							sym->dir_dep.tri == mod ? 'm' : 'n');
+						expr_gstr_print(sym->dir_dep.expr, &gs);
+						str_printf(&gs, "\n");
+						fputs(str_get(&gs), stderr);
+					} else {
+						sym_validate_default(sym);
+					}
+					break;
+				case S_STRING:
+					if (sym->dir_dep.tri == no &&
+					strcmp((char *)(sym->def[S_DEF_USER].val), "") != 0) {
+						struct gstr gs = str_new();
+
+						str_printf(&gs,
+							"\nERROR: unmet direct dependencies detected for %s\n",
+							sym->name);
+						str_printf(&gs,
+							"  Depends on [%c]: ",
+							sym->dir_dep.tri == mod ? 'm' : 'n');
+						expr_gstr_print(sym->dir_dep.expr, &gs);
+						str_printf(&gs, "\n");
+						fputs(str_get(&gs), stderr);
+					}
+				default:
+					break;
+				}
+			}
+		}
 	}
 
 	for_all_symbols(i, sym) {
diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index 471a59acecec..820a47fb4968 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -38,6 +38,8 @@ void zconf_initscan(const char *name);
 void zconf_nextfile(const char *name);
 int zconf_lineno(void);
 const char *zconf_curname(void);
+extern const char *verbose;
+static const char tristate2char[3] = {'n', 'm', 'y'};
 
 /* confdata.c */
 const char *conf_get_configname(void);
@@ -112,6 +114,7 @@ struct property *sym_get_range_prop(struct symbol *sym);
 const char *sym_get_string_default(struct symbol *sym);
 struct symbol *sym_check_deps(struct symbol *sym);
 struct symbol *prop_get_symbol(struct property *prop);
+void sym_validate_default(struct symbol *sym);
 
 static inline tristate sym_get_tristate_value(struct symbol *sym)
 {
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 0572330bf8a7..8b11d6ea1d30 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -91,6 +91,53 @@ static struct property *sym_get_default_prop(struct symbol *sym)
 	return NULL;
 }
 
+void sym_validate_default(struct symbol *sym)
+{
+	if (sym->visible == no) {
+		struct gstr gs = str_new();
+		const char *value = sym_get_string_default(sym);
+
+		switch (sym->type) {
+		case S_BOOLEAN:
+		case S_TRISTATE:
+			if (strcmp(value, "n") != 0) {
+				str_printf(&gs,
+					"\nERROR : %s[%c => %c] value is invalid\n due to it has default value\n",
+					sym->name,
+					tristate2char[sym->def[S_DEF_USER].tri],
+					tristate2char[sym->curr.tri]);
+			} else if (sym->implied.tri != no) {
+				str_printf(&gs,
+					"\nERROR : %s[%c => %c] value is invalid\n due to its invisible and has imply value\n",
+					sym->name,
+					tristate2char[sym->def[S_DEF_USER].tri],
+					tristate2char[sym->curr.tri]);
+				str_printf(&gs,
+					" Imply : ");
+				expr_gstr_print(sym->implied.expr, &gs);
+				str_printf(&gs, "\n");
+			}
+			break;
+		case S_STRING:
+		case S_INT:
+		case S_HEX:
+			if (strcmp(value, "") != 0) {
+				str_printf(&gs,
+					"\nERROR : %s[%s => %s] value is invalid\n",
+					sym->name,
+					(char *)(sym->def[S_DEF_USER].val),
+					(char *)(sym->curr.val));
+				str_printf(&gs,
+					" due to it has default value\n");
+			}
+			break;
+		default:
+			break;
+		}
+		fputs(str_get(&gs), stderr);
+	}
+}
+
 struct property *sym_get_range_prop(struct symbol *sym)
 {
 	struct property *prop;
@@ -600,7 +647,8 @@ bool sym_string_valid(struct symbol *sym, const char *str)
 bool sym_string_within_range(struct symbol *sym, const char *str)
 {
 	struct property *prop;
-	long long val;
+	long long val, left, right;
+	struct gstr gs = str_new();
 
 	switch (sym->type) {
 	case S_STRING:
@@ -612,8 +660,20 @@ bool sym_string_within_range(struct symbol *sym, const char *str)
 		if (!prop)
 			return true;
 		val = strtoll(str, NULL, 10);
-		return val >= sym_get_range_val(prop->expr->left.sym, 10) &&
-		       val <= sym_get_range_val(prop->expr->right.sym, 10);
+		left = sym_get_range_val(prop->expr->left.sym, 10);
+		right = sym_get_range_val(prop->expr->right.sym, 10);
+		if (val >= left && val <= right)
+			return true;
+		if (verbose) {
+			str_printf(&gs,
+				"\nERROR: unmet range detected for %s\n",
+				sym->name);
+			str_printf(&gs,
+				" symbol value is %lld, the range is (%lld %lld)\n",
+				val, left, right);
+			fputs(str_get(&gs), stderr);
+		}
+		return false;
 	case S_HEX:
 		if (!sym_string_valid(sym, str))
 			return false;
@@ -621,8 +681,20 @@ bool sym_string_within_range(struct symbol *sym, const char *str)
 		if (!prop)
 			return true;
 		val = strtoll(str, NULL, 16);
-		return val >= sym_get_range_val(prop->expr->left.sym, 16) &&
-		       val <= sym_get_range_val(prop->expr->right.sym, 16);
+		left = sym_get_range_val(prop->expr->left.sym, 16);
+		right = sym_get_range_val(prop->expr->right.sym, 16);
+		if (val >= left && val <= right)
+			return true;
+		if (verbose) {
+			str_printf(&gs,
+				"\nERROR: unmet range detected for %s\n",
+				sym->name);
+			str_printf(&gs,
+				" symbol value is 0x%llx, the range is (0x%llx 0x%llx)\n",
+				val, left, right);
+			fputs(str_get(&gs), stderr);
+		}
+		return false;
 	case S_BOOLEAN:
 	case S_TRISTATE:
 		switch (str[0]) {
-- 
2.17.1

