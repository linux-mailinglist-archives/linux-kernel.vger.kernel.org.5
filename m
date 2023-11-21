Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E5F7F2558
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 06:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbjKUFgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 00:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjKUFg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 00:36:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EF9D79
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 21:36:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6E5C433CA;
        Tue, 21 Nov 2023 05:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700544976;
        bh=NQFkESlGtOo/Z9kTwMOTiB8dRtXYj2d4RmPD6fS+g6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RuE6wR8s0cxItHT3S4v7846HvTe8lzcB2GDG2usS3By8VthmMpudVeqd8U8fNOrH6
         om/JguB2ZLBLI0bLl3U0NAX7CceryPzzMnPfR9xGRaLfqRcFNiwfDwT6pIaxcK9SV2
         /gtAtDGnJLSTZWk4xkjlCYg3LX7ai4cL0RyKBkq+yp0G0UxgmQX4v/PETr61S7jvDV
         4nMxnm3stGHrnb5XnaXTX5vUlk6CkAFUrSa3qGPDhGNIbTnPrtfGYVcfJaIZJWZOYF
         cME8q3NrmRl3KKcqTti1PJTJ0zNtx7K3SPeH9JonPLtlYq4UYPPx/AVKO6uoc1hiFc
         X13VXI4G9j19Q==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] mm/damon/core: export symbols for supporting loadable modules
Date:   Tue, 21 Nov 2023 05:36:02 +0000
Message-Id: <20231121053604.60798-2-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121053604.60798-1-sj@kernel.org>
References: <20231121053604.60798-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose DAMON core symbols for supporting minimum functionality from
loadable modules.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index c080a16f6bdd..8ab8c902b9e2 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -111,6 +111,7 @@ int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id)
 	mutex_unlock(&damon_ops_lock);
 	return err;
 }
+EXPORT_SYMBOL(damon_select_ops);
 
 /*
  * Construct a damon_region struct
@@ -353,6 +354,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 
 	return scheme;
 }
+EXPORT_SYMBOL(damon_new_scheme);
 
 static void damos_set_next_apply_sis(struct damos *s, struct damon_ctx *ctx)
 {
@@ -390,6 +392,7 @@ void damon_destroy_scheme(struct damos *s)
 	damon_del_scheme(s);
 	damon_free_scheme(s);
 }
+EXPORT_SYMBOL(damon_destroy_scheme);
 
 /*
  * Construct a damon_target struct
@@ -411,11 +414,13 @@ struct damon_target *damon_new_target(void)
 
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
@@ -493,6 +498,7 @@ struct damon_ctx *damon_new_ctx(void)
 
 	return ctx;
 }
+EXPORT_SYMBOL(damon_new_ctx);
 
 static void damon_destroy_targets(struct damon_ctx *ctx)
 {
@@ -518,6 +524,7 @@ void damon_destroy_ctx(struct damon_ctx *ctx)
 
 	kfree(ctx);
 }
+EXPORT_SYMBOL(damon_destroy_ctx);
 
 static unsigned int damon_age_for_new_attrs(unsigned int age,
 		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
@@ -645,6 +652,7 @@ void damon_set_schemes(struct damon_ctx *ctx, struct damos **schemes,
 	for (i = 0; i < nr_schemes; i++)
 		damon_add_scheme(ctx, schemes[i]);
 }
+EXPORT_SYMBOL(damon_set_schemes);
 
 /**
  * damon_nr_running_ctxs() - Return number of currently running contexts.
@@ -748,6 +756,7 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive)
 
 	return err;
 }
+EXPORT_SYMBOL(damon_start);
 
 /*
  * __damon_stop() - Stops monitoring of a given context.
@@ -791,6 +800,7 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
 	}
 	return err;
 }
+EXPORT_SYMBOL(damon_stop);
 
 /*
  * Reset the aggregated monitoring results ('nr_accesses' of each region).
-- 
2.34.1

