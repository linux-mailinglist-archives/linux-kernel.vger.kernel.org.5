Return-Path: <linux-kernel+bounces-98260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8938B87778F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 17:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC256B21070
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 16:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4031D39ACB;
	Sun, 10 Mar 2024 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5Rugcrt"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6833985A
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 16:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710087593; cv=none; b=RG041atkeb44atw4OuGfa6bExUyOJpYeP2DpNUt/fX1oLdFLzYkszVy25Xh1E5HvzhJmxcvLjNHjVle1iS4EiXQ+IOPNksKleUwkb+Lrn4H9VOzmtR0BcZjjB5sYsWlhMvJ3RBlrGqN2Hd7mTm8ZrI01QbvgfGILfaGkvBV+MJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710087593; c=relaxed/simple;
	bh=J5acmMsD54oYTnHuEQfnt9oSFMxN+SahVQsAnU4lXF4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T/YA4DeVg4YuYPRu7xfja+SGgTroLrO/8iW+dYYUqTXCDvs+RXnbd56BicYnDdJPO0oWQp5MlwUrz34hxrtkitxCv+reGkr0E4JTlSOVLce1VPTGsn1t91e2IPLuQAamGN+r0Bwc+FsXo6qeywlqIiT1LBOJdAmusjmbtgdVHo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5Rugcrt; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dd6d4832dcso2707305ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 09:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710087590; x=1710692390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=851j3vfRHp84OK606+bgekYXQPhzWJ9JsgIZlL8TxvE=;
        b=Q5RugcrtbOVDJmf/L2996JNadfLPq7h74l4xMOkjeoRvW70SJFbWiKzLW0oa9a85Cn
         XZToiBSDYWZLkYCX3StgpOwFk9Kcn4CwYO6CVwlwKKqS9rLffyDujOVh1rWDU8MOqoUC
         872jQz7rRR2PKWkHG2en/8BU6VvjMSOvkqYCQaaUamng/coxrpHs3m3N8PsmEdGz37jU
         xIfPuoYNqeputotkXioqG+NJ4/26pgPKIXbPiUxybP/YGc1pk+IIfrOkyX1u0CTbtWqg
         VD5FhsEbDaAouVNbiq3mBfY4LYG0N345IH+UlUNG7SVG/oiS2SqgribNspZiqakBKhcS
         NfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710087590; x=1710692390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=851j3vfRHp84OK606+bgekYXQPhzWJ9JsgIZlL8TxvE=;
        b=nozJ+dRLxFTne3EfaGuD54XuNxhFpH294eFyrufzVFWSR1GXBijcDYi5WHR+Bw0Bh8
         Y733mTcIuT/D0x+2iCXNGtdsEjp9YgBhOr7E6TaDWkbj5cKelZ5edfQOf7jRHkeobion
         kSbbBBjmV4QxyjuYGKVfwKKqoXsB7U4hQkp2T14Y/VNY0VegEfNDHqUxFZezHnngt7HT
         WDYBlpwh3x7CAabIpOcYfFm8GVM+v/OGMEZfeHTo1yrXbSn6ubORNPgfvb4x5BFTVEw/
         E9PLccONPr6Jq+C/u0W/n4RvtViTHv7+M2QL0JZwzW5jx2/tYzI7MJ0tpjXVE4plI92k
         zwFQ==
X-Gm-Message-State: AOJu0YwgGSxNrONcvlPvOTsu6o0DA5yHmgj9NJzj17QDpvy0+kO0Jk/H
	QMFbWgHvxnwJaQeipq80Ghfy2F9TKQDBqHvDj/c4JCp4RS+WGMC6MfRE1EdIqyA=
X-Google-Smtp-Source: AGHT+IFztDrUp3uO/wqSJz3ILSXojHNKoB/jEAqCMqRTtRX+qnxA6EtO7N8xZ/2ETfOXO695G2yTbg==
X-Received: by 2002:a05:6a20:d90b:b0:1a1:44f9:feeb with SMTP id jd11-20020a056a20d90b00b001a144f9feebmr5717742pzb.3.1710087590454;
        Sun, 10 Mar 2024 09:19:50 -0700 (PDT)
