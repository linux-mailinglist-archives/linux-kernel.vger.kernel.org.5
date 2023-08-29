Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D0F78BDCE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 07:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbjH2FYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 01:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbjH2FXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 01:23:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F72198;
        Mon, 28 Aug 2023 22:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693286629; x=1724822629;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=A5E1QO0Muv9CKMLT/sotcOqRhE+vFwm9Hd7FndpNHeo=;
  b=BLH28EZH68rs/EQxN5bJ+nj3FE5k1goW8jAr9OwymzzjqFrjqbgqzdAu
   z4BaAmWA1wx9w79gw/AxCTq9sb0Bo3Tos6j06mAAQijRfDf9ipWrOGHBR
   E5cv5q6cJUWbee9n0MkJg+bggpAr5o956XlkAdGuoEuMbyQXa3CEzbacJ
   zy8kREt89Wb18AhA+jpdFXWgydGu6bScI++bNgizaOCaZG5f56qwybQVu
   SHuy3rM26UrayR2VEZG1zEOOPpe+4dxLev/u2wsX+7w+7+tjmPQtQW87r
   RdwLiuCht3oJ7nFZnYg8uBmzMw3UR2eVxQOyfOeIfkAhT/i12YA37/MVB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="441625153"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="441625153"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 22:23:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="738556282"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="738556282"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.37.183])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 22:23:30 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH RFC v2 00/18] DCD: Add support for Dynamic Capacity Devices
 (DCD)
Date:   Mon, 28 Aug 2023 22:20:51 -0700
Message-Id: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADOA7WQC/32OzQqDMBCEX0X23C1J1BR6KhT6AL0WD/lZa6BGS
 VKpiO/e6K2XHmfmG2YWiBQcRTgXCwSaXHSDz0IcCjCd8k9CZ7MGwUTJJKvQGotpHknge4wpkOq
 RGcvrVgouWwu5qFUk1EF5023VX3oDxkCt++yrD7jfrtBks3MxDWHen0x8j/6NThwZnriWZcW1o
 rq6OJ/odTRDD826rl/jEZ2B2gAAAA==
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693286607; l=5925;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=A5E1QO0Muv9CKMLT/sotcOqRhE+vFwm9Hd7FndpNHeo=;
 b=FfwSS3QN/OUCY00XcZhHEU4cknG+tUPOXkOrlrGwmGBg+IG4WBIOLWmPCyIGe/Ql0ScO6gPjr
 8XFaLwV+HMDCsj/PdqAjp6YBlRqpo5TUNdl63RRQSovFBK9xwF8C2wk
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A Dynamic Capacity Device (DCD) (CXL 3.0 spec 9.13.3) is a CXL memory
device that implements dynamic capacity.  Dynamic capacity feature
allows memory capacity to change dynamically, without the need for
resetting the device.

Even though this is marked v2 by b4, this is effectively a whole new
series for DCD support.  Quite a bit of the core support was completed
by Navneet in [4].  However, the architecture through the CXL region,
DAX region, and DAX Device layers is completely different.  Particular
attention was paid to:

	1) managing skip resources in the hardware device
	2) ensuring the host OS only sent a release memory mailbox
	   response when all DAX devices are done using an extent
	3) allowing dax devices to span extents
	4) allowing dax devices to use parts of extents

I could say all of the review comments from v1 are addressed but frankly
the series has changed so much that I can't guarantee anything.

The series continues to be based on the type-2 work posted from Dan.[2]
However, my branch with that work is a bit dated.  Therefore I have
posted this series on github here.[5]

Testing was sped up with cxl-test and ndctl dcd support.  A preview of
that work is on github.[6]  In addition Fan Ni's Qemu DCD series was
used part of the time.[3]

The major parts of this series are:

- Get the dynamic capacity (DC) region information from cxl device
- Configure device DC regions reported by hardware
- Enhance CXL and DAX regions for DC
	a. maintain separation between the hardware extents and the CXL
	   region extents to provide for the addition of interleaving in
	   the future.
