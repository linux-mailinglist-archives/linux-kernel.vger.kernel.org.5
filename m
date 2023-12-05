Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EF38044E1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346441AbjLEC3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344107AbjLEC3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:29:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F820124
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 18:29:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4127C433C9;
        Tue,  5 Dec 2023 02:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701743345;
        bh=hl6U6OugfgCPU2deKjlNge8ZmSL6lB/DjRx+v2yMHcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J6aY+O82JRLvi9ZiWWCgNK9dzhk/rfbzFntuVc90rQCW/Qz98hD+qf1B+yrS8lvYu
         XUIDJKNblYxLPqmArrgtOb4NxmUhlPnUNpFSomqcHGzLHD5JVDiUduOhmugOvLbPuG
         WXOEHM3IGOGqXhKGrZP+kJjf38+ykbHuleoo3E2+2yRd/8nRjGgl0uDINgj1OVDnk7
         fTsDY58oxNXjT2WKpZZNi8iSjrAKre/9np2NhgNBqh9iA11U2kLCJMxhTbSk7qKbNk
         EjaY/ejgRFM9qz4Bh/64/9Hk5OeEN3dcCKJ8PT/UHgvKQ6lFDxvOOsNwUmnw+bC2jq
         FLJrF+YB+LCKw==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mm/damon/core: export symbols for supporting loadable modules
Date:   Tue,  5 Dec 2023 02:28:56 +0000
Message-Id: <20231205022858.1540-2-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205022858.1540-1-sj@kernel.org>
References: <20231205022858.1540-1-sj@kernel.org>
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

Expose minimum DAMON core symbols for supporting use of basic
functionality from loadable modules.  Followup commits will add sample
loadable modules that use the exported symbols.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index f91715a58dc7..8a5c3e905738 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -111,6 +111,7 @@ int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id)
 	mutex_unlock(&damon_ops_lock);
 	return err;
 }
+EXPORT_SYMBOL(damon_select_ops);
 
 /*
  * Construct a damon_region struct
@@ -343,6 +344,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 
 	return scheme;
 }
+EXPORT_SYMBOL(damon_new_scheme);
 
 static void damos_set_next_apply_sis(struct damos *s, struct damon_ctx *ctx)
 {
@@ -380,6 +382,7 @@ void damon_destroy_scheme(struct damos *s)
 	damon_del_scheme(s);
 	damon_free_scheme(s);
 }
+EXPORT_SYMBOL(damon_destroy_scheme);
 
 /*
  * Construct a damon_target struct
@@ -401,11 +404,13 @@ struct damon_target *damon_new_target(void)
 
 	return t;
 }
+EXPORT_SYMBOL(damon_new_target);
 
 void damon_add_target(struct damon_ctx *ctx, struct damon_target *t)
 {
 	list_add_tail(&t->list, &ctx->adaptive_targets);
 }
+EXPORT_SYMBOL(damon_add_target);
 
 bool damon_targets_empty(struct damon_ctx *ctx)
 {
@@ -464,6 +469,7 @@ struct damon_ctx *damon_new_ctx(void)
 
 	return ctx;
 }
+EXPORT_SYMBOL(damon_new_ctx);
 
 static void damon_destroy_targets(struct damon_ctx *ctx)
 {
@@ -489,6 +495,7 @@ void damon_destroy_ctx(struct damon_ctx *ctx)
 
 	kfree(ctx);
 }
+EXPORT_SYMBOL(damon_destroy_ctx);
 
 static unsigned int damon_age_for_new_attrs(unsigned int age,
 		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
@@ -616,6 +623,7 @@ void damon_set_schemes(struct damon_ctx *ctx, struct damos **schemes,
 	for (i = 0; i < nr_schemes; i++)
 		damon_add_scheme(ctx, schemes[i]);
 }
+EXPORT_SYMBOL(damon_set_schemes);
 
 /**
  * damon_nr_running_ctxs() - Return number of currently running contexts.
@@ -719,6 +727,7 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive)
 
 	return err;
 }
+EXPORT_SYMBOL(damon_start);
 
 /*
  * __damon_stop() - Stops monitoring of a given context.
@@ -762,6 +771,7 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
 	}
 	return err;
 }
+EXPORT_SYMBOL(damon_stop);
 
 /*
  * Reset the aggregated monitoring results ('nr_accesses' of each region).
-- 
2.34.1

