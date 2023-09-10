Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42598799C70
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 05:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345705AbjIJDlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 23:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241204AbjIJDk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 23:40:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD64318F;
        Sat,  9 Sep 2023 20:40:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E782EC433CD;
        Sun, 10 Sep 2023 03:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694317253;
        bh=MX3U5PAIeegCJCB7eLilaWjnagt4bwpadGy8uCoTAPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ukwU7ClsMJzswDPgiPqi34noD/YWgkgpYy9DTKZv6j27OpTnHzCYojjnIIeATvJYN
         ahttWt3gMemTLniiTvBNfWs/xtDY8/cnBxOVexAWmn/45Om5A9B80Fyd8Lh4ayso3S
         h2IOtpquQVNeVk/ljEco9I+zHWzG9plGhihdWjIUaDeakrlOgGuNxa+XnnDi/A8gfO
         N70z6/+H4ITZFIZp3II+NPOj7wCMGK/ofQn13w16+xfVvSR5dGtKacsaVZgLXNbC3d
         I4z7iTc426dEh1+QdaG28ZXBNBtTVotkJ75bMNBlcObJljwa3L3QDiAfMbfxEPN47s
         bXb9XM7/1Dh8w==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 3/8] mm/damon/core: expose nr_accesses_bp from damos_before_apply tracepoint
Date:   Sun, 10 Sep 2023 03:40:43 +0000
Message-Id: <20230910034048.59191-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230910034048.59191-1-sj@kernel.org>
References: <20230910034048.59191-1-sj@kernel.org>
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

damos_before_apply tracepoint is exposing access rate of DAMON regions
using nr_accesses, which was actually used by DAMOS in the past.
However, it has changed to use nr_accesses_bp instead.  Update the
tracepoint to expose the value that DAMOS is really using.  Note that it
doesn't expose the value as is in the basis point, but after converting
it to the natural number by dividing it by 10,000.  That's for avoiding
confuses for old users.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/trace/events/damon.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index 9e7b39495b05..6f98198c0104 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -34,7 +34,7 @@ TRACE_EVENT(damos_before_apply,
 		__entry->target_idx = target_idx;
 		__entry->start = r->ar.start;
 		__entry->end = r->ar.end;
-		__entry->nr_accesses = r->nr_accesses;
+		__entry->nr_accesses = r->nr_accesses_bp / 10000;
 		__entry->age = r->age;
 		__entry->nr_regions = nr_regions;
 	),
-- 
2.25.1

