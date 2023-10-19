Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406C07D02BC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 21:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346526AbjJSTtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 15:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346466AbjJSTtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 15:49:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F745114;
        Thu, 19 Oct 2023 12:49:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F74C433C9;
        Thu, 19 Oct 2023 19:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697744970;
        bh=JqMVIy0mCbZQnCjtrYElDQM3Dsnc1xV+CtQNq7jTX4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oe6x2sCUCq4JfvkLqpDa4AQ+8p4t2drxdj8w0WFjYf1hxoNLFLp0vaQyeQ2Fc7j+J
         2dPCch5ISN4TtP+cfgKjTVNCyIucKm3x3veg9XYIDq0nZ4dw4WO49I1KZAiEq6mQae
         DH+2HwS7+ej8MoOkb74v7OTx04+XRrJNyzlFwsK2oquSwLQYbewr/2rZMAZXriQUMv
         wP5LugNRndnmkqm9QCG3rgRkJd5JOb8OBuvRjAFkg4352A/MgAeCdCe0ZPxyuoju6h
         Ax7kASeHfQQLqMi3wUh8GQTMqxg65h0B92mS1Cxv7gGLnvwDjOk4281T9dP7jqX7BC
         19G38VMbA3q2w==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 1/5] mm/damon: implement a function for max nr_accesses safe calculation
Date:   Thu, 19 Oct 2023 19:49:20 +0000
Message-Id: <20231019194924.100347-2-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019194924.100347-1-sj@kernel.org>
References: <20231019194924.100347-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maximum nr_accesses of given DAMON context can be calculated by
dividing the aggregation interval by the sampling interval.  Some logics
in DAMON uses the maximum nr_accesses as a divisor.  Hence, the value
shouldn't be zero.  Such case is avoided since DAMON avoids setting the
agregation interval as samller than the sampling interval.  However,
since nr_accesses is unsigned int while the intervals are unsigned long,
the maximum nr_accesses could be zero while casting.  Implement a
function that handles the corner case.

Note that this commit is not fixing the real issue since this is only
introducing the safe function that will replaces the problematic
divisions.  The replacements will be made by followup commits, to make
backporting on stable series easier.

Fixes: 198f0f4c58b9 ("mm/damon/vaddr,paddr: support pageout prioritization")
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 27b995c22497..ab2f17d9926b 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -681,6 +681,13 @@ static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
 	return ctx->ops.id == DAMON_OPS_VADDR || ctx->ops.id == DAMON_OPS_FVADDR;
 }
 
+static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs)
+{
+	/* {aggr,sample}_interval are unsigned long, hence could overflow */
+	return min(attrs->aggr_interval / attrs->sample_interval,
+			(unsigned long)UINT_MAX);
+}
+
 
 int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive);
 int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
-- 
2.34.1

