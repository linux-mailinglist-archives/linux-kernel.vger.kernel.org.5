Return-Path: <linux-kernel+bounces-50077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED3A8473F8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CB60289479
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847DA14D449;
	Fri,  2 Feb 2024 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpRuZ5dP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4E214C5BF;
	Fri,  2 Feb 2024 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889529; cv=none; b=JV9SaGvZUcvdXrWK32GMP4F4/MgNjQ5Jxm7NO9bxuvYFzWBm2eLAHMf+dJxtUAPeJb4qS+v8mTrpU65aJtP5siauzOyfqBTZHeeNoL8exUQNEPt1o5j/TP8wka99tFgnezC6ux7yrM5NHWxcf6+EpqDwuX7GJA92xPAOI7qKJYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889529; c=relaxed/simple;
	bh=6HFGjcFafgAEeyFv5246DWk9iueSVCKM1qtHrZhaPSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p/Jjm0lB/o/H3az7EboYsMqQC0BG3drg4/3TNsltXpOKtGzBjpekIfzpMCgA534pLNi0Q9vMiy3dKW1aaQGhJ1KnSqPCxV5OwNWy6MyHDzI6e1kB+86HlnUOwGR9NYzvgAK4nk+6nrB/DrSGeHZ45nzowo+4UxGDqXIHjrMTnZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpRuZ5dP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2705C43394;
	Fri,  2 Feb 2024 15:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706889529;
	bh=6HFGjcFafgAEeyFv5246DWk9iueSVCKM1qtHrZhaPSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZpRuZ5dPoGqLFy/mD0TUPIugrzKvZNC3pn/xuM5uXOnMUEqeAnO4mP8J8AHOovi2e
	 V9bv0V1t/dUZRfMyT4NzZyNHZMzVHge3oW8tFHgt00Ksh1X3PvC+4dmZYbcJBhXUG/
	 gcsT67VmRc4T6xM/t/Ax5DuasRogKbT6srB21N5znhBBAnURVRBwa6AM+Rndjg7ToG
	 RbRqnyuADceWcSz5Mc2mJAsN55XxxsNFrtEicOnr2TmRRo+jXuh9lI1chiuVFMNbcE
	 jISsQmgtU8+B5ipXmnnXFbx7nN30wzCHwCpSfLoYghJRfeUrjNLQI6tnvWRrtVOf3q
	 rw+/eJ5ierp4Q==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 17/27] kconfig: make file::name a flexible array member
Date: Sat,  3 Feb 2024 00:58:15 +0900
Message-Id: <20240202155825.314567-18-masahiroy@kernel.org>
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

Call malloc() just once to allocate needed memory.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/expr.h | 2 +-
 scripts/kconfig/util.c | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
index 85e0d1ab3c8a..760b1e681b43 100644
--- a/scripts/kconfig/expr.h
+++ b/scripts/kconfig/expr.h
@@ -19,7 +19,7 @@ extern "C" {
 
 struct file {
 	struct file *next;
-	const char *name;
+	char name[];
 };
 
 typedef enum tristate {
diff --git a/scripts/kconfig/util.c b/scripts/kconfig/util.c
index 958543bb0a37..2636dccea0c9 100644
--- a/scripts/kconfig/util.c
+++ b/scripts/kconfig/util.c
@@ -13,6 +13,7 @@
 struct file *file_lookup(const char *name)
 {
 	struct file *file;
+	size_t len;
 
 	for (file = file_list; file; file = file->next) {
 		if (!strcmp(name, file->name)) {
@@ -20,9 +21,11 @@ struct file *file_lookup(const char *name)
 		}
 	}
 
-	file = xmalloc(sizeof(*file));
+	len = strlen(name);
+	file = xmalloc(sizeof(*file) + len + 1);
 	memset(file, 0, sizeof(*file));
-	file->name = xstrdup(name);
+	memcpy(file->name, name, len);
+	file->name[len] = '\0';
 	file->next = file_list;
 	file_list = file;
 
-- 
2.40.1


