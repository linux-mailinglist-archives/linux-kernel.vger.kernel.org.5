Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C775F7A1405
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 04:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjIOCxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 22:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjIOCxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 22:53:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6322701
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 19:53:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B15C433CA;
        Fri, 15 Sep 2023 02:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694746383;
        bh=i00VYLhoAf7cwF/8O1Xi88bbaOl2lSsV4k5ng0qJ0ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EyWd6QeH+I+otwhxDe5iLd5XAOviRv5NU62+pG7wOYSt1RxJd562R/9kRGV/14S6k
         wqwgK3S/aoyzhC6ERZqSSiw7JvU7BAbifNwCKIe6Ic1N++Fm4YodPXqekKh7wy5E4c
         frf4PtL+Dv7zzGaMntbeugmrQFPZnEwcCuwZ6MVTdQMvr7clAKApk58dlqzx4D9XB7
         gFmgUFdVfZXcHnVsiUAYX4nj2eQscAJwIuXzXjzAOvHwZF0ZRQvEYWdpSJfowFNMuu
         CkJENgkBPYUg94GulS9lebSqQJdp3mZ2b0vLC1KWqzgCeo/tyq22w10Ies9ncnlHit
         8JGVkX6Fe/OWA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] mm/damon/vaddr: call damon_update_region_access_rate() always
Date:   Fri, 15 Sep 2023 02:52:45 +0000
Message-Id: <20230915025251.72816-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230915025251.72816-1-sj@kernel.org>
References: <20230915025251.72816-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When getting mm_struct of the monitoring target process fails, there wil
be no need to increase the access rate counter (nr_accesses) of the
regions for the process.  Hence, damon_va_check_accesses() skips calling
damon_update_region_access_rate() in the case.  This breaks the
assumption that damon_update_region_access_rate() is called for every
region, for every sampling interval.  Call the function for every region
even in the case.  This might increase the overhead in some cases, but
such case would not be frequent, so no significant impact is really
expected.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 7fc0bda73b4c..e36303271f9d 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -563,6 +563,11 @@ static void __damon_va_check_access(struct mm_struct *mm,
 	static unsigned long last_folio_sz = PAGE_SIZE;
 	static bool last_accessed;
 
+	if (!mm) {
+		damon_update_region_access_rate(r, false);
+		return;
+	}
+
 	/* If the region is in the last checked page, reuse the result */
 	if (same_target && (ALIGN_DOWN(last_addr, last_folio_sz) ==
 				ALIGN_DOWN(r->sampling_addr, last_folio_sz))) {
@@ -586,15 +591,14 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
 
 	damon_for_each_target(t, ctx) {
 		mm = damon_get_mm(t);
-		if (!mm)
-			continue;
 		same_target = false;
 		damon_for_each_region(r, t) {
 			__damon_va_check_access(mm, r, same_target);
 			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
 			same_target = true;
 		}
-		mmput(mm);
+		if (mm)
+			mmput(mm);
 	}
 
 	return max_nr_accesses;
-- 
2.25.1

