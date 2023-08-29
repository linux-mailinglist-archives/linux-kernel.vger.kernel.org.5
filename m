Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121BD78C682
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjH2NzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236686AbjH2Ny2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:54:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF329F7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 06:54:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA4D8FEC;
        Tue, 29 Aug 2023 06:55:02 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.57.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D2DC3F64C;
        Tue, 29 Aug 2023 06:54:18 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Sami Mujawar <sami.mujawar@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 1/2] coresight: trbe: Add a representative coresight_platform_data for TRBE
Date:   Tue, 29 Aug 2023 19:24:04 +0530
Message-Id: <20230829135405.1159449-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230829135405.1159449-1-anshuman.khandual@arm.com>
References: <20230829135405.1159449-1-anshuman.khandual@arm.com>
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

TRBE coresight devices do not need regular connections information, as the
paths get built between all percpu source and their respective percpu sink
devices. Please refer 'commit 2cd87a7b293d ("coresight: core: Add support
for dedicated percpu sinks")' which added support for percpu sink devices.

coresight_register() expect device connections via the platform_data. TRBE
devices do not have any graph connections and thus is empty. With upcoming
ACPI support for TRBE, we do not get a real acpi_device and thus
coresight_get_platform_dat() will end up in failures. Hence this allocates
a zeroed coresight_platform_data structure and assigns that back into the
device.

Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index e20c1c6acc73..97b9e72965e6 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -1253,8 +1253,18 @@ static void arm_trbe_register_coresight_cpu(struct trbe_drvdata *drvdata, int cp
 	desc.name = devm_kasprintf(dev, GFP_KERNEL, "trbe%d", cpu);
 	if (!desc.name)
 		goto cpu_clear;
-
-	desc.pdata = coresight_get_platform_data(dev);
+	/*
+	 * TRBE coresight devices do not need regular connections
+	 * information, as the paths get built between all percpu
+	 * source and their respective percpu sink devices. Though
+	 * coresight_register() expect device connections via the
+	 * platform_data, which TRBE devices do not have. As they
+	 * are not real ACPI devices, coresight_get_platform_data()
+	 * ends up failing. Instead let's allocate a dummy zeroed
+	 * coresight_platform_data structure and assign that back
+	 * into the device for that purpose.
+	 */
+	desc.pdata = devm_kzalloc(dev, sizeof(*desc.pdata), GFP_KERNEL);
 	if (IS_ERR(desc.pdata))
 		goto cpu_clear;
 
-- 
2.25.1

