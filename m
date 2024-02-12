Return-Path: <linux-kernel+bounces-62479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D3585216C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF49284908
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DF64F20C;
	Mon, 12 Feb 2024 22:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fxisH7+Y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jBQ05rww";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fxisH7+Y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jBQ05rww"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9D74E1D2
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 22:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707776972; cv=none; b=IiKutnKoa7T+QOeMwbkITAb1u9trejw9FT2Yvd3ySDl6ZWkhRkQqM2uDaSuQ71T8ut47Ztkzl9xGOsTd+OJTyDAGhvi+RN5iZFg6M6QgYZBieeFvn8Poh5FXpnB7TIHCoFvGrB+zv4/oChbiSSAR///crVpFGh3bUKHEu3NgAe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707776972; c=relaxed/simple;
	bh=gNFCECv9ePcmxaUYUJiZyIxZAIAz5HmsoobEzrrMM3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sa1rHXjnS+nRm2p5hsUI9BuznGb3q7ewZi9W3Lt8q3GPQUxjQal8T9lGd40EgZdDWZoNqu0LmunFnDbZEF4mxM/xqKXIIKxeVnwTqaeKgzeB2E7tJGep2hZS5FqOjeSrriht4VGtYbggGBSPBb2IKRuEN8ua2Ti1+EhfGeMgjMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fxisH7+Y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jBQ05rww; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fxisH7+Y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jBQ05rww; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BB3B822177;
	Mon, 12 Feb 2024 22:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707776968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJDeumumoHSH5oo9xUAbNOW5Kp3HxNHVXVwRc820AXk=;
	b=fxisH7+Ywg+k3MLHTeypNE73ysJ51gHcpfkHzqy3ymHFJbJX/uV1avZt4d5LfFRP+Gk2R8
	UhDuSi+c1JSPl6b0CxwkUuFd+e26s2mCanskxmQbtGBrA8cwXd6Ut0I4Xcx16UlZHtim64
	sjp+JOIc0pJnwhoBvrw4KDnjGOCvQVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707776968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJDeumumoHSH5oo9xUAbNOW5Kp3HxNHVXVwRc820AXk=;
	b=jBQ05rwwCs72vdAdft1AuBuwuzSrKzDP73TbkM1+0nJRjhxw9YOi7rA+LeU2IMFi7vCkod
	wqJqqu+Eo9oTaRBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707776968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJDeumumoHSH5oo9xUAbNOW5Kp3HxNHVXVwRc820AXk=;
	b=fxisH7+Ywg+k3MLHTeypNE73ysJ51gHcpfkHzqy3ymHFJbJX/uV1avZt4d5LfFRP+Gk2R8
	UhDuSi+c1JSPl6b0CxwkUuFd+e26s2mCanskxmQbtGBrA8cwXd6Ut0I4Xcx16UlZHtim64
	sjp+JOIc0pJnwhoBvrw4KDnjGOCvQVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707776968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJDeumumoHSH5oo9xUAbNOW5Kp3HxNHVXVwRc820AXk=;
	b=jBQ05rwwCs72vdAdft1AuBuwuzSrKzDP73TbkM1+0nJRjhxw9YOi7rA+LeU2IMFi7vCkod
	wqJqqu+Eo9oTaRBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 82E9413212;
	Mon, 12 Feb 2024 22:29:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id CGxaE8ebymX5JgAAn2gu4w
	(envelope-from <osalvador@suse.de>); Mon, 12 Feb 2024 22:29:27 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v8 2/5] mm,page_owner: Implement the tracking of the stacks count
Date: Mon, 12 Feb 2024 23:30:26 +0100
Message-ID: <20240212223029.30769-3-osalvador@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212223029.30769-1-osalvador@suse.de>
References: <20240212223029.30769-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com,suse.de];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

page_owner needs to increment a stack_record refcount when a new allocation
occurs, and decrement it on a free operation.
In order to do that, we need to have a way to get a stack_record from a
handle.
Implement __stack_depot_get_stack_record() which just does that, and make
it public so page_owner can use it.

Also implement {inc,dec}_stack_record_count() which increments
or decrements on respective allocation and free operations, via
__reset_page_owner() (free operation) and __set_page_owner() (alloc
operation).

Traversing all stackdepot buckets comes with its own complexity,
plus we would have to implement a way to mark only those stack_records
that were originated from page_owner, as those are the ones we are
interested in.
For that reason, page_owner maintains its own list of stack_records,
because traversing that list is faster than traversing all buckets
while keeping at the same time a low complexity.
inc_stack_record_count() is responsible of adding new stack_records
into the list stack_list.

Modifications on the list are protected via a spinlock with irqs
disabled, since this code can also be reached from IRQ context.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/stackdepot.h |  9 +++++
 lib/stackdepot.c           |  8 +++++
 mm/page_owner.c            | 73 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index 90274860fd8e..f3c2162bf615 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -175,6 +175,15 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
 depot_stack_handle_t stack_depot_save(unsigned long *entries,
 				      unsigned int nr_entries, gfp_t gfp_flags);
 
