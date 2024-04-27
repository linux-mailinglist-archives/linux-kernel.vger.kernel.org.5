Return-Path: <linux-kernel+bounces-160973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 134268B454E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 11:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 917A2B21D9D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 09:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC634597D;
	Sat, 27 Apr 2024 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUMNDpku"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7E440BED;
	Sat, 27 Apr 2024 09:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714209403; cv=none; b=uA4djM135fkbv7jeosBAHbdJDGX4mh2kZ3i6nh/aucsaCiLM3kQYfLD0tKIFwf0lbzoqB3iwr3MNLnPJVbAC0ixteog382NK3s+EqIZcTJIZbcGVVjopF82ENQTu0yW+bwPwTfWOAeWfFiuJKyvvemuUVE4xeSu573QRDgeSuoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714209403; c=relaxed/simple;
	bh=spjxZtU2X9VEEO69NhaiUz7HWIUhY1zMZiiojKMLKJk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fZmhLI2sywKMlWdv7GJrOoyXu8sReCkVpih/HSXBdyY5Ycvoh2awU6DWRg+PBQ807To+lAJapSsRJCwsbgHYqSAV8nWRssU6GZ5CiKhNUeEtWKKXAXXXJHt58GliVGAYA8dd04wX5Wo9PvcdcheZ5tBXCsbyV53h4hNW/A4uw2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUMNDpku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A3AC113CE;
	Sat, 27 Apr 2024 09:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714209403;
	bh=spjxZtU2X9VEEO69NhaiUz7HWIUhY1zMZiiojKMLKJk=;
	h=From:To:Cc:Subject:Date:From;
	b=HUMNDpkuyco7soSPC4Rzf8bKLrCZyn5K6pqb9WdOqdW0PPmw7NluRvmgW2gQ2WNhN
	 U/l4gJb5hQDVl6DohxW8+u3AGY5WfYVIg/DLDHX7GGfkPOOHbn4UU/XuQBnKyWOvQe
	 fvFErRstI92CYRG+IEF79gf/RqfNV7fovuG4VRRoPUDqYRUoxPmo42vjyveOTTYKRI
	 9wYRnwcdTxNNrSFnu/ks7n4pq2NsR2fSl4777y0u294Lb63u8bHuiEFTmlMEnkPtFM
	 bb5VTrTznU2lK7laxdO4JrFm7k6NcIqIXMJNd5C3NIsEsZndzSiEkkY9WhKE3M2hrF
	 lvv8QElSuWbDA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] kconfig: remove SYMBOL_NO_WRITE flag
Date: Sat, 27 Apr 2024 18:16:38 +0900
Message-Id: <20240427091638.2722050-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This flag is set to symbols that are not intended to be written
to the .config file.

Since commit b75b0a819af9 ("kconfig: change defconfig_list option to
environment variable"), SYMBOL_NO_WRITE is only set to choices.

Therefore, (sym->flags & SYMBOL_NO_WRITE) is equivalent to
sym_is_choice(sym). This flags is no longer necessary.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/confdata.c | 4 ++--
 scripts/kconfig/expr.h     | 1 -
 scripts/kconfig/gconf.c    | 2 --
 scripts/kconfig/parser.y   | 2 +-
 scripts/kconfig/symbol.c   | 3 +--
 5 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index bcce87658998..5caec434e6f4 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -502,7 +502,7 @@ int conf_read(const char *name)
 
 	for_all_symbols(sym) {
 		sym_calc_value(sym);
-		if (sym_is_choice(sym) || (sym->flags & SYMBOL_NO_WRITE))
+		if (sym_is_choice(sym))
 			continue;
 		if (sym_has_value(sym) && (sym->flags & SYMBOL_WRITE)) {
 			/* check that calculated value agrees with saved value */
@@ -1007,7 +1007,7 @@ static int conf_touch_deps(void)
 
 	for_all_symbols(sym) {
 		sym_calc_value(sym);
-		if ((sym->flags & SYMBOL_NO_WRITE) || !sym->name)
+		if (sym_is_choice(sym))
 			continue;
 		if (sym->flags & SYMBOL_WRITE) {
 			if (sym->flags & SYMBOL_DEF_AUTO) {
diff --git a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
index f646a98de006..d965e427753e 100644
--- a/scripts/kconfig/expr.h
+++ b/scripts/kconfig/expr.h
@@ -135,7 +135,6 @@ struct symbol {
 #define SYMBOL_WRITE      0x0200  /* write symbol to file (KCONFIG_CONFIG) */
 #define SYMBOL_CHANGED    0x0400  /* ? */
 #define SYMBOL_WRITTEN    0x0800  /* track info to avoid double-write to .config */
-#define SYMBOL_NO_WRITE   0x1000  /* Symbol for internal use only; it will not be written */
 #define SYMBOL_CHECKED    0x2000  /* used during dependency checking */
 #define SYMBOL_WARNED     0x8000  /* warning has been issued */
 
diff --git a/scripts/kconfig/gconf.c b/scripts/kconfig/gconf.c
index 13e2449ac83f..67a27c497c40 100644
--- a/scripts/kconfig/gconf.c
+++ b/scripts/kconfig/gconf.c
@@ -91,8 +91,6 @@ static const char *dbg_sym_flags(int val)
 		strcat(buf, "write/");
 	if (val & SYMBOL_CHANGED)
 		strcat(buf, "changed/");
-	if (val & SYMBOL_NO_WRITE)
-		strcat(buf, "no_write/");
 
 	buf[strlen(buf) - 1] = '\0';
 
diff --git a/scripts/kconfig/parser.y b/scripts/kconfig/parser.y
index 69dc0c098acb..613fa8c9c2d0 100644
--- a/scripts/kconfig/parser.y
+++ b/scripts/kconfig/parser.y
@@ -222,7 +222,7 @@ config_option: T_MODULES T_EOL
 choice: T_CHOICE T_EOL
 {
 	struct symbol *sym = sym_lookup(NULL, 0);
-	sym->flags |= SYMBOL_NO_WRITE;
+
 	menu_add_entry(sym);
 	menu_add_expr(P_CHOICE, NULL, NULL);
 	printd(DEBUG_PARSE, "%s:%d:choice\n", cur_filename, cur_lineno);
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 8b34992ba5ed..b909c64f3bac 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -466,10 +466,9 @@ void sym_calc_value(struct symbol *sym)
 			if (sym->flags & SYMBOL_CHANGED)
 				sym_set_changed(choice_sym);
 		}
-	}
 
-	if (sym->flags & SYMBOL_NO_WRITE)
 		sym->flags &= ~SYMBOL_WRITE;
+	}
 
 	if (sym->flags & SYMBOL_NEED_SET_CHOICE_VALUES)
 		set_all_choice_values(sym);
-- 
2.40.1


