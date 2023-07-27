Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1EC7765891
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbjG0QYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbjG0QXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:23:51 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E7D2D64
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:23:49 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-768054797f7so101768685a.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1690475028; x=1691079828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6xeXNZ7MmGxs9MCe+qdgeE1O4rbj13SYexzHrnrzbc=;
        b=t1KwP89hpnwg0NYhi1k1hMQB/3gQRSOWAy1zvJ7pueqsOL6lMhlnGs29bj9q3R7ed2
         5TGX5AbXfBOKFrqHxQDMSSGFph1MqS/IIURzJrYtuyq5DJDNQSlPgyx6HKbsJCFrgyMs
         etJArP1Qo7jM62rDTvet0BjBWc9wIdYpICMtw4B6tf9ouYzlHD0s6flS1M2mtpzmsp3P
         Tg1utgnTtVxz7Ck+6yn7HuwnCpOeXrrLAxZP/B7IVeVZfU45bb/Ad1ZLt/8jOMuY4acP
         s9Ljx+sG57pZI23evKzyyIa5rmfHvAJu7nn7DIh1eF/R8VZWmTH5gwWvPzEBnh8xunF7
         LIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690475028; x=1691079828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6xeXNZ7MmGxs9MCe+qdgeE1O4rbj13SYexzHrnrzbc=;
        b=NtSpgW7h4tLR1CtowqtNzfZVgxDUc2ptcNdn8nHCiDANe/vlmePDpaOjDWXMbhI9UH
         QGXWoY9uWcARYLoNLDoU5Imbr28ERcpEGHx5sMritglpLc5/JBtyaLUf0FXC/J5a32K4
         PzpqxqWO6ldiEaOVuInPqW+YV5jCofGuC5Evof7zg91CH/TImOm3XxFEwpHekVW8xrT7
         MLxIDbFMyQTo8K2Dh50hjbfVpXdSJPgv0/Trytc2sJmyD46JvdLAJIjRG3KMbj13PVg0
         IylhqNKhBI/okHK1zRC8PLB012ZEebOzfKsxnbgqsQJldDk+E+IXork5d9NIT3gOERHH
         OQ4A==
X-Gm-Message-State: ABy/qLZUwhfqzB54oYBno9DXP6qALgN2s/14eVj6mVWr+OtVK2+ksWaQ
        2vB/HSA5LZ9EXI5indJgl4LMFA==
X-Google-Smtp-Source: APBJJlHsm+mf07gWGmI92coTtdUdEWEsIic/VUEsa+GtEeTjX9B1tCutvPQZueF/jzY9ZsnEbTyiCA==
X-Received: by 2002:a05:620a:ccf:b0:768:b0c:e4c1 with SMTP id b15-20020a05620a0ccf00b007680b0ce4c1mr434494qkj.27.1690475028555;
        Thu, 27 Jul 2023 09:23:48 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ad06])
        by smtp.gmail.com with ESMTPSA id p13-20020ae9f30d000000b0076816153dcdsm505827qkg.106.2023.07.27.09.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 09:23:48 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mm: zswap: tighten up entry invalidation
Date:   Thu, 27 Jul 2023 12:22:24 -0400
Message-ID: <20230727162343.1415598-3-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727162343.1415598-1-hannes@cmpxchg.org>
References: <20230727162343.1415598-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing a zswap entry from the tree is tied to an explicit operation
that's supposed to drop the base reference: swap invalidation,
exclusive load, duplicate store. Don't silently remove the entry on
final put, but instead warn if an entry is in tree without reference.

While in that diff context, convert a BUG_ON to a WARN_ON_ONCE. No
need to crash on a refcount underflow.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index e123b1c7981c..e34ac89e6098 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -402,9 +402,9 @@ static void zswap_entry_put(struct zswap_tree *tree,
 {
 	int refcount = --entry->refcount;
 
-	BUG_ON(refcount < 0);
+	WARN_ON_ONCE(refcount < 0);
 	if (refcount == 0) {
-		zswap_rb_erase(&tree->rbroot, entry);
+		WARN_ON_ONCE(!RB_EMPTY_NODE(&entry->rbnode));
 		zswap_free_entry(entry);
 	}
 }
-- 
2.41.0

