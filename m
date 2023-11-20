Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05F87F0DCE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjKTIn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbjKTInT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:43:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C749F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:43:14 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 445531F750;
        Mon, 20 Nov 2023 08:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700469793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9KwZyfV7MQI2yuPA0zEe5ABuumoWkd6UHOrlY+2DXtc=;
        b=18reAZ2yAcdBFEdQaz+5irPkXXOsJxea/MYnsQ2USIGUzIzALXtdh1iC3nRFOl3Fa83l0D
        OHUw1+MIjrSfQuR9T8l4yChyFrGeIZjwyqpLPP6qgjQHsoEGBnlbt5vPwMxGsOeXi6z/D3
        wABxJWx6Ce7ztWJih95VFqr3pWmgcIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700469793;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9KwZyfV7MQI2yuPA0zEe5ABuumoWkd6UHOrlY+2DXtc=;
        b=b4bGvsyUeKGgJYWUfFX4xb35t3MGvceX54PAP448j1O6i8ZNYOXZEHgJ7q0xT4BPOq49pN
        NJmqUYfaGjEVT4AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8CA3413912;
        Mon, 20 Nov 2023 08:43:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IEt/HyAcW2U3VgAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 20 Nov 2023 08:43:12 +0000
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
Subject: [PATCH v6 2/4] lib/stackdepot: Move stack_record struct definition into the header
Date:   Mon, 20 Nov 2023 09:42:58 +0100
Message-Id: <20231120084300.4368-3-osalvador@suse.de>
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
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         R_MISSING_CHARSET(2.50)[];
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

In order to move the heavy lifting into page_owner code, this one
needs to have access to stack_record structure, which right now
sits in lib/stackdepot.c.
Move it to the stackdepot.h header so page_owner can access
stack_record's struct fields.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/stackdepot.h | 34 ++++++++++++++++++++++++++++++++++
 lib/stackdepot.c           | 34 ----------------------------------
 2 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index 6ba4fcdb0c5f..269a828a5e94 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -32,6 +32,40 @@ typedef u32 depot_stack_handle_t;
  */
 #define STACK_DEPOT_EXTRA_BITS 5
 
+#define DEPOT_HANDLE_BITS (sizeof(depot_stack_handle_t) * 8)
+
+#define DEPOT_VALID_BITS 1
+#define DEPOT_POOL_ORDER 2 /* Pool size order, 4 pages */
+#define DEPOT_POOL_SIZE (1LL << (PAGE_SHIFT + DEPOT_POOL_ORDER))
+#define DEPOT_STACK_ALIGN 4
+#define DEPOT_OFFSET_BITS (DEPOT_POOL_ORDER + PAGE_SHIFT - DEPOT_STACK_ALIGN)
+#define DEPOT_POOL_INDEX_BITS (DEPOT_HANDLE_BITS - DEPOT_VALID_BITS - \
+			       DEPOT_OFFSET_BITS - STACK_DEPOT_EXTRA_BITS)
+#define DEPOT_POOLS_CAP 8192
+#define DEPOT_MAX_POOLS \
+	(((1LL << (DEPOT_POOL_INDEX_BITS)) < DEPOT_POOLS_CAP) ? \
+	(1LL << (DEPOT_POOL_INDEX_BITS)) : DEPOT_POOLS_CAP)
+
+/* Compact structure that stores a reference to a stack. */
+union handle_parts {
+	depot_stack_handle_t handle;
+	struct {
+		u32 pool_index	: DEPOT_POOL_INDEX_BITS;
+		u32 offset	: DEPOT_OFFSET_BITS;
+		u32 valid	: DEPOT_VALID_BITS;
+		u32 extra	: STACK_DEPOT_EXTRA_BITS;
+	};
+};
+
+struct stack_record {
+	struct stack_record *next;	/* Link in the hash table */
+	u32 hash;			/* Hash in the hash table */
+	u32 size;			/* Number of stored frames */
+	union handle_parts handle;
+	refcount_t count;		/* Number of the same repeated stacks */
+	unsigned long entries[];	/* Variable-sized array of frames */
+};
+
 /*
  * Using stack depot requires its initialization, which can be done in 3 ways:
  *
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index d35edac430c4..1343d3095bc1 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -30,40 +30,6 @@
 #include <linux/memblock.h>
 #include <linux/kasan-enabled.h>
 
-#define DEPOT_HANDLE_BITS (sizeof(depot_stack_handle_t) * 8)
-
-#define DEPOT_VALID_BITS 1
-#define DEPOT_POOL_ORDER 2 /* Pool size order, 4 pages */
-#define DEPOT_POOL_SIZE (1LL << (PAGE_SHIFT + DEPOT_POOL_ORDER))
-#define DEPOT_STACK_ALIGN 4
-#define DEPOT_OFFSET_BITS (DEPOT_POOL_ORDER + PAGE_SHIFT - DEPOT_STACK_ALIGN)
-#define DEPOT_POOL_INDEX_BITS (DEPOT_HANDLE_BITS - DEPOT_VALID_BITS - \
-			       DEPOT_OFFSET_BITS - STACK_DEPOT_EXTRA_BITS)
-#define DEPOT_POOLS_CAP 8192
-#define DEPOT_MAX_POOLS \
-	(((1LL << (DEPOT_POOL_INDEX_BITS)) < DEPOT_POOLS_CAP) ? \
-	 (1LL << (DEPOT_POOL_INDEX_BITS)) : DEPOT_POOLS_CAP)
-
-/* Compact structure that stores a reference to a stack. */
-union handle_parts {
-	depot_stack_handle_t handle;
-	struct {
-		u32 pool_index	: DEPOT_POOL_INDEX_BITS;
-		u32 offset	: DEPOT_OFFSET_BITS;
-		u32 valid	: DEPOT_VALID_BITS;
-		u32 extra	: STACK_DEPOT_EXTRA_BITS;
-	};
-};
-
-struct stack_record {
-	struct stack_record *next;	/* Link in the hash table */
-	u32 hash;			/* Hash in the hash table */
-	u32 size;			/* Number of stored frames */
-	union handle_parts handle;
-	refcount_t count;		/* Number of the same repeated stacks */
-	unsigned long entries[];	/* Variable-sized array of frames */
-};
-
 static bool stack_depot_disabled;
 static bool __stack_depot_early_init_requested __initdata = IS_ENABLED(CONFIG_STACKDEPOT_ALWAYS_INIT);
 static bool __stack_depot_early_init_passed __initdata;
-- 
2.42.0