+/**
+ * __stack_depot_get_stack_record - Get a pointer to a stack_record struct
+ * This function is only for internal purposes.
+ * @handle: Stack depot handle
+ *
+ * Return: Returns a pointer to a stack_record struct
+ */
+struct stack_record *__stack_depot_get_stack_record(depot_stack_handle_t handle);
+
 /**
  * stack_depot_fetch - Fetch a stack trace from stack depot
  *
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 6f9095374847..fdb09450a538 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -685,6 +685,14 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 }
 EXPORT_SYMBOL_GPL(stack_depot_save);
 
+struct stack_record *__stack_depot_get_stack_record(depot_stack_handle_t handle)
+{
+	if (!handle)
+		return NULL;
+
+	return depot_fetch_stack(handle);
+}
+
 unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 			       unsigned long **entries)
 {
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 5634e5d890f8..7d1b3f75cef3 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -36,6 +36,14 @@ struct page_owner {
 	pid_t free_tgid;
 };
 
+struct stack {
+	struct stack_record *stack_record;
+	struct stack *next;
+};
+
+static struct stack *stack_list;
+static DEFINE_SPINLOCK(stack_list_lock);
+
 static bool page_owner_enabled __initdata;
 DEFINE_STATIC_KEY_FALSE(page_owner_inited);
 
@@ -61,6 +69,57 @@ static __init bool need_page_owner(void)
 	return page_owner_enabled;
 }
 
+static void add_stack_record_to_list(struct stack_record *stack_record)
+{
+	unsigned long flags;
+	struct stack *stack;
+
+	stack = kmalloc(sizeof(*stack), GFP_KERNEL);
+	if (stack) {
+		stack->stack_record = stack_record;
+		stack->next = NULL;
+
+		spin_lock_irqsave(&stack_list_lock, flags);
+		if (!stack_list) {
+			stack_list = stack;
+		} else {
+			stack->next = stack_list;
+			stack_list = stack;
+		}
+		spin_unlock_irqrestore(&stack_list_lock, flags);
+	}
+}
+
+static void inc_stack_record_count(depot_stack_handle_t handle)
+{
+	struct stack_record *stack_record = __stack_depot_get_stack_record(handle);
+
+	if (stack_record) {
+		/*
+		 * New stack_record's that do not use STACK_DEPOT_FLAG_GET start
+		 * with REFCOUNT_SATURATED to catch spurious increments of their
+		 * refcount.
+		 * Since we do not use STACK_DEPOT_FLAG_{GET,PUT} API, let us
+		 * set a refcount of 1 ourselves.
+		 */
+		if (refcount_read(&stack_record->count) == REFCOUNT_SATURATED) {
+			refcount_set(&stack_record->count, 1);
+
+			/* Add the new stack_record to our list */
+			add_stack_record_to_list(stack_record);
+		}
+		refcount_inc(&stack_record->count);
+	}
+}
+
+static void dec_stack_record_count(depot_stack_handle_t handle)
+{
+	struct stack_record *stack_record = __stack_depot_get_stack_record(handle);
+
+	if (stack_record)
+		refcount_dec(&stack_record->count);
+}
+
 static __always_inline depot_stack_handle_t create_dummy_stack(void)
 {
 	unsigned long entries[4];
@@ -140,6 +199,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
 	int i;
 	struct page_ext *page_ext;
 	depot_stack_handle_t handle;
+	depot_stack_handle_t alloc_handle;
 	struct page_owner *page_owner;
 	u64 free_ts_nsec = local_clock();
 
@@ -147,6 +207,9 @@ void __reset_page_owner(struct page *page, unsigned short order)
 	if (unlikely(!page_ext))
 		return;
 
+	page_owner = get_page_owner(page_ext);
+	alloc_handle = page_owner->handle;
+
 	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
 	for (i = 0; i < (1 << order); i++) {
 		__clear_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
@@ -158,6 +221,15 @@ void __reset_page_owner(struct page *page, unsigned short order)
 		page_ext = page_ext_next(page_ext);
 	}
 	page_ext_put(page_ext);
+	if (alloc_handle != early_handle)
+		/*
+		 * early_handle is being set as a handle for all those
+		 * early allocated pages. See init_pages_in_zone().
+		 * Since their refcount is not being incremented because
+		 * the machinery is not ready yet, we cannot decrement
+		 * their refcount either.
+		 */
+		dec_stack_record_count(alloc_handle);
 }
 
 static inline void __set_page_owner_handle(struct page_ext *page_ext,
@@ -199,6 +271,7 @@ noinline void __set_page_owner(struct page *page, unsigned short order,
 		return;
 	__set_page_owner_handle(page_ext, handle, order, gfp_mask);
 	page_ext_put(page_ext);
+	inc_stack_record_count(handle);
 }
 
 void __set_page_owner_migrate_reason(struct page *page, int reason)
-- 
2.43.0


