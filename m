Return-Path: <linux-kernel+bounces-65605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D598854F55
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B9D5B295F7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABFA60BAD;
	Wed, 14 Feb 2024 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QfUJWNsY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NqpFyR0W";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VG4Ut+Wj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5/ZZStpO"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74D060DD0
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930062; cv=none; b=STjwpsWUvamu674sgv9fWr0hSHQ+ZedlaZ40/CDHwT5KbE3i7nLD2hQ8YA0vmfPDHO5GE53II1EMBUnQKwOO23lX8LA7tO3bAQOEX7mWwZAyPKjNk7VylYf+K3gC2smb5G28k+4UYL8m40ojgaNW0ky6g8vXGH/m9Q9o7+cuFy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930062; c=relaxed/simple;
	bh=JDrT54aiGAYbEHrr5qCHhGgrUnvZlwD72eoFUUkLGiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJcFPyqmNzW4o2qxZFGZdgeAwfpO7DpzIWAdZ/aYTLHjyhGYFkE7UcWUEy6mbCL+dYJ+ZxwWsnVi60NtgVXqY6iizs4wK0kYCi/sbg79icuNZ6QJBJBf5AJ3l7rpCHxtQ3Ht6zx2N2cdK28O9mx9mKg7IiQjEItNf04aJtHPeok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QfUJWNsY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NqpFyR0W; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VG4Ut+Wj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5/ZZStpO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0273821E6C;
	Wed, 14 Feb 2024 17:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707930058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lC7K795PsIjvK78gQgEPDu4QR3bWLN1iZOc7KJySKTk=;
	b=QfUJWNsYEg3KlDVV4k1fz2Z4FNC954z4a5oZO/EaiOe4OEj6AGeLZ61GNB09dj3pceDX8c
	0BtvUmMAhKu/yWzZUG3a/wS3X+F8NJY6hs037IYw2koXF/aPCLWInIAGoRphwmoY12UB11
	Z2BCiFPh5Jnm+Y4CfMVprTqhfrS8Ixk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707930058;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lC7K795PsIjvK78gQgEPDu4QR3bWLN1iZOc7KJySKTk=;
	b=NqpFyR0WyUs8K9/mIycrNliOlVlk7eBO/EXa3oGpB0KY3txNKQohc73oglNWyvPoIJf4g/
	02PyWQUa9ZfKYBCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707930057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lC7K795PsIjvK78gQgEPDu4QR3bWLN1iZOc7KJySKTk=;
	b=VG4Ut+WjS+KyJLCfZj/q6vbCFpijr3XDjBFPP/vYWr5ln6qyC4WdmQCEymerlFrqoScGOM
	50wbFytT5pPvEHlrxbA+M+5Y/ri/jdjU+Ja7qoRyJFJ6YtK5t70T3IbrPuaXtc+r18Jut+
	DfBmKzP6ihTD9Wr2I2Efntylc3oEPU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707930057;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lC7K795PsIjvK78gQgEPDu4QR3bWLN1iZOc7KJySKTk=;
	b=5/ZZStpOLmoNOFv6SW/+i2+fhk1okI4WDrzltPYDBfKZ81iuZWYRKl7N9yk2cbNYolWMR6
	ad4u3zytC2E4YtAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C8EF13A0B;
	Wed, 14 Feb 2024 17:00:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id WKXWF8jxzGUfMwAAn2gu4w
	(envelope-from <osalvador@suse.de>); Wed, 14 Feb 2024 17:00:56 +0000
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
Subject: [PATCH v9 3/7] mm,page_owner: Maintain own list of stack_records structs
Date: Wed, 14 Feb 2024 18:01:53 +0100
Message-ID: <20240214170157.17530-4-osalvador@suse.de>
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
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VG4Ut+Wj;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="5/ZZStpO"
X-Spamd-Result: default: False [-1.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0273821E6C
X-Spam-Level: 
X-Spam-Score: -1.81
X-Spam-Flag: NO

page_owner needs to increment a stack_record refcount when a new allocation
occurs, and decrement it on a free operation.
In order to do that, we need to have a way to get a stack_record from a
handle.
Implement __stack_depot_get_stack_record() which just does that, and make
it public so page_owner can use it.

Also, traversing all stackdepot buckets comes with its own complexity,
plus we would have to implement a way to mark only those stack_records
that were originated from page_owner, as those are the ones we are
interested in.
For that reason, page_owner maintains its own list of stack_records,
because traversing that list is faster than traversing all buckets
while keeping at the same time a low complexity.

For now, add to stack_list only the stack_records of dummy_handle and
failure_handle, and set their refcount of 1.

Further patches will add code to increment or decrement stack_records
count on allocation and free operation.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/stackdepot.h | 11 +++++++++++
 lib/stackdepot.c           |  8 ++++++++
 mm/page_owner.c            | 15 +++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index c4b5ad57c066..3c6caa5abc7c 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -178,6 +178,17 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
 depot_stack_handle_t stack_depot_save(unsigned long *entries,
 				      unsigned int nr_entries, gfp_t gfp_flags);
 
+/**
+ * __stack_depot_get_stack_record - Get a pointer to a stack_record struct
+ *
+ * @handle: Stack depot handle
+ *
+ * This function is only for internal purposes.
+ *
+ * Return: Returns a pointer to a stack_record struct
+ */
+struct stack_record *__stack_depot_get_stack_record(depot_stack_handle_t handle);
+
 /**
  * stack_depot_fetch - Fetch a stack trace from stack depot
  *
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 4a661a6777da..3da6d7cfcdfb 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -687,6 +687,14 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
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
index 5634e5d890f8..33e342b15d9b 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -36,6 +36,14 @@ struct page_owner {
 	pid_t free_tgid;
 };
 
+struct stack {
+	struct stack_record *stack_record;
+	struct stack *next;
+};
+static struct stack dummy_stack;
+static struct stack failure_stack;
+static struct stack *stack_list;
+
 static bool page_owner_enabled __initdata;
 DEFINE_STATIC_KEY_FALSE(page_owner_inited);
 
@@ -95,6 +103,13 @@ static __init void init_page_owner(void)
 	register_early_stack();
 	static_branch_enable(&page_owner_inited);
 	init_early_allocated_pages();
+	/* Initialize dummy and failure stacks and link them to stack_list */
+	dummy_stack.stack_record = __stack_depot_get_stack_record(dummy_handle);
+	failure_stack.stack_record = __stack_depot_get_stack_record(failure_handle);
+	refcount_set(&dummy_stack.stack_record->count, 1);
+	refcount_set(&failure_stack.stack_record->count, 1);
+	dummy_stack.next = &failure_stack;
+	stack_list = &dummy_stack;
 }
 
 struct page_ext_operations page_owner_ops = {
-- 
2.43.0


