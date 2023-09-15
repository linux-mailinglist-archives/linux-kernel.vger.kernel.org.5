Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BC47A1409
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 04:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjIOCxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 22:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjIOCxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 22:53:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97669272C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 19:53:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC4AC43391;
        Fri, 15 Sep 2023 02:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694746392;
        bh=RYtjac5KN7rdOK43JC6LnDJ12z7FKzya3dCtCsi8Y0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GgK6DIT/rJEDrFaud01fxNb9X9ulgXc+DHEZpEYNHpQBHaq6gCDhkm5CNvhTtn3nY
         UbHvgHF8XfDy9iIQIOfKt9G99WrG6wz1rwaSpybz3ut17/5oFJLGNwPwq1dcXrWKXw
         07Q++0DI8CyHA7uWn8iE/iur/xjP7LIoSyXDJG46430Bw910FuSgyA45Gs5G4frZcV
         Ta3OJrD342CslwNXGEcjPCByNlfc4PH3dXgyopGgHEaLztbBRCa9GDKaRR+CsuB4V7
         OzStFx2T2Mv1/CPjbye7T09snFeyN6HXv+p2/gZ5lgLUNFJItBRAK+qhQ0xw8XEGD0
         hlGk0P+/2eBlQ==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] mm/damon/core: mark damon_moving_sum() as a static function
Date:   Fri, 15 Sep 2023 02:52:51 +0000
Message-Id: <20230915025251.72816-9-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230915025251.72816-1-sj@kernel.org>
References: <20230915025251.72816-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 45cc108c0fe1..b15cf47d2d29 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1587,7 +1587,7 @@ int damon_set_region_biggest_system_ram_default(struct damon_target *t,
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

