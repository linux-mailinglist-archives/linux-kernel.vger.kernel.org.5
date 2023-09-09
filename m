Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327AE799626
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 05:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244716AbjIIDhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 23:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240919AbjIIDhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 23:37:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314591FEA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 20:37:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A803BC433CD;
        Sat,  9 Sep 2023 03:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694230649;
        bh=u4g+CGjCZbG2QHJKasID6b5E2s2G6qeOdsap6ruSGmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Izsy8M9gmHRZoYcw3BIdjHqk4Bh4D39q8DOc/nlB1dcLYYvpMQGZxHev79ESz2uns
         WEu/9IXL70k9mccElhHgYBm8RqMZJk6rScKpW7vnlzL/IY3fsrVG5lAuul/mz7MdGn
         UJrGFRmo4XD9g1Q33/kCg0C+GCVOWZwGsjdlE5Q+MBBRu8xG/fnutSXgquG1SjGdnp
         b+iZW54q/5eZ9jpWecrLxzyz4UXNo3+AXEljpMjsI66zhNXb+aGUk22Q2BQx6qJJ/3
         jT/ulxnTRocN/Vg5EAkvTeirS7OtTYYuLlQwTDc/RZrHcbr/aRpVaxBD2hrKfcwSJu
         Fp0dVQBatu+iw==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 8/8] mm/damon/core: mark damon_moving_sum() as a static function
Date:   Sat,  9 Sep 2023 03:37:11 +0000
Message-Id: <20230909033711.55794-9-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230909033711.55794-1-sj@kernel.org>
References: <20230909033711.55794-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function is used by only mm/damon/core.c.  Mark it as a static
function.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 2 --
 mm/damon/core.c       | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 0fe13482df63..491fdd3e4c76 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -632,8 +632,6 @@ void damon_add_region(struct damon_region *r, struct damon_target *t);
 void damon_destroy_region(struct damon_region *r, struct damon_target *t);
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 		unsigned int nr_ranges);
-unsigned int damon_moving_sum(unsigned int mvsum, unsigned int nomvsum,
-		unsigned int len_window, unsigned int new_value);
 void damon_update_region_access_rate(struct damon_region *r, bool accessed,
 		struct damon_attrs *attrs);
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 1ba7c4669263..83b0cd329e84 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1627,7 +1627,7 @@ int damon_set_region_biggest_system_ram_default(struct damon_target *t,
  *
  * Return: Pseudo-moving average after getting the @new_value.
  */
-unsigned int damon_moving_sum(unsigned int mvsum, unsigned int nomvsum,
+static unsigned int damon_moving_sum(unsigned int mvsum, unsigned int nomvsum,
 		unsigned int len_window, unsigned int new_value)
 {
 	return mvsum - nomvsum / len_window + new_value;
-- 
2.25.1

