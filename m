Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA567A24BE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbjIOR3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbjIOR3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:29:11 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907D22119;
        Fri, 15 Sep 2023 10:29:05 -0700 (PDT)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RnLkb068Nz6K6C2;
        Sat, 16 Sep 2023 01:28:22 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 15 Sep 2023 18:29:02 +0100
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
Subject: [RFC PATCH 0/9] ACPI:RASF: Add support for ACPI RASF, ACPI RAS2 and configure scrubbers
Date:   Sat, 16 Sep 2023 01:28:09 +0800
Message-ID: <20230915172818.761-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
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

This series add,
1. support for ACPI RASF(RAS feature table) PCC interfaces
to communicate with the HW patrol scrubber in the platform,
as per ACPI 5.1 & upwards revision. Section 5.2.20.

2. support for ACPI RAS2(RAS2 feature table), as per
ACPI 6.5 & upwards revision. Section 5.2.21.

3. scrub driver supports configuring parameters of the memory
scrubbers in the system. This driver has been implemented
based on the hwmon subsystem.

The features have tested with RASF and RAS2 emulation in the QEMU.

Previous references to the memory scub and RASF topics.
https://lore.kernel.org/all/20221103155029.2451105-1-jiaqiyan@google.com/
https://patchwork.kernel.org/project/linux-arm-kernel/patch/CS1PR84MB0038718F49DBC0FF03919E1184390@CS1PR84MB0038.NAMPRD84.PROD.OUTLOOK.COM/

A Somasundaram (2):
  ACPI:RASF: Add extract RASF table to register RASF platform devices
  ACPI:RASF: Add common library for RASF and RAS2 PCC interfaces

Shiju Jose (7):
  memory: scrub: Add scrub driver supports configuring memory scrubbers
    in the system
  memory: scrub: sysfs: Add Documentation entries for set of scrub
    attributes
  Documentation/scrub-configure.rst: Add documentation for scrub driver
  memory: RASF: Add memory RASF driver
  ACPICA: ACPI 6.5: Add support for RAS2 table
  ACPI:RAS2: Add driver for ACPI RAS2 feature table (RAS2)
  memory: RAS2: Add memory RAS2 driver

 .../ABI/testing/sysfs-class-scrub-configure   |  82 ++++
 Documentation/scrub-configure.rst             |  55 +++
 drivers/acpi/Kconfig                          |  15 +
 drivers/acpi/Makefile                         |   1 +
 drivers/acpi/ras2_acpi.c                      |  97 ++++
 drivers/acpi/rasf_acpi.c                      |  71 +++
 drivers/acpi/rasf_acpi_common.c               | 272 +++++++++++
 drivers/memory/Kconfig                        |  15 +
 drivers/memory/Makefile                       |   3 +
 drivers/memory/ras2.c                         | 334 +++++++++++++
 drivers/memory/rasf.c                         | 335 +++++++++++++
 drivers/memory/rasf_common.c                  | 251 ++++++++++
 drivers/memory/scrub/Kconfig                  |  11 +
 drivers/memory/scrub/Makefile                 |   6 +
 drivers/memory/scrub/memory-scrub.c           | 452 ++++++++++++++++++
 include/acpi/actbl2.h                         |  55 +++
 include/acpi/rasf_acpi.h                      |  59 +++
 include/memory/memory-scrub.h                 |  85 ++++
 include/memory/rasf.h                         |  82 ++++
 19 files changed, 2281 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-scrub-configure
 create mode 100644 Documentation/scrub-configure.rst
 create mode 100755 drivers/acpi/ras2_acpi.c
 create mode 100755 drivers/acpi/rasf_acpi.c
 create mode 100755 drivers/acpi/rasf_acpi_common.c
 create mode 100644 drivers/memory/ras2.c
 create mode 100644 drivers/memory/rasf.c
 create mode 100644 drivers/memory/rasf_common.c
 create mode 100644 drivers/memory/scrub/Kconfig
 create mode 100644 drivers/memory/scrub/Makefile
 create mode 100755 drivers/memory/scrub/memory-scrub.c
 create mode 100755 include/acpi/rasf_acpi.h
 create mode 100755 include/memory/memory-scrub.h
 create mode 100755 include/memory/rasf.h

-- 
2.34.1

