Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733D07BD297
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 06:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345069AbjJIEhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 00:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345055AbjJIEhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 00:37:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD548A4
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 21:37:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F8631FB;
        Sun,  8 Oct 2023 21:38:16 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AC24D3F7A6;
        Sun,  8 Oct 2023 21:37:33 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: perf: arm_pmuv3: Update 'pmc_width' based on actual HW event width
Date:   Mon,  9 Oct 2023 10:07:24 +0530
Message-Id: <20231009043724.175100-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This updates 'perf_event_mmap_page->pmc_width' based on actual HW event's
width that are currently missing i.e ARMPMU_EVT_63BIT and ARMPMU_EVT_47BIT.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.6-rc5.

 drivers/perf/arm_pmuv3.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index fe4db1831662..94723d00548e 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -1375,6 +1375,10 @@ void arch_perf_update_userpage(struct perf_event *event,
 	if (userpg->cap_user_rdpmc) {
 		if (event->hw.flags & ARMPMU_EVT_64BIT)
 			userpg->pmc_width = 64;
+		else if (event->hw.flags & ARMPMU_EVT_63BIT)
+			userpg->pmc_width = 63;
+		else if (event->hw.flags & ARMPMU_EVT_47BIT)
+			userpg->pmc_width = 47;
 		else
 			userpg->pmc_width = 32;
 	}
-- 
2.25.1

