Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2DB7D02C2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 21:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346556AbjJSTtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 15:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346517AbjJSTte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 15:49:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB5711F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:49:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BB7C433C9;
        Thu, 19 Oct 2023 19:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697744973;
        bh=A7qQGX2x61HuX9WngSjrxy/tMdxThwG7cO+vlCnt/oI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lNgSoOfsk3ij3VEBkFziLTTOeodtOyWouwKEqFx+/Vc1mq4dpwxhRKSnXoRwsoucb
         xmeYm9yqQYBthSax96jDtI9ODtXEb7yTCOZCjdebg76CWIbn9yQVDy2jFkZj8rYXd7
         oNq9xzrIQ25Tmf5XiVN2Aee+jPubzu3B3kxz7bjVCA4KdCtkt8pFLhJZjYzNyONzZQ
         PkVOy9fqQoNU8ok3jV6I4nU555Th406ewtAd/tBdhmST6Bpzl33dF6VUag7JudpLqA
         tc87Na/V54yov3Z36qOUQBq0gpwPA3O3j6ZH+zXwVdSxO1X3vjDD/8mnwLNYKGgs1n
         qQNgxlmk5W1XA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] mm/damon/core: avoid divide-by-zero from pseudo-moving window length calculation
Date:   Thu, 19 Oct 2023 19:49:24 +0000
Message-Id: <20231019194924.100347-6-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019194924.100347-1-sj@kernel.org>
References: <20231019194924.100347-1-sj@kernel.org>
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

When calculating the pseudo-moving access rate, DAMON divides some
values by the maximum nr_accesses.  However, due to the type of the
related variables, simple division-based calculation of the divisor can
return zero.  As a result, divide-by-zero is possible.  Fix it by using
damon_max_nr_accesses(), which handles the case.

Note that this is a fix for a commit that not in the mainline but mm
tree.

Fixes: ace30fb21af5 ("mm/damon/core: use pseudo-moving sum for nr_accesses_bp")
Signed-off-by: SeongJae Park <sj@kernel.org>
---

Note that this is for a patch in mm-stable that not yet merged into the
mainline.

 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index e194c8075235..aa2dc7087cd9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1665,7 +1665,7 @@ void damon_update_region_access_rate(struct damon_region *r, bool accessed,
 	 * aggr_interval, owing to validation of damon_set_attrs().
 	 */
 	if (attrs->sample_interval)
-		len_window = attrs->aggr_interval / attrs->sample_interval;
+		len_window = damon_max_nr_accesses(attrs);
 	r->nr_accesses_bp = damon_moving_sum(r->nr_accesses_bp,
 			r->last_nr_accesses * 10000, len_window,
 			accessed ? 10000 : 0);
-- 
2.34.1

