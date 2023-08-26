Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0884578944B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 09:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjHZHWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 03:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjHZHVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 03:21:42 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4846E2139;
        Sat, 26 Aug 2023 00:21:35 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RXp9q2qVBz1L9Vf;
        Sat, 26 Aug 2023 15:19:59 +0800 (CST)
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
Subject: [PATCH v2 2/2] ACPI: NFIT: use struct_size() helper
Date:   Sat, 26 Aug 2023 15:16:54 +0800
Message-ID: <20230826071654.564372-2-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230826071654.564372-1-liaoyu15@huawei.com>
References: <20230826071654.564372-1-liaoyu15@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows that,
in the worst scenario, could lead to heap overflows.

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/nfit/core.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 305f590c54a8..2f7217600307 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -712,8 +712,7 @@ static bool add_spa(struct acpi_nfit_desc *acpi_desc,
 		}
 	}
 
-	nfit_spa = devm_kzalloc(dev, sizeof(*nfit_spa) + sizeof_spa(spa),
-			GFP_KERNEL);
+	nfit_spa = devm_kzalloc(dev, struct_size(nfit_spa, spa, 1), GFP_KERNEL);
 	if (!nfit_spa)
 		return false;
 	INIT_LIST_HEAD(&nfit_spa->list);
@@ -741,7 +740,7 @@ static bool add_memdev(struct acpi_nfit_desc *acpi_desc,
 			return true;
 		}
 
-	nfit_memdev = devm_kzalloc(dev, sizeof(*nfit_memdev) + sizeof(*memdev),
+	nfit_memdev = devm_kzalloc(dev, struct_size(nfit_memdev, memdev, 1),
 			GFP_KERNEL);
 	if (!nfit_memdev)
 		return false;
@@ -812,8 +811,7 @@ static bool add_dcr(struct acpi_nfit_desc *acpi_desc,
 			return true;
 		}
 
-	nfit_dcr = devm_kzalloc(dev, sizeof(*nfit_dcr) + sizeof(*dcr),
-			GFP_KERNEL);
+	nfit_dcr = devm_kzalloc(dev, struct_size(nfit_dcr, dcr, 1), GFP_KERNEL);
 	if (!nfit_dcr)
 		return false;
 	INIT_LIST_HEAD(&nfit_dcr->list);
@@ -855,7 +853,7 @@ static size_t sizeof_idt(struct acpi_nfit_interleave *idt)
 {
 	if (idt->header.length < sizeof(*idt))
 		return 0;
-	return sizeof(*idt) + sizeof(u32) * idt->line_count;
+	return struct_size(idt, line_offset, idt->line_count);
 }
 
 static bool add_idt(struct acpi_nfit_desc *acpi_desc,
-- 
2.25.1

