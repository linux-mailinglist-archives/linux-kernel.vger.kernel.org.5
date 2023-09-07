Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F58D796EE7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 04:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242701AbjIGC3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 22:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241928AbjIGC3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 22:29:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DE119A6;
        Wed,  6 Sep 2023 19:29:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0184BC433C7;
        Thu,  7 Sep 2023 02:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694053780;
        bh=EttCSXcWQaBCLpMduSaDVf+bO6xFKw8ChvQvuGULuQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ohoS0Q5NTqWvbTzBXP57Dq2ofbn2QBljXe1cpT6j4lRuQzRB3V3WC0/jjWNW9zKsh
         Pj0L+aNe9DpvOK+7f35EDNXepLHd2afINFwGotsGZrvFObI/8v0cnnEYpBOI2JUYmH
         /zr4DyQSRbrTK5dB2xtxZlxJVBO3UwjdbgcXEKRHJ7oe+HD6kjIPk8WJR4qzpiLMez
         orXkcK9BjJfpw0WtGMGlpGtkR3tkbB/jErb9/Dcmbg7Npz4s11Z0ecchpXsRgN5L5M
         t0gpXfrIaxSegMGSQeogKMEwEIC3I5l9+WKq0T+o70jZ9Bez1OALFBaPB6txHNOCkN
         ks7bnKiPNy1Vg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] Docs/mm/damon/design: explicitly introduce ``nr_accesses``
Date:   Thu,  7 Sep 2023 02:29:22 +0000
Message-Id: <20230907022929.91361-5-sj@kernel.org>
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

The design document is explaining about the access tracking mechanism
and the access rate counter (nr_accesses), but not directly mentions the
name.  Add a sentence for making it clear.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index a20383d01a95..5c465835a44f 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -163,9 +163,10 @@ assumption (pages in a region have the same access frequencies) is kept, only
 one page in the region is required to be checked.  Thus, for each ``sampling
 interval``, DAMON randomly picks one page in each region, waits for one
 ``sampling interval``, checks whether the page is accessed meanwhile, and
-increases the access frequency of the region if so.  Therefore, the monitoring
-overhead is controllable by setting the number of regions.  DAMON allows users
-to set the minimum and the maximum number of regions for the trade-off.
+increases the access frequency counter of the region if so.  The counter is
+called ``nr_regions`` of the region.  Therefore, the monitoring overhead is
+controllable by setting the number of regions.  DAMON allows users to set the
+minimum and the maximum number of regions for the trade-off.
 
 This scheme, however, cannot preserve the quality of the output if the
 assumption is not guaranteed.
-- 
2.25.1

