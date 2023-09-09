Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0237799621
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 05:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240984AbjIIDhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 23:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238658AbjIIDha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 23:37:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61381FE0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 20:37:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9D3C433CA;
        Sat,  9 Sep 2023 03:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694230645;
        bh=i00VYLhoAf7cwF/8O1Xi88bbaOl2lSsV4k5ng0qJ0ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VD7vx44U9dFth1mw8DD6/tF3vY8dJrY4i0AbyDhCeIvUZ0PjoyjTr0uDrc4XE++6n
         GKp6zJxyQBZgrTBQa3ylYI1tcapLevgnxvqbFpynlo61t/XVs6nxWadFFQ7Lh6ptWr
         Fo0v4zlMnz571bTWOm/PJ9kouinp00CWg6XtI/LEvgRfidGdzVyDiYmXcHo71yevdR
         vrv79Lsj0MmfleOGdqLnGH9DolmAid835/T8ZIwLIUkzZY2si3odwvphQjQNLxTdzD
         TltpVKUxSogUHAUYT7Fa7Ds0wUbsk6PPBcwzRrlSeZUTuzdfWn8WTwYW4jz5Ye7nkZ
         9A7wodJebTOzw==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 2/8] mm/damon/vaddr: call damon_update_region_access_rate() always
Date:   Sat,  9 Sep 2023 03:37:05 +0000
Message-Id: <20230909033711.55794-3-sj@kernel.org>
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

