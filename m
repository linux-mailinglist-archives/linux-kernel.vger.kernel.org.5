Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33787A24C6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbjIOR3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbjIOR3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:29:11 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAC42105;
        Fri, 15 Sep 2023 10:29:06 -0700 (PDT)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RnLkc52pkz6K6LZ;
        Sat, 16 Sep 2023 01:28:24 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 15 Sep 2023 18:29:04 +0100
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
Subject: [RFC PATCH 3/9] Documentation/scrub-configure.rst: Add documentation for scrub driver
Date:   Sat, 16 Sep 2023 01:28:12 +0800
Message-ID: <20230915172818.761-4-shiju.jose@huawei.com>
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

Add documentation for scrub driver, supports configure scrub parameters,
in Documentation/scrub-configure.rst

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 Documentation/scrub-configure.rst | 55 +++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/scrub-configure.rst

diff --git a/Documentation/scrub-configure.rst b/Documentation/scrub-configure.rst
new file mode 100644
index 000000000000..9f8581b88788
--- /dev/null
+++ b/Documentation/scrub-configure.rst
@@ -0,0 +1,55 @@
+==========================
+Scrub subsystem driver
+==========================
+
+Copyright (c) 2023 HiSilicon Limited.
+
+:Author:   Shiju Jose <shiju.jose@huawei.com>
+:License:  The GNU Free Documentation License, Version 1.2
+          (dual licensed under the GPL v2)
+:Original Reviewers:
+
+- Written for: 6.7
+- Updated for:
+
+Introduction
+------------
+The scrub subsystem driver provides the interface for configure the
+parameters of memory scrubbers in the system. The scrub device drivers
+in the system register with the scrub configure subsystem.
+
+The scrub configure driver exposes the scrub controls to the user
+via sysfs.
+
+The File System
+---------------
+
+The configuration parameters of the registered scrubbers could be
+accessed via the /sys/class/scrub/scrubX/regionN/
+
+sysfs
+-----
+
+Sysfs files are documented in
+`Documentation/ABI/testing/sysfs-class-scrub-configure`.
+
+Example
+-------
+
+  The usage takes the form shown in this example::
+
+    # echo 0x300000 > /sys/class/scrub/scrub0/region0/addr_base
+    # echo 0x100000 > /sys/class/scrub/scrub0/region0/addr_size
+    # cat /sys/class/scrub/scrub0/region0/speed_available
+    # 1-60
+    # echo 25 > /sys/class/scrub/scrub0/region0/speed
+    # echo 1 > /sys/class/scrub/scrub0/region0/enable
+
+    # cat /sys/class/scrub/scrub0/region0/speed
+    # 0x19
+    # cat /sys/class/scrub/scrub0/region0/addr_base
+    # 0x100000
+    # cat /sys/class/scrub/scrub0/region0/addr_size
+    # 0x200000
+
+    # echo 0 > /sys/class/scrub/scrub0/region0/enable
-- 
2.34.1

