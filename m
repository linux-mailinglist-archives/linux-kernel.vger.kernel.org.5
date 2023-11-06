Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AFA7E30B0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 00:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjKFXHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 18:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbjKFXHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 18:07:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7940170C;
        Mon,  6 Nov 2023 15:07:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BD5C433C8;
        Mon,  6 Nov 2023 23:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699312034;
        bh=VHVJ13YZqdYKkwnFgKP74fWXjhwE0I38JVB17STLT78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kqtoSRq4D+AJqQqbNl8/czKE7eoRBWB1dvwMZ9jN6/DKXDHL6nD0RD+UNMu77rJye
         A8atZuo1TUOumTw8YHXceyMe8Lwr4kIiq6S8M/Ll3rr7zg+dUFgMnh4WXSJYuJdy6m
         QPlSg9o7wpONvimyy7ub8LkqcEjgYEqmRrxMrDy/WtHJDzu42v+bEjGEsXYCsY6IGa
         M7sVSq8sXOAn5Bt4Z52YaF4J0jcw6XLFsScyqTniSwqEVAZqphCs2J1okfRz5H9kCA
         w6x+sa/hHwr07ZjAutbOgBu5C3X0v+a38Pm5d+ZP3TfsZmnXPlnK72jOXRm4Kb/OLQ
         5ax+EdchabCEQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Sasha Levin <sashal@kernel.org>, kent.overstreet@linux.dev
Subject: [PATCH AUTOSEL 6.1 2/2] lib/generic-radix-tree.c: Don't overflow in peek()
Date:   Mon,  6 Nov 2023 18:07:09 -0500
Message-ID: <20231106230710.3734490-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106230710.3734490-1-sashal@kernel.org>
References: <20231106230710.3734490-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.61
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

[ Upstream commit 9492261ff2460252cf2d8de89cdf854c7e2b28a0 ]

When we started spreading new inode numbers throughout most of the 64
bit inode space, that triggered some corner case bugs, in particular
some integer overflows related to the radix tree code. Oops.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/generic-radix-tree.h |  7 +++++++
 lib/generic-radix-tree.c           | 17 ++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/generic-radix-tree.h b/include/linux/generic-radix-tree.h
index 107613f7d7920..f6cd0f909d9fb 100644
--- a/include/linux/generic-radix-tree.h
+++ b/include/linux/generic-radix-tree.h
@@ -38,6 +38,7 @@
 
 #include <asm/page.h>
 #include <linux/bug.h>
+#include <linux/limits.h>
 #include <linux/log2.h>
 #include <linux/math.h>
 #include <linux/types.h>
@@ -184,6 +185,12 @@ void *__genradix_iter_peek(struct genradix_iter *, struct __genradix *, size_t);
 static inline void __genradix_iter_advance(struct genradix_iter *iter,
 					   size_t obj_size)
 {
+	if (iter->offset + obj_size < iter->offset) {
+		iter->offset	= SIZE_MAX;
+		iter->pos	= SIZE_MAX;
+		return;
+	}
+
 	iter->offset += obj_size;
 
 	if (!is_power_of_2(obj_size) &&
diff --git a/lib/generic-radix-tree.c b/lib/generic-radix-tree.c
index f25eb111c0516..7dfa88282b006 100644
--- a/lib/generic-radix-tree.c
+++ b/lib/generic-radix-tree.c
@@ -166,6 +166,10 @@ void *__genradix_iter_peek(struct genradix_iter *iter,
 	struct genradix_root *r;
 	struct genradix_node *n;
 	unsigned level, i;
+
+	if (iter->offset == SIZE_MAX)
+		return NULL;
+
 restart:
 	r = READ_ONCE(radix->root);
 	if (!r)
@@ -184,10 +188,17 @@ void *__genradix_iter_peek(struct genradix_iter *iter,
 			(GENRADIX_ARY - 1);
 
 		while (!n->children[i]) {
+			size_t objs_per_ptr = genradix_depth_size(level);
+
+			if (iter->offset + objs_per_ptr < iter->offset) {
+				iter->offset	= SIZE_MAX;
+				iter->pos	= SIZE_MAX;
+				return NULL;
+			}
+
 			i++;
-			iter->offset = round_down(iter->offset +
-					   genradix_depth_size(level),
-					   genradix_depth_size(level));
+			iter->offset = round_down(iter->offset + objs_per_ptr,
+						  objs_per_ptr);
 			iter->pos = (iter->offset >> PAGE_SHIFT) *
 				objs_per_page;
 			if (i == GENRADIX_ARY)
-- 
2.42.0

