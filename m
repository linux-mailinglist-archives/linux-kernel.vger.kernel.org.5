Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF747820A1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 00:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjHTWsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 18:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjHTWsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 18:48:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB389D;
        Sun, 20 Aug 2023 15:48:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7D6960AF2;
        Sun, 20 Aug 2023 22:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7F0C433C7;
        Sun, 20 Aug 2023 22:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692571685;
        bh=JN73pTS3ZRKgTEIXsF+IbODrn07EawwkrFb8emYRdrA=;
        h=From:To:Cc:Subject:Date:From;
        b=AzSnGIZmmkbQrOAXXHRqm4C+jft4uCeqWQr/R0PAn8gfxGvjmvrztg4/YFxFMkaX8
         sp5n2CVE4+4hmTF69WpCE3adbfxAa/RGqDoutRLWgZ2WcRQYlc57um4lim4iyLv4Wt
         P+VqVxwRBPNKZ2vSVmgTCksdZT3YQpHIZDVf4gVl9uiVJAJNGTXM0JNjUX0NaQYvT4
         Un9arLhGUvYUXMwi+ajXSb2fT7AGudGlOwPftugV5D8gMV/rU2twRUAPQRYIuNgPwm
         BerTeAIMf/j9N2PvegbV0Qtaw0FOMhxz8tgXHg8LznVWK+K+VYdkPfaYVKwW5UqCj6
         yi/s36qbPpYBw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] kbuild: merge list.h in modpost and kconfig
Date:   Mon, 21 Aug 2023 07:48:00 +0900
Message-Id: <20230820224800.3905291-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move scripts/mod/list.h to scripts/include/list.h and remove
scripts/kconfig/list.h. This removes the code duplication between
scripts/mod/list.h and scripts/kconfig/list.h.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile                        |   2 +-
 scripts/{mod => include}/list.h |   0
 scripts/kconfig/expr.h          |   3 +-
 scripts/kconfig/list.h          | 132 --------------------------------
 scripts/kconfig/preprocess.c    |   2 +-
 scripts/mod/modpost.h           |   2 +-
 6 files changed, 5 insertions(+), 136 deletions(-)
 rename scripts/{mod => include}/list.h (100%)
 delete mode 100644 scripts/kconfig/list.h

diff --git a/Makefile b/Makefile
index 4382cdb38fba..5434e093d086 100644
--- a/Makefile
+++ b/Makefile
@@ -469,7 +469,7 @@ export rust_common_flags := --edition=2021 \
 			    -Dclippy::needless_continue \
 			    -Wclippy::dbg_macro
 
-KBUILD_HOSTCFLAGS   := $(KBUILD_USERHOSTCFLAGS) $(HOST_LFS_CFLAGS) $(HOSTCFLAGS)
+KBUILD_HOSTCFLAGS   := $(KBUILD_USERHOSTCFLAGS) $(HOST_LFS_CFLAGS) $(HOSTCFLAGS) -I $(srctree)/scripts/include
 KBUILD_HOSTCXXFLAGS := -Wall -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
 KBUILD_HOSTRUSTFLAGS := $(rust_common_flags) -O -Cstrip=debuginfo \
 			-Zallow-features= $(HOSTRUSTFLAGS)
diff --git a/scripts/mod/list.h b/scripts/include/list.h
similarity index 100%
rename from scripts/mod/list.h
rename to scripts/include/list.h
diff --git a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
index 4a9a23b1b7e1..8f46c079fa98 100644
--- a/scripts/kconfig/expr.h
+++ b/scripts/kconfig/expr.h
@@ -12,11 +12,12 @@ extern "C" {
 
 #include <assert.h>
 #include <stdio.h>
-#include "list.h"
 #ifndef __cplusplus
 #include <stdbool.h>
 #endif
 
+#include <list.h>
+
 struct file {
 	struct file *next;
 	struct file *parent;
diff --git a/scripts/kconfig/list.h b/scripts/kconfig/list.h
deleted file mode 100644
index 45cb237ab7ef..000000000000
--- a/scripts/kconfig/list.h
+++ /dev/null
@@ -1,132 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef LIST_H
-#define LIST_H
-
-/*
- * Copied from include/linux/...
- */
-
-#undef offsetof
-#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
-
-/**
- * container_of - cast a member of a structure out to the containing structure
- * @ptr:        the pointer to the member.
- * @type:       the type of the container struct this is embedded in.
- * @member:     the name of the member within the struct.
- *
- */
-#define container_of(ptr, type, member) ({                      \
-	const typeof( ((type *)0)->member ) *__mptr = (ptr);    \
-	(type *)( (char *)__mptr - offsetof(type,member) );})
-
-
-struct list_head {
-	struct list_head *next, *prev;
-};
-
-
-#define LIST_HEAD_INIT(name) { &(name), &(name) }
-
-#define LIST_HEAD(name) \
-	struct list_head name = LIST_HEAD_INIT(name)
-
-/**
- * list_entry - get the struct for this entry
- * @ptr:	the &struct list_head pointer.
- * @type:	the type of the struct this is embedded in.
- * @member:	the name of the list_head within the struct.
- */
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
-{
-	return head->next == head;
-}
-
-/*
- * Insert a new entry between two known consecutive entries.
- *
- * This is only for internal list manipulation where we know
- * the prev/next entries already!
- */
-static inline void __list_add(struct list_head *_new,
-			      struct list_head *prev,
-			      struct list_head *next)
-{
-	next->prev = _new;
-	_new->next = next;
-	_new->prev = prev;
-	prev->next = _new;
-}
-
-/**
- * list_add_tail - add a new entry
- * @new: new entry to be added
- * @head: list head to add it before
- *
- * Insert a new entry before the specified head.
- * This is useful for implementing queues.
- */
-static inline void list_add_tail(struct list_head *_new, struct list_head *head)
-{
-	__list_add(_new, head->prev, head);
-}
-
-/*
- * Delete a list entry by making the prev/next entries
- * point to each other.
- *
- * This is only for internal list manipulation where we know
- * the prev/next entries already!
- */
-static inline void __list_del(struct list_head *prev, struct list_head *next)
-{
-	next->prev = prev;
-	prev->next = next;
-}
-
-#define LIST_POISON1  ((void *) 0x00100100)
-#define LIST_POISON2  ((void *) 0x00200200)
-/**
- * list_del - deletes entry from list.
- * @entry: the element to delete from the list.
- * Note: list_empty() on entry does not return true after this, the entry is
- * in an undefined state.
- */
-static inline void list_del(struct list_head *entry)
-{
-	__list_del(entry->prev, entry->next);
-	entry->next = (struct list_head*)LIST_POISON1;
-	entry->prev = (struct list_head*)LIST_POISON2;
-}
-#endif
diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
index 748da578b418..cc2d5d26185d 100644
--- a/scripts/kconfig/preprocess.c
+++ b/scripts/kconfig/preprocess.c
@@ -9,7 +9,7 @@
 #include <stdlib.h>
 #include <string.h>
 
-#include "list.h"
+#include <list.h>
 #include "lkc.h"
 
 #define ARRAY_SIZE(arr)		(sizeof(arr) / sizeof((arr)[0]))
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 5f94c2c9f2d9..4ebc053cc68f 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -11,7 +11,7 @@
 #include <unistd.h>
 #include <elf.h>
 
-#include "list.h"
+#include <list.h>
 #include "elfconfig.h"
 
 /* On BSD-alike OSes elf.h defines these according to host's word size */
-- 
2.39.2

