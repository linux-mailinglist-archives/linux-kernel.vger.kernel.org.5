Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E820796E24
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 02:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245013AbjIGAnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 20:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241271AbjIGAnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 20:43:22 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEAB172E;
        Wed,  6 Sep 2023 17:43:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VrV7FoD_1694047394;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VrV7FoD_1694047394)
          by smtp.aliyun-inc.com;
          Thu, 07 Sep 2023 08:43:15 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        james.clark@arm.com, leo.yan@linaro.org
Cc:     mingo@redhat.com, baolin.wang@linux.alibaba.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, bpf@vger.kernel.org
Subject: [PATCH v5 2/2] perf record: Update docs regarding the maximum limitation of AUX area
Date:   Thu,  7 Sep 2023 08:43:08 +0800
Message-Id: <20230907004308.25874-3-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907004308.25874-1-xueshuai@linux.alibaba.com>
References: <20230907004308.25874-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maximum AUX area is limited by the page size of the system. Update
the documentation to reflect this.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 tools/perf/Documentation/perf-record.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 680396c56bd1..dfc322d6f1f1 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -292,6 +292,17 @@ OPTIONS
 	Also, by adding a comma, the number of mmap pages for AUX
 	area tracing can be specified.
 
+	The maximum AUX area is limited by the maximum physically contiguous
+	memory allocated from slab/slub. It can be calculated with following
+	formula:
+
+	  PAGE_SIZE << MAX_ORDER
+	( ---------------------- ) * PAGE_SIZE
+	   sizeof(page_pointer)
+
+	For example with 4K pages and MAX_ORDER=10 configured, the maximum AUX
+	area is 2GiB.
+
 -g::
 	Enables call-graph (stack chain/backtrace) recording for both
 	kernel space and user space.
-- 
2.39.3

