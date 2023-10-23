Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BF27D3C6A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjJWQ0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbjJWQ0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:26:17 -0400
X-Greylist: delayed 129 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Oct 2023 09:26:15 PDT
Received: from out-210.mta1.migadu.com (out-210.mta1.migadu.com [IPv6:2001:41d0:203:375::d2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C2F10E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:26:14 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698078373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uhMrVBrzgAoT1gwViC8KxLkH9OMZhix/uhvoEc70W98=;
        b=Ne3J1RXv7CfIkYMjEOEAo2MOXXrLjJl0MG/nn5TuOVSCeJC7ACQ8Zc+U0+7fVaprnL1TwV
        YcPWlAN0bBL1/0CJWM+oWPOfzdH5fmC91XjSmronfj3U3HMmSByKdvCQOOSWPbS9RJ3nc5
        z58ccvrjKa1GY9FZizpTtMWzArqCzuI=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v3 18/19] kasan: check object_size in kasan_complete_mode_report_info
Date:   Mon, 23 Oct 2023 18:22:49 +0200
Message-Id: <97721c54e9ccacc494dbcfcd0cbd5f5aaab6973b.1698077459.git.andreyknvl@google.com>
In-Reply-To: <cover.1698077459.git.andreyknvl@google.com>
References: <cover.1698077459.git.andreyknvl@google.com>
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

