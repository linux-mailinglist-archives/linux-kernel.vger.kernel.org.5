Return-Path: <linux-kernel+bounces-65604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F791854F62
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7E91B27E07
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CB960EE4;
	Wed, 14 Feb 2024 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EpHuBP6g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fCmFCy05";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EpHuBP6g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fCmFCy05"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7AA60DC8
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930061; cv=none; b=KbMx5ZNVAIuKvS+IY5DRKY7mYLixDRf8vvo3FlDJrcQtVCXCqG67ncEt9iaiENOC/YEeDpAsogUxh925t0hFvwV/9LI411zDdDZAcNi3/vb9L4WBQ9acoe3Zy7jigblhgbEPYgXsEZFHsloGTHjRG49zLws1JzHw8+DOV67nyMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930061; c=relaxed/simple;
	bh=r3gdID2+FZwKGXH7wclOgW4Lu9TNnCPm1g2kjvB1dio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mabLqnPO+tAl6EdBPXRiSyYvHyO3aq1OPo5jsaRG+4vlXr2zxuHugLUkc4lxEAvu975zrx7DVl0lFz6yPVKf5iJ5lhnf0+F7zNKJbP/eqMhBT8SlgnHciJN1s3pOiKkz0vXf7SACkONVENmBQ+imgerD5jBi1g0b6k84bWkuTyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EpHuBP6g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fCmFCy05; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EpHuBP6g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fCmFCy05; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 017141FD18;
	Wed, 14 Feb 2024 17:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707930058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UE3eKfl5kkI5fbvZQeYL5WioU57G5GzrnlK8ssFNQw4=;
	b=EpHuBP6glUCfx3TEAZSizbmIf9MU6xfQbSgNaV2UwXijSOS5Fy1blUiRDza1eJ8xpVSHWh
	BiZep5YNbbJTsqIb2LNty3m3UVqH5Mm+AVyQFFLv9tsNNzNO4l3ppN0E47RDJxKsCr9zQz
	sBYq+LYB7AOCPmw5RW3vjSDTlt7M5/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707930058;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UE3eKfl5kkI5fbvZQeYL5WioU57G5GzrnlK8ssFNQw4=;
	b=fCmFCy055XA4DUwbrXzHieNWBb5QQ3ODxy9PZ+pFHq7/1ZcJULtxR7NF16xAmFkf4tCUdt
	pDnnoetfjziN4XBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707930058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UE3eKfl5kkI5fbvZQeYL5WioU57G5GzrnlK8ssFNQw4=;
	b=EpHuBP6glUCfx3TEAZSizbmIf9MU6xfQbSgNaV2UwXijSOS5Fy1blUiRDza1eJ8xpVSHWh
	BiZep5YNbbJTsqIb2LNty3m3UVqH5Mm+AVyQFFLv9tsNNzNO4l3ppN0E47RDJxKsCr9zQz
	sBYq+LYB7AOCPmw5RW3vjSDTlt7M5/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707930058;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UE3eKfl5kkI5fbvZQeYL5WioU57G5GzrnlK8ssFNQw4=;
	b=fCmFCy055XA4DUwbrXzHieNWBb5QQ3ODxy9PZ+pFHq7/1ZcJULtxR7NF16xAmFkf4tCUdt
	pDnnoetfjziN4XBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 72D7F13A35;
	Wed, 14 Feb 2024 17:00:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id sIpWGcnxzGUfMwAAn2gu4w
	(envelope-from <osalvador@suse.de>); Wed, 14 Feb 2024 17:00:57 +0000
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
Subject: [PATCH v9 4/7] mm,page_owner: Implement the tracking of the stacks count
Date: Wed, 14 Feb 2024 18:01:54 +0100
Message-ID: <20240214170157.17530-5-osalvador@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214170157.17530-1-osalvador@suse.de>
References: <20240214170157.17530-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

