Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F298089E4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443044AbjLGOJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442831AbjLGOJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:09:29 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 529E610C2;
        Thu,  7 Dec 2023 06:09:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 407A412FC;
        Thu,  7 Dec 2023 06:10:20 -0800 (PST)
Received: from e126817.. (e126817.cambridge.arm.com [10.2.3.5])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A71BB3F6C4;
        Thu,  7 Dec 2023 06:09:32 -0800 (PST)
From:   Ben Gainey <ben.gainey@arm.com>
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, Ben Gainey <ben.gainey@arm.com>
Subject: [PATCH] tools/perf: Fix missing reference count get in call_path_from_sample
Date:   Thu,  7 Dec 2023 14:09:11 +0000
Message-ID: <20231207140911.3240408-1-ben.gainey@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The addr_location map and maps fields in the inner loop were missing
calls to map__get/maps__get. The subsequent addr_location__exit call in
each loop puts the map/maps fields causing use-after-free aborts.

This issue reproduces on at least arm64 and x86_64 with something
simple like `perf record -g ls` followed by `perf script -s script.py`
with the following script:

    perf_db_export_mode = True
    perf_db_export_calls = False
    perf_db_export_callchains = True

    def sample_table(*args):
        print(f'sample_table({args})')

    def call_path_table(*args):
        print(f'call_path_table({args}')

Fixes: 0dd5041c9a0ea ("perf addr_location: Add init/exit/copy functions")
Signed-off-by: Ben Gainey <ben.gainey@arm.com>
---
 tools/perf/util/db-export.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index b9fb71ab7a73..106429155c2e 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -253,8 +253,8 @@ static struct call_path *call_path_from_sample(struct db_export *dbe,
 		 */
 		addr_location__init(&al);
 		al.sym = node->ms.sym;
-		al.map = node->ms.map;
-		al.maps = thread__maps(thread);
+		al.map = map__get(node->ms.map);
+		al.maps = maps__get(thread__maps(thread));
 		al.addr = node->ip;
 
 		if (al.map && !al.sym)
-- 
2.43.0

