Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DC780F611
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376698AbjLLTIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbjLLTIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:08:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6D0AF;
        Tue, 12 Dec 2023 11:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702408128; x=1733944128;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=dpfvyMcZmnaBfEa9kAQ2vdi2Cex9sJ/adqK/EfeY78w=;
  b=HbIsefz47uawHoqhCyRlXukge1juFRTdDuyiTYgGzToyQQi/uuu7Vw9f
   pKT4ij4eiODLjVClBDDVrRBXE8UBOkp0rnszqjkOXu45v3TDqjqMB4YIl
   SZW1k1yYk49LQQiJujaq+VHAAveCCUZIcdMj4i56iVvQ7H8d3Lka1r1lI
   5bgaoDC2Cod19kWdVimWTK5QdveScqXypwJ14ivdAE6mfqUZlkXIHAB/r
   UZMTeWBqnNtzB2dElKnCcSxDda1pvIzDoDyZ+NnnSN/no0QQTGJ868NdO
   Yoqc31hbhWT7lvy2TvIchjV/F73KeffM2/w3QZyfIbjIQ92p3c04AdTUa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="13550585"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="13550585"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 11:08:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="844017855"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="844017855"
Received: from cmperez2-mobl2.amr.corp.intel.com (HELO [192.168.1.200]) ([10.212.66.25])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 11:08:45 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v4 0/3] Add DAX ABI for memmap_on_memory
Date:   Tue, 12 Dec 2023 12:08:29 -0700
Message-Id: <20231212-vv-dax_abi-v4-0-1351758f0c92@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK2veGUC/3XM0QqCMBTG8VeRXbfYOVtTu+o9ImJuZzkoDZVhi
 O/etBsL4lx9B37/ifXUBerZMZtYRzH0oW3SULuM2do0N+LBpc1QoASBBx4jd2a8mipwyA1CaZU
 WuWYJPDvyYVxj50vadeiHtnut7QjL95NBobeZCFxwlSuqioJQgD2FZqD73rYPtmQi/qeYqFfpU
 ErtRPFL5YYCfFGZqLFeWwuVo9Jv6TzPb0gBiYIaAQAA
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Li Zhijian <lizhijian@fujitsu.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.13-dev-433a8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2200;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=dpfvyMcZmnaBfEa9kAQ2vdi2Cex9sJ/adqK/EfeY78w=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDKkV63dGlR9OO/jFJiTw7osF+afjTgeW2stbzNb6vT9ff
 6L5w5+yHaUsDGJcDLJiiix/93xkPCa3PZ8nMMERZg4rE8gQBi5OAZjIpzRGhp/PbmlwrH9xZ1UC
 X1/kxua/D2xYJq5UPpmxpb6ngC2ep5uRYYbRRP+trzbfCZ797YRAwDaHlPfv13EvPaG9hfXkwrU
 6rhwA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DAX drivers were missing sysfs ABI documentation entirely.  Add this
missing documentation for the sysfs ABI for DAX regions and Dax devices
in patch 1. Define guard(device) semantics for Scope Based Resource
Management for device_lock, and convert device_{lock,unlock} flows in
drivers/dax/bus.c to use this in patch 2. Add a new ABI for toggling
memmap_on_memory semantics in patch 3.

The missing ABI was spotted in [1], this series is a split of the new
ABI additions behind the initial documentation creation.

[1]: https://lore.kernel.org/linux-cxl/651f27b728fef_ae7e7294b3@dwillia2-xfh.jf.intel.com.notmuch/

Changes in v4:
- Hold the device lock when checking if the dax_dev is bound to kmem
  (Ying, Dan)
- Remove dax region checks (and locks) as they were unnecessary.
- Introduce guard(device) for device lock/unlock (Dan)
- Convert the rest of drivers/dax/bus.c to guard(device)
- Link to v3: https://lore.kernel.org/r/20231211-vv-dax_abi-v3-0-acf6cc1bde9f@intel.com

Changes in v3:
- Fix typo in ABI docs (Zhijian Li)
- Add kernel config and module parameter dependencies to the ABI docs
  entry (David Hildenbrand)
- Ensure kmem isn't active when setting the sysfs attribute (Ying
  Huang)
- Simplify returning from memmap_on_memory_store()
- Link to v2: https://lore.kernel.org/r/20231206-vv-dax_abi-v2-0-f4f4f2336d08@intel.com

Changes in v2:
- Fix CC lists, patch 1/2 didn't get sent correctly in v1
- Link to v1: https://lore.kernel.org/r/20231206-vv-dax_abi-v1-0-474eb88e201c@intel.com

---
Vishal Verma (3):
      Documentatiion/ABI: Add ABI documentation for sys-bus-dax
      dax/bus: Introduce guard(device) for device_{lock,unlock} flows
      dax: add a sysfs knob to control memmap_on_memory behavior

 include/linux/device.h                  |   2 +
 drivers/dax/bus.c                       | 141 ++++++++++++++-------------
 Documentation/ABI/testing/sysfs-bus-dax | 168 ++++++++++++++++++++++++++++++++
 3 files changed, 244 insertions(+), 67 deletions(-)
---
base-commit: c4e1ccfad42352918810802095a8ace8d1c744c9
change-id: 20231025-vv-dax_abi-17a219c46076

Best regards,
-- 
Vishal Verma <vishal.l.verma@intel.com>

