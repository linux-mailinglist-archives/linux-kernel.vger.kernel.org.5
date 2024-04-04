Return-Path: <linux-kernel+bounces-131005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503628981DA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06153286BA7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864085788E;
	Thu,  4 Apr 2024 07:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b+JDHNpN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="l19wa1e0"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8387D55C1D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 07:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712214353; cv=none; b=fDeHcQYVgWJzbRJXDOAV5G0jOuOhHji+vTuh7Xw3cHqzWoJoCMf5p4jAJNats1SUJ9bEXoAZ0C54wE6FvUdM+tlGFgPaLR50gvI13b8GTmbwgQmELPZRKipF1k751DbGjPRlj7FWCs3en0ukbbnhMy/lFqQD8j/8RcmsACpST64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712214353; c=relaxed/simple;
	bh=pT76JQzWTDByYDUHSG1XbhIBfbGMgeY7bp4NaZs2iRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4Y5Jvvo004hdKcSFyQ7IPHcMT9LRlh3KitqwnTbuqoqLHPp77QcFDqG5f7wT0qMvQcfCT1X54b4raA5PMt6dpONmKnD+cVR3QWzsP+uSMEdLz2xCs1nXBIzhh1mCotWis24d6MXx7aT/luJjZcucF0y42UX32jbJ2Lvf2Ra3XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b+JDHNpN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=l19wa1e0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E193378EC;
	Thu,  4 Apr 2024 07:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712214348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L9csULMalRTJ5bwNt2srfmcGplNPvj1BEqpu1yrZ8PM=;
	b=b+JDHNpNj2CVttstyNqm814TITnISk4F7GULwqe+fIIP1mtyQ47GBToNvgBAC7H8/oGTfi
	Toh+8PzgcYrloVYdeg3thh3Tk5TlB1cInGEN2hML821UWErMTCw3kddxvluc+w0fX6Ra/B
	WPWbyqmxIhELcQ6nWa/BYZzbpHJUyeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712214348;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L9csULMalRTJ5bwNt2srfmcGplNPvj1BEqpu1yrZ8PM=;
	b=l19wa1e0HyXrXtipe5A2g71Pqed7khVCl1p+XMHjKo0UB/mwOIA+Q5UR0iRhXBjIjgaZXD
	VZRaK1iWwefbCQAQ==
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E0607139E8;
	Thu,  4 Apr 2024 07:05:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id SAvZMktRDmY6cgAAn2gu4w
	(envelope-from <osalvador@suse.de>); Thu, 04 Apr 2024 07:05:47 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v4 1/4] mm,page_owner: Update metadata for tail pages
Date: Thu,  4 Apr 2024 09:06:59 +0200
Message-ID: <20240404070702.2744-2-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404070702.2744-1-osalvador@suse.de>
References: <20240404070702.2744-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.983];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com,rivosinc.com,suse.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.cz:email,imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -5.80
X-Spam-Level: 
X-Spam-Flag: NO

__set_page_owner_handle() and __reset_page_owner() update the metadata
of all pages when the page is of a higher-order, but we miss to do the
same when the pages are migrated.
__folio_copy_owner() only updates the metadata of the head page, meaning
that the information stored in the first page and the tail pages will not
match.

Strictly speaking that is not a big problem because 1) we do not print
tail pages and 2) upon splitting all tail pages will inherit the
metadata of the head page, but it is better to have all metadata in check
should there be any problem, so it can ease debugging.

For that purpose, a couple of helpers are created
__update_page_owner_handle() which updates the metadata on allocation,
and __update_page_owner_free_handle() which does the same when the page
is freed.

__folio_copy_owner() will make use of both as it needs to entirely replace
the page_owner metadata for the new page.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
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


