Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871137CAD9C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbjJPPfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbjJPPfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:35:02 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A78AD9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:35:00 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-405417465aaso45663965e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697470499; x=1698075299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wB7/iWqEpIuTjd3/Y3wkGwJ3ek+RrsFECJqLSfrqbjo=;
        b=eTAqZMRHRYRjtwE1zjXCNA61wHrjMsItJG9rvZqYVXP4VgRtVk8C4eZE4yLJhsQqAq
         3Ft6J4LYiZidpdwKzGfEk6t2KnyAaREV+LaihKnKJCYVWh4ddgXhLwZHLXW3XM8rFrel
         NGO37zN3L479ya5zb4r707B84eu3NLKmmTqNLdMep1PZ6/xPfX1UcHjLitKU+pP74Uuh
         dPra+tGob3IdjQnGErgxNymw6wVJOmuxv6EqB4HTtnaxhXjqBoSzPC2V8K86cm67dZUb
         tF52USf2eyvU9FUxEim/TeEjIDM/FKIsKlkaLNVZfRPrrON7bXE6TqL5oVzLNkZQoo4b
         9AOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697470499; x=1698075299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wB7/iWqEpIuTjd3/Y3wkGwJ3ek+RrsFECJqLSfrqbjo=;
        b=QiRjKCDXr+bgJa5mqfM6B+G3w+t5K5b+6Ff+rhmOgT/vVEmeN4eIEfxGVE0eM50L9C
         5U6033ZpMqBmuOEvzcRR/JIy28/84XAQPnKPUL7+H10z4EnZzjDr1Rzyfi1M61ARtjYk
         TSIkTkIGE447OuH1Z0mHFz7aOqzKOSSt+4X8/Xv8k4ltV6sNkHPqH0cdokLi/jAWy5sL
         s9YphiH4/Xs9ljAxzr3i2B6DNOA9DRlOSh1AOBFrdazCYltiC51rIr3i1cxI+1xRwT7S
         b3CMZKBkL9MA3J83oIIDqJuJVmmPq8Ro72KnEwDjXHLSL2jx24OYa0j9y/KozhgvnZue
         zmGQ==
X-Gm-Message-State: AOJu0YwmIxAt1K9cAa+wbI9zLjvA2I3MFH1vnLfZpE6kdwDbttb2uU+D
        maKhExf2bycuwLstFIEJbuM=
X-Google-Smtp-Source: AGHT+IENykvCYMH2GUFFnk4c9myhQF291xXM25TEAoR7zDZCDmEgtPOhszVuBAFmH/sAs6yrQpJLwA==
X-Received: by 2002:a5d:420a:0:b0:31f:bdbc:d762 with SMTP id n10-20020a5d420a000000b0031fbdbcd762mr30244049wrq.44.1697470498637;
        Mon, 16 Oct 2023 08:34:58 -0700 (PDT)
Received: from PC-PEDRO-ARCH.lan ([2001:8a0:7280:5801:9441:3dce:686c:bfc7])
        by smtp.gmail.com with ESMTPSA id bx7-20020a5d5b07000000b003232f167df5sm1955283wrb.108.2023.10.16.08.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 08:34:52 -0700 (PDT)
From:   Pedro Falcato <pedro.falcato@gmail.com>
To:     kasan-dev@googlegroups.com, Alexander Potapenko <glider@google.com>
Cc:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Pedro Falcato <pedro.falcato@gmail.com>
Subject: [PATCH v2] mm: kmsan: Panic on failure to allocate early boot metadata
Date:   Mon, 16 Oct 2023 16:34:46 +0100
Message-ID: <20231016153446.132763-1-pedro.falcato@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given large enough allocations and a machine with low enough memory (i.e
a default QEMU VM), it's entirely possible that
kmsan_init_alloc_meta_for_range's shadow+origin allocation fails.

Instead of eating a NULL deref kernel oops, check explicitly for
memblock_alloc() failure and panic with a nice error message.

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
v2:
Address checkpatch warnings, namely:
	- Unsplit a user-visible string
	- Split an overly long line in the commit message
 mm/kmsan/shadow.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
index 87318f9170f..b9d05aff313 100644
--- a/mm/kmsan/shadow.c
+++ b/mm/kmsan/shadow.c
@@ -285,12 +285,17 @@ void __init kmsan_init_alloc_meta_for_range(void *start, void *end)
 	size = PAGE_ALIGN((u64)end - (u64)start);
 	shadow = memblock_alloc(size, PAGE_SIZE);
 	origin = memblock_alloc(size, PAGE_SIZE);
+
+	if (!shadow || !origin)
+		panic("%s: Failed to allocate metadata memory for early boot range of size %llu",
+		      __func__, size);
+
 	for (u64 addr = 0; addr < size; addr += PAGE_SIZE) {
 		page = virt_to_page_or_null((char *)start + addr);
-		shadow_p = virt_to_page_or_null((char *)shadow + addr);
+		shadow_p = virt_to_page((char *)shadow + addr);
 		set_no_shadow_origin_page(shadow_p);
 		shadow_page_for(page) = shadow_p;
-		origin_p = virt_to_page_or_null((char *)origin + addr);
+		origin_p = virt_to_page((char *)origin + addr);
 		set_no_shadow_origin_page(origin_p);
 		origin_page_for(page) = origin_p;
 	}
-- 
2.42.0

