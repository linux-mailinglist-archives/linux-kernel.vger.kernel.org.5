Return-Path: <linux-kernel+bounces-118410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C673988BA6A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54CC42A253E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EC2132C37;
	Tue, 26 Mar 2024 06:29:26 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7AA130AD3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 06:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434565; cv=none; b=SMKtGrNvfH7ZMFSz6cs/9RLqNZLsHGXfrezeevwtGe+z9GImyW1CXlJpeqj6U+6ymxWJ/O6EhHlz7lC0uATyLymy6wBV779EXVwkvWlL0mpPA4Q4fZvYIg8vT9yT8ssVAmOrhsSxCKwKqBksIGRJ5oa5AY0ScYfLNL7VzOYthbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434565; c=relaxed/simple;
	bh=4bilCE0ag76FbZ9infqppWcstVqGD8KBZfFu2eapSD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nk+SY3X2bzK9A3b31FyOPh5ripTvnILObKhcvN0hRFc8AUKShYYeMSlcbLRn90N1MVaVn5Wj2fbjwe/8vi6wBf0JFSvoCOt9jq6NCX+zVNZFK81CSHKee0yfM3fqIqu79c3EiwrFcDXDA9JJR3ISEpa8+gUNohmXn2yxFN+DWlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8622D5D1CD;
	Tue, 26 Mar 2024 06:29:16 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 067E413215;
	Tue, 26 Mar 2024 06:29:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id MKx6OjtrAmY2YQAAn2gu4w
	(envelope-from <osalvador@suse.de>); Tue, 26 Mar 2024 06:29:15 +0000
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
Subject: [PATCH v3 1/3] mm,page_owner: Update metada for tail pages
Date: Tue, 26 Mar 2024 07:30:34 +0100
Message-ID: <20240326063036.6242-2-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326063036.6242-1-osalvador@suse.de>
References: <20240326063036.6242-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.00
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Queue-Id: 8622D5D1CD

__set_page_owner_handle() and __reset_page_owner() update the metadata
of all pages when the page is of a higher-order, but we miss to do the
same when the pages are migrated.
__folio_copy_owner() only updates the metadata of the head page, meaning
that the information stored in the first page and the tail pages will not
match.

Strictly speaking that is not a big problem because 1) we do not print
tail pages and 2) upon splitting all tail pages will inherit the
metada of the head page, but it is better to have all metadata in check
should there be any problem, so it can ease debugging.

For that purpose, a couple of helpers are created
__update_page_owner_handle() which updates the metadata on allocation,
and __update_page_owner_free_handle() which does the same when the page
is freed.

__folio_copy_owner() will make use of both as it needs to entirely replace
the page_owner metadata for the new page.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/page_owner.c | 137 ++++++++++++++++++++++++++----------------------
 1 file changed, 74 insertions(+), 63 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index d17d1351ec84..52d1ced0b57f 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -228,9 +228,58 @@ static void dec_stack_record_count(depot_stack_handle_t handle)
 		refcount_dec(&stack_record->count);
 }
 
