Return-Path: <linux-kernel+bounces-58878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC9B84EE02
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2271F249AB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3474151008;
	Thu,  8 Feb 2024 23:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FqIo5CvJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e9Com5bm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FqIo5CvJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e9Com5bm"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB9B50267
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 23:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707435916; cv=none; b=Q/GuHL9+oywkO2z3VJ4tTb49be1x0UOJiVaEgEddeqlDXviEoQQgqRIGcr0qgzNCEeOxYulrwnE67IJ8Jtem9rQB0xCc5I8Hh+Pp5FfKCGYThYDNfLYMzVpSN+yJQbOvXjxsBWnu8Ngchk8E1XhQCEZJ+vPGshTDMtVGCRuTLFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707435916; c=relaxed/simple;
	bh=wdjyH8x1YZucLguMDb3KPjDfIknPxybLEtYyM3a0pcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsJurOFWSh6MzLgeEEkVehitK0/yXz6LeX7/xSXScxsWbPv5zZ/XHDM2zsvY97cZ7Bx8Q4hiwRJePqIttsBuGmRR6F0psYSUdRZ4hTwUY0MjVXh+Me/z3aVuJ6VOrBFcfNeQ4Oqx4vddiVqFe2cf44UveBBUnsgxLhnaV7jKiuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FqIo5CvJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=e9Com5bm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FqIo5CvJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=e9Com5bm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 52DCB2231D;
	Thu,  8 Feb 2024 23:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707435912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=txtCde6C1McUcle00OaiAlK/R7byCyLGw0BeYvVKqOg=;
	b=FqIo5CvJ6oX+sMFvUZG+ClyHR4cWlBMV/ux5MN/ol+aO92XWT7VftClRCEZdKUIFqzYobq
	bbLmF2YqyOIw3TkWci/8KIn+799W0jctO1lgK25+uzR7W6eJXMZYrUGg5hIwJk3KyRGa58
	BFUulIJUPi65U4NFdLHvmY0UCPSIoDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707435912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=txtCde6C1McUcle00OaiAlK/R7byCyLGw0BeYvVKqOg=;
	b=e9Com5bminDIKvAD8i86K8dC9in6zV+PepP4s9oQpN5dbVpe6CHWBBaeUt5KudzVDTMp8y
	6L17clAD++kcEtAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707435912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=txtCde6C1McUcle00OaiAlK/R7byCyLGw0BeYvVKqOg=;
	b=FqIo5CvJ6oX+sMFvUZG+ClyHR4cWlBMV/ux5MN/ol+aO92XWT7VftClRCEZdKUIFqzYobq
	bbLmF2YqyOIw3TkWci/8KIn+799W0jctO1lgK25+uzR7W6eJXMZYrUGg5hIwJk3KyRGa58
	BFUulIJUPi65U4NFdLHvmY0UCPSIoDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707435912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=txtCde6C1McUcle00OaiAlK/R7byCyLGw0BeYvVKqOg=;
	b=e9Com5bminDIKvAD8i86K8dC9in6zV+PepP4s9oQpN5dbVpe6CHWBBaeUt5KudzVDTMp8y
	6L17clAD++kcEtAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEBF413984;
	Thu,  8 Feb 2024 23:45:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uE7SK4dnxWWUfAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 08 Feb 2024 23:45:11 +0000
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
Subject: [PATCH v7 1/4] lib/stackdepot: Move stack_record struct definition into the header
Date: Fri,  9 Feb 2024 00:45:36 +0100
Message-ID: <20240208234539.19113-2-osalvador@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208234539.19113-1-osalvador@suse.de>
References: <20240208234539.19113-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ********
X-Spam-Score: 8.80
X-Spamd-Result: default: False [8.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com,suse.de];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

In order to move the heavy lifting into page_owner code, this one
needs to have access to the stack_record structure, which right now
sits in lib/stackdepot.c.
Move it to the stackdepot.h header so page_owner can access
stack_record's struct fields.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/stackdepot.h | 44 ++++++++++++++++++++++++++++++++++++++
 lib/stackdepot.c           | 43 -------------------------------------
 2 files changed, 44 insertions(+), 43 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index adcbb8f23600..d0dcf4aebfb4 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -30,6 +30,50 @@ typedef u32 depot_stack_handle_t;
  */
 #define STACK_DEPOT_EXTRA_BITS 5
 
