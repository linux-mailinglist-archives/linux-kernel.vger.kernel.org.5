Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586F27D4A34
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbjJXIds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbjJXIdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:33:41 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA64E99
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:33:17 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6be0277c05bso3277371b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698136397; x=1698741197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MLK4HxQMsxrLAQzNmdHMtQCN++SQMztyyHR1MHkRQQ=;
        b=B94SZKzSqsawfuayEI/UehMSGtS4IxKFKCX0IwoUmRF+6j0ja4TTqt59k0u7TDRF1p
         v8R7VVFKp8LBp57ATeW2It8DKLS65pyhb/4rSN1Fuow/XilrMzprvcYO9Ib6AryUsYvt
         YNxAebFQw7nuEBiyji2mdf1YCtIejq8msAXlzACmiB0SxmPyLjHzQ+MhHyFxUncgRaNY
         ET7bPkppLatdrhxoRPCaGsHcAf3WK9yj1xKa7paPjkbbjhvUENO6mKi7Wn9+gnuaK01H
         k5wygUCn0Bb+cF+rTWWBJX3aTMOhgtQZfmuJc8fNMRgGXEcKy9AQYfv8VFC5ClTASV/b
         OPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698136397; x=1698741197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MLK4HxQMsxrLAQzNmdHMtQCN++SQMztyyHR1MHkRQQ=;
        b=Po8hkhLgdT11zcGD1J746JWFuw482mcI5gZ8Dv79Ub7LsT9XJtFdMeWM77cuINTKQ+
         KYKqLpYStSFxlwWKmdd3lHnsSIoD4Bm57Mb52JAeajKd5n6HhCs/uYY5uMUc0M455nv3
         nv05JMqjRpHQJSAK2cv9he/t103fsU7BFFpff0nd/IAcU2evpgK6cuUXUmwz8HUfl5B1
         K7AlCYireDI0O7wteykmu1qSYu3MYhRLQsaJuVRH/RA6xwLLwrFhCjHQrzmnu/XrvKJG
         MWb9ZdhcWzDxhuIeZS12ke+AlefOfsusuOesDbCJAiA2m4KOSQ1dMcTYS3z7xqDlwI/A
         a/yw==
X-Gm-Message-State: AOJu0Yz6T33oI/jsy3To7uFkmef2VVHzHFZkGN65TJDFflUMXAoTpug9
        EOHVxh4DYTq1IO+E0F89eCbdMA==
X-Google-Smtp-Source: AGHT+IHB77N08kpQP3kK7g9QlYWTNYn9tfxBH6TdMNcz14U0iu/fhKvY168Jlzr+1CThhjfwCpOJUw==
X-Received: by 2002:a05:6a00:2292:b0:6bd:7cbd:15a2 with SMTP id f18-20020a056a00229200b006bd7cbd15a2mr10659966pfe.26.1698136397397;
        Tue, 24 Oct 2023 01:33:17 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id y21-20020aa79af5000000b0068be348e35fsm7236977pfp.166.2023.10.24.01.33.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Oct 2023 01:33:17 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com
Cc:     zhangpeng.00@bytedance.com, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 01/10] maple_tree: Add mt_free_one() and mt_attr() helpers
Date:   Tue, 24 Oct 2023 16:32:49 +0800
Message-Id: <20231024083258.65750-2-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231024083258.65750-1-zhangpeng.00@bytedance.com>
References: <20231024083258.65750-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two helpers:
1. mt_free_one(), used to free a maple node.
2. mt_attr(), used to obtain the attributes of maple tree.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
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