-void __reset_page_owner(struct page *page, unsigned short order)
+static inline void __update_page_owner_handle(struct page_ext *page_ext,
+					      depot_stack_handle_t handle,
+					      unsigned short order,
+					      gfp_t gfp_mask,
+					      short last_migrate_reason, u64 ts_nsec,
+					      pid_t pid, pid_t tgid, char *comm)
 {
 	int i;
+	struct page_owner *page_owner;
+
+	for (i = 0; i < (1 << order); i++) {
+		page_owner = get_page_owner(page_ext);
+		page_owner->handle = handle;
+		page_owner->order = order;
+		page_owner->gfp_mask = gfp_mask;
+		page_owner->last_migrate_reason = last_migrate_reason;
+		page_owner->pid = pid;
+		page_owner->tgid = tgid;
+		page_owner->ts_nsec = ts_nsec;
+		strscpy(page_owner->comm, comm,
+			sizeof(page_owner->comm));
+		__set_bit(PAGE_EXT_OWNER, &page_ext->flags);
+		__set_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
+		page_ext = page_ext_next(page_ext);
+	}
+}
+
+static inline void __update_page_owner_free_handle(struct page_ext *page_ext,
+						   depot_stack_handle_t handle,
+						   unsigned short order,
+						   pid_t pid, pid_t tgid,
+						   u64 free_ts_nsec)
+{
+	int i;
+	struct page_owner *page_owner;
+
+	for (i = 0; i < (1 << order); i++) {
+		page_owner = get_page_owner(page_ext);
+		/* Only __reset_page_owner() wants to clear the bit */
+		if (handle) {
+			__clear_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
+			page_owner->free_handle = handle;
+		}
+		page_owner->free_ts_nsec = free_ts_nsec;
+		page_owner->free_pid = current->pid;
+		page_owner->free_tgid = current->tgid;
+		page_ext = page_ext_next(page_ext);
+	}
+}
+
+void __reset_page_owner(struct page *page, unsigned short order)
+{
 	struct page_ext *page_ext;
 	depot_stack_handle_t handle;
 	depot_stack_handle_t alloc_handle;
@@ -245,16 +294,10 @@ void __reset_page_owner(struct page *page, unsigned short order)
 	alloc_handle = page_owner->handle;
 
 	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
-	for (i = 0; i < (1 << order); i++) {
-		__clear_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
-		page_owner->free_handle = handle;
-		page_owner->free_ts_nsec = free_ts_nsec;
-		page_owner->free_pid = current->pid;
-		page_owner->free_tgid = current->tgid;
-		page_ext = page_ext_next(page_ext);
-		page_owner = get_page_owner(page_ext);
-	}
+	__update_page_owner_free_handle(page_ext, handle, order, current->pid,
+					current->tgid, free_ts_nsec);
 	page_ext_put(page_ext);
+
 	if (alloc_handle != early_handle)
 		/*
 		 * early_handle is being set as a handle for all those
@@ -266,36 +309,11 @@ void __reset_page_owner(struct page *page, unsigned short order)
 		dec_stack_record_count(alloc_handle);
 }
 
-static inline void __set_page_owner_handle(struct page_ext *page_ext,
-					depot_stack_handle_t handle,
-					unsigned short order, gfp_t gfp_mask)
-{
-	struct page_owner *page_owner;
-	int i;
-	u64 ts_nsec = local_clock();
-
-	for (i = 0; i < (1 << order); i++) {
-		page_owner = get_page_owner(page_ext);
-		page_owner->handle = handle;
-		page_owner->order = order;
-		page_owner->gfp_mask = gfp_mask;
-		page_owner->last_migrate_reason = -1;
-		page_owner->pid = current->pid;
-		page_owner->tgid = current->tgid;
-		page_owner->ts_nsec = ts_nsec;
-		strscpy(page_owner->comm, current->comm,
-			sizeof(page_owner->comm));
-		__set_bit(PAGE_EXT_OWNER, &page_ext->flags);
-		__set_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
-
-		page_ext = page_ext_next(page_ext);
-	}
-}
-
 noinline void __set_page_owner(struct page *page, unsigned short order,
 					gfp_t gfp_mask)
 {
 	struct page_ext *page_ext;
+	u64 ts_nsec = local_clock();
 	depot_stack_handle_t handle;
 
 	handle = save_stack(gfp_mask);
@@ -303,7 +321,9 @@ noinline void __set_page_owner(struct page *page, unsigned short order,
 	page_ext = page_ext_get(page);
 	if (unlikely(!page_ext))
 		return;
-	__set_page_owner_handle(page_ext, handle, order, gfp_mask);
+	__update_page_owner_handle(page_ext, handle, order, gfp_mask, -1,
+				   current->pid, current->tgid, ts_nsec,
+				   current->comm);
 	page_ext_put(page_ext);
 	inc_stack_record_count(handle, gfp_mask);
 }
@@ -342,7 +362,7 @@ void __folio_copy_owner(struct folio *newfolio, struct folio *old)
 {
 	struct page_ext *old_ext;
 	struct page_ext *new_ext;
-	struct page_owner *old_page_owner, *new_page_owner;
+	struct page_owner *old_page_owner;
 
 	old_ext = page_ext_get(&old->page);
 	if (unlikely(!old_ext))
@@ -355,31 +375,21 @@ void __folio_copy_owner(struct folio *newfolio, struct folio *old)
 	}
 
 	old_page_owner = get_page_owner(old_ext);
-	new_page_owner = get_page_owner(new_ext);
-	new_page_owner->order = old_page_owner->order;
-	new_page_owner->gfp_mask = old_page_owner->gfp_mask;
-	new_page_owner->last_migrate_reason =
-		old_page_owner->last_migrate_reason;
-	new_page_owner->handle = old_page_owner->handle;
-	new_page_owner->pid = old_page_owner->pid;
-	new_page_owner->tgid = old_page_owner->tgid;
-	new_page_owner->free_pid = old_page_owner->free_pid;
-	new_page_owner->free_tgid = old_page_owner->free_tgid;
-	new_page_owner->ts_nsec = old_page_owner->ts_nsec;
-	new_page_owner->free_ts_nsec = old_page_owner->ts_nsec;
-	strcpy(new_page_owner->comm, old_page_owner->comm);
-
+	__update_page_owner_handle(new_ext, old_page_owner->handle,
+				   old_page_owner->order, old_page_owner->gfp_mask,
+				   old_page_owner->last_migrate_reason,
+				   old_page_owner->ts_nsec, old_page_owner->pid,
+				   old_page_owner->tgid, old_page_owner->comm);
 	/*
-	 * We don't clear the bit on the old folio as it's going to be freed
-	 * after migration. Until then, the info can be useful in case of
-	 * a bug, and the overall stats will be off a bit only temporarily.
-	 * Also, migrate_misplaced_transhuge_page() can still fail the
-	 * migration and then we want the old folio to retain the info. But
-	 * in that case we also don't need to explicitly clear the info from
-	 * the new page, which will be freed.
+	 * Do not proactively clear PAGE_EXT_OWNER{_ALLOCATED} bits as the folio
+	 * will be freed after migration. Keep them until then as they may be
+	 * useful.
 	 */
-	__set_bit(PAGE_EXT_OWNER, &new_ext->flags);
-	__set_bit(PAGE_EXT_OWNER_ALLOCATED, &new_ext->flags);
+	__update_page_owner_free_handle(new_ext, 0, old_page_owner->order,
+					old_page_owner->free_pid,
+					old_page_owner->free_tgid,
+					old_page_owner->free_ts_nsec);
+
 	page_ext_put(new_ext);
 	page_ext_put(old_ext);
 }
@@ -787,8 +797,9 @@ static void init_pages_in_zone(pg_data_t *pgdat, struct zone *zone)
 				goto ext_put_continue;
 
 			/* Found early allocated page */
-			__set_page_owner_handle(page_ext, early_handle,
-						0, 0);
+			__update_page_owner_handle(page_ext, early_handle, 0, 0,
+						   -1, local_clock(), current->pid,
+						   current->tgid, current->comm);
 			count++;
 ext_put_continue:
 			page_ext_put(page_ext);
-- 
2.44.0


