Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7A378CA7C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237706AbjH2ROv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237702AbjH2ROV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:14:21 -0400
Received: from out-251.mta1.migadu.com (out-251.mta1.migadu.com [IPv6:2001:41d0:203:375::fb])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56F5E7D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:13:49 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693329224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6r+jJInS3pVfd7hB9KGynpwXDuP9tHCSgnjNZ7TlokM=;
        b=PT1yVeNi/WFW0iBcrm2Hn4oAVO5Mp4hu85tRrRP1HYBbHSPjNipz67GtVxzpFdOYzHKM/M
        EOna2VPwPAI1BS2TmFOrLFsWZmPHYOllcK3aTIE2DJg0Lqwv7JOqQ+rn0o60sbtux81qug
        hC+Sq5lFDkk29LN4JU6YC08g6eDKk+8=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 13/15] stackdepot: add backwards links to hash table buckets
Date:   Tue, 29 Aug 2023 19:11:23 +0200
Message-Id: <e9ed24afd386d12e01c1169c17531f9ce54c0044.1693328501.git.andreyknvl@google.com>
In-Reply-To: <cover.1693328501.git.andreyknvl@google.com>
References: <cover.1693328501.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Maintain links in the stack records to previous entries within the
hash table buckets.

This is preparatory patch for implementing the eviction of stack records
from the stack depot.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/stackdepot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index a84c0debbb9e..641db97d8c7c 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -58,6 +58,7 @@ union handle_parts {
 
 struct stack_record {
 	struct stack_record *next;	/* Link in hash table or freelist */
+	struct stack_record *prev;	/* Link in hash table */
 	u32 hash;			/* Hash in hash table */
 	u32 size;			/* Number of stored frames */
 	union handle_parts handle;
@@ -493,6 +494,9 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 
 		if (new) {
 			new->next = *bucket;
+			new->prev = NULL;
+			if (*bucket)
+				(*bucket)->prev = new;
 			*bucket = new;
 			found = new;
 		}
-- 
2.25.1

