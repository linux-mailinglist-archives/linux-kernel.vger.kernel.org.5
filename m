Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46BB7DF675
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376746AbjKBPdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347525AbjKBPdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:33:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3820185
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=nVJ2BrBhs84Vo8op91bCrEqQKyYGP8iSvvBesTbvcL8=; b=rABb7LV3Tw27YsY9IlOdGOlTXx
        gGljf5bb0ix4DLZ9VPLkCYUfnE881R1/OkrO0I9jJxJPXOQNcozuYIdsSlSdQXgYWL+0BfvUIsr8l
        OdntMdkVRuBIvA5mrZJl2gmABAGqaz97zI56lJ4uYG/mr4NytS0l2BDyigxSySU++od46JThpDDpk
        9TPpW9aTs2ZrB74l6XgpGwzgK1QdlrDR1BVgTjF1IJwQmxR8O/BaWivQnGeUc1DV4Co5qmNokddCm
        bO4jekbhQyrroQtLUQ05nl5LA2G6EM+6L37WhXvk9peSENHrKkp9/Uq6gdbTEeixpxIaJ7P1S4iEA
        WDoLNhLQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qyZgV-0005PI-Eg; Thu, 02 Nov 2023 15:32:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 4C239301C46; Thu,  2 Nov 2023 16:32:39 +0100 (CET)
Message-Id: <20231102152018.285699719@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 02 Nov 2023 16:09:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com
Subject: [PATCH 05/13] perf: Simplify perf_cgroup_connect()
References: <20231102150919.719936610@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use CLASS to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/file.h |    2 +-
 kernel/events/core.c |   19 ++++++++-----------
 2 files changed, 9 insertions(+), 12 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -936,22 +936,20 @@ static inline int perf_cgroup_connect(in
 {
 	struct perf_cgroup *cgrp;
 	struct cgroup_subsys_state *css;
-	struct fd f = fdget(fd);
-	int ret = 0;
+	int ret;
 
+	CLASS(fd, f)(fd);
 	if (!f.file)
 		return -EBADF;
 
 	css = css_tryget_online_from_dir(f.file->f_path.dentry,
 					 &perf_event_cgrp_subsys);
-	if (IS_ERR(css)) {
-		ret = PTR_ERR(css);
-		goto out;
-	}
+	if (IS_ERR(css))
+		return PTR_ERR(css);
 
 	ret = perf_cgroup_ensure_storage(event, css);
 	if (ret)
-		goto out;
+		return ret;
 
 	cgrp = container_of(css, struct perf_cgroup, css);
 	event->cgrp = cgrp;
@@ -963,11 +961,10 @@ static inline int perf_cgroup_connect(in
 	 */
 	if (group_leader && group_leader->cgrp != cgrp) {
 		perf_detach_cgroup(event);
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-out:
-	fdput(f);
-	return ret;
+
+	return 0;
 }
 
 static inline void


