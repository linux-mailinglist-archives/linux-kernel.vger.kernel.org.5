Return-Path: <linux-kernel+bounces-151765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE32A8AB39F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B431C21372
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6DB139562;
	Fri, 19 Apr 2024 16:47:48 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC311311B6;
	Fri, 19 Apr 2024 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545267; cv=none; b=soyZbWcDrb5ffCtk8ptrFDiGanEtCfqXMkfhkuIg9tcDJbKz4J8skqYx0g1HeAL35I0YpeCJbPHfFKlvucjNuyO8/dRfi5kt2RppkBmQHsOVZh3wlSWfa2BA3kzQBzNGGMMqXdZ3TEniXTE90FTlDvEbxeM+8W56ktSH7uC98Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545267; c=relaxed/simple;
	bh=d6DvWl7KBYXVZrvmSFJ3OD7trgmOII6iBu3bq4ubDBw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ku929ghR6UQjuFtSjeswxQ8I+uAipz7y45EFQRC/+2zGuRvSGt6RV4xzlTqzpbsAxL/nqc3OeeYsKoY2R6EUsixO0+sNxoYQYjgyhE0CuZAS+gd8c9eKsqj3Ky8lJ5AhGpclGqvTNECAXYo7ISg2A8w+jCCQLq67ZXOa7mHE3I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VLgW222M4z6K61q;
	Sat, 20 Apr 2024 00:45:34 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 16B37140B18;
	Sat, 20 Apr 2024 00:47:41 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 17:47:40 +0100
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
	<wbs@os.amperecomputing.com>, <nifan.cxl@gmail.com>, <yazen.ghannam@amd.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH v8 00/10] ras: scrub: introduce subsystem + CXL/ACPI-RAS2 drivers
Date: Sat, 20 Apr 2024 00:47:09 +0800
Message-ID: <20240419164720.1765-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Shiju Jose <shiju.jose@huawei.com>

Memory Scrub
============

Increasing DRAM size and cost has made memory subsystem reliability
an important concern. These modules are used where potentially
corrupted data could cause expensive or fatal issues. Memory errors are
one of the top hardware failures that cause server and workload crashes. 

Memory scrub is a feature where an ECC engine reads data from
each memory media location, corrects with an ECC if necessary and
writes the corrected data back to the same memory media location.

The memory DIMMs could be scrubbed at a configurable rate to detect
uncorrected memory errors and attempts to recover from detected memory
errors providing the following benefits.
- Proactively scrubbing memory DIMMs reduces the chance of a correctable
  error becoming uncorrectable.
- Once detected, uncorrected errors caught in unallocated memory pages are
  isolated and prevented from being allocated to an application or the OS.
- The probability of software/hardware products encountering memory
  errors is reduced.
Some details of background can be found in Reference [5].

There are 2 types of memory scrubbing,
1. Background (patrol) scrubbing of the RAM whilest the RAM is otherwise
   idle.
2. On-demand scrubbing for a specific address range/region of memory. 

There are several types of interfaces to HW memory scrubbers
identified such as ACPI NVDIMM ARS(Address Range Scrub), CXL memory
device patrol scrub, CXL DDR5 ECS, ACPI RAS2 memory scrubbing.

The scrub control varies between different memory scrubbers. To allow
for standard userspace tooling there is a need to present these controls
with a standard ABI.
 
Introduce generic memory scrub subsystem which allows user to
control underlying scrubbers in the system via generic sysfs scrub
control interface.

Use case of scrub control feature
=================================
1. Scrub controls in user space allow the user space tool to disable
and enable the feature in case disabling of the scrubbing and changing
the scrub rate are needed for other purposes such as performance-aware
operations which requires the background operations to be turned off or
reduced.
2. Also allows to perform on-demand scrubbing for specific address range
if supported by the scrubber.

