Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB337E7370
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 22:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345141AbjKIVPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 16:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjKIVPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 16:15:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C72D5E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 13:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=bkCl5OqaBwjr8Wp3TIpZ0yixG4f4EXLtVKQiFMou+24=; b=JFV5Bs24DOTAdVlRJDZBZDjqg8
        KbUp3wbw/sO3+EpMTVC2NugOWDgz6B82qX6ub7InkVhfaSohe2epXS4L/UPDyINFgij7uso4RE73u
        sEE7FBrH1YlLgIHOgighWrUU/C7mNN6OZut+jy6vm/bQnOj4XpMcG8srhns3uJxjQIiFIrDnEZpPM
        dcPbW6raEZHglI/VOvJinujTcqNkCKOm47zWDYc9u175Jl/sb1Llti588ckCjfkC9jOOqw22pVDVc
        MpJihG+gFGQ8WSFbJ9YSk2wK2+iJOeSKacnevcy4IsliKxn04eg6AwPsSvegPSbgIWoSiT7t+2t7L
        Kp6/Cmag==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r1CMo-009UYw-G8; Thu, 09 Nov 2023 21:15:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gfp: Include __GFP_NOWARN in GFP_NOWAIT
Date:   Thu,  9 Nov 2023 21:15:07 +0000
Message-Id: <20231109211507.2262419-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GFP_NOWAIT callers are always prepared for their allocations to fail
because they fail so frequently.  Forcing the callers to remember to add
__GFP_NOWARN is just annoying and leads to an endless stream of patches
for the places where we forgot to add it.

We can now remove __GFP_NOWARN from all the callers which specify
GFP_NOWAIT, but I'd rather wait a cycle and send patches to each
maintainer instead of creating a big pile of merge conflicts.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/gfp_types.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 6583a58670c5..ae994534a12a 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -274,7 +274,8 @@ typedef unsigned int __bitwise gfp_t;
  * accounted to kmemcg.
  *
  * %GFP_NOWAIT is for kernel allocations that should not stall for direct
- * reclaim, start physical IO or use any filesystem callback.
+ * reclaim, start physical IO or use any filesystem callback.  It is very
+ * likely to fail to allocate memory, even for very small allocations.
  *
  * %GFP_NOIO will use direct reclaim to discard clean pages or slab pages
  * that do not require the starting of any physical IO.
@@ -325,7 +326,7 @@ typedef unsigned int __bitwise gfp_t;
 #define GFP_ATOMIC	(__GFP_HIGH|__GFP_KSWAPD_RECLAIM)
 #define GFP_KERNEL	(__GFP_RECLAIM | __GFP_IO | __GFP_FS)
 #define GFP_KERNEL_ACCOUNT (GFP_KERNEL | __GFP_ACCOUNT)
-#define GFP_NOWAIT	(__GFP_KSWAPD_RECLAIM)
+#define GFP_NOWAIT	(__GFP_KSWAPD_RECLAIM | __GFP_NOWARN)
 #define GFP_NOIO	(__GFP_RECLAIM)
 #define GFP_NOFS	(__GFP_RECLAIM | __GFP_IO)
 #define GFP_USER	(__GFP_RECLAIM | __GFP_IO | __GFP_FS | __GFP_HARDWALL)
-- 
2.42.0

