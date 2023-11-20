Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84E87F0DCD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjKTInU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjKTInR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:43:17 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123C4A4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:43:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A23E2218EA;
        Mon, 20 Nov 2023 08:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700469791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MGpg1D+QkOzBj9HvH6Pm0yN+PlTUNsrk3hG0zRKlbo0=;
        b=I2B+KXB0e9Z8ba/sISmr7L1ZKTOJNxenGu9vqCIQj6M7fRTZftawKFLK4iEL8j5xND0rdf
        FE99H50tlrN3e4sKT2JKUpEOL9Hk8MzDeOwGBI9689VKXtifZUalbA1rd0lQdVAvZu+9oi
        lPd0IiBuPwkSK6eJv6UDXx53+W0mUlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700469791;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MGpg1D+QkOzBj9HvH6Pm0yN+PlTUNsrk3hG0zRKlbo0=;
        b=kFHm8z2IL7kLEdY1UWV1ldcG4z+LFZcCdrWBKgAyr8a324wFwRAr5+772aJ5JFlZVKf0It
        09G4NT9vwC+18jDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E420F13912;
        Mon, 20 Nov 2023 08:43:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qFTTNB4cW2U3VgAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 20 Nov 2023 08:43:10 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Alexander Potapenko <glider@google.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v6 1/4] lib/stackdepot: Add a refcount field in stack_record
Date:   Mon, 20 Nov 2023 09:42:57 +0100
Message-Id: <20231120084300.4368-2-osalvador@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231120084300.4368-1-osalvador@suse.de>
References: <20231120084300.4368-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Score: 9.30
X-Spamd-Result: default: False [9.30 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_SPAM(5.10)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         MIME_GOOD(-0.10)[text/plain];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         REPLY(-4.00)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-0.999];
         NEURAL_SPAM_LONG(3.50)[1.000];
         RCPT_COUNT_TWELVE(0.00)[12];
         MID_CONTAINS_FROM(1.00)[];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,suse.cz,redhat.com,google.com,gmail.com,suse.de];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to filter out the page_owner output and print only those
stacks for which their counter (number of outstanding allocations) goes
beyond a certain threshold.
This gives us the chance to get rid of a lot of noise.
In order to do that, we need to know how many outstanding allocations
with a particular stack (for allocation) do we have, so we add a new
refcount_t field in the stack_record struct.

Note that this might increase the size of the struct for some
architectures.
E.g: x86_64 is not affected due to alignment, but x86 32bits might.

Besides adding the refcount, this patch also introduces
stack_depot_{inc,dec}_count for the allocation/free handle.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/stackdepot.h |  2 ++
 lib/stackdepot.c           | 53 +++++++++++++++++++++++++++++++-------
 mm/page_owner.c            |  6 +++++
 3 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index e58306783d8e..6ba4fcdb0c5f 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -94,6 +94,8 @@ static inline int stack_depot_early_init(void)	{ return 0; }
 depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 					unsigned int nr_entries,
 					gfp_t gfp_flags, bool can_alloc);
+void stack_depot_inc_count(depot_stack_handle_t handle);
+void stack_depot_dec_count(depot_stack_handle_t handle);
 
 /**
  * stack_depot_save - Save a stack trace to stack depot
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 2f5aa851834e..d35edac430c4 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -60,6 +60,7 @@ struct stack_record {
 	u32 hash;			/* Hash in the hash table */
 	u32 size;			/* Number of stored frames */
 	union handle_parts handle;
+	refcount_t count;		/* Number of the same repeated stacks */
 	unsigned long entries[];	/* Variable-sized array of frames */
 };
 
@@ -305,6 +306,7 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 	stack->handle.offset = pool_offset >> DEPOT_STACK_ALIGN;
 	stack->handle.valid = 1;
 	stack->handle.extra = 0;
