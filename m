Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9AC78944A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 09:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjHZHWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 03:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjHZHVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 03:21:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593E52137;
        Sat, 26 Aug 2023 00:21:34 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RXp7D4R3VztSMt;
        Sat, 26 Aug 2023 15:17:44 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 26 Aug
 2023 15:21:31 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>, <rafael@kernel.org>
CC:     <liaoyu15@huawei.com>, <liwei391@huawei.com>, <lenb@kernel.org>,
        <robert.moore@intel.com>, <linux-acpi@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] ACPI: NFIT: Fix incorrect calculation of idt size
Date:   Sat, 26 Aug 2023 15:16:53 +0800
Message-ID: <20230826071654.564372-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

acpi_nfit_interleave's field 'line_offset' is switched to flexible array [1],
but sizeof_idt() still calculates the size in the form of 1-element array.

Therefore, fix incorrect calculation in sizeof_idt().

[1] https://lore.kernel.org/lkml/2652195.BddDVKsqQX@kreacher/

Fixes: 2a5ab99847bd ("ACPICA: struct acpi_nfit_interleave: Replace 1-element array with flexible array")
Cc: stable@vger.kernel.org # v6.4+
Signed-off-by: Yu Liao <liaoyu15@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
v1 -> v2: add Dave's review tag and cc nvdimm@lists.linux.dev
---
 drivers/acpi/nfit/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 07204d482968..305f590c54a8 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -855,7 +855,7 @@ static size_t sizeof_idt(struct acpi_nfit_interleave *idt)
 {
 	if (idt->header.length < sizeof(*idt))
 		return 0;
-	return sizeof(*idt) + sizeof(u32) * (idt->line_count - 1);
+	return sizeof(*idt) + sizeof(u32) * idt->line_count;
 }
 
 static bool add_idt(struct acpi_nfit_desc *acpi_desc,
-- 
2.25.1

