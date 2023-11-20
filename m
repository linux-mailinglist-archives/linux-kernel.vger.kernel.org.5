Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06117F1B9A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbjKTRwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbjKTRvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:51:25 -0500
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542FA1988
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:50:47 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700502645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mWJyEm6VyaOWhREL8AAhhvtbKxcDTX0iHOdq2I7biaE=;
        b=WmK6QhekX7FInJyHV2uIR20pRmvpYax2GIBAaZMlPJyA0fa28yyqkU2wHc9EZkcNKhaGVw
        rpPS5IdkJL5crjQMbxbFNxa8MnpB9QR4IgbAId2GDpPOic2y+TwrC0P2SZxzr/nb1ApKtj
        eY3o0dSnWGXhfqV2/RcUKsx+woR/BOo=
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
Subject: [PATCH v4 22/22] lib/stackdepot: adjust DEPOT_POOLS_CAP for KMSAN
Date:   Mon, 20 Nov 2023 18:47:20 +0100
Message-Id: <301a115cf7ce8ddb42ef6de9151c2bb76ba728fc.1700502145.git.andreyknvl@google.com>
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

KMSAN is frequently used in fuzzing scenarios and thus saves a lot of
stack traces. As KMSAN does not support evicting stack traces from the
stack depot, the stack depot capacity might be reached quickly with large
stack records.

Adjust the maximum number of stack depot pools for this case.

The average size of a stack trace saved into the stack depot is ~16
frames. Thus, adjust the maximum pools number accordingly to keep the
maximum number of stack traces that can be saved into the stack depot
similar to the one that was allowed before the stack trace eviction
changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/stackdepot.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index c1b31160f4b4..870cce2f4cbd 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -41,7 +41,17 @@
 #define DEPOT_OFFSET_BITS (DEPOT_POOL_ORDER + PAGE_SHIFT - DEPOT_STACK_ALIGN)
 #define DEPOT_POOL_INDEX_BITS (DEPOT_HANDLE_BITS - DEPOT_OFFSET_BITS - \
 			       STACK_DEPOT_EXTRA_BITS)
+#if IS_ENABLED(CONFIG_KMSAN) && CONFIG_STACKDEPOT_MAX_FRAMES >= 32
+/*
+ * KMSAN is frequently used in fuzzing scenarios and thus saves a lot of stack
+ * traces. As KMSAN does not support evicting stack traces from the stack
+ * depot, the stack depot capacity might be reached quickly with large stack
+ * records. Adjust the maximum number of stack depot pools for this case.
+ */
+#define DEPOT_POOLS_CAP (8192 * (CONFIG_STACKDEPOT_MAX_FRAMES / 16))
+#else
 #define DEPOT_POOLS_CAP 8192
+#endif
 #define DEPOT_MAX_POOLS \
 	(((1LL << (DEPOT_POOL_INDEX_BITS)) < DEPOT_POOLS_CAP) ? \
 	 (1LL << (DEPOT_POOL_INDEX_BITS)) : DEPOT_POOLS_CAP)
-- 
2.25.1

