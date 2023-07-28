Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0EA5767705
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 22:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbjG1UfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 16:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbjG1Uey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 16:34:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E43A449E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 13:34:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B92D062203
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 20:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B668BC433C9;
        Fri, 28 Jul 2023 20:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690576489;
        bh=RNhaUHFt4yEDSg34n1AIbUDtUgo0To5YvQtFN1055is=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p2r8hu9CmFI364JLZUBG5moYhkILhGzb8EUF5UUqi4zpjISMyATubHTf8iaRu+Y3e
         B7Mb9YlocLRyG+jrKWyvPFKDQJHIHMnMaPTd9txEMbGeYRaSJwgaAbCHqkHQg9K0fW
         VibqHFWGC5EnpYUnVK2qUxRfeduyXd72rk2CDLfw2EbHQyq+wZyKy/1sqT5yCbjDgj
         /aoJsj5yLhShWP70po7j3u8d9kh4bpVU6glpe2lFV8+KPa5zSjLDjgg/5R/XkpKt2P
         EevGd1FGvMBFcAwR88pJIotq/h/bcab83pCI7HEFhB+wwMDetEl+nhyJtU+EfdmRb8
         2FkRJskRSLGqA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 01/13] mm/damon/core: introduce address range type damos filter
Date:   Fri, 28 Jul 2023 20:34:32 +0000
Message-Id: <20230728203444.70703-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728203444.70703-1-sj@kernel.org>
References: <20230728203444.70703-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users can know special characteristic of specific address ranges.  NUMA
nodes or special objects or buffers in virtual address space could be
such examples.  For such cases, DAMOS schemes could required to be
applied to only specific address ranges.  Implement yet another type of
DAMOS filter for the purpose.

Note that the existing filter types, namely anon pages and memcg DAMOS
filters needed page level type check.  Because such check can be done
efficiently in the opertions set layer, those filters are handled in
operations set layer.  Specifically, only paddr operations set
implementation supports these filters.  Also, because statistics
counting is done in the DAMON core layer, the regions that filtered out
by these filters are counted as tried but failed to the statistics.

Unlike those, address range based filters can efficiently handled in the
core layer.  Hence, do the handling in the layer, and count the regions
that filtered out by those as the scheme has not tried for the region.
This difference should clearly documented.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 22 +++++++++++++-----
 mm/damon/core.c       | 52 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 6 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index d5d4d19928e0..476f37a883a4 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -226,16 +226,24 @@ struct damos_stat {
  * enum damos_filter_type - Type of memory for &struct damos_filter
  * @DAMOS_FILTER_TYPE_ANON:	Anonymous pages.
  * @DAMOS_FILTER_TYPE_MEMCG:	Specific memcg's pages.
+ * @DAMOS_FILTER_TYPE_ADDR:	Address range.
  * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
  *
- * The support of each filter type is up to running &struct damon_operations.
- * &enum DAMON_OPS_PADDR is supporting all filter types, while
- * &enum DAMON_OPS_VADDR and &enum DAMON_OPS_FVADDR are not supporting any
- * filter types.
+ * The anon pages type and memcg type filters are handled by underlying
+ * &struct damon_operations as a part of scheme action trying, and therefore
+ * accounted as 'tried'.  In contrast, other types are handled by core layer
+ * before trying of the action and therefore not accounted as 'tried'.
+ *
+ * The support of the filters that handled by &struct damon_operations depend
+ * on the running &struct damon_operations.
+ * &enum DAMON_OPS_PADDR supports both anon pages type and memcg type filters,
+ * while &enum DAMON_OPS_VADDR and &enum DAMON_OPS_FVADDR don't support any of
+ * the two types.
  */
 enum damos_filter_type {
 	DAMOS_FILTER_TYPE_ANON,
 	DAMOS_FILTER_TYPE_MEMCG,
+	DAMOS_FILTER_TYPE_ADDR,
 	NR_DAMOS_FILTER_TYPES,
 };
 
@@ -244,18 +252,20 @@ enum damos_filter_type {
  * @type:	Type of the page.
  * @matching:	If the matching page should filtered out or in.
  * @memcg_id:	Memcg id of the question if @type is DAMOS_FILTER_MEMCG.
+ * @addr_range:	Address range if @type is DAMOS_FILTER_TYPE_ADDR.
  * @list:	List head for siblings.
  *
  * Before applying the &damos->action to a memory region, DAMOS checks if each
  * page of the region matches to this and avoid applying the action if so.
- * Note that the check support is up to &struct damon_operations
- * implementation.
+ * Support of each filter type depends on the running &struct damon_operations
+ * and the type.  Refer to &enum damos_filter_type for more detai.
  */
 struct damos_filter {
 	enum damos_filter_type type;
 	bool matching;
 	union {
 		unsigned short memcg_id;
+		struct damon_addr_range addr_range;
 	};
 	struct list_head list;
 };
diff --git a/mm/damon/core.c b/mm/damon/core.c
index cbe5a1cc27c4..c061d289c832 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -906,6 +906,56 @@ static void damos_update_stat(struct damos *s,
 	s->stat.sz_applied += sz_applied;
 }
 
+static bool __damos_filter_out(struct damon_target *t, struct damon_region *r,
+		struct damos_filter *filter)
+{
+	bool matched = false;
+	unsigned long start, end;
+
+	switch (filter->type) {
+	case DAMOS_FILTER_TYPE_ADDR:
+		start = ALIGN_DOWN(filter->addr_range.start, DAMON_MIN_REGION);
+		end = ALIGN_DOWN(filter->addr_range.end, DAMON_MIN_REGION);
+
+		/* inside the range */
+		if (start <= r->ar.start && r->ar.end <= end) {
+			matched = true;
+			break;
+		}
+		/* outside of the range */
+		if (r->ar.end <= start || end <= r->ar.start) {
+			matched = false;
+			break;
+		}
+		/* start before the range and overlap */
+		if (r->ar.start < start) {
+			damon_split_region_at(t, r, start - r->ar.start);
+			matched = false;
+			break;
+		}
+		/* start inside the range */
+		damon_split_region_at(t, r, end - r->ar.start);
+		matched = true;
+		break;
+	default:
+		break;
+	}
+
+	return matched == filter->matching;
+}
+
+static bool damos_filter_out(struct damon_target *t, struct damon_region *r,
+		struct damos *s)
+{
+	struct damos_filter *filter;
+
+	damos_for_each_filter(filter, s) {
+		if (__damos_filter_out(t, r, filter))
+			return true;
+	}
+	return false;
+}
+
 static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		struct damon_region *r, struct damos *s)
 {
@@ -932,6 +982,8 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 			}
 			damon_split_region_at(t, r, sz);
 		}
+		if (damos_filter_out(t, r, s))
+			return;
 		ktime_get_coarse_ts64(&begin);
 		if (c->callback.before_damos_apply)
 			err = c->callback.before_damos_apply(c, t, r, s);
-- 
2.25.1

