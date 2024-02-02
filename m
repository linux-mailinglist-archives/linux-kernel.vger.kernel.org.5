Return-Path: <linux-kernel+bounces-50085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C964E847409
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AFCEB2C1E6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29814152DFB;
	Fri,  2 Feb 2024 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruhFwbtw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662B5151CF4;
	Fri,  2 Feb 2024 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889538; cv=none; b=ZwFKWZmXplKlHChirBOhDFliu1r94yjwY/jYY/3zSLFpAw2q4iYHhncbQvV8RKGaSN6fB2McH+m4QiLL891xHxysoxfP88TMwOEGbifnP8WyBubwYU5CQ6a4pmff86TKFEzk6ftGJTjeSb7gecqiUhDnUzAQBgHYiUTjhTKS6jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889538; c=relaxed/simple;
	bh=X8I9rXVeGCoi7QcnwK71myLC6oWao8zTKDKpyMAWvVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q02AA6ixz2XkoF09bp+idYDM3ey6oXXHaJCRKcg6zOk6Sa9IUfGcrLDJkakwWYxMIyCJOk5h6vMx4Ns1Gr0/TZdP90mMrniU8Ec1uYFsCU4x9w5zf35Yf9zMFJKNpFQlNp05YHeqROwa0ex+faZgpsN3eh6X8SoN25EYB52j7xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ruhFwbtw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B95C433F1;
	Fri,  2 Feb 2024 15:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706889538;
	bh=X8I9rXVeGCoi7QcnwK71myLC6oWao8zTKDKpyMAWvVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ruhFwbtwadYQ+aNHjKCd11eXVlQ7wLThqD6C1mWZNU+jhMKHpQ2auVnO/eSPsB6+u
	 37fcPp48rAWE7w8tmgQYNgB205Io0CJL1RzBt5MN6MVDulVdvkZNXNS8yyzBeOD6dq
	 0Nuy2uyWp560OU3J+py8kfOlcsRxjitACuxs778wcKnhtQP4/ufG5yFAdmDGuoBFUy
	 ZxBG8KGyl8XEzY4hpEvAmUzyXcrdsHLpFF4Wzscwb/kSbDEO62qKYMtqehjee25PRx
	 6yij5ztam2Vo9vMKZwrkOgVwit0UIp5GpPcAB4KTMVDWxZZVr0SljfNwNju0I5yHT9
	 8LliXU3QuTMug==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 25/27] kconfig: convert linked list of files to hash table
Date: Sat,  3 Feb 2024 00:58:23 +0900
Message-Id: <20240202155825.314567-26-masahiroy@kernel.org>
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

Currently, a linked list is used to keep track of all the Kconfig
files that have ever been parsed. Every time the "source" statement
is encountered, the linked list is traversed to check if the file has
been opened before. This prevents the same file from being recorded
in include/config/auto.conf.cmd again.

Given 1500+ Kconfig files parsed, a hashtable is now a more optimal
data structure.

By the way, you may wonder why we check this in the first place.
It matters only when the same file is included multiple times.
In old days, such a use case was forbidden, but commit f094f8a1b273
("kconfig: allow multiple inclusion of the same file") provided a bit
more flexibility. Of course, it is almost hypothetical...

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/util.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/scripts/kconfig/util.c b/scripts/kconfig/util.c
index 610d64c01479..abd697ed8de7 100644
--- a/scripts/kconfig/util.c
+++ b/scripts/kconfig/util.c
@@ -7,34 +7,37 @@
 #include <stdarg.h>
 #include <stdlib.h>
 #include <string.h>
+
+#include "hashtable.h"
 #include "lkc.h"
+#include "util.h"
+
+/* hash table of all parsed Kconfig files */
+static HASHTABLE_DEFINE(file_hashtable, 1U << 11);
 
 struct file {
-	struct file *next;
+	struct hlist_node node;
 	char name[];
 };
 
-static struct file *file_list;
-
 /* file already present in list? If not add it */
 const char *file_lookup(const char *name)
 {
 	struct file *file;
 	size_t len;
+	int hash = strhash(name);
 
-	for (file = file_list; file; file = file->next) {
-		if (!strcmp(name, file->name)) {
+	hash_for_each_possible(file_hashtable, file, node, hash)
+		if (!strcmp(name, file->name))
 			return file->name;
-		}
-	}
 
 	len = strlen(name);
 	file = xmalloc(sizeof(*file) + len + 1);
 	memset(file, 0, sizeof(*file));
 	memcpy(file->name, name, len);
 	file->name[len] = '\0';
-	file->next = file_list;
-	file_list = file;
+
+	hash_add(file_hashtable, &file->node, hash);
 
 	str_printf(&autoconf_cmd, "\t%s \\\n", name);
 
-- 
2.40.1


