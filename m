Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C607D3C60
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjJWQZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjJWQZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:25:12 -0400
Received: from out-201.mta0.migadu.com (out-201.mta0.migadu.com [91.218.175.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63872E4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:25:10 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698078308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EAtH6mtyDDwPJA3G1u2tEpoRGlDDlV29Wi3V3trZXF4=;
        b=kPoNUZX00gmVx2jTNWUBw1MnjfYZ+Ih+Xex2SmhQ0zyGsX2Ioeza+QBykBxwXLreMwqivE
        M2aRr8G1yeGyH9/IfvhHARI9SQY8lVb/5X48pbhNEAEo4GD626fn7sdXdC2E92CjCX+Meu
        xIXcm3bRhi2HV2gkZQpZtoUQzaGzoec=
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
Subject: [PATCH v3 13/19] kmsan: use stack_depot_save instead of __stack_depot_save
Date:   Mon, 23 Oct 2023 18:22:44 +0200
Message-Id: <b043aa9c2e1e076a2d9a039c62e071d3e70ad39e.1698077459.git.andreyknvl@google.com>
In-Reply-To: <cover.1698077459.git.andreyknvl@google.com>
References: <cover.1698077459.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Make KMSAN use stack_depot_save instead of __stack_depot_save,
as it always passes true to __stack_depot_save as the last argument.

Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v1->v2:
- This is a new patch.
---
 mm/kmsan/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/kmsan/core.c b/mm/kmsan/core.c
index 3adb4c1d3b19..5d942f19d12a 100644
--- a/mm/kmsan/core.c
+++ b/mm/kmsan/core.c
@@ -76,7 +76,7 @@ depot_stack_handle_t kmsan_save_stack_with_flags(gfp_t flags,
 	/* Don't sleep. */
 	flags &= ~(__GFP_DIRECT_RECLAIM | __GFP_KSWAPD_RECLAIM);
 
-	handle = __stack_depot_save(entries, nr_entries, flags, true);
+	handle = stack_depot_save(entries, nr_entries, flags);
 	return stack_depot_set_extra_bits(handle, extra);
 }
 
@@ -250,11 +250,10 @@ depot_stack_handle_t kmsan_internal_chain_origin(depot_stack_handle_t id)
 	/*
 	 * @entries is a local var in non-instrumented code, so KMSAN does not
 	 * know it is initialized. Explicitly unpoison it to avoid false
-	 * positives when __stack_depot_save() passes it to instrumented code.
+	 * positives when stack_depot_save() passes it to instrumented code.
 	 */
 	kmsan_internal_unpoison_memory(entries, sizeof(entries), false);
-	handle = __stack_depot_save(entries, ARRAY_SIZE(entries), __GFP_HIGH,
-				    true);
+	handle = stack_depot_save(entries, ARRAY_SIZE(entries), __GFP_HIGH);
 	return stack_depot_set_extra_bits(handle, extra_bits);
 }
 
-- 
2.25.1

