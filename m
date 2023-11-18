Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F32D7EFE68
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 08:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjKRH7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 02:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjKRH7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 02:59:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35266D51
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 23:59:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342B5C433C9;
        Sat, 18 Nov 2023 07:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700294358;
        bh=YxFaQuWjuJpS5NUYQ/dIR/BuE2+ge6XoKjKGeh3QdZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RydCbEjNwUvyzYgnPXpoQnsDGmvaPa+DqH6m/UGtiqzLQFwoJrZf7xfrMvZGXemYD
         Bz79mX4w5aXFlxf1Y5x5RmvFwkfbE52Sk7sGpYhI03McpyvaF7yq/z1FX7+ciOU3Og
         qACTu2uaSzjvPjyGPqG40OPkBVNiZAU7Ymkre/xaFOu6E70W3X03PkuAVEn2b58B3x
         fE+0Bwd+tUFK0mfFJnSJgkyiJgpqhVNZtj7p/6MkwF0u2tZ4LP/8COrEspm3vCQHJ2
         phJY39ZuMaH5l32Ra64ba4Hjo3cXPiYj1URfxSUkznp8MuNyZU+2oykoLHIlImL3Ix
         H12/nymBeAr+w==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 3/6] kconfig: deduplicate code in conf_read_simple()
Date:   Sat, 18 Nov 2023 16:59:09 +0900
Message-Id: <20231118075912.1303509-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118075912.1303509-1-masahiroy@kernel.org>
References: <20231118075912.1303509-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kconfig accepts both "# CONFIG_FOO is not set" and "CONFIG_FOO=n" as
a valid input, but conf_read_simple() duplicates similar code to handle
them. Factor out the common code.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/confdata.c | 89 +++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 54 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 92e8e37aca4d..b6a90f6baea1 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -342,11 +342,10 @@ int conf_read_simple(const char *name, int def)
 	FILE *in = NULL;
 	char   *line = NULL;
 	size_t  line_asize = 0;
-	char *p, *p2;
+	char *p, *p2, *val;
 	struct symbol *sym;
 	int i, def_flags;
-	const char *warn_unknown;
-	const char *werror;
+	const char *warn_unknown, *werror, *sym_name;
 
 	warn_unknown = getenv("KCONFIG_WARN_UNKNOWN_SYMBOLS");
 	werror = getenv("KCONFIG_WERROR");
@@ -424,77 +423,34 @@ int conf_read_simple(const char *name, int def)
 
 	while (compat_getline(&line, &line_asize, in) != -1) {
 		conf_lineno++;
-		sym = NULL;
 		if (line[0] == '#') {
 			if (line[1] != ' ')
 				continue;
-			if (memcmp(line + 2, CONFIG_, strlen(CONFIG_)))
+			p = line + 2;
+			if (memcmp(p, CONFIG_, strlen(CONFIG_)))
 				continue;
-			p = strchr(line + 2 + strlen(CONFIG_), ' ');
+			sym_name = p + strlen(CONFIG_);
+			p = strchr(sym_name, ' ');
 			if (!p)
 				continue;
 			*p++ = 0;
 			if (strncmp(p, "is not set", 10))
 				continue;
 
-			sym = sym_find(line + 2 + strlen(CONFIG_));
-			if (!sym) {
-				if (warn_unknown)
-					conf_warning("unknown symbol: %s",
-						     line + 2 + strlen(CONFIG_));
-
-				conf_set_changed(true);
-				continue;
-			}
-			if (sym->flags & def_flags) {
-				conf_warning("override: reassigning to symbol %s", sym->name);
-			}
-			switch (sym->type) {
-			case S_BOOLEAN:
-			case S_TRISTATE:
-				sym->def[def].tri = no;
-				sym->flags |= def_flags;
-				break;
-			default:
-				;
-			}
+			val = "n";
 		} else if (memcmp(line, CONFIG_, strlen(CONFIG_)) == 0) {
-			p = strchr(line + strlen(CONFIG_), '=');
+			sym_name = line + strlen(CONFIG_);
+			p = strchr(sym_name, '=');
 			if (!p)
 				continue;
 			*p++ = 0;
+			val = p;
 			p2 = strchr(p, '\n');
 			if (p2) {
 				*p2-- = 0;
 				if (*p2 == '\r')
 					*p2 = 0;
 			}
-
-			sym = sym_find(line + strlen(CONFIG_));
-			if (!sym) {
-				if (def == S_DEF_AUTO) {
-					/*
-					 * Reading from include/config/auto.conf
-					 * If CONFIG_FOO previously existed in
-					 * auto.conf but it is missing now,
-					 * include/config/FOO must be touched.
-					 */
-					conf_touch_dep(line + strlen(CONFIG_));
-				} else {
-					if (warn_unknown)
-						conf_warning("unknown symbol: %s",
-							     line + strlen(CONFIG_));
-
-					conf_set_changed(true);
-				}
-				continue;
-			}
-
-			if (sym->flags & def_flags) {
-				conf_warning("override: reassigning to symbol %s", sym->name);
-			}
-			if (conf_set_sym_val(sym, def, def_flags, p))
-				continue;
 		} else {
 			if (line[0] != '\r' && line[0] != '\n')
 				conf_warning("unexpected data: %.*s",
@@ -503,6 +459,31 @@ int conf_read_simple(const char *name, int def)
 			continue;
 		}
 
+		sym = sym_find(sym_name);
+		if (!sym) {
+			if (def == S_DEF_AUTO) {
+				/*
+				 * Reading from include/config/auto.conf.
+				 * If CONFIG_FOO previously existed in auto.conf
+				 * but it is missing now, include/config/FOO
+				 * must be touched.
+				 */
+				conf_touch_dep(sym_name);
+			} else {
+				if (warn_unknown)
+					conf_warning("unknown symbol: %s", sym_name);
+
+				conf_set_changed(true);
+			}
+			continue;
+		}
+
+		if (sym->flags & def_flags)
+			conf_warning("override: reassigning to symbol %s", sym->name);
+
+		if (conf_set_sym_val(sym, def, def_flags, val))
+			continue;
+
 		if (sym && sym_is_choice_value(sym)) {
 			struct symbol *cs = prop_get_symbol(sym_get_choice_prop(sym));
 			switch (sym->def[def].tri) {
-- 
2.40.1

