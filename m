Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A937F080D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 18:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjKSRPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 12:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjKSRPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 12:15:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4FBF2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 09:15:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C42C433C8;
        Sun, 19 Nov 2023 17:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700414131;
        bh=wGhN7a1c1/p9kfRbyE8itY6KQu9wn5cOAaIJeGVmnnc=;
        h=From:To:Cc:Subject:Date:From;
        b=XkfEizFwjv4s2yyAh/IAdR4Ce6ANjOrHPS6OuUGobhk63MS2x68e7h7vDvp478EgL
         raG02fy8zS6Zg8iVPZ2/GmQeoINkjLj9ER0t634jT0bMnPTVJlIGwZEuAhRG9bRdGp
         LGqm7giPcvncWcu7qPOQbfn4BAZzlqiiIw4JVn4sJh9HLYuVRRcvUKgpXRLATg3bE3
         Z3/oPm1KhExae4SvDwzPARf/8tZLK4fi6QW6K38QS/kF5fUs0mYxWbzOVIuNMUGEM3
         Jk6MSHWzyA/E66pjT5jbU5I17CbKbEz4aou4ik1VANNJ4G2tAZhC+9o2fL+3tA+Dlu
         j0XgF6IfYEe/w==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm/damon/core: copy nr_accesses when splitting region
Date:   Sun, 19 Nov 2023 17:15:28 +0000
Message-Id: <20231119171529.66863-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

Regions split function ('damon_split_region_at()') is called at the
beginning of an aggregation interval, and when DAMOS applying the
actions and charging quota.  Because 'nr_accesses' fields of all regions
are reset at the beginning of each aggregation interval, and DAMOS was
applying the action at the end of each aggregation interval, there was
no need to copy the 'nr_accesses' field to the split-out region.

However, commit 42f994b71404 ("mm/damon/core: implement scheme-specific
apply interval") made DAMOS applies action on its own timing interval.
Hence, 'nr_accesses' should also copied to split-out regions, but the
commit didn't.  Fix it by copying it.

Fixes: 42f994b71404 ("mm/damon/core: implement scheme-specific apply interval")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Cc-ing stable@ is not needed, since the commit that introduced the issue has
merged in v6.7 merge window.

 mm/damon/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6262d55904e7..ce1562783e7e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1225,6 +1225,7 @@ static void damon_split_region_at(struct damon_target *t,
 	new->age = r->age;
 	new->last_nr_accesses = r->last_nr_accesses;
 	new->nr_accesses_bp = r->nr_accesses_bp;
+	new->nr_accesses = r->nr_accesses;
 
 	damon_insert_region(new, r, damon_next_region(r), t);
 }
-- 
2.34.1

