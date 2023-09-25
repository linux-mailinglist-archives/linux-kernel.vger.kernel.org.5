Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584527ACE56
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjIYCiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjIYCik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:38:40 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581401A5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:38:32 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-59bebd5bdadso66411917b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695609511; x=1696214311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5XEvYirztCmygWgA/YyclPRF8/aR4iz+4trJcZQ1vs=;
        b=Z1lzMyTdLTGVjUpL1AU94XTKABwqKLX7oujhYDXtiKUiHAmDO21DkkCpltRHJN3Y5b
         qLYnoZ7T168q+GQmrOmHeeIMVt3lIdjpXRSTFmM2pHQYQrib8tYI3kOa6f/XiOut/L6L
         ClBdoqzQ1nZD01VLXGEkCvT5geHHtIHgfBaXK7O7vBNQ6VDGZKilv9El695btJykonLV
         +VMBkcYc4+TQOGce/KHaRM3fO0iOyUSSIpHiuFxJ9pa4vVxogiDN4WtO2ux1QIyy9c/d
         da2ObZULoQ7oXARvW3oFDLAfoX71rrGTA92xHO1BC26HDNqlPjkLUqGDADklHKp+UHjK
         jmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695609511; x=1696214311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5XEvYirztCmygWgA/YyclPRF8/aR4iz+4trJcZQ1vs=;
        b=b/vkrw5U0X7cikOP12puC3gjrFQOmWUhB2vzTQrvqX3hS75MmeOKlrJi6fkLnZTm3c
         F5MlBlMi9G+YcXkCwR+EGgpJ+q9342xFIhtmfo2YfI+I4h/rKR89wHV7WQ1ahnNoRqKS
         GgxRU4QjjmrVgaVJoETDdLFNPOKDqZYPurF2UDQXkCooHTs+VNoY5v5ntZrsKNPp3MMV
         euyw6fRWLR03qwv7n6O65X5uR+K/a5KXBcgsOUOE6vMaiYrQ8EQprv+Di4NtSIwJccGC
         lUBCmrjqb/8/PgBWYStBiuZTRdPcnz879/qBEl0MQHVZQIP4Y5QeOiBmi4twdUZzkrZV
         xyWQ==
X-Gm-Message-State: AOJu0YxXt7sRM6N7fNGldWjtxOjHb7Lh2FElW5IL3oAImdfh97bkZAyp
        Lkpx36EKQ7C01z4RmJRlB1jX6YF3XZE=
X-Google-Smtp-Source: AGHT+IF0GHcs1mVP2hs9Qn4EFWSTl2IaQvlt9Ej6mQTI05TqIPT1Yd/nQgbjSvbJoEGgWE7w1u1eZg==
X-Received: by 2002:a05:690c:3685:b0:59f:4c3a:711d with SMTP id fu5-20020a05690c368500b0059f4c3a711dmr5181430ywb.11.1695609510977;
        Sun, 24 Sep 2023 19:38:30 -0700 (PDT)
Received: from localhost ([2607:fb90:3eac:cd78:b6b5:ba0f:9e64:f2e1])
        by smtp.gmail.com with ESMTPSA id w62-20020a0ded41000000b005837633d9cbsm2147926ywe.64.2023.09.24.19.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 19:38:30 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 6/8] bitmap: replace _reg_op(REG_OP_ISFREE) with find_next_bit()
Date:   Sun, 24 Sep 2023 19:38:15 -0700
Message-Id: <20230925023817.782509-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925023817.782509-1-yury.norov@gmail.com>
References: <20230925023817.782509-1-yury.norov@gmail.com>
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

_reg_op(REG_OP_ISFREE) can be trivially replaced with find_next_bit().
Doing that opens room for potential small_const_nbits() optimization.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 4dba15f2e970..9345a6ffe39d 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1352,7 +1352,7 @@ int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
 {
 	unsigned int len = BIT(order);
 
-	if (!__reg_op(bitmap, pos, order, REG_OP_ISFREE))
+	if (find_next_bit(bitmap, pos + len, pos) < pos + len)
 		return -EBUSY;
 	bitmap_set(bitmap, pos, len);
 	return 0;
-- 
2.39.2

