Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0639F7D8D86
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 05:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345273AbjJ0Dje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 23:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345248AbjJ0Djc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 23:39:32 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584D9198
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 20:39:07 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5aa7172bafdso1326470a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 20:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698377947; x=1698982747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMjhw76FECkOO5zRdU6IjOHgP+3TMOQK2mZ19zJdvuE=;
        b=AuoT6Ymrit+ZplwF9h5pZgz5X2ydjFt5NqEFhn5MYDY6PFkj4TMwjfLxY/hqZRqWJL
         n+QeVjvAwwIMabb8Aof754791skcrsrIgCTxK5ZO+hn1PXRY7hhhhveeEtDOjyrk5zxn
         cwucZRpdPKVx3VcrxovDJnbLg0Y3Xe02GJPoiUiyi1D5zU+DY6WRDNUxm77DlBlnIK52
         4RYDp/SKZ8O7jkKsUB7R4EpQjmXoP+yEm5gN97k878r/SkQebOdzl3bRAfvfOrqQ0Egd
         uorpPXUIZLygh/M1AVJY1Aq+EDMZUOljrEckiyiI7T53fJlpeNKuMQ187ycHOFN2bF4M
         7RAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698377947; x=1698982747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMjhw76FECkOO5zRdU6IjOHgP+3TMOQK2mZ19zJdvuE=;
        b=QEcIT6fk79OJtTTGEXU9MuT25a1//MgcEdWtl+EyYe7r2sShLeCCL1LxvBWaaA/lhL
         9i82TMJUARkf90UJxUIt4djVOsvP3nCBMh+GFM0wOLD83UGUIsvqg5tcEONf/bFrwXwt
         UQuxo0atA9ZgftLKeYMkfadBJUv7e+VtYfv1pLGy8w7yXnbN5l/N3B0HLeT1VNleAw/7
         aZDuv/Ux03X8RjIQ++E1r6cRQLTLgF16EixYME+9z0JKgGRr8cvmThPAOdoecc/hyn4q
         J8xttJWLCCnekIhgSAG//8OC4YFhxJrYb+bWVZ3crsopM/B+2/9nKVoBMf6UE0VveuXK
         X77g==
X-Gm-Message-State: AOJu0YzWYBfp0VIaE9wj7nq2hsF8noKuhO4Pw+Cd41UPKS/zqMBLeOEd
        HRxVSvWInzBTxCRy9Jc4KHvyhw==
X-Google-Smtp-Source: AGHT+IE+9o1D6mC/tBfbhMEHSHxO+4OKy9VNzv+o8iR1rqr4G54ZqAEfL4OOVueaw3fQnMy76xQeKg==
X-Received: by 2002:a05:6a21:3d89:b0:17b:3cd6:b1bc with SMTP id bj9-20020a056a213d8900b0017b3cd6b1bcmr1812360pzc.14.1698377946837;
        Thu, 26 Oct 2023 20:39:06 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id ms19-20020a17090b235300b00267d9f4d340sm2345676pjb.44.2023.10.26.20.38.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Oct 2023 20:39:06 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com
Cc:     zhangpeng.00@bytedance.com, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 01/10] maple_tree: Add mt_free_one() and mt_attr() helpers
Date:   Fri, 27 Oct 2023 11:38:36 +0800
Message-Id: <20231027033845.90608-2-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231027033845.90608-1-zhangpeng.00@bytedance.com>
References: <20231027033845.90608-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two helpers:
1. mt_free_one(), used to free a maple node.
2. mt_attr(), used to obtain the attributes of maple tree.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index bb24d84a4922..ca7039633844 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -165,6 +165,11 @@ static inline int mt_alloc_bulk(gfp_t gfp, size_t size, void **nodes)
 	return kmem_cache_alloc_bulk(maple_node_cache, gfp, size, nodes);
 }
 
+static inline void mt_free_one(struct maple_node *node)
+{
+	kmem_cache_free(maple_node_cache, node);
+}
+
 static inline void mt_free_bulk(size_t size, void __rcu **nodes)
 {
 	kmem_cache_free_bulk(maple_node_cache, size, (void **)nodes);
@@ -205,6 +210,11 @@ static unsigned int mas_mt_height(struct ma_state *mas)
 	return mt_height(mas->tree);
 }
 
+static inline unsigned int mt_attr(struct maple_tree *mt)
+{
+	return mt->ma_flags & ~MT_FLAGS_HEIGHT_MASK;
+}
+
 static inline enum maple_type mte_node_type(const struct maple_enode *entry)
 {
 	return ((unsigned long)entry >> MAPLE_NODE_TYPE_SHIFT) &
@@ -5573,7 +5583,7 @@ void mas_destroy(struct ma_state *mas)
 			mt_free_bulk(count, (void __rcu **)&node->slot[1]);
 			total -= count;
 		}
-		kmem_cache_free(maple_node_cache, node);
+		mt_free_one(ma_mnode_ptr(node));
 		total--;
 	}
 
-- 
2.20.1

