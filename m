Return-Path: <linux-kernel+bounces-62480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD9085216D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2661C22521
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B9F4F608;
	Mon, 12 Feb 2024 22:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aO8sIvNw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IMz7vyf+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aO8sIvNw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IMz7vyf+"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CCD4EB34
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 22:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707776973; cv=none; b=LmqbZtN6ey2xtTH2DND4M8Juhy19aRf9FLZtnDsIJGNfagw3qtFgfA5sKYUgyfSI+iNDAtND8SoMa42ua6pQJiNkn7r9HjtnCKa7CT4b/FLnxW3TGCOuI/B9fUr+llcPrYK8SVZv+FvfcO1dsfO1RaemH9zKoof3ZF+twjFpDEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707776973; c=relaxed/simple;
	bh=PslCDCM3yg1q5QFWu02AeTqtUBHZaW7ctPxFlrHtAsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rauubtk7JUTCwRbPpR4noMBI8JrpzHf+5R81rsJa7Rd0RguenazMHLO3uwXfQ/7PY6OhyStoh1TdBM5boua4X9b6qV6l4w2hPIJiG2aCpmP/II1j0nFMWiiOtQ3iNjxIzbv5SNSi2BYlK8monVaU9sY1PwTHsPnZiuHWx8NvdA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aO8sIvNw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IMz7vyf+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aO8sIvNw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IMz7vyf+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4330622160;
	Mon, 12 Feb 2024 22:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707776970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S9GgOB2bpckE3olLSUoq4h/Hy5/g1rCORxaucTcFT3o=;
	b=aO8sIvNwoxgZohBoscNS6wvlgcWjwXje8eEteMwwtBuB/+u2WRUjh8NwW4qXahgHFoOv/3
	/2MuhVHGZzW70sU0W/+D51GvcRLU9+pVPIMz7GxwfGGqH/5FTYg667EBvytadc8R/KNzwU
	i3X2tsgY6Ob+sgqpA4KA0ngkfibk9tQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707776970;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S9GgOB2bpckE3olLSUoq4h/Hy5/g1rCORxaucTcFT3o=;
	b=IMz7vyf+FqsnnTqxhLZ2ZG4SOkTO2sPVHymdrZdBtZvjkwp8tB+6RN2TSyC8izEmJRrrPE
	aY8LnAReVrEaukCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707776970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S9GgOB2bpckE3olLSUoq4h/Hy5/g1rCORxaucTcFT3o=;
	b=aO8sIvNwoxgZohBoscNS6wvlgcWjwXje8eEteMwwtBuB/+u2WRUjh8NwW4qXahgHFoOv/3
	/2MuhVHGZzW70sU0W/+D51GvcRLU9+pVPIMz7GxwfGGqH/5FTYg667EBvytadc8R/KNzwU
	i3X2tsgY6Ob+sgqpA4KA0ngkfibk9tQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707776970;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S9GgOB2bpckE3olLSUoq4h/Hy5/g1rCORxaucTcFT3o=;
	b=IMz7vyf+FqsnnTqxhLZ2ZG4SOkTO2sPVHymdrZdBtZvjkwp8tB+6RN2TSyC8izEmJRrrPE
	aY8LnAReVrEaukCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 79FDA13212;
	Mon, 12 Feb 2024 22:29:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id eIdfGcmbymX5JgAAn2gu4w
	(envelope-from <osalvador@suse.de>); Mon, 12 Feb 2024 22:29:29 +0000
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
Subject: [PATCH v8 3/5] mm,page_owner: Display all stacks and their count
Date: Mon, 12 Feb 2024 23:30:27 +0100
Message-ID: <20240212223029.30769-4-osalvador@suse.de>
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
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
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
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

This patch adds a new directory called 'page_owner_stacks' under
/sys/kernel/debug/, with a file called 'show_stacks' in it.
Reading from that file will show all stacks that were added by page_owner
followed by their counting, giving us a clear overview of stack <-> count
relationship.

