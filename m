Return-Path: <linux-kernel+bounces-78489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2937B86140F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D534628532A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A476FB9;
	Fri, 23 Feb 2024 14:37:44 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07255469D;
	Fri, 23 Feb 2024 14:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699063; cv=none; b=Fz2HPxzh+gq050UtTGk1yrpQBJ27F7jRvRuVGp9/xjSNbjPnGQ+GtQ87ni1TyPV5aIbpL1ELozEtfCzZephicul8l12hQAfW4d1u/WkssxdO7ykhZIOckipr9cc3/n1tyKRRsVZSFJqJS7JzoGusjud2kEiMvm3mp8mSJbQf5aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699063; c=relaxed/simple;
	bh=B8tmKlM2SuEwWy8ZSsDEye6G44FSjeSZYQxZwkll2q4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZbTway0UUe5pgD8zDtkeQdkTuw2lO4chxaLpXiVw1AqUsOT6pmLsaoT47jLfaEi5PkImoe3lXAeLbnjEhB1YvkeK+XfUuUPjYpXhGuEUCLGI6IMSxE1izISmIJnMXWFbGnE5LuYlHzpEwTZ2KnuAo5nXX2LntlXXD9Xw2VY6Hcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ThCD5296xz6J9yc;
	Fri, 23 Feb 2024 22:33:09 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id E8E88140B33;
	Fri, 23 Feb 2024 22:37:34 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 14:37:33 +0000
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-mm@kvack.org>, <dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
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
Subject: [RFC PATCH v7 00/12] memory: scrub: introduce subsystem + CXL/ACPI-RAS2 drivers
Date: Fri, 23 Feb 2024 22:37:11 +0800
Message-ID: <20240223143723.1574-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Shiju Jose <shiju.jose@huawei.com>

'Previously known as: cxl: Add support for CXL feature commands,
 CXL device patrol scrub control and DDR5 ECS control features'
https://lore.kernel.org/lkml/20240215111455.1462-1-shiju.jose@huawei.com/

Introduce generic memory scrub subsystem which allows user to
control underlying memory scrubbers in the system via the sysfs
scrub control interface.

Memory scrub is a feature where an ECC engine reads data from
each memory media location, corrects with an ECC if necessary and
writes the corrected data back to the same memory media location.
More details can be found in Reference [1].

CXL patrol scrub and DDR5 ECS and ACPI RAS2 HW based memory
patrol scrub features are added as use cases for the scrub
subsystem to expose the scrub controls to the user.

CXL device patrol scrub and DDR5 ECS features needs support for
the CXL feature mail box commands. CXL device scrub driver
registers with the memory scrub subsystem to expose the scrub
controls for CXL device patrol and ECS scrubs to the user.

RAS2 HW based memory patrol scrub needs RAS2 PCC interfaces
and ACPI RAS2 driver for communication b/w kernel and firmware.
ACPI RAS2 Driver adds platform device, for each memory feature,
which binds to the RAS2 memory driver.
Memory RAS2 driver registers with the memory scrub subsystem to
expose the RAS2 scrub controls to the user.

Series adds,
1. scrub subsystem driver supports configuring memory scrubs
   in the system.
2. support for CXL feature mailbox commands.
3. CXL device scrub driver supporting patrol scrub control and
   ECS control features.
4. register CXL device patrol scrub and ECS with scrub subsystem.
5. common library for RAS2 PCC interfaces.
6. ACPI RAS2 driver for ACPI RAS2 feature table (RAS2).
7. memory RAS2 driver and registers with scrub subsystem.

The QEMU series to support the CXL specific scrub features is
available here,
https://lore.kernel.org/qemu-devel/20240223085902.1549-1-shiju.jose@huawei.com/

References:
1. Discussions on kernel support of memory error detection and
   patrol scrubber can be found here.
   https://lore.kernel.org/all/20221103155029.2451105-1-jiaqiyan@google.com/

2. Discussions on RASF:
   https://lore.kernel.org/lkml/20230915172818.761-1-shiju.jose@huawei.com/#r 
   https://patchwork.kernel.org/project/linux-arm-kernel/patch/CS1PR84MB0038718F49DBC0FF03919E1184390@CS1PR84MB0038.NAMPRD84.PROD.OUTLOOK.COM/