Received: from vaxr-BM6660-BM6360.. ([2001:288:7001:2703:b932:8fbf:e860:5e2b])
        by smtp.gmail.com with ESMTPSA id cv8-20020a17090afd0800b0029bcf62e296sm2165608pjb.42.2024.03.10.09.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 09:19:49 -0700 (PDT)
From: I-HSIN CHENG <richard120310@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: I-HSIN CHENG <richard120310@gmail.com>
Subject: [PATCH] <linux/list.h>: Correct comments for list_del()
Date: Mon, 11 Mar 2024 00:19:30 +0800
Message-Id: <20240310161930.226784-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Orginal comments for the function list_del() and other related
functions all described the entry to be removed from the list as
"delete", such as __list_del() , list_del_init() and so on.

However the usage of "delete" in the comments of those functions is
misleading. "Delete" means erase, while "remove" means take away and set
aside. We do not perform any operations to erase the memory location or
any content in the entry in those functions mentioned above, we simply
"removes" the entry from the list, that is why "remove" is a correct
and more preferred word for the description in the comments for the
function list_del() and its related functions.

Signed-off-by: I-HSIN CHENG <richard120310@gmail.com>
---
 include/linux/list.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index 164b4d0e9..aefd111a6 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -184,7 +184,7 @@ static inline void list_add_tail(struct list_head *new, struct list_head *head)
 }
 
 /*
- * Delete a list entry by making the prev/next entries
+ * Remove a list entry by making the prev/next entries
  * point to each other.
  *
  * This is only for internal list manipulation where we know
@@ -197,7 +197,7 @@ static inline void __list_del(struct list_head * prev, struct list_head * next)
 }
 
 /*
- * Delete a list entry and clear the 'prev' pointer.
+ * Remove a list entry and clear the 'prev' pointer.
  *
  * This is a special-purpose list clearing method used in the networking code
  * for lists allocated as per-cpu, where we don't want to incur the extra
@@ -219,8 +219,8 @@ static inline void __list_del_entry(struct list_head *entry)
 }
 
 /**
- * list_del - deletes entry from list.
- * @entry: the element to delete from the list.
+ * list_del - removes entry from list.
+ * @entry: the element to remove from the list.
  * Note: list_empty() on entry does not return true after this, the entry is
  * in an undefined state.
  */
@@ -279,8 +279,8 @@ static inline void list_swap(struct list_head *entry1,
 }
 
 /**
- * list_del_init - deletes entry from list and reinitialize it.
- * @entry: the element to delete from the list.
+ * list_del_init - removes entry from list and reinitialize it.
+ * @entry: the element to remove from the list.
  */
 static inline void list_del_init(struct list_head *entry)
 {
@@ -289,7 +289,7 @@ static inline void list_del_init(struct list_head *entry)
 }
 
 /**
- * list_move - delete from one list and add as another's head
+ * list_move - remove from one list and add as another's head
  * @list: the entry to move
  * @head: the head that will precede our entry
  */
@@ -300,7 +300,7 @@ static inline void list_move(struct list_head *list, struct list_head *head)
 }
 
 /**
- * list_move_tail - delete from one list and add as another's tail
+ * list_move_tail - remove from one list and add as another's tail
  * @list: the entry to move
  * @head: the head that will follow our entry
  */
@@ -374,7 +374,7 @@ static inline int list_empty(const struct list_head *head)
 }
 
 /**
- * list_del_init_careful - deletes entry from list and reinitialize it.
+ * list_del_init_careful - removes entry from list and reinitialize it.
  * @entry: the element to delete from the list.
  *
  * This is the same as list_del_init(), except designed to be used
@@ -983,8 +983,8 @@ static inline void __hlist_del(struct hlist_node *n)
 }
 
 /**
- * hlist_del - Delete the specified hlist_node from its list
- * @n: Node to delete.
+ * hlist_del - Remove the specified hlist_node from its list
+ * @n: Node to remove.
  *
  * Note that this function leaves the node in hashed state.  Use
  * hlist_del_init() or similar instead to unhash @n.
@@ -997,8 +997,8 @@ static inline void hlist_del(struct hlist_node *n)
 }
 
 /**
- * hlist_del_init - Delete the specified hlist_node from its list and initialize
- * @n: Node to delete.
+ * hlist_del_init - Remove the specified hlist_node from its list and initialize
+ * @n: Node to remove.
  *
  * Note that this function leaves the node in unhashed state.
  */
-- 
2.34.1