E.g:

  prep_new_page+0xa9/0x120
  get_page_from_freelist+0x801/0x2210
  __alloc_pages+0x18b/0x350
  alloc_pages_mpol+0x91/0x1f0
  folio_alloc+0x14/0x50
  filemap_alloc_folio+0xb2/0x100
  __filemap_get_folio+0x14a/0x490
  ext4_write_begin+0xbd/0x4b0 [ext4]
  generic_perform_write+0xc1/0x1e0
  ext4_buffered_write_iter+0x68/0xe0 [ext4]
  ext4_file_write_iter+0x70/0x740 [ext4]
  vfs_write+0x33d/0x420
  ksys_write+0xa5/0xe0
  do_syscall_64+0x80/0x160
  entry_SYSCALL_64_after_hwframe+0x6e/0x76
 stack_count: 4578

The seq stack_{start,next} functions will iterate through the list
stack_list in order to print all stacks.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/page_owner.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 1 deletion(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 7d1b3f75cef3..3e4b7cd7c8f8 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -84,7 +84,12 @@ static void add_stack_record_to_list(struct stack_record *stack_record)
 			stack_list = stack;
 		} else {
 			stack->next = stack_list;
-			stack_list = stack;
+			/* This pairs with smp_load_acquire() from function
+			 * stack_start(). This guarantees that stack_start()
+			 * will see an updated stack_list before starting to
+			 * traverse the list.
+			 */
+			smp_store_release(&stack_list, stack);
 		}
 		spin_unlock_irqrestore(&stack_list_lock, flags);
 	}
@@ -792,8 +797,97 @@ static const struct file_operations proc_page_owner_operations = {
 	.llseek		= lseek_page_owner,
 };
 
+static void *stack_start(struct seq_file *m, loff_t *ppos)
+{
+	struct stack *stack;
+
+	if (*ppos == -1UL)
+		return NULL;
+
+	if (!*ppos) {
+		/*
+		 * This pairs with smp_store_release() from function
+		 * add_stack_record_to_list(), so we get a consistent
+		 * value of stack_list.
+		 */
+		stack = smp_load_acquire(&stack_list);
+	} else {
+		stack = m->private;
+		stack = stack->next;
+	}
+
+	m->private = stack;
+
+	return stack;
+}
+
+static void *stack_next(struct seq_file *m, void *v, loff_t *ppos)
+{
+	struct stack *stack = v;
+
+	stack = stack->next;
+	*ppos = stack ? *ppos + 1 : -1UL;
+	m->private = stack;
+
+	return stack;
+}
+
+static int stack_print(struct seq_file *m, void *v)
+{
+	char *buf;
+	int ret = 0;
+	struct stack *stack = v;
+	struct stack_record *stack_record = stack->stack_record;
+
+	if (!stack_record->size || stack_record->size < 0 ||
+	    refcount_read(&stack_record->count) < 2)
+		return 0;
+
+	buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
+
+	ret += stack_trace_snprint(buf, PAGE_SIZE, stack_record->entries,
+				   stack_record->size, 0);
+	if (!ret)
+		goto out;
+
+	scnprintf(buf + ret, PAGE_SIZE - ret, "stack_count: %d\n\n",
+		  refcount_read(&stack_record->count));
+
+	seq_printf(m, buf);
+	seq_puts(m, "\n\n");
+out:
+	kfree(buf);
+
+	return 0;
+}
+
+static void stack_stop(struct seq_file *m, void *v)
+{
+}
+
+static const struct seq_operations page_owner_stack_op = {
+	.start	= stack_start,
+	.next	= stack_next,
+	.stop	= stack_stop,
+	.show	= stack_print
+};
+
+static int page_owner_stack_open(struct inode *inode, struct file *file)
+{
+	return seq_open_private(file, &page_owner_stack_op, 0);
+}
+
+static const struct file_operations page_owner_stack_operations = {
+	.open		= page_owner_stack_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
 static int __init pageowner_init(void)
 {
+	struct dentry *dir;
+
 	if (!static_branch_unlikely(&page_owner_inited)) {
 		pr_info("page_owner is disabled\n");
 		return 0;
@@ -801,6 +895,9 @@ static int __init pageowner_init(void)
 
 	debugfs_create_file("page_owner", 0400, NULL, NULL,
 			    &proc_page_owner_operations);
+	dir = debugfs_create_dir("page_owner_stacks", NULL);
+	debugfs_create_file("show_stacks", 0400, dir, NULL,
+			    &page_owner_stack_operations);
 
 	return 0;
 }
-- 
2.43.0


