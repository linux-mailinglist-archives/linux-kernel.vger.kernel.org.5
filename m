Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1EF796EEF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 04:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245080AbjIGCaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 22:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245052AbjIGC3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 22:29:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683341BD3;
        Wed,  6 Sep 2023 19:29:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C04C433C9;
        Thu,  7 Sep 2023 02:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694053785;
        bh=BKOeFu7T8a2LEb2S23swx71FouyPaLhdxkSplv88jDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kW9lSKJUK8+ODGx8+zLAuwY4U8iF1ZuvoO7A+S27Q/xz6o4XPq68SwXNgzmyYnuEj
         7WyyAtobo0uu9GfdSX6ATJ6HmrbwpUrlbRY76oIle3a7639PBD8FsDroWOedtlhvBJ
         BprdBWHVEqzGCzw1lDqWeyDNOvDtW4K3fbPjftNElyFGevEYFcZI9LzRv05kW1qN4M
         6PYPngTZqKcq7sHlV9uEdLmA9k+RYmpT5Y6vpkCEZmF6/KzzVksprDIJzoQbnn7lf6
         8EYD5qEPNvxsMDKaO3Nq5KDn2d3yN6qiyuRZxCJf3DJt5CLXz0xiLjdo+Z3cOkkHoo
         eI3cefVYuwqfg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] mm/damon/core: remove 'struct target *' parameter from damon_aggregated tracepoint
Date:   Thu,  7 Sep 2023 02:29:29 +0000
Message-Id: <20230907022929.91361-12-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230907022929.91361-1-sj@kernel.org>
References: <20230907022929.91361-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

damon_aggregateed tracepoint is receiving 'struct target *', but doesn't
use it.  Remove it from the prototype.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/trace/events/damon.h | 6 +++---
 mm/damon/core.c              | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index c79f1d4c39af..0b8d13bde17a 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -11,10 +11,10 @@
 
 TRACE_EVENT(damon_aggregated,
 
-	TP_PROTO(struct damon_target *t, unsigned int target_id,
-		struct damon_region *r, unsigned int nr_regions),
+	TP_PROTO(unsigned int target_id, struct damon_region *r,
+		unsigned int nr_regions),
 
-	TP_ARGS(t, target_id, r, nr_regions),
+	TP_ARGS(target_id, r, nr_regions),
 
 	TP_STRUCT__entry(
 		__field(unsigned long, target_id)
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 1ce483a3c2b5..b895f70acb2d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -805,7 +805,7 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 		struct damon_region *r;
 
 		damon_for_each_region(r, t) {
-			trace_damon_aggregated(t, ti, r, damon_nr_regions(t));
+			trace_damon_aggregated(ti, r, damon_nr_regions(t));
 			r->last_nr_accesses = r->nr_accesses;
 			r->nr_accesses = 0;
 		}
-- 
2.25.1

