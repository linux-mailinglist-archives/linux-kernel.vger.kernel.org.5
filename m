Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB1A7F1B98
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbjKTRv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbjKTRvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:51:23 -0500
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EDED45
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:50:45 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700502643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uhMrVBrzgAoT1gwViC8KxLkH9OMZhix/uhvoEc70W98=;
        b=lATFUJLNYsof+QZ6G2sBXsnC9Q+wIKDyc8lFVJDjx9RK2nGA9FoeQs6kQO+6hjM8HBefIP
        eURADnY2Rf+gcAsebe+mW3WuHxDxbtNbYaSjhKQqLHNAk7mVow4Kb9CTZdG5zssygETF+r
        BwY3IBxnt51rdnlRs7VhwlO0TNcSVR8=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v4 19/22] kasan: check object_size in kasan_complete_mode_report_info
Date:   Mon, 20 Nov 2023 18:47:17 +0100
Message-Id: <68c6948175aadd7e7e7deea61725103d64a4528f.1700502145.git.andreyknvl@google.com>
In-Reply-To: <cover.1700502145.git.andreyknvl@google.com>
References: <cover.1700502145.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Check the object size when looking up entries in the stack ring.

If the size of the object for which a report is being printed does not
match the size of the object for which a stack trace has been saved in
the stack ring, the saved stack trace is irrelevant.

Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v2->v3:
- Added missing "../slab.h" include for accessing a kmem_cache field.

Changes v1->v2:
- This is a new patch.
---
 mm/kasan/report_tags.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
index 78abdcde5da9..55154743f915 100644
--- a/mm/kasan/report_tags.c
+++ b/mm/kasan/report_tags.c
@@ -7,6 +7,7 @@
 #include <linux/atomic.h>
 
 #include "kasan.h"
+#include "../slab.h"
 
 extern struct kasan_stack_ring stack_ring;
 
@@ -58,7 +59,8 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
 		entry = &stack_ring.entries[i % stack_ring.size];
 
 		if (kasan_reset_tag(entry->ptr) != info->object ||
-		    get_tag(entry->ptr) != get_tag(info->access_addr))
+		    get_tag(entry->ptr) != get_tag(info->access_addr) ||
+		    info->cache->object_size != entry->size)
 			continue;
 
 		if (entry->is_free) {
-- 
2.25.1

