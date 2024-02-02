Return-Path: <linux-kernel+bounces-50080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 928CF8473FF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 069161F2277A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D901509BB;
	Fri,  2 Feb 2024 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b48Qze55"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEB01509A2;
	Fri,  2 Feb 2024 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889532; cv=none; b=Zc29EWufiwbkQ4Tspsnty2XzouPgYO18e2CH1980Eq+yvwrqyPvEZaPLo1jAIk4v3UQezwY3pgyF+j48gQNSNs1aHck0a+FOKw9oWzEjo+9KoFVPUqAToP7nfgH6F1Zp4+WL11FNQDIdqcFBNVCcsW3NmNJSOYw5MHSAUcq8vtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889532; c=relaxed/simple;
	bh=3UkbuV1BdSBeEq4498jv1YQWyekAl1uueQ2UBHUrDPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XkmkRz5tNLliQ1rOkwpHLQJHTv2hXG069cdaVfJsuCQU7ukhHOpj2pmhJ3Vks34FCGCPgYsEmgHkL1NWpPd8QwXkqVC7TCQADlbzwPgGMAzFl+L3kkQzjOqeIadFtTkruwJ8P7zLCo3ITMZRWJI/yRjfCiqq5N4xw6Uc7zvEQPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b48Qze55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1F4C43399;
	Fri,  2 Feb 2024 15:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706889532;
	bh=3UkbuV1BdSBeEq4498jv1YQWyekAl1uueQ2UBHUrDPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b48Qze55ui0AZMZDN8tdq1p44477owiSB94LCs/NNUhjwkhvi2bS+otpr7oq8u4ij
	 Lnzu5zW8M8V/JF7ilIatMHRzKbujx72Iszg8VmvFKQzgPnjAf/8LYSDBlYPCYXN6ZR
	 xUy9Bz8V9vImondApHcZHomvaRc0WUzES8KrtIOg8idxUefSb0OkO17UWMRylooKrs
	 MnbjBn0NmczTJYZATmCVhBelTf6OOEHP3auGicWFDPZ+Jkw+aWx9kjAQsX7qUg7/U4
	 Kc4GZn5Y80ej3cbbOLlqnwgRr8msbLfhOTBHcyETErPNJw1pUs/Lkvv/UDf7Ys78j3
	 60aAx0zEjkLtg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 20/27] kconfig: resync list.h
Date: Sat,  3 Feb 2024 00:58:18 +0900
Message-Id: <20240202155825.314567-21-masahiroy@kernel.org>
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

Update the existing macros and inline functions based on
include/linux/list.h.

The variable name '_new' can be reverted to 'new' because this header
is no longer included from the C++ file, scripts/kconfig/qconf.cc.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/list.h | 183 +++++++++++++++++++++++++++--------------
 1 file changed, 121 insertions(+), 62 deletions(-)

diff --git a/scripts/kconfig/list.h b/scripts/kconfig/list.h
index babed0baf4ae..2bce2b8f21d1 100644
--- a/scripts/kconfig/list.h
+++ b/scripts/kconfig/list.h
@@ -2,25 +2,39 @@
 #ifndef LIST_H
 #define LIST_H
 
+#include <stddef.h>
+
 #include "list_types.h"
 
-/*
- * Copied from include/linux/...
- */
-
-#undef offsetof
-#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
+/* Are two types/vars the same type (ignoring qualifiers)? */
+#define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
 
 /**
  * container_of - cast a member of a structure out to the containing structure
- * @ptr:        the pointer to the member.
- * @type:       the type of the container struct this is embedded in.
- * @member:     the name of the member within the struct.
+ * @ptr:	the pointer to the member.
+ * @type:	the type of the container struct this is embedded in.
+ * @member:	the name of the member within the struct.
  *
  */
-#define container_of(ptr, type, member) ({                      \
-	const typeof( ((type *)0)->member ) *__mptr = (ptr);    \
-	(type *)( (char *)__mptr - offsetof(type,member) );})
+#define container_of(ptr, type, member) ({				\
+	void *__mptr = (void *)(ptr);					\
+	_Static_assert(__same_type(*(ptr), ((type *)0)->member) ||	\
+		      __same_type(*(ptr), void),			\
+		      "pointer type mismatch in container_of()");	\
+	((type *)(__mptr - offsetof(type, member))); })
+
+#define LIST_POISON1  ((void *) 0x100)
+#define LIST_POISON2  ((void *) 0x122)
+
+/*
+ * Circular doubly linked list implementation.
+ *
+ * Some of the internal functions ("__xxx") are useful when
+ * manipulating whole lists rather than single entries, as
+ * sometimes we already know the next/prev entries and we can
+ * generate better code by using them directly rather than
+ * using the generic single-entry routines.
+ */
 
 #define LIST_HEAD_INIT(name) { &(name), &(name) }
 
@@ -28,45 +42,16 @@
 	struct list_head name = LIST_HEAD_INIT(name)
 
 /**
- * list_entry - get the struct for this entry
- * @ptr:	the &struct list_head pointer.
- * @type:	the type of the struct this is embedded in.
- * @member:	the name of the list_head within the struct.
+ * INIT_LIST_HEAD - Initialize a list_head structure
+ * @list: list_head structure to be initialized.
+ *
+ * Initializes the list_head to point to itself.  If it is a list header,
+ * the result is an empty list.
  */