Changes
v6 -> v7:
1. Main changes for comments from Jonathan.
1.1. CXL
 - Changes for deal with small mail box and supporting multipart
   feature data transfers.
 - Provide more specific parameters to mbox supported/get/set features
   interface functions.
 - kvmalloc -> kmalloc in CXL scrub mem allocation for feature commands.
 - Changed the way using __free(kfree)
 - Removed readback and verify for setting CXL scrub patrol and ECS
   parameters. Could be added later if needed.
 - In is_visible() callback functions for scrub control sysfs attrs
   changed to writeback the default attribute mode value instead of
   setting per attrs.
 - Add documentation for sysfs interfaces for CXL ECS scrub control. 
1.2. RAS2
 - In rasf common code, rename rasf to ras2 because RASF seems obselete.
 - Replace pr_* with dev_* log function calls from ACPI RAS2 and
   memory RAS2 drivers.
 - In rasf common code, rename rasf to ras2.
 - Removed including unnecessary .h file from memory RAS2 driver.
 - In is_visible() callback functions for scrub control sysfs attrs
   changed to writeback the default attribute mode value instead of
   setting per attribute.

2. Changes for comments from Fan.
 - Add debug message if cxl patrol scrub and ecs init function
   calls fail.
3. Updated cover letter for feedback from Dan Williams. 
   
v5 -> v6:
1. Changes for comments from Davidlohr, Thanks.
 - Update CXL feature code based on spec 3.1.
 - attrb -> attr
 - Use enums with default counting.  
2. Rebased to the latest kernel.

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
  ACPI:RAS2: Add common library for RAS2 PCC interfaces

Shiju Jose (11):
  cxl/mbox: Add GET_SUPPORTED_FEATURES mailbox command
  cxl/mbox: Add GET_FEATURE mailbox command
  cxl/mbox: Add SET_FEATURE mailbox command
  cxl/memscrub: Add CXL device patrol scrub control feature
  cxl/memscrub: Add CXL device ECS control feature
  memory: scrub: Add scrub subsystem driver supports configuring memory
    scrubs in the system
  cxl/memscrub: Register CXL device patrol scrub with scrub subsystem
    driver
  cxl/memscrub: Register CXL device ECS with scrub subsystem driver
  ACPICA: ACPI 6.5: Add support for RAS2 table
  ACPI:RAS2: Add driver for ACPI RAS2 feature table (RAS2)
  memory: RAS2: Add memory RAS2 driver

 .../ABI/testing/sysfs-class-cxl-ecs-configure |  79 ++
 .../ABI/testing/sysfs-class-scrub-configure   |  91 ++
 drivers/acpi/Kconfig                          |  14 +
 drivers/acpi/Makefile                         |   1 +
 drivers/acpi/ras2_acpi.c                      |  97 ++
 drivers/acpi/ras2_acpi_common.c               | 272 +++++
 drivers/cxl/Kconfig                           |  21 +
 drivers/cxl/core/Makefile                     |   1 +
 drivers/cxl/core/mbox.c                       | 143 +++
 drivers/cxl/core/memscrub.c                   | 954 ++++++++++++++++++
 drivers/cxl/core/region.c                     |   3 +
 drivers/cxl/cxlmem.h                          | 124 +++
 drivers/cxl/pci.c                             |   4 +
 drivers/memory/Kconfig                        |  15 +
 drivers/memory/Makefile                       |   3 +
 drivers/memory/ras2.c                         | 364 +++++++
 drivers/memory/ras2_common.c                  | 282 ++++++
 drivers/memory/scrub/Kconfig                  |  11 +
 drivers/memory/scrub/Makefile                 |   6 +
 drivers/memory/scrub/memory-scrub.c           | 369 +++++++
 include/acpi/actbl2.h                         | 137 +++
 include/acpi/ras2_acpi.h                      |  59 ++
 include/memory/memory-scrub.h                 |  79 ++
 include/memory/ras2.h                         |  88 ++
 24 files changed, 3217 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-cxl-ecs-configure
 create mode 100644 Documentation/ABI/testing/sysfs-class-scrub-configure
 create mode 100755 drivers/acpi/ras2_acpi.c
 create mode 100755 drivers/acpi/ras2_acpi_common.c
 create mode 100644 drivers/cxl/core/memscrub.c
 create mode 100644 drivers/memory/ras2.c
 create mode 100644 drivers/memory/ras2_common.c
 create mode 100644 drivers/memory/scrub/Kconfig
 create mode 100644 drivers/memory/scrub/Makefile
 create mode 100755 drivers/memory/scrub/memory-scrub.c
 create mode 100644 include/acpi/ras2_acpi.h
 create mode 100755 include/memory/memory-scrub.h
 create mode 100755 include/memory/ras2.h

-- 
2.34.1