+#define DEPOT_HANDLE_BITS (sizeof(depot_stack_handle_t) * 8)
+
+#define DEPOT_POOL_ORDER 2 /* Pool size order, 4 pages */
+#define DEPOT_POOL_SIZE (1LL << (PAGE_SHIFT + DEPOT_POOL_ORDER))
+#define DEPOT_STACK_ALIGN 4
+#define DEPOT_OFFSET_BITS (DEPOT_POOL_ORDER + PAGE_SHIFT - DEPOT_STACK_ALIGN)
+#define DEPOT_POOL_INDEX_BITS (DEPOT_HANDLE_BITS - DEPOT_OFFSET_BITS - \
+			       STACK_DEPOT_EXTRA_BITS)
+
+/* Compact structure that stores a reference to a stack. */
+union handle_parts {
+	depot_stack_handle_t handle;
+	struct {
+		u32 pool_index  : DEPOT_POOL_INDEX_BITS;
+		u32 offset      : DEPOT_OFFSET_BITS;
+		u32 extra       : STACK_DEPOT_EXTRA_BITS;
+	};
+};
+
+struct stack_record {
+	struct list_head hash_list;	/* Links in the hash table */
+	u32 hash;			/* Hash in hash table */
+	u32 size;			/* Number of stored frames */
+	union handle_parts handle;	/* Constant after initialization */
+	refcount_t count;
+	union {
+		unsigned long entries[CONFIG_STACKDEPOT_MAX_FRAMES];	/* Frames */
+		struct {
+			/*
+			 * An important invariant of the implementation is to
+			 * only place a stack record onto the freelist iff its
+			 * refcount is zero. Because stack records with a zero
+			 * refcount are never considered as valid, it is safe to
+			 * union @entries and freelist management state below.
+			 * Conversely, as soon as an entry is off the freelist
+			 * and its refcount becomes non-zero, the below must not
+			 * be accessed until being placed back on the freelist.
+			 */
+			struct list_head free_list;	/* Links in the freelist */
+			unsigned long rcu_state;	/* RCU cookie */
+		};
+	};
+};
+
 typedef u32 depot_flags_t;
 
 /*
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 5caa1f566553..16c8a1bf0008 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -35,14 +35,6 @@
 #include <linux/memblock.h>
 #include <linux/kasan-enabled.h>
 
-#define DEPOT_HANDLE_BITS (sizeof(depot_stack_handle_t) * 8)
-
-#define DEPOT_POOL_ORDER 2 /* Pool size order, 4 pages */
-#define DEPOT_POOL_SIZE (1LL << (PAGE_SHIFT + DEPOT_POOL_ORDER))
-#define DEPOT_STACK_ALIGN 4
-#define DEPOT_OFFSET_BITS (DEPOT_POOL_ORDER + PAGE_SHIFT - DEPOT_STACK_ALIGN)
-#define DEPOT_POOL_INDEX_BITS (DEPOT_HANDLE_BITS - DEPOT_OFFSET_BITS - \
-			       STACK_DEPOT_EXTRA_BITS)
 #if IS_ENABLED(CONFIG_KMSAN) && CONFIG_STACKDEPOT_MAX_FRAMES >= 32
 /*
  * KMSAN is frequently used in fuzzing scenarios and thus saves a lot of stack
@@ -58,41 +50,6 @@
 	(((1LL << (DEPOT_POOL_INDEX_BITS)) < DEPOT_POOLS_CAP) ? \
 	 (1LL << (DEPOT_POOL_INDEX_BITS)) : DEPOT_POOLS_CAP)
 
-/* Compact structure that stores a reference to a stack. */
-union handle_parts {
-	depot_stack_handle_t handle;
-	struct {
-		u32 pool_index	: DEPOT_POOL_INDEX_BITS;
-		u32 offset	: DEPOT_OFFSET_BITS;
-		u32 extra	: STACK_DEPOT_EXTRA_BITS;
-	};
-};
-
-struct stack_record {
-	struct list_head hash_list;	/* Links in the hash table */
-	u32 hash;			/* Hash in hash table */
-	u32 size;			/* Number of stored frames */
-	union handle_parts handle;	/* Constant after initialization */
-	refcount_t count;
-	union {
-		unsigned long entries[CONFIG_STACKDEPOT_MAX_FRAMES];	/* Frames */
-		struct {
-			/*
-			 * An important invariant of the implementation is to
-			 * only place a stack record onto the freelist iff its
-			 * refcount is zero. Because stack records with a zero
-			 * refcount are never considered as valid, it is safe to
-			 * union @entries and freelist management state below.
-			 * Conversely, as soon as an entry is off the freelist
-			 * and its refcount becomes non-zero, the below must not
-			 * be accessed until being placed back on the freelist.
-			 */
-			struct list_head free_list;	/* Links in the freelist */
-			unsigned long rcu_state;	/* RCU cookie */
-		};
-	};
-};
-
 #define DEPOT_STACK_RECORD_SIZE \
 	ALIGN(sizeof(struct stack_record), 1 << DEPOT_STACK_ALIGN)
 
-- 
2.43.0


