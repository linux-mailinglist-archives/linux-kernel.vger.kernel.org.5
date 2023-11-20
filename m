Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252587F0DD0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjKTIng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjKTIn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:43:26 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2FC1AA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:43:18 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 58A0D1F855;
        Mon, 20 Nov 2023 08:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700469796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PDH277g7F2wYgGggepn2hqYKq/ycO2DhoCkVXWauxYM=;
        b=vULYWMFMmmaG4S6iAkq5rSYmzy20p9tn1S3i6DL/n7pooOCC0Z+gGAbJ3WGHNnAFjw1Oeb
        OCX2wKXShH5JPzCNgEvnFq1C9WhDIOFSrP9E/HjhIs3ItAn5AwWVeq3djPr7uW40iDdPDj
        a7gK1tVk27s7VosOL1aTePWRIqQUGJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700469796;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PDH277g7F2wYgGggepn2hqYKq/ycO2DhoCkVXWauxYM=;
        b=AePaBT45sbywumguZikXpcc3f5I8qh22AOKqNPJdL4aMGBn+rV5hcc7enjPGv4AhKNpohk
        HO99W3gl6HlKfNCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A1BEA13912;
        Mon, 20 Nov 2023 08:43:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uEGWJCMcW2U3VgAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 20 Nov 2023 08:43:15 +0000
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
Subject: [PATCH v6 4/4] mm,page_owner: Filter out stacks by a threshold counter
Date:   Mon, 20 Nov 2023 09:43:00 +0100
Message-Id: <20231120084300.4368-5-osalvador@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231120084300.4368-1-osalvador@suse.de>
References: <20231120084300.4368-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Score: 4.20
X-Spamd-Result: default: False [4.20 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         MIME_GOOD(-0.10)[text/plain];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         REPLY(-4.00)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_RATELIMIT(0.00)[to_ip_from(RL5rfg3hcnr63ytnowg6b9545r)];
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

We want to be able to filter out the output based on a certain
threshold, so we can leave out stacks with a low counter of
outstanding allocations.

We can control the threshold value by a new file called
'page_owner_threshold', which is 0 by default.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/page_owner.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 509c11e506db..6ee345dafd01 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -41,6 +41,8 @@ static depot_stack_handle_t dummy_handle;
 static depot_stack_handle_t failure_handle;
 static depot_stack_handle_t early_handle;
 
+static unsigned long page_owner_stack_threshold;
+
 static void init_early_allocated_pages(void);
 
 static int __init early_page_owner_param(char *buf)
@@ -763,6 +765,9 @@ static int stack_print(struct seq_file *m, void *v)
 	int ret = 0;
 	struct stack_record *stack = (struct stack_record *)v;
 
+	if (refcount_read(&stack->count) < page_owner_stack_threshold)
+		return 0;
+
 	buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
 
 	ret += stack_depot_get_stack_info(stack, buf);
@@ -804,6 +809,21 @@ const struct file_operations page_owner_stack_operations = {
 	.release        = seq_release,
 };
 
+int page_owner_threshold_get(void *data, u64 *val)
+{
+	*val = page_owner_stack_threshold;
+	return 0;
+}
+
+int page_owner_threshold_set(void *data, u64 val)
+{
+	page_owner_stack_threshold = val;
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(proc_page_owner_threshold, &page_owner_threshold_get,
+			&page_owner_threshold_set, "%llu");
+
 static int __init pageowner_init(void)
 {
 	if (!static_branch_unlikely(&page_owner_inited)) {
@@ -815,6 +835,8 @@ static int __init pageowner_init(void)
 			    &proc_page_owner_operations);
 	debugfs_create_file("page_owner_stacks", 0400, NULL, NULL,
 			    &page_owner_stack_operations);
+	debugfs_create_file("page_owner_threshold", 0600, NULL, NULL,
+			    &proc_page_owner_threshold);
 
 	return 0;
 }
-- 
2.42.0

