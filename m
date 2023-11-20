Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6767F1B5E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbjKTRrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjKTRrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:47:33 -0500
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B871510E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:47:29 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700502447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4GD92F9WT2lJ15sdFM57D7OnzHXCVz8Opyiuivl9/aY=;
        b=qyhdPL9yHGZwgbX97BEztXeCz1Zt+rIj3RmbbGcjPTQsTwh98G4ATjxhFfnwka3CKqD1b6
        x9kwKDWmny/BO2cvVbgqEwg2/wpgt3BzZx3yBf1KxUz7o5wnkBkYXhX4a/sfMby5QWyf2c
        4HelafeGlMBXbFW+ItTdiGsKvqfzEZg=
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
Subject: [PATCH v4 02/22] lib/stackdepot: check disabled flag when fetching
Date:   Mon, 20 Nov 2023 18:47:00 +0100
Message-Id: <c3bfa3b7ab00b2e48ab75a3fbb9c67555777cb08.1700502145.git.andreyknvl@google.com>
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

Do not try fetching a stack trace from the stack depot if the
stack_depot_disabled flag is enabled.

Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/stackdepot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 0eeaef4f2523..f8a8033e1dc8 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -483,7 +483,7 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 	 */
 	kmsan_unpoison_memory(entries, sizeof(*entries));
 
-	if (!handle)
+	if (!handle || stack_depot_disabled)
 		return 0;
 
 	if (parts.pool_index > pool_index_cached) {
-- 
2.25.1

