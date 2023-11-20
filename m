Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AB87F0DCF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjKTInc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjKTInU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:43:20 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837E0E5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:43:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2498E1F7AB;
        Mon, 20 Nov 2023 08:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700469795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7EwAqAp1NFiaOxvyhYru50OYx9A1799Fnc0qEZ742hE=;
        b=j7OyRP9wUjBWfFGuqYCOlJ4Uf4LJ0AYn1ES0WLdmpsaoFXdeRHCtefgi+Jb4X80VPBIgHF
        zNWqHtXrZuVlz+2vtY42snzsEPA5Ws1P9DSV6DEBpFUyH54UGTyWHaKyCo4R2Luwsa80sN
        JfTIrqzKynVwrl/Tw9F0zaTv54SIRFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700469795;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7EwAqAp1NFiaOxvyhYru50OYx9A1799Fnc0qEZ742hE=;
        b=RxXVN6L+9WAKE2vHWxLlrQIUbQkcvm0uCy8VrlyaNQ7cR3anpx7Mk09o8jH550OgCTb8O4
        czmQIHJXImh1ImAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22BA913912;
        Mon, 20 Nov 2023 08:43:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SFrpACIcW2U3VgAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 20 Nov 2023 08:43:14 +0000
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
Subject: [PATCH v6 3/4] mm,page_owner: Add page_owner_stacks file to print out only stacks and their counter
Date:   Mon, 20 Nov 2023 09:42:59 +0100
Message-Id: <20231120084300.4368-4-osalvador@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231120084300.4368-1-osalvador@suse.de>
References: <20231120084300.4368-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are not interested in the owner of each individual pfn,
but how many outstanding allocations are there for each unique
allocating stack trace.

Right now, getting that information is quite hard as one needs
to fiddle with page_owner output, screen through pfns and make
the links.

So, instead, let us add a new file called 'page_owner_stacks'
that shows just that.
Such file will only show the stacktrace once followed by its
counter, which represents the number of outstanding allocations.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/stackdepot.h |  2 +
 lib/stackdepot.c           | 29 +++++++++++++
 mm/page_owner.c            | 87 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 118 insertions(+)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index 269a828a5e94..09c478b1bf73 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -146,6 +146,8 @@ void stack_depot_dec_count(depot_stack_handle_t handle);
 depot_stack_handle_t stack_depot_save(unsigned long *entries,
 				      unsigned int nr_entries, gfp_t gfp_flags);
 
+struct stack_record *stack_depot_get_next_stack(unsigned long *table,
+						struct stack_record *curr_stack);
 /**
  * stack_depot_fetch - Fetch a stack trace from stack depot
  *
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 1343d3095bc1..65708c0c1e50 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -452,6 +452,35 @@ static struct stack_record *stack_depot_getstack(depot_stack_handle_t handle)
 	return stack;
 }
 
+struct stack_record *stack_depot_get_next_stack(unsigned long *table,
+						struct stack_record *curr_stack)
+{
+	unsigned long nr_table = *table;
+	struct stack_record *next = NULL, **stacks;
+	unsigned long stack_table_entries = stack_hash_mask + 1;
+
+	if (!curr_stack) {
+		if (nr_table) {
+new_table:
+			nr_table++;
+			if (nr_table >= stack_table_entries)
+				goto out;
+		}
+	stacks = &stack_table[nr_table];
+	curr_stack = (struct stack_record *)stacks;
+	next = curr_stack;
+	} else {
+		next = curr_stack->next;
+	}
+
+	if (!next)
+		goto new_table;
+
+out:
+	*table = nr_table;
+	return next;
+}
+
 unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 			       unsigned long **entries)
 {
diff --git a/mm/page_owner.c b/mm/page_owner.c
index d53316d0d9be..509c11e506db 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -719,6 +719,91 @@ static const struct file_operations proc_page_owner_operations = {
 	.llseek		= lseek_page_owner,
 };
 
+static void *stack_start(struct seq_file *m, loff_t *ppos)
+{
+	unsigned long *nr_table = m->private;
+	void *stack;
+
+	/* First time */
+	if (*ppos == 0)
+		*nr_table = 0;
+
+	if (*ppos == -1UL)
+		return NULL;
+
+	stack = stack_depot_get_next_stack(nr_table, NULL);
+
+	return stack;
+}
+
+static void *stack_next(struct seq_file *m, void *v, loff_t *ppos)
+{
+	unsigned long *nr_table = m->private;
+	void *next_stack;
+
+	next_stack = stack_depot_get_next_stack(nr_table, v);
+	*ppos = next_stack ? *ppos + 1 : -1UL;
+
+	return next_stack;
+}
+
+static int stack_depot_get_stack_info(struct stack_record *stack, char *buf)
+{
+	if (!stack->size || stack->size < 0 ||
+	    stack->size > PAGE_SIZE || stack->handle.valid != 1 ||
+	    refcount_read(&stack->count) < 1)
+		return 0;
+
+	return stack_trace_snprint(buf, PAGE_SIZE, stack->entries, stack->size, 0);
+}
+
+static int stack_print(struct seq_file *m, void *v)
+{
+	char *buf;
+	int ret = 0;
+	struct stack_record *stack = (struct stack_record *)v;
+
+	buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
+
+	ret += stack_depot_get_stack_info(stack, buf);
+	if (!ret)
+		goto out;
+
+	scnprintf(buf + ret, PAGE_SIZE - ret, "stack_count: %d\n\n",
+		  refcount_read(&stack->count));
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
+	.start  = stack_start,
+	.next   = stack_next,
+	.stop   = stack_stop,
+	.show   = stack_print
+};
+
+static int page_owner_stack_open(struct inode *inode, struct file *file)
+{
+	return seq_open_private(file, &page_owner_stack_op,
+				sizeof(unsigned long));
+}
+
+const struct file_operations page_owner_stack_operations = {
+	.open           = page_owner_stack_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = seq_release,
+};
+
 static int __init pageowner_init(void)
 {
 	if (!static_branch_unlikely(&page_owner_inited)) {
@@ -728,6 +813,8 @@ static int __init pageowner_init(void)
 
 	debugfs_create_file("page_owner", 0400, NULL, NULL,
 			    &proc_page_owner_operations);
+	debugfs_create_file("page_owner_stacks", 0400, NULL, NULL,
+			    &page_owner_stack_operations);
 
 	return 0;
 }
-- 
2.42.0