- Get and maintain the hardware extent lists for each device via an
  initial extent list and DC event records
        a. Add capacity Events
	b. Add capacity response
	b. Release capacity events
	d. Release capacity response
- Notify region layers of extent changes
- Allow for DAX devices to be created on extents which are surfaced
- Maintain references on extents which are in use
	a. Send Release capacity Response only when DAX devices are not
	   using memory
- Allow DAX region extent labels to change to allow for flexibility in
  DAX device creation in the future (further enhancements are required
  to ndctl for this)
- Trace Dynamic Capacity events
- Add cxl-test infrastructure to allow for faster unit testing

To: Dan Williams <dan.j.williams@intel.com>
Cc: Navneet Singh <navneet.singh@intel.com>
Cc: Fan Ni <fan.ni@samsung.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

[1] https://lore.kernel.org/all/64326437c1496_934b2949f@dwillia2-mobl3.amr.corp.intel.com.notmuch/
[2] https://lore.kernel.org/all/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/
[3] https://lore.kernel.org/all/6483946e8152f_f1132294a2@iweiny-mobl.notmuch/
[4] https://lore.kernel.org/r/20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com
[5] https://github.com/weiny2/linux-kernel/commits/dcd-v2-2023-08-28
[6] https://github.com/weiny2/ndctl/tree/dcd-region2

---
Changes in v2:
- iweiny: Complete rework of the entire series
- Link to v1: https://lore.kernel.org/r/20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com

---
Ira Weiny (15):
      cxl/hdm: Debug, use decoder name function
      cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
      cxl/region: Add Dynamic Capacity decoder and region modes
      cxl/port: Add Dynamic Capacity mode support to endpoint decoders
      cxl/port: Add Dynamic Capacity size support to endpoint decoders
      cxl/region: Add Dynamic Capacity CXL region support
      cxl/mem: Read extents on memory device discovery
      cxl/mem: Handle DCD add and release capacity events.
      cxl/region: Expose DC extents on region driver load
      cxl/region: Notify regions of DC changes
      dax/bus: Factor out dev dax resize logic
      dax/region: Support DAX device creation on dynamic DAX regions
      tools/testing/cxl: Make event logs dynamic
      tools/testing/cxl: Add DC Regions to mock mem data
      tools/testing/cxl: Add Dynamic Capacity events

Navneet Singh (3):
      cxl/mem: Read Dynamic capacity configuration from the device
      cxl/mem: Expose device dynamic capacity configuration
      cxl/mem: Trace Dynamic capacity Event Record

 Documentation/ABI/testing/sysfs-bus-cxl |  56 ++-
 drivers/cxl/core/core.h                 |   1 +
 drivers/cxl/core/hdm.c                  | 215 ++++++++-
 drivers/cxl/core/mbox.c                 | 646 +++++++++++++++++++++++++-
 drivers/cxl/core/memdev.c               |  77 ++++
 drivers/cxl/core/port.c                 |  19 +
 drivers/cxl/core/region.c               | 418 +++++++++++++++--
 drivers/cxl/core/trace.h                |  65 +++
 drivers/cxl/cxl.h                       |  99 +++-
 drivers/cxl/cxlmem.h                    | 138 +++++-
 drivers/cxl/mem.c                       |  50 ++
 drivers/cxl/pci.c                       |   8 +
 drivers/dax/Makefile                    |   1 +
 drivers/dax/bus.c                       | 263 ++++++++---
 drivers/dax/bus.h                       |   1 +
 drivers/dax/cxl.c                       | 213 ++++++++-
 drivers/dax/dax-private.h               |  61 +++
 drivers/dax/extent.c                    | 133 ++++++
 tools/testing/cxl/test/mem.c            | 782 +++++++++++++++++++++++++++-----
 19 files changed, 3005 insertions(+), 241 deletions(-)
---
base-commit: c76cce37fb6f3796e8e146677ba98d3cca30a488
change-id: 20230604-dcd-type2-upstream-0cd15f6216fd

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

