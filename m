Return-Path: <linux-kernel+bounces-50073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8468473F0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8211F21AFA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9A714C593;
	Fri,  2 Feb 2024 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lt21hQpl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79229146916;
	Fri,  2 Feb 2024 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889525; cv=none; b=jJSjd8Z/hae/rwvbIzxusJF9/yFHKFZ4DCYdwJs8MTtYBE3/2Q77gLMgCmX2hZ9sTfF+5LhdTVn1NGqtqeel5qM0JuGj3GvfvWaA8LfuyWkUWlqszWeBwKCeXRjJmkxTrCm0sqJYl/7TQNhTHANDZYQYIBF1i3NrDlv0Ee85UJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889525; c=relaxed/simple;
	bh=3mNf0ZSZTDvEBfE5C19X3m4Dwgk1+kn+7smzF28GagI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s9nkBG7it1P5pDRky9Moqmflh2YkpbWO+Cbh+m820nwk/+5UJafvRrsUqiclou+15T8T49QELilj5Jza/aEjsnRjrJ3o55ElQP3vphIhE8FKG/hgcI3PQ9kcGmPgqsMZVEFOs3R1Y2sBAu0Qd7lmDbL/iArY/l/HyNiIuWOfVds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lt21hQpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49ECBC43390;
	Fri,  2 Feb 2024 15:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706889524;
	bh=3mNf0ZSZTDvEBfE5C19X3m4Dwgk1+kn+7smzF28GagI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lt21hQplVb5hpQcN3B1YGxA27O40fqtkxEjJknCLhtioRhIMsTNmsb2AaIeWKOaTB
	 Y4f8jNCpoET6elOnrKzGV5o19M3YyeAiJn872n6ngh9D6m8QOMm2wtlai2wuap1aGN
	 oV9tD0Ny4rsv+vCq6fY69G2Zy4vxnoy9SRRlu8A7PpDB0pJDom37XqBJxtiEGzv/Nw
	 K4oM3fpAH+dRbd+SBKgTOsk31SoNWBy98uCB3uuvDPxt5s0kF4J+RzkrME80gtZlNi
	 1ZC+5LmxzFpsP/d7YNQ0cXArHQ2TR90yD/q+IJgRda+P0tOJPTReTHSsenHzpME11d
	 sMjETBZ+AetuQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 13/27] kconfig: replace file->name with name in zconf_nextfile()
Date: Sat,  3 Feb 2024 00:58:11 +0900
Message-Id: <20240202155825.314567-14-masahiroy@kernel.org>
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

The 'file->name' and 'name' are the same in this function.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/lexer.l | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/kconfig/lexer.l b/scripts/kconfig/lexer.l
index 3b3893f673dc..35ad1b256470 100644
--- a/scripts/kconfig/lexer.l
+++ b/scripts/kconfig/lexer.l
@@ -420,10 +420,10 @@ void zconf_nextfile(const char *name)
 	buf->yylineno = yylineno;
 	buf->parent = current_buf;
 	current_buf = buf;
-	yyin = zconf_fopen(file->name);
+	yyin = zconf_fopen(name);
 	if (!yyin) {
 		fprintf(stderr, "%s:%d: can't open file \"%s\"\n",
-			cur_filename, cur_lineno, file->name);
+			cur_filename, cur_lineno, name);
 		exit(1);
 	}
 	yy_switch_to_buffer(yy_create_buffer(yyin, YY_BUF_SIZE));
@@ -432,17 +432,17 @@ void zconf_nextfile(const char *name)
 	file->parent = current_file;
 
 	for (iter = current_file; iter; iter = iter->parent) {
-		if (!strcmp(iter->name, file->name)) {
+		if (!strcmp(iter->name, name)) {
 			fprintf(stderr,
 				"Recursive inclusion detected.\n"
 				"Inclusion path:\n"
-				"  current file : %s\n", file->name);
+				"  current file : %s\n", name);
 			iter = file;
 			do {
 				iter = iter->parent;
 				fprintf(stderr, "  included from: %s:%d\n",
 					iter->name, iter->lineno);
-			} while (strcmp(iter->name, file->name));
+			} while (strcmp(iter->name, name));
 			exit(1);
 		}
 	}
-- 
2.40.1


