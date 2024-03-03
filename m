Return-Path: <linux-kernel+bounces-89649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F2286F392
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 05:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03D7283F3C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 04:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9029A95C;
	Sun,  3 Mar 2024 04:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLbbt3NZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56CE945A;
	Sun,  3 Mar 2024 04:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709438444; cv=none; b=lBOZIhfGsRyuN/RDVYl2IXk5HP0fX8SrRaG69kgolecjuaevVEmohLRBo0lRp4zdEpLHOLDiQAF9YJs3KlNWWfUQ803lpGFb4pXs6J0QHonrK8gSPWY75T+/mJ6PqESU+kKyJNTNADNieDbqzOolbLyDgVm1EAIFrSCedMYQnLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709438444; c=relaxed/simple;
	bh=b61Pfq2+8r8OGJHhDhI5Mm5KHha8WJXnv9P4YukQfBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=suq4dTgks5DkwrsJG0I5taTlDDdqn9YBoFmgyH/McMKf590T1J/Pz2Hq8qZWnY6TpnCvLXE7tTCEybIRTQgfV2nf3wB6dCr/Jp+V+SVA42UXoqlHB8jY+nBn80HCvHSfOHlqi6Ns69/uYCqAaE+kJ2S6sH/rrJ6ngrY2odQyRiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLbbt3NZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9FEC433C7;
	Sun,  3 Mar 2024 04:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709438443;
	bh=b61Pfq2+8r8OGJHhDhI5Mm5KHha8WJXnv9P4YukQfBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MLbbt3NZn0xrsQuW9NCvbKNKiSeesbi6x6G29LqmLs3fYnPcVm7MeeqbvRau/8PG3
	 FwmfASUsLjng7lF3Fkjctm2zv9ZxrWz0v22602HMBVOhdmNtKpFfseGvkR0cxti8bK
	 RPJhTsci3ncZ2rDYkW9bKDRCewOWaHQxCHrmMLfNk9nxgxd/9ZsspeMzlT1axf5NgP
	 Gnqs5OFFGwLQe2pi1hrAgCS8nWR1gu7/mXxE5Puxw38GVX9h3AbyKtWH8MX7qPO9Tu
	 McpIzOkvHW9c+YYNd4jg65rXTrzHxZx5ehM48GDVJIxMCL9fFzTNxK/EK3dYi4xGOv
	 5ba1zvvnbJDrA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-doc@vger.kernel.org
Subject: [PATCH 3/3] kconfig: remove named choice support
Date: Sun,  3 Mar 2024 13:00:35 +0900
Message-Id: <20240303040035.3450914-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240303040035.3450914-1-masahiroy@kernel.org>
References: <20240303040035.3450914-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5a1aa8a1aff6 ("kconfig: add named choice group") did not provide
enough explanation. A use case was found in another project [1], but
this has never been used in the kernel.

[1]: https://lore.kernel.org/all/201012150034.01356.yann.morin.1998@anciens.enib.fr/

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Documentation/kbuild/kconfig-language.rst |  6 +-----
 scripts/kconfig/parser.y                  | 10 +++-------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/Documentation/kbuild/kconfig-language.rst b/Documentation/kbuild/kconfig-language.rst
index 0135905c0aa3..79ac2e8184f6 100644
--- a/Documentation/kbuild/kconfig-language.rst
+++ b/Documentation/kbuild/kconfig-language.rst
@@ -393,7 +393,7 @@ of C0, which doesn't depend on M::
 
 choices::
 
-	"choice" [symbol]
+	"choice"
 	<choice options>
 	<choice block>
 	"endchoice"
@@ -412,10 +412,6 @@ the kernel, but all drivers can be compiled as modules.
 
 A choice accepts another option "optional", which allows to set the
 choice to 'n' and no entry needs to be selected.
-If no [symbol] is associated with a choice, then you can not have multiple
-definitions of that choice. If a [symbol] is associated to the choice,
-then you may define the same choice (i.e. with the same entries) in another
-place.
 
 comment::
 
diff --git a/scripts/kconfig/parser.y b/scripts/kconfig/parser.y
index b505e43e0d02..22f616334585 100644
--- a/scripts/kconfig/parser.y
+++ b/scripts/kconfig/parser.y
@@ -94,7 +94,7 @@ struct menu *current_menu, *current_entry;
 %type <expr> if_expr
 %type <string> end
 %type <menu> if_entry menu_entry choice_entry
-%type <string> word_opt assign_val
+%type <string> assign_val
 %type <flavor> assign_op
 
 %destructor {
@@ -222,13 +222,12 @@ config_option: T_MODULES T_EOL
 
 /* choice entry */
 
-choice: T_CHOICE word_opt T_EOL
+choice: T_CHOICE T_EOL
 {
-	struct symbol *sym = sym_lookup($2, SYMBOL_CHOICE);
+	struct symbol *sym = sym_lookup(NULL, SYMBOL_CHOICE);
 	sym->flags |= SYMBOL_NO_WRITE;
 	menu_add_entry(sym);
 	menu_add_expr(P_CHOICE, NULL, NULL);
-	free($2);
 	printd(DEBUG_PARSE, "%s:%d:choice\n", cur_filename, cur_lineno);
 };
 
@@ -449,9 +448,6 @@ symbol:	  nonconst_symbol
 	| T_WORD_QUOTE	{ $$ = sym_lookup($1, SYMBOL_CONST); free($1); }
 ;
 
-word_opt: /* empty */			{ $$ = NULL; }
-	| T_WORD
-
 /* assignment statement */
 
 assignment_stmt:  T_WORD assign_op assign_val T_EOL	{ variable_add($1, $3, $2); free($1); free($3); }
-- 
2.40.1


