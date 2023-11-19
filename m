Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B7C7F07BF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 17:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjKSQ6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 11:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjKSQ57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 11:57:59 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99B28138;
        Sun, 19 Nov 2023 08:57:55 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 936051476;
        Sun, 19 Nov 2023 08:58:41 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64E5A3F6C4;
        Sun, 19 Nov 2023 08:57:50 -0800 (PST)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
        maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
        rppt@kernel.org, hughd@google.com
Cc:     pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
        vincenzo.frascino@arm.com, david@redhat.com, eugenis@google.com,
        kcc@google.com, hyesoo.yu@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC v2 03/27] mm: cma: Make CMA_ALLOC_SUCCESS/FAIL count the number of pages
Date:   Sun, 19 Nov 2023 16:56:57 +0000
Message-Id: <20231119165721.9849-4-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231119165721.9849-1-alexandru.elisei@arm.com>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CMA_ALLOC_SUCCESS, respectively CMA_ALLOC_FAIL, are increased by one
after each cma_alloc() function call. This is done even though cma_alloc()
can allocate an arbitrary number of CMA pages. When looking at
/proc/vmstat, the number of successful (or failed) cma_alloc() calls
doesn't tell much with regards to how many CMA pages were allocated via
cma_alloc() versus via the page allocator (regular allocation request or
PCP lists refill).

This can also be rather confusing to a user who isn't familiar with the
code, since the unit of measurement for nr_free_cma is the number of pages,
but cma_alloc_success and cma_alloc_fail count the number of cma_alloc()
function calls.

Let's make this consistent, and arguably more useful, by having
CMA_ALLOC_SUCCESS count the number of successfully allocated CMA pages, and
CMA_ALLOC_FAIL count the number of pages cma_alloc() failed to allocate.

For users that wish to track the number of cma_alloc() calls, there are
tracepoints for that already implemented.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 mm/cma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 2b2494fd6b59..2b74db5116d5 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -517,10 +517,10 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 	pr_debug("%s(): returned %p\n", __func__, page);
 out:
 	if (page) {
-		count_vm_event(CMA_ALLOC_SUCCESS);
+		count_vm_events(CMA_ALLOC_SUCCESS, count);
 		cma_sysfs_account_success_pages(cma, count);
 	} else {
-		count_vm_event(CMA_ALLOC_FAIL);
+		count_vm_events(CMA_ALLOC_FAIL, count);
 		if (cma)
 			cma_sysfs_account_fail_pages(cma, count);
 	}
-- 
2.42.1

