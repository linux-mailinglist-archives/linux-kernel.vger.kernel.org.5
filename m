Return-Path: <linux-kernel+bounces-50067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A19D8473E4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA77A1F2A1FD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996F6149005;
	Fri,  2 Feb 2024 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNYxlaze"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6651487D3;
	Fri,  2 Feb 2024 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889519; cv=none; b=liqUIMJlxlNi6InJ/rxUdHgFhyA7stYJBzad3NDohcBepiArlJprw1YDwXgz1my3ytbm9KPUOjy/tnT/VNanWC9eG1wBlkbj8/5/uFJx+7ZjmoTvEZyu8mtaSbea/4afdAhuNNzfc0MczMBUdwSH9vg/fJNs97fzuVwRH26+Y/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889519; c=relaxed/simple;
	bh=R/ud+/692kalgVHV0nqCoalOnQuqYPYP1Bs8zxfM520=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Knxhn2bUoDQZDT3rO/CGKv0vmYR/403atT9R6OvbPsOf8nNRg47zJD7+jVLgIKyV91fylm210Lb/84KwZYkqOne5sPKWnijfsj0sTuWjBg9+Q/oEZFqwTFG4QanXRJsog5CwfX5wRAubKe0ajkGcFnO9obg92c5NQolEyiqOh4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNYxlaze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE71C433F1;
	Fri,  2 Feb 2024 15:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706889518;
	bh=R/ud+/692kalgVHV0nqCoalOnQuqYPYP1Bs8zxfM520=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iNYxlazejOtTkfIDYgKVtb0w3qXSn/htZNacZR08Yz1ZnsDAGDrl5dXkTmKgew4+b
	 7B93InMSKi1t4t0iLFaJ+uxVy9U5i2I0za3d3Npy24JTbWAfzrfqPCDhIe9FCZ5jXJ
	 xGYJ9mtlROeoV8AorAayvblqUmYHca3/iYwRqzFKXnTlfDSWyvTWhyZyYfvT6ot97w
	 JemRdBbueOE0dyP/pCulU4fiN8qJ8/OvaeGlMkNFMkdEBGmhKVayu/MksxLyrvFjis
	 HTPwIcxrzvhVgCOzYBp89Bn0+7ctPJNCrDn9ntOhDzKS/iXVlc3cgOWRl5V6kWpHA+
	 tbIAJNf1RGBfw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 07/27] kconfig: call env_write_dep() right after yyparse()
Date: Sat,  3 Feb 2024 00:58:05 +0900
Message-Id: <20240202155825.314567-8-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240202155825.314567-1-masahiroy@kernel.org>
References: <20240202155825.314567-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows preprocess.c to free up all of its resources when the parse
stage is finished. It also ensures conf_write_autoconf_cmd() produces
consistent results even if called multiple times for any reason.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/confdata.c   |  8 ++------
 scripts/kconfig/lkc_proto.h  |  2 +-
 scripts/kconfig/parser.y     |  9 ++++++++-
 scripts/kconfig/preprocess.c | 11 +++++++----
 4 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index f6a96fdddb7e..dafc572e7b7e 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -994,14 +994,10 @@ static int conf_write_autoconf_cmd(const char *autoconf_name)
 		return -1;
 	}
 
+	fprintf(out, "autoconfig := %s\n", autoconf_name);
+
 	fputs(str_get(&autoconf_cmd), out);
 
-	fprintf(out, "\n%s: $(deps_config)\n\n", autoconf_name);
-
-	env_write_dep(out, autoconf_name);
-
-	fprintf(out, "\n$(deps_config): ;\n");
-
 	fflush(out);
 	ret = ferror(out); /* error check for all fprintf() calls */
 	fclose(out);
diff --git a/scripts/kconfig/lkc_proto.h b/scripts/kconfig/lkc_proto.h
index a4ae5e9eadad..85491d74a094 100644
--- a/scripts/kconfig/lkc_proto.h
+++ b/scripts/kconfig/lkc_proto.h
@@ -46,7 +46,7 @@ enum variable_flavor {
 	VAR_RECURSIVE,
 	VAR_APPEND,
 };
-void env_write_dep(FILE *f, const char *auto_conf_name);
+void env_write_dep(struct gstr *gs);
 void variable_add(const char *name, const char *value,
 		  enum variable_flavor flavor);
 void variable_all_del(void);
diff --git a/scripts/kconfig/parser.y b/scripts/kconfig/parser.y
index 611038c502fc..cfb82ba09037 100644
--- a/scripts/kconfig/parser.y
+++ b/scripts/kconfig/parser.y
@@ -482,7 +482,7 @@ void conf_parse(const char *name)
 
 	autoconf_cmd = str_new();
 
-	str_printf(&autoconf_cmd, "deps_config := \\\n");
+	str_printf(&autoconf_cmd, "\ndeps_config := \\\n");
 
 	zconf_initscan(name);
 
@@ -492,6 +492,13 @@ void conf_parse(const char *name)
 		yydebug = 1;
 	yyparse();
 
+	str_printf(&autoconf_cmd,
+		   "\n"
+		   "$(autoconfig): $(deps_config)\n"
+		   "$(deps_config): ;\n");
+
+	env_write_dep(&autoconf_cmd);
+
 	/* Variables are expanded in the parse phase. We can free them here. */
 	variable_all_del();
 
diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
index d1f5bcff4b62..b9853d4a891c 100644
--- a/scripts/kconfig/preprocess.c
+++ b/scripts/kconfig/preprocess.c
@@ -87,14 +87,17 @@ static char *env_expand(const char *name)
 	return xstrdup(value);
 }
 
-void env_write_dep(FILE *f, const char *autoconfig_name)
+void env_write_dep(struct gstr *s)
 {
 	struct env *e, *tmp;
 
 	list_for_each_entry_safe(e, tmp, &env_list, node) {
-		fprintf(f, "ifneq \"$(%s)\" \"%s\"\n", e->name, e->value);
-		fprintf(f, "%s: FORCE\n", autoconfig_name);
-		fprintf(f, "endif\n");
+		str_printf(s,
+			   "\n"
+			   "ifneq \"$(%s)\" \"%s\"\n"
+			   "$(autoconfig): FORCE\n"
+			   "endif\n",
+			   e->name, e->value);
 		env_del(e);
 	}
 }
-- 
2.40.1