+	refcount_set(&stack->count, 1);
 	memcpy(stack->entries, entries, flex_array_size(stack, entries, size));
 	pool_offset += required_size;
 	/*
@@ -457,8 +459,7 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 }
 EXPORT_SYMBOL_GPL(stack_depot_save);
 
-unsigned int stack_depot_fetch(depot_stack_handle_t handle,
-			       unsigned long **entries)
+static struct stack_record *stack_depot_getstack(depot_stack_handle_t handle)
 {
 	union handle_parts parts = { .handle = handle };
 	/*
@@ -470,6 +471,26 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 	size_t offset = parts.offset << DEPOT_STACK_ALIGN;
 	struct stack_record *stack;
 
+	if (!handle)
+		return NULL;
+
+	if (parts.pool_index > pool_index_cached) {
+		WARN(1, "pool index %d out of bounds (%d) for stack id %08x\n",
+		     parts.pool_index, pool_index_cached, handle);
+		return NULL;
+	}
+	pool = stack_pools[parts.pool_index];
+	if (!pool)
+		return NULL;
+	stack = pool + offset;
+	return stack;
+}
+
+unsigned int stack_depot_fetch(depot_stack_handle_t handle,
+			       unsigned long **entries)
+{
+	struct stack_record *stack;
+
 	*entries = NULL;
 	/*
 	 * Let KMSAN know *entries is initialized. This shall prevent false
@@ -480,21 +501,33 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 	if (!handle)
 		return 0;
 
-	if (parts.pool_index > pool_index_cached) {
-		WARN(1, "pool index %d out of bounds (%d) for stack id %08x\n",
-			parts.pool_index, pool_index_cached, handle);
-		return 0;
-	}
-	pool = stack_pools[parts.pool_index];
-	if (!pool)
+	stack = stack_depot_getstack(handle);
+	if (!stack)
 		return 0;
-	stack = pool + offset;
 
 	*entries = stack->entries;
 	return stack->size;
 }
 EXPORT_SYMBOL_GPL(stack_depot_fetch);
 
+void stack_depot_inc_count(depot_stack_handle_t handle)
+{
+	struct stack_record *stack = NULL;
+
+	stack = stack_depot_getstack(handle);
+	if (stack)
+		refcount_inc(&stack->count);
+}
+
+void stack_depot_dec_count(depot_stack_handle_t handle)
+{
+	struct stack_record *stack = NULL;
+
+	stack = stack_depot_getstack(handle);
+	if (stack)
+		refcount_dec(&stack->count);
+}
+
 void stack_depot_print(depot_stack_handle_t stack)
 {
 	unsigned long *entries;
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 4f13ce7d2452..d53316d0d9be 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -139,6 +139,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
 	int i;
 	struct page_ext *page_ext;
 	depot_stack_handle_t handle;
+	depot_stack_handle_t alloc_handle;
 	struct page_owner *page_owner;
 	u64 free_ts_nsec = local_clock();
 
@@ -146,6 +147,9 @@ void __reset_page_owner(struct page *page, unsigned short order)
 	if (unlikely(!page_ext))
 		return;
 
+	page_owner = get_page_owner(page_ext);
+	alloc_handle = page_owner->handle;
+
 	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
 	for (i = 0; i < (1 << order); i++) {
 		__clear_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
@@ -155,6 +159,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
 		page_ext = page_ext_next(page_ext);
 	}
 	page_ext_put(page_ext);
+	stack_depot_dec_count(alloc_handle);
 }
 
 static inline void __set_page_owner_handle(struct page_ext *page_ext,
@@ -196,6 +201,7 @@ noinline void __set_page_owner(struct page *page, unsigned short order,
 		return;
 	__set_page_owner_handle(page_ext, handle, order, gfp_mask);
 	page_ext_put(page_ext);
+	stack_depot_inc_count(handle);
 }
 
 void __set_page_owner_migrate_reason(struct page *page, int reason)
-- 
2.42.0

