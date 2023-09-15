Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223457A24CA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236444AbjIOR3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236062AbjIOR3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:29:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1077211E;
        Fri, 15 Sep 2023 10:29:09 -0700 (PDT)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RnLkg43fGz6K6Pc;
        Sat, 16 Sep 2023 01:28:27 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 15 Sep 2023 18:29:07 +0100
From:   <shiju.jose@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
        <tony.luck@intel.com>, <james.morse@arm.com>,
        <dave.hansen@linux.intel.com>, <david@redhat.com>,
        <jiaqiyan@google.com>, <jthoughton@google.com>,
        <somasundaram.a@hpe.com>, <erdemaktas@google.com>,
        <pgonda@google.com>, <rientjes@google.com>, <duenwen@google.com>,
        <Vilas.Sridharan@amd.com>, <mike.malvestuto@intel.com>,
        <gthelen@google.com>, <linuxarm@huawei.com>,
        <jonathan.cameron@huawei.com>, <tanxiaofei@huawei.com>,
        <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 7/9] ACPICA: ACPI 6.5: Add support for RAS2 table
Date:   Sat, 16 Sep 2023 01:28:16 +0800
Message-ID: <20230915172818.761-8-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20230915172818.761-1-shiju.jose@huawei.com>
References: <20230915172818.761-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

Add support for ACPI RAS2 feature table(RAS2) defined in the ACPI 6.5
Specification & upwards revision, section 5.2.21.

The RAS2 table provides interfaces for platform RAS features. RAS2 offers
the same services as RASF, but is more scalable than the latter.
RAS2 supports independent RAS controls and capabilities for a given RAS
feature for multiple instances of the same component in a given system.
The platform can support either RAS2 or RASF but not both.

Link: https://github.com/acpica/acpica/pull/892

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 include/acpi/actbl2.h | 55 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 3751ae69432f..41e77cacc5c6 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -47,6 +47,7 @@
 #define ACPI_SIG_PPTT           "PPTT"	/* Processor Properties Topology Table */
 #define ACPI_SIG_PRMT           "PRMT"	/* Platform Runtime Mechanism Table */
 #define ACPI_SIG_RASF           "RASF"	/* RAS Feature table */
+#define ACPI_SIG_RAS2           "RAS2"	/* RAS2 Feature table */
 #define ACPI_SIG_RGRT           "RGRT"	/* Regulatory Graphics Resource Table */
 #define ACPI_SIG_RHCT           "RHCT"	/* RISC-V Hart Capabilities Table */
 #define ACPI_SIG_SBST           "SBST"	/* Smart Battery Specification Table */
@@ -2743,6 +2744,60 @@ enum acpi_rasf_status {
 #define ACPI_RASF_ERROR                 (1<<2)
 #define ACPI_RASF_STATUS                (0x1F<<3)
 
+/*******************************************************************************
+ *
+ * RAS2 - RAS2 Feature Table (ACPI 6.5)
+ *        Version 2
+ *
+ *
+ ******************************************************************************/
+
+struct acpi_table_ras2 {
+	struct acpi_table_header header;        /* Common ACPI table header */
+	u16 reserved;
+	u16 num_pcc_descs;
+};
+
+/*
+ * RAS2 Platform Communication Channel Descriptor
+ */
+
+struct acpi_ras2_pcc_desc {
+	u8 channel_id;
+	u16 reserved;
+	u8 feature_type;
+	u32 instance;
+};
+
+/*
+ * RAS2 Platform Communication Channel Shared Memory Region
+ */
+
+struct acpi_ras2_shared_memory {
+	u32 signature;
+	u16 command;
+	u16 status;
+	u16 version;
+	u8 features[16];
+	u8 set_capabilities[16];
+	u16 num_parameter_blocks;
+	u32 set_capabilities_status;
+};
+
+/*
+ * RAS2 Parameter Block Structure for PATROL_SCRUB
+ */
+
+struct acpi_ras2_patrol_scrub_parameter {
+	struct acpi_rasf_parameter_block header;
+	u16 patrol_scrub_command;
+	u64 requested_address_range[2];
+	u64 actual_address_range[2];
+	u32 flags;
+	u32 scrub_params_out;
+	u32 scrub_params_in;
+};
+
 /*******************************************************************************
  *
  * RGRT - Regulatory Graphics Resource Table
-- 
2.34.1