Comparison of scrubbing features
================================
 ................................................................
 .              .   ACPI    . CXL patrol.  CXL ECS  .  ARS      .
 .  Name        .   RAS2    . scrub     .           .           .
 ................................................................
 .              .           .           .           .           .
 . On-demand    . Supported . No        . No        . Supported .
 . Scrubbing    .           .           .           .           .
 .              .           .           .           .           .  
 ................................................................
 .              .           .           .           .           .
 . Background   . Supported . Supported . Supported . No        .
 . scrubbing    .           .           .           .           .
 .              .           .           .           .           .
 ................................................................
 .              .           .           .           .           .
 . Mode of      . Scrub ctrl. per device. per memory.  Unknown  .
 . scrubbing    . per NUMA  .           . media     .           .
 .              . domain.   .           .           .           .
 ................................................................
 .              .           .           .           .           . 
 . Query scrub  . Supported . Supported . Supported . Supported .       
 . capabilities .           .           .           .           .
 .              .           .           .           .           .
 ................................................................
 .              .           .           .           .           . 
 . Setting      . Supported . No        . No        . Supported .       
 . address range.           .           .           .           .
 .              .           .           .           .           .
 ................................................................
 .              .           .           .           .           . 
 . Setting      . Supported . Supported . No        . No        .       
 . scrub rate   .           .           .           .           .
 .              .           .           .           .           .
 ................................................................
 .              .           .           .           .           . 
 . Unit for     . Not       . in hours  . No        . No        .       
 . scrub rate   . Defined   .           .           .           .
 .              .           .           .           .           .
 ................................................................
 .              . Supported .           .           .           .
 . Scrub        . on-demand . No        . No        . Supported .
 . status/      . scrubbing .           .           .           .
 . Completion   . only      .           .           .           .
 ................................................................
 . UC error     .           .CXL general.CXL general. ACPI UCE  .
 . reporting    . Exception .media/DRAM .media/DRAM . notify and.
 .              .           .event/media.event/media. query     .
 .              .           .scan?      .scan?      . ARS status.
 ................................................................
 .              .           .           .           .           .      
 . Clear UC     .  No       . No        .  No       . Supported .
 . error        .           .           .           .           .
 .              .           .           .           .           .  
 ................................................................
 .              .           .           .           .           .
 . Translate    . No        . No        . No        . Supported .
 . *(1)SPA to   .           .           .           .           .
 . *(2)DPA      .           .           .           .           .  
 ................................................................
 .              .           .           .           .           .
 . Error inject . No        . Can inject. No        . Supported .
 .              .           . poison for.           .           .
 .              .           . CXL       .           .           .  
 ................................................................
*(1) - SPA - System Physical Address. See section 9.19.7.8
       Function Index 5 - Translate SPA of ACPI spec r6.5.  
*(2) - DPA - Device Physical Address. See section 9.19.7.8
       Function Index 5 - Translate SPA of ACPI spec r6.5.  

CXL Scrubbing features
======================
Add support for control CXL patrol scrubber and ACPI RAS2 HW based memory
patrol scrubber and register with the scrub subsystem to expose the scrub
controls to the userspace tool.

CXL spec r3.1 section 8.2.9.9.11.1 describes the memory device patrol scrub
control feature. The device patrol scrub proactively locates and makes
corrections to errors in regular cycle. The patrol scrub control allows the
request to configure patrol scrubber's input configurations.

The patrol scrub control allows the requester to specify the number of
hours in which the patrol scrub cycles must be completed, provided that
the requested number is not less than the minimum number of hours for the
patrol scrub cycle that the device is capable of. In addition, the patrol
scrub controls allow the host to disable and enable the feature in case
disabling of the feature is needed for other purposes such as
performance-aware operations which require the background operations to be
turned off.

ACPI RAS2 Hardware-based Memory Scrubbing
=========================================
ACPI spec 6.5 section 5.2.21 ACPI RAS2 describes ACPI RAS2 table
provides interfaces for platform RAS features and supports independent
RAS controls and capabilities for a given RAS feature for multiple
instances of the same component in a given system.
Memory RAS features apply to RAS capabilities, controls and operations
that are specific to memory. RAS2 PCC sub-spaces for memory-specific RAS
features have a Feature Type of 0x00 (Memory).

