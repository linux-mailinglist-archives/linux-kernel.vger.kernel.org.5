Return-Path: <linux-kernel+bounces-15296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DF78229DB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9BB1F23E6D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CF0182BB;
	Wed,  3 Jan 2024 09:02:58 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6617D182A9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91A63C15;
	Wed,  3 Jan 2024 01:03:41 -0800 (PST)
Received: from e126645.nice.arm.com (e126645.nice.arm.com [10.34.100.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 58FC83F7A6;
	Wed,  3 Jan 2024 01:02:54 -0800 (PST)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Pierre Gondois <pierre.gondois@arm.com>,
	Marco Elver <elver@google.com>,
	Kees Cook <keescook@chromium.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] list: Add hlist_count_nodes()
Date: Wed,  3 Jan 2024 10:02:38 +0100
Message-Id: <20240103090241.164817-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a function to count nodes in a hlist. hlist_count_nodes()
is similar to list_count_nodes().

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 include/linux/list.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/list.h b/include/linux/list.h
index 1837caedf723..0f1b1d4a2e2e 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -1175,4 +1175,19 @@ static inline void hlist_move_list(struct hlist_head *old,
 	     pos && ({ n = pos->member.next; 1; });			\
 	     pos = hlist_entry_safe(n, typeof(*pos), member))
 
+/**
+ * hlist_count_nodes - count nodes in the hlist
+ * @head:	the head for your hlist.
+ */
+static inline size_t hlist_count_nodes(struct hlist_head *head)
+{
+	struct hlist_node *pos;
+	size_t count = 0;
+
+	hlist_for_each(pos, head)
+		count++;
+
+	return count;
+}
+
 #endif
-- 
2.25.1


