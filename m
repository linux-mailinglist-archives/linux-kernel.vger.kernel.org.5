Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117EF7EB061
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjKNM5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNM5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:57:08 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF68F196;
        Tue, 14 Nov 2023 04:57:04 -0800 (PST)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SV5mV35ssz6JBHR;
        Tue, 14 Nov 2023 20:52:26 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 14 Nov 2023 12:57:02 +0000
From:   <shiju.jose@huawei.com>
To:     <linux-cxl@vger.kernel.org>
CC:     <jonathan.cameron@huawei.com>, <Vilas.Sridharan@amd.com>,
        <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>,
        <rientjes@google.com>, <jiaqiyan@google.com>,
        <tony.luck@intel.com>, <Jon.Grimm@amd.com>,
        <dave.hansen@linux.intel.com>, <linux-acpi@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
        <james.morse@arm.com>, <david@redhat.com>, <jthoughton@google.com>,
        <somasundaram.a@hpe.com>, <erdemaktas@google.com>,
        <"pgonda@pgonda"@google.com>, <duenwen@google.com>,
        <mike.malvestuto@intel.com>, <gthelen@google.com>,
        <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
        <kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
        <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 0/6] cxl: Add support for CXL feature commands, CXL device patrol scrub control and DDR5 ECS control features
Date:   Tue, 14 Nov 2023 20:56:41 +0800
Message-ID: <20231114125648.1146-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

1. Add support for CXL feature commands(CXL spec 3.0 section 8.2.9.6).
2. Add CXL device scrub driver supporting patrol scrub control feature
(CXL spec 3.1 section 8.2.9.9.11.1) and DDR5 ECS feature(CXL spec 3.1
section 8.2.9.9.11.2).
3. Add scrub attributes for DDR5 ECS control to the memory scrub driver.

The attributes for the CXL scrub control features is exposed to the user
in the sysfs and is based on the previous code submitted for the memory
scrub control feature.
The patch and series for supporting memory scrub control feature are here,
https://lore.kernel.org/lkml/20230915172818.761-2-shiju.jose@huawei.com/ 
https://lore.kernel.org/lkml/20230915172818.761-1-shiju.jose@huawei.com/

The QEMU series to support these features is available here,
https://lore.kernel.org/qemu-devel/20231114124711.1128-1-shiju.jose@huawei.com/T/#t

Shiju Jose (6):
  cxl/mbox: Add GET_SUPPORTED_FEATURES, GET_FEATURE and SET_FEATURE
    mailbox commands
  cxl/memscrub: Add CXL device patrol scrub control feature
  memory: scrub: Add function to show scrub attributes in decimal
  memory: scrub: Add scrub control attributes for the DDR5 ECS
  cxl/memscrub: Add CXL device DDR5 ECS control feature
  cxl: scrub: sysfs: Add Documentation for CXL memory device scrub
    control attributes

 .../testing/sysfs-class-cxl-scrub-configure   |  135 +++
 drivers/cxl/Kconfig                           |   23 +
 drivers/cxl/core/Makefile                     |    1 +
 drivers/cxl/core/mbox.c                       |   74 ++
 drivers/cxl/core/memscrub.c                   | 1008 +++++++++++++++++
 drivers/cxl/cxlmem.h                          |  104 ++
 drivers/cxl/pci.c                             |    8 +
 drivers/memory/scrub/memory-scrub.c           |   36 +-
 include/memory/memory-scrub.h                 |   11 +
 include/uapi/linux/cxl_mem.h                  |    3 +
 10 files changed, 1400 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-cxl-scrub-configure
 create mode 100644 drivers/cxl/core/memscrub.c

-- 
2.34.1