The platform can use the hardware-based memory scrubbing feature to expose
controls and capabilities associated with hardware-based memory scrub
engines. The RAS2 memory scrubbing feature supports following as per spec,
 - Independent memory scrubbing controls for each NUMA domain, identified
   using its proximity domain.
   Note: However AmpereComputing has single entry repeated as they have
         centralized controls.
 - Provision for background (patrol) scrubbing of the entire memory system,
   as well as on-demand scrubbing for a specific region of memory.

ACPI Address Range Scrubbing(ARS)
================================
ARS allows the platform to communicate memory errors to system software.
This capability allows system software to prevent accesses to addresses
with uncorrectable errors in memory. ARS functions manage all NVDIMMs
present in the system. Only one scrub can be in progress system wide
at any given time.
Following functions are supported as per the specification.
1. Query ARS Capabilities for a given address range, indicates platform
   supports the ACPI NVDIMM Root Device Unconsumed Error Notification.
2. Start ARS triggers an Address Range Scrub for the given memory range.
   Address scrubbing can be done for volatile memory, persistent memory,
   or both.
3. Query ARS Status command allows software to get the status of ARS,  
   including the progress of ARS and ARS error record.
4. Clear Uncorrectable Error.
5. Translate SPA
6. ARS Error Inject etc.
iNote: Support for ARS is not added in this series because to reduce the
line of code for review and could be added after initial code is merged. 

Series adds,
1. Scrub subsystem driver supports configuring memory scrubbers
   in the system.
2. Support for CXL feature mailbox commands, which is used by
   CXL device scrubbing features. 
3. CXL device scrub driver supporting patrol scrub control and
   register with scrub subsystem.
5. ACPI RAS2 driver adds OS interface for RAS2 communication through
   PCC mailbox and extracts ACPI RAS2 feature table (RAS2) and
   create platform device for the RAS memory features, which binds
   to the memory ACPI RAS2 driver.
7. Memory ACPI RAS2 driver gets the PCC subspace for communicating
   with the ACPI compliant platform supports ACPI RAS2. Add callback
   functions and registers with scrub subsystem to support user to
   control the HW patrol scrubbers exposed to the kernel via the
   ACPI RAS2 table.

Note: The RAS2 feature has dependency on the patch
      "ACPICA: ACPI 6.5: Add support for RAS2 table" which Rafael has queued. 
https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=9726d821f88e284ecd998b76ae5f2174721cd9dc

The QEMU series to support the CXL specific scrub features is
available here,
https://lore.kernel.org/qemu-devel/20240223085902.1549-1-shiju.jose@huawei.com/

Open Questions based on feedbacks from the community:
1. Leo: Standardize unit for scrub rate, for example ACPI RAS2 does not define
   unit for the scrub rate. RAS2 clarification needed. 
2. Jonathan:
   May the scrub class to be rename as RASCTL or something like that to allow
   for wider control options etc that open compute RAS API supports?  
3. Jonathan: Any need for discoverability of capability to scan different regions,
   such as global PA space to the userspace. Left as future extension.
4. Jiaqi:
   - STOP_PATROL_SCRUBBER from RAS2 must be blocked and, must not be exposed to
     OS/userspace. Stopping patrol scrubber is unacceptable for platform where
     OEM has enabled patrol scrubber, because the patrol scrubber is a key part
     of logging and is repurposed for other RAS actions.
   If the OEM does not want to expose this control, they should lock it down so the
   interface is not exposed to the OS. These features are optional afterall.
   - "Requested Address Range"/"Actual Address Range" (region to scrub) is a
      similarly bad thing to expose in RAS2.
   If the OEM does not want to expose this, they should lock it down so the
   interface is not exposed to the OS. These features are optional afterall.
5. Shiju: How to determine initial status(background scrub / stopped etc).
   
References:
1. ACPI spec r6.5 section 5.2.21 ACPI RAS2.
2. ACPI spec r6.5 section 9.19.7.2 ARS.
3. CXL spec  r3.1 8.2.9.9.11.1 Device patrol scrub control feature
4. CXL spec  r3.1 8.2.9.9.11.2 DDR5 ECS feature
5. Background information about kernel support for memory scan, memory
   error detection and ACPI RASF.
   https://lore.kernel.org/all/20221103155029.2451105-1-jiaqiyan@google.com/
