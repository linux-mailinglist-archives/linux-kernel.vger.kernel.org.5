Return-Path: <linux-kernel+bounces-23633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C1F82AF66
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D8E285D23
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A125F171B2;
	Thu, 11 Jan 2024 13:18:07 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D24F32C94;
	Thu, 11 Jan 2024 13:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T9lXD0cr1z6K8wp;
	Thu, 11 Jan 2024 21:15:24 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 53AB4140CB9;
	Thu, 11 Jan 2024 21:18:01 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 13:18:00 +0000
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<david@redhat.com>, <Vilas.Sridharan@amd.com>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>, <rientjes@google.com>, <jiaqiyan@google.com>,
	<tony.luck@intel.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<mike.malvestuto@intel.com>, <gthelen@google.com>,
	<wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH v5 00/12] cxl: Add support for CXL feature commands, CXL device patrol scrub control and DDR5 ECS control features
Date: Thu, 11 Jan 2024 21:17:29 +0800
Message-ID: <20240111131741.1356-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Shiju Jose <shiju.jose@huawei.com>

1. Add support for CXL feature mailbox commands.
2. Add CXL device scrub driver supporting patrol scrub control and ECS
control features.
3. Add scrub subsystem driver supports configuring memory scrubs in the system.
4. Register CXL device patrol scrub and ECS with scrub subsystem.
5. Add common library for RASF and RAS2 PCC interfaces.
6. Add driver for ACPI RAS2 feature table (RAS2).
7. Add memory RAS2 driver and register with scrub subsystem.

The QEMU series to support the CXL specific features is available here,
https://lore.kernel.org/qemu-devel/20231124135338.1191-1-shiju.jose@huawei.com/

Changes
v4 -> v5:
1. Following are the main changes made based on the feedback from Dan Williams on v4.
1.1. In the scrub subsystem the common scrub control attributes are statically defined
     instead of dynamically created.
1.2. Add scrub subsystem support externally defined attribute group.
     Add CXL ECS driver define ECS specific attribute group and pass to
	 the scrub subsystem.
1.3. Move cxl_mem_ecs_init() to cxl/core/region.c so that the CXL region_id
     is used in the registration with the scrub subsystem. 	 
1.4. Add previously posted RASF common and RAS2 patches to this scrub series.
	 
2. Add support for the 'enable_background_scrub' attribute
   for RAS2, on request from Bill Schwartz(wschwartz@amperecomputing.com).

v3 -> v4:
1. Fixes for the warnings/errors reported by kernel test robot.
2. Add support for reading the 'enable' attribute of CXL patrol scrub.

Changes
v2 -> v3:
1. Changes for comments from Davidlohr, Thanks.
 - Updated cxl scrub kconfig
 - removed usage of the flag is_support_feature from
   the function cxl_mem_get_supported_feature_entry().
 - corrected spelling error.
 - removed unnecessary debug message.
 - removed export feature commands to the userspace.
2. Possible fix for the warnings/errors reported by kernel
   test robot.
3. Add documentation for the common scrub configure atrributes.

v1 -> v2:
1. Changes for comments from Dave Jiang, Thanks.
 - Split patches.
 - reversed xmas tree declarations.
 - declared flags as enums.
 - removed few unnecessary variable initializations.
 - replaced PTR_ERR_OR_ZERO() with IS_ERR() and PTR_ERR().
 - add auto clean declarations.
 - replaced while loop with for loop.
 - Removed allocation from cxl_get_supported_features() and
   cxl_get_feature() and make change to take allocated memory
   pointer from the caller.
 - replaced if/else with switch case.
 - replaced sprintf() with sysfs_emit() in 2 places.
 - replaced goto label with return in few functions.
2. removed unused code for supported attributes from ecs.
3. Included following common patch for scrub configure driver
   to this series.
   "memory: scrub: Add scrub driver supports configuring memory scrubbers
    in the system"

A Somasundaram (1):
  ACPI:RASF: Add common library for RASF and RAS2 PCC interfaces

Shiju Jose (11):
  cxl/mbox: Add GET_SUPPORTED_FEATURES mailbox command
  cxl/mbox: Add GET_FEATURE mailbox command
  cxl/mbox: Add SET_FEATURE mailbox command
  cxl/memscrub: Add CXL device patrol scrub control feature
  cxl/memscrub: Add CXL device ECS control feature
  memory: scrub: Add scrub subsystem driver supports configuring memory
    scrubs in the system
  cxl/memscrub: Register CXL device patrol scrub with scrub configure
    driver
  cxl/memscrub: Register CXL device ECS with scrub configure driver
  ACPICA: ACPI 6.5: Add support for RAS2 table
  ACPI:RAS2: Add driver for ACPI RAS2 feature table (RAS2)
  memory: RAS2: Add memory RAS2 driver

 .../ABI/testing/sysfs-class-scrub-configure   |   91 ++
 drivers/acpi/Kconfig                          |   15 +
 drivers/acpi/Makefile                         |    1 +
 drivers/acpi/ras2_acpi.c                      |   97 ++
 drivers/acpi/rasf_acpi_common.c               |  272 +++++
 drivers/cxl/Kconfig                           |   23 +
 drivers/cxl/core/Makefile                     |    1 +
 drivers/cxl/core/mbox.c                       |   59 +
 drivers/cxl/core/memscrub.c                   | 1009 +++++++++++++++++
 drivers/cxl/core/region.c                     |    1 +
 drivers/cxl/cxlmem.h                          |  120 ++
 drivers/cxl/pci.c                             |    5 +
 drivers/memory/Kconfig                        |   15 +
 drivers/memory/Makefile                       |    3 +
 drivers/memory/ras2.c                         |  354 ++++++
 drivers/memory/rasf_common.c                  |  269 +++++
 drivers/memory/scrub/Kconfig                  |   11 +
 drivers/memory/scrub/Makefile                 |    6 +
 drivers/memory/scrub/memory-scrub.c           |  367 ++++++
 include/acpi/actbl2.h                         |  137 +++
 include/acpi/rasf_acpi.h                      |   58 +
 include/memory/memory-scrub.h                 |   78 ++
 include/memory/rasf.h                         |   88 ++
 23 files changed, 3080 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-scrub-configure
 create mode 100755 drivers/acpi/ras2_acpi.c
 create mode 100755 drivers/acpi/rasf_acpi_common.c
 create mode 100644 drivers/cxl/core/memscrub.c
 create mode 100644 drivers/memory/ras2.c
 create mode 100644 drivers/memory/rasf_common.c
 create mode 100644 drivers/memory/scrub/Kconfig
 create mode 100644 drivers/memory/scrub/Makefile
 create mode 100755 drivers/memory/scrub/memory-scrub.c
 create mode 100644 include/acpi/rasf_acpi.h
 create mode 100755 include/memory/memory-scrub.h
 create mode 100755 include/memory/rasf.h

-- 
2.34.1


