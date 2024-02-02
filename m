Return-Path: <linux-kernel+bounces-50082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 560F2847403
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D50A5B22F60
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D3615146B;
	Fri,  2 Feb 2024 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBF3HzlA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F57415145C;
	Fri,  2 Feb 2024 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889535; cv=none; b=SMDrsfJQnlR7I1E+QClkzpZGyN/ubYzKjosspx3jy8FuBS5jXaWy4nokCBwjnVe/bflcciiMw9NbYZ3aYb5Ywm9XvosvnFHpJkxJi+K2gNOPmZ/arlbvwALPb4qIeMagTy1HYjiTQVSieZznRrxBPYeWp1DabBuiwgjdIfq/fC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889535; c=relaxed/simple;
	bh=D8GL5EXe9NsGs57qE1qR40Cel+KA+fOzcvMaeqYSUEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P0m0N8myx7OS7i9ICujsQ26zdhLHNmrS9MySJRHTZCVrg5s3pr/jiAwrgdHFKFxh2qSMZrpKYDygMqrXvA6u6/l8yYGBDJaplIZR0CFsJhVOl3eE06W0nmZ65lLi5MITKAMwR7lWHmgPRE0jxV+wS24I8cFlniv0lD/Ny+czE/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBF3HzlA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F38C43390;
	Fri,  2 Feb 2024 15:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706889534;
	bh=D8GL5EXe9NsGs57qE1qR40Cel+KA+fOzcvMaeqYSUEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EBF3HzlAFciTdheF83e/1eXRxiduLLwv7xiG/VW0468UcO70fbmYmNr88vjefwNE/
	 SMaRjSDnRn/8dmgujdNwDVC87ZzyK0IgHEPPoOt9vl/zu/WKNWprM/nnTaqQ+DzQdC
	 6r4xE1FWm720uABImbWFlj94W0NKEPyvaCp9bhVEL2Fvz52Cuumv+7vq7+4wZo7mI3
	 Q4ltRD9xYxwqYw+ej/rSXoc9kfgTQE24MArka8C/bYrJvbNy0B41v0B/6V1WnSvrTb
	 FTHSo268/7veL8X3gOHnCl7KOzJeEIzUmq9YkYSm5/mBmsIOczTbcgbV9/xUm8WIWM
	 prX8q2XzQWUPw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 22/27] kconfig: add macros useful for hashtable
Date: Sat,  3 Feb 2024 00:58:20 +0900
Message-Id: <20240202155825.314567-23-masahiroy@kernel.org>
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

This is similar to include/linux/hashtable.h, but the implementation
has been simplified.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/hashtable.h | 48 +++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 scripts/kconfig/hashtable.h

diff --git a/scripts/kconfig/hashtable.h b/scripts/kconfig/hashtable.h
new file mode 100644
index 000000000000..71724800d178
--- /dev/null
+++ b/scripts/kconfig/hashtable.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef HASHTABLE_H
+#define HASHTABLE_H
+
+#include "array_size.h"
+#include "list.h"
+
+#define HASH_SIZE(name) (ARRAY_SIZE(name))
+
+#define HASHTABLE_DECLARE(name, size)		struct hlist_head name[size]
+
+#define HASHTABLE_DEFINE(name, size)						\
+	HASHTABLE_DECLARE(name, size) =						\
+			{ [0 ... ((size) - 1)] = HLIST_HEAD_INIT }
+
+#define hash_head(table, key)		(&(table)[(key) % HASH_SIZE(table)])
+
+/**
+ * hash_add - add an object to a hashtable
+ * @table: hashtable to add to
+ * @node: the &struct hlist_node of the object to be added
+ * @key: the key of the object to be added
+ */
+#define hash_add(table, node, key)						\
+	hlist_add_head(node, hash_head(table, key))
+
+/**
+ * hash_for_each - iterate over a hashtable
+ * @table: hashtable to iterate
+ * @obj: the type * to use as a loop cursor for each entry
+ * @member: the name of the hlist_node within the struct
+ */
+#define hash_for_each(table, obj, member)				\
+	for (int bkt = 0; bkt < HASH_SIZE(table); bkt++)		\
+		hlist_for_each_entry(obj, &table[bkt], member)
+
+/**
+ * hash_for_each_possible - iterate over all possible objects hashing to the
+ * same bucket
+ * @table: hashtable to iterate
+ * @obj: the type * to use as a loop cursor for each entry
+ * @member: the name of the hlist_node within the struct
+ * @key: the key of the objects to iterate over
+ */
+#define hash_for_each_possible(table, obj, member, key)			\
+	hlist_for_each_entry(obj, hash_head(table, key), member)
+
+#endif /* HASHTABLE_H */
-- 
2.40.1