6. Discussions on RASF:
   https://lore.kernel.org/lkml/20230915172818.761-1-shiju.jose@huawei.com/#r 

Changes
=======
v7 -> v8:
1. Add more detailed cover letter and add info for basic analysis
   of ACPI ARS for comment from Dan Williams.
2. Changed file name etc from ras2 to acpi_ras2 in memory ACPI RAS2
   driver for comment from Boris.
3. Add documents for usage for comment from Jonathan.
4. Changed logic in memory/acpi_ras2.c for enable background
   scrubbing to allow setting the scrub rate.
5. Merged memory/acpi_ras2_common.c with memory/acpi_ras2.c and
   obselete code, suggested by Jonathan.  
6. Initial optimizations and cleanup especially in the memory/acpi_ras2.
7. Removed CXL ECS support for time being. 
8. Removed support for region based scrub control from the scrub
   subsytem, which was needed for the CXL ECS, can be added later
   if required.
9. Fixed the format of few comments and a definition in CXL feature
    code for the feedbacks from Fan.
11. Jonathan done several optimizations, interface changes and
    cleanups all over the code.
12. Fixes for feedbacks from Daniel Ferguson(Amperecomputing)
    for RAS2.
13.  Workaround for a RAS2 case of only one actual controller as
     reported by Daniel Ferguson(AmpereComputing) in their hardware.
14. Feedback from Yazen, move the common scrub and ras2 changes
    under /drivers/ras/.
15. Drop patch ACPICA: ACPI 6.5: Add support for RAS2 table because 
    Rafael queued the patch.
    https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=9726d821f88e284ecd998b76ae5f2174721cd9dc
 
v6 -> v7:
1. Main changes for comments from Jonathan, Thanks.
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

2. Changes for comments from Fan, Thanks.
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


Jonathan Cameron (2):
  ACPICA: Add __free() based cleanup function for acpi_put_table
  platform: Add __free() based cleanup function for platform_device_put

Shiju Jose (8):
  ras: scrub: Add scrub subsystem
  cxl/mbox: Add GET_SUPPORTED_FEATURES mailbox command
  cxl/mbox: Add GET_FEATURE mailbox command
  cxl/mbox: Add SET_FEATURE mailbox command
  cxl/memscrub: Add CXL device patrol scrub control feature
  ACPI:RAS2: Add ACPI RAS2 driver
  ras: scrub: Add scrub control attributes for ACPI RAS2
  ras: scrub: ACPI RAS2: Add memory ACPI RAS2 driver

 .../ABI/testing/sysfs-class-scrub-configure   |  71 ++++
 Documentation/scrub/scrub-configure.rst       |  85 ++++
 drivers/acpi/Kconfig                          |  10 +
 drivers/acpi/Makefile                         |   1 +
 drivers/acpi/ras2.c                           | 366 ++++++++++++++++
 drivers/cxl/Kconfig                           |  19 +
 drivers/cxl/core/Makefile                     |   1 +
 drivers/cxl/core/mbox.c                       | 153 +++++++
 drivers/cxl/core/memscrub.c                   | 314 ++++++++++++++
 drivers/cxl/cxlmem.h                          | 130 ++++++
 drivers/cxl/mem.c                             |   6 +
 drivers/ras/Kconfig                           |  17 +
 drivers/ras/Makefile                          |   2 +
 drivers/ras/acpi_ras2.c                       | 358 ++++++++++++++++
 drivers/ras/memory_scrub.c                    | 402 ++++++++++++++++++
 include/acpi/acpixf.h                         |   2 +
 include/acpi/ras2_acpi.h                      |  59 +++
 include/linux/memory_scrub.h                  |  45 ++
 include/linux/platform_device.h               |   1 +
 19 files changed, 2042 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-scrub-configure
 create mode 100644 Documentation/scrub/scrub-configure.rst
 create mode 100755 drivers/acpi/ras2.c
 create mode 100644 drivers/cxl/core/memscrub.c
 create mode 100644 drivers/ras/acpi_ras2.c
 create mode 100755 drivers/ras/memory_scrub.c
 create mode 100644 include/acpi/ras2_acpi.h
 create mode 100755 include/linux/memory_scrub.h

-- 
2.34.1