Implement {inc,dec}_stack_record_count() which increments or
decrements on respective allocation and free operations, via
__reset_page_owner() (free operation) and __set_page_owner() (alloc
operation).
Newly allocated stack_record structs will be added to the list stack_list
via add_stack_record_to_list().
Modifications on the list are protected via a spinlock with irqs
disabled, since this code can also be reached from IRQ context.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Marco Elver <elver@google.com>
---
 mm/page_owner.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 33e342b15d9b..df6a923af5de 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -43,6 +43,7 @@ struct stack {
 static struct stack dummy_stack;
 static struct stack failure_stack;
 static struct stack *stack_list;
+static DEFINE_SPINLOCK(stack_list_lock);
 
 static bool page_owner_enabled __initdata;
 DEFINE_STATIC_KEY_FALSE(page_owner_inited);
@@ -150,11 +151,68 @@ static noinline depot_stack_handle_t save_stack(gfp_t flags)
 	return handle;
 }
 
+static void add_stack_record_to_list(struct stack_record *stack_record,
+				     gfp_t gfp_mask)
+{
+	unsigned long flags;
+	struct stack *stack;
+
+	/* Filter gfp_mask the same way stackdepot does, for consistency */
+	gfp_mask &= ~GFP_ZONEMASK;
+	gfp_mask &= (GFP_ATOMIC | GFP_KERNEL);
+	gfp_mask |= __GFP_NOWARN;
+
+	stack = kmalloc(sizeof(*stack), gfp_mask);
+	if (!stack)
+		return;
+
+	stack->stack_record = stack_record;
+	stack->next = NULL;
+
+	spin_lock_irqsave(&stack_list_lock, flags);
+	stack->next = stack_list;
+	stack_list = stack;
+	spin_unlock_irqrestore(&stack_list_lock, flags);
+}
+
+static void inc_stack_record_count(depot_stack_handle_t handle, gfp_t gfp_mask)
+{
+	struct stack_record *stack_record = __stack_depot_get_stack_record(handle);
+
+	if (!stack_record)
+		return;
+
+	/*
+	 * New stack_record's that do not use STACK_DEPOT_FLAG_GET start
+	 * with REFCOUNT_SATURATED to catch spurious increments of their
+	 * refcount.
+	 * Since we do not use STACK_DEPOT_FLAG_GET API, let us
+	 * set a refcount of 1 ourselves.
+	 */
+	if (refcount_read(&stack_record->count) == REFCOUNT_SATURATED) {
+		int old = REFCOUNT_SATURATED;
+
+		if (atomic_try_cmpxchg_relaxed(&stack_record->count.refs, &old, 1))
+			/* Add the new stack_record to our list */
+			add_stack_record_to_list(stack_record, gfp_mask);
+	}
+	refcount_inc(&stack_record->count);
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
 void __reset_page_owner(struct page *page, unsigned short order)
 {
 	int i;
 	struct page_ext *page_ext;
 	depot_stack_handle_t handle;
+	depot_stack_handle_t alloc_handle;
 	struct page_owner *page_owner;
 	u64 free_ts_nsec = local_clock();
 
@@ -162,17 +220,29 @@ void __reset_page_owner(struct page *page, unsigned short order)
 	if (unlikely(!page_ext))
 		return;
 
+	page_owner = get_page_owner(page_ext);
+	alloc_handle = page_owner->handle;
+
 	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
 	for (i = 0; i < (1 << order); i++) {
 		__clear_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
-		page_owner = get_page_owner(page_ext);
 		page_owner->free_handle = handle;
 		page_owner->free_ts_nsec = free_ts_nsec;
 		page_owner->free_pid = current->pid;
 		page_owner->free_tgid = current->tgid;
 		page_ext = page_ext_next(page_ext);
+		page_owner = get_page_owner(page_ext);
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
@@ -214,6 +284,7 @@ noinline void __set_page_owner(struct page *page, unsigned short order,
 		return;
 	__set_page_owner_handle(page_ext, handle, order, gfp_mask);
 	page_ext_put(page_ext);
+	inc_stack_record_count(handle, gfp_mask);
 }
 
 void __set_page_owner_migrate_reason(struct page *page, int reason)
-- 
2.43.0


