Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810D57BD2C3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 07:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345100AbjJIFSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 01:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345099AbjJIFSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 01:18:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50695FA
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 22:18:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41FB21FB;
        Sun,  8 Oct 2023 22:18:42 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E2F523F7A6;
        Sun,  8 Oct 2023 22:17:59 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] driver: perf: arm_pmuv3: Identify 'event->attr.config1' based attributes
Date:   Mon,  9 Oct 2023 10:47:53 +0530
Message-Id: <20231009051753.179355-1-anshuman.khandual@arm.com>
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

This defines macros to identify long and rdpmc attributes which get carried
inside 'event->attr.config1', thus making the code explicit and clear.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.6-rc5.

 drivers/perf/arm_pmuv3.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 94723d00548e..797ffd5a8fed 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -298,16 +298,19 @@ PMU_FORMAT_ATTR(event, "config:0-15");
 PMU_FORMAT_ATTR(long, "config1:0");
 PMU_FORMAT_ATTR(rdpmc, "config1:1");
 
+#define ARM_PMUV3_ATTR_LONG	0x01
+#define ARM_PMUV3_ATTR_RDPMC	0x02
+
 static int sysctl_perf_user_access __read_mostly;
 
 static inline bool armv8pmu_event_is_64bit(struct perf_event *event)
 {
-	return event->attr.config1 & 0x1;
+	return event->attr.config1 & ARM_PMUV3_ATTR_LONG;
 }
 
 static inline bool armv8pmu_event_want_user_access(struct perf_event *event)
 {
-	return event->attr.config1 & 0x2;
+	return event->attr.config1 & ARM_PMUV3_ATTR_RDPMC;
 }
 
 static struct attribute *armv8_pmuv3_format_attrs[] = {
-- 
2.25.1