-#define list_entry(ptr, type, member) \
-	container_of(ptr, type, member)
-
-/**
- * list_for_each_entry	-	iterate over list of given type
- * @pos:	the type * to use as a loop cursor.
- * @head:	the head for your list.
- * @member:	the name of the list_head within the struct.
- */
-#define list_for_each_entry(pos, head, member)				\
-	for (pos = list_entry((head)->next, typeof(*pos), member);	\
-	     &pos->member != (head); 	\
-	     pos = list_entry(pos->member.next, typeof(*pos), member))
-
-/**
- * list_for_each_entry_safe - iterate over list of given type safe against removal of list entry
- * @pos:	the type * to use as a loop cursor.
- * @n:		another type * to use as temporary storage
- * @head:	the head for your list.
- * @member:	the name of the list_head within the struct.
- */
-#define list_for_each_entry_safe(pos, n, head, member)			\
-	for (pos = list_entry((head)->next, typeof(*pos), member),	\
-		n = list_entry(pos->member.next, typeof(*pos), member);	\
-	     &pos->member != (head);					\
-	     pos = n, n = list_entry(n->member.next, typeof(*n), member))
-
-/**
- * list_empty - tests whether a list is empty
- * @head: the list to test.
- */
-static inline int list_empty(const struct list_head *head)
+static inline void INIT_LIST_HEAD(struct list_head *list)
 {
-	return head->next == head;
+	list->next = list;
+	list->prev = list;
 }
 
 /*
@@ -75,14 +60,14 @@ static inline int list_empty(const struct list_head *head)
  * This is only for internal list manipulation where we know
  * the prev/next entries already!
  */
-static inline void __list_add(struct list_head *_new,
+static inline void __list_add(struct list_head *new,
 			      struct list_head *prev,
 			      struct list_head *next)
 {
-	next->prev = _new;
-	_new->next = next;
-	_new->prev = prev;
-	prev->next = _new;
+	next->prev = new;
+	new->next = next;
+	new->prev = prev;
+	prev->next = new;
 }
 
 /**
@@ -93,9 +78,9 @@ static inline void __list_add(struct list_head *_new,
  * Insert a new entry before the specified head.
  * This is useful for implementing queues.
  */
-static inline void list_add_tail(struct list_head *_new, struct list_head *head)
+static inline void list_add_tail(struct list_head *new, struct list_head *head)
 {
-	__list_add(_new, head->prev, head);
+	__list_add(new, head->prev, head);
 }
 
 /*
@@ -111,8 +96,11 @@ static inline void __list_del(struct list_head *prev, struct list_head *next)
 	prev->next = next;
 }
 
-#define LIST_POISON1  ((void *) 0x00100100)
-#define LIST_POISON2  ((void *) 0x00200200)
+static inline void __list_del_entry(struct list_head *entry)
+{
+	__list_del(entry->prev, entry->next);
+}
+
 /**
  * list_del - deletes entry from list.
  * @entry: the element to delete from the list.
@@ -121,8 +109,79 @@ static inline void __list_del(struct list_head *prev, struct list_head *next)
  */
 static inline void list_del(struct list_head *entry)
 {
-	__list_del(entry->prev, entry->next);
-	entry->next = (struct list_head*)LIST_POISON1;
-	entry->prev = (struct list_head*)LIST_POISON2;
+	__list_del_entry(entry);
+	entry->next = LIST_POISON1;
+	entry->prev = LIST_POISON2;
 }
-#endif
+
+/**
+ * list_empty - tests whether a list is empty
+ * @head: the list to test.
+ */
+static inline int list_empty(const struct list_head *head)
+{
+	return head->next == head;
+}
+
+/**
+ * list_entry - get the struct for this entry
+ * @ptr:	the &struct list_head pointer.
+ * @type:	the type of the struct this is embedded in.
+ * @member:	the name of the list_head within the struct.
+ */
+#define list_entry(ptr, type, member) \
+	container_of(ptr, type, member)
+
+/**
+ * list_first_entry - get the first element from a list
+ * @ptr:	the list head to take the element from.
+ * @type:	the type of the struct this is embedded in.
+ * @member:	the name of the list_head within the struct.
+ *
+ * Note, that list is expected to be not empty.
+ */
+#define list_first_entry(ptr, type, member) \
+	list_entry((ptr)->next, type, member)
+
+/**
+ * list_next_entry - get the next element in list
+ * @pos:	the type * to cursor
+ * @member:	the name of the list_head within the struct.
+ */
+#define list_next_entry(pos, member) \
+	list_entry((pos)->member.next, typeof(*(pos)), member)
+
+/**
+ * list_entry_is_head - test if the entry points to the head of the list
+ * @pos:	the type * to cursor
+ * @head:	the head for your list.
+ * @member:	the name of the list_head within the struct.
+ */
+#define list_entry_is_head(pos, head, member)				\
+	(&pos->member == (head))
+
+/**
+ * list_for_each_entry - iterate over list of given type
+ * @pos:	the type * to use as a loop cursor.
+ * @head:	the head for your list.
+ * @member:	the name of the list_head within the struct.
+ */
+#define list_for_each_entry(pos, head, member)				\
+	for (pos = list_first_entry(head, typeof(*pos), member);	\
+	     !list_entry_is_head(pos, head, member);			\
+	     pos = list_next_entry(pos, member))
+
+/**
+ * list_for_each_entry_safe - iterate over list of given type. Safe against removal of list entry
+ * @pos:	the type * to use as a loop cursor.
+ * @n:		another type * to use as temporary storage
+ * @head:	the head for your list.
+ * @member:	the name of the list_head within the struct.
+ */
+#define list_for_each_entry_safe(pos, n, head, member)			\
+	for (pos = list_first_entry(head, typeof(*pos), member),	\
+		n = list_next_entry(pos, member);			\
+	     !list_entry_is_head(pos, head, member);			\
+	     pos = n, n = list_next_entry(n, member))
+
+#endif /* LIST_H */
-- 
2.40.1


