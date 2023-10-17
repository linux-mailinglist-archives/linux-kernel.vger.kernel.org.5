Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A46C7CBA40
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbjJQFpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJQFpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:45:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077CAB0;
        Mon, 16 Oct 2023 22:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697521507; x=1729057507;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=D2q85RkwugIFb5ErxqlgU3WLAEq5xCEwZ4AKsbq/LHM=;
  b=Pjx5StE1NQI7LiGGeX+Bpt/10W28HbeoW76XtDgzvGf09aGHrMSZ9gM6
   QpLjg3rxg0c75bFo1PugVaMPngVYCK2gJBFbam5JIn3+k1NO04XjGf/PC
   EUFiC5fFO8l/zdaC8QhDQ13JP/qa588t4sA1Xn0FqkkYm2N4Qx9sDg3/5
   RfkOF3VHjJpIyvNWFqyR59G7gojqxVk7hcbVZ/KY2myO2SW9l5y3R5ifW
   xJ7Ixps6UqA8l7hbbcohz0pDzPASmrDTs+96e8srfpABPgyLAYUXQIA1D
   5jLJ+JErjdQjm1EwNdr7hp4/1q/WmzVcnUqxEm4rYtiv6BBgen62hDthF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="384580741"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="384580741"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 22:45:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="879693918"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="879693918"
Received: from mjwirth-mobl.amr.corp.intel.com (HELO [192.168.1.200]) ([10.209.151.162])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 22:45:00 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v6 0/3] mm: use memmap_on_memory semantics for dax/kmem
Date:   Mon, 16 Oct 2023 23:44:54 -0600
Message-Id: <20231016-vv-kmem_memmap-v6-0-078f0d3c0371@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFYfLmUC/3XOy07EMAwF0F8ZZU1Q3k1Y8R8IITd1aEQfo2aIQ
 KP+O55ZUNGKhRfX0rn2lRVcMhb2dLqyBWsueZ4ouIcTiz1M78hzR5kpobRwUvNa+ceI4xvNCGd
 ujdfRd8KoJjBCLRTk7QJT7IlNn8NAy/OCKX/dr7y8Uu5zuczL9/1olbftv/1VcsGT6zBEB0lF9
 5ynCw6PcR7ZraqqjTdKHLgi7n3bAbTahKD3XG/cC3ngmrgRDgNAss6HPTcbD8ofuCHuUmp0wmh
 lgD23v1wKYQ/cEgdrOhm8TAL+PL+u6w9QU2covQEAAA==
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4668;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=D2q85RkwugIFb5ErxqlgU3WLAEq5xCEwZ4AKsbq/LHM=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDKl68pEKMU+LNeWDPF1K7pYs2eC89+dCgaITj6ZWLevbt
 zZ1gpd+RykLgxgXg6yYIsvfPR8Zj8ltz+cJTHCEmcPKBDKEgYtTACaSG8PI8ETpm+Z+0z/O+x8f
 2FCWtrh28/FEyX+NvkKcb1tuun5gjmD4n1FWn8v0TMSkpvZ0HoP/w2s6VY4sljyuwt9vzLQIKNd
 iBAA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dax/kmem driver can potentially hot-add large amounts of memory
originating from CXL memory expanders, or NVDIMMs, or other 'device
memories'. There is a chance there isn't enough regular system memory
available to fit the memmap for this new memory. It's therefore
desirable, if all other conditions are met, for the kmem managed memory
to place its memmap on the newly added memory itself.

The main hurdle for accomplishing this for kmem is that memmap_on_memory
can only be done if the memory being added is equal to the size of one
memblock. To overcome this, allow the hotplug code to split an add_memory()
request into memblock-sized chunks, and try_remove_memory() to also
expect and handle such a scenario.

Patch 1 teaches the memory_hotplug code to allow for splitting
add_memory() and remove_memory() requests over memblock sized chunks.

Patch 2 adds a sysfs control for the kmem driver that would
allow an opt-out of using memmap_on_memory for the memory being added.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
Changes in v6:
- Add a prep patch to replace an open coded kmemdup in
  add_memory_resource() (Dan Williams)
- Fix ordering of firmware_map_remove w.r.t taking the hotplug lock
  (David Hildenbrand)
- Remove unused 'nid' variable, and a stray whitespace (David Hildenbrand)
- Clean up and simplify the altmap vs non-altmap paths for
  try_remove_memory (David Hildenbrand)
- Add a note to the changelog in patch 1 linking to the PUD mappings
  proposal (David Hildenbrand)
- Remove the new sysfs ABI from the kmem/dax drivers until ABI
  documentation for /sys/bus/dax can be established (will split this out
  into a separate patchset) (Dan Williams)
- Link to v5: https://lore.kernel.org/r/20231005-vv-kmem_memmap-v5-0-a54d1981f0a3@intel.com

Changes in v5:
- Separate out per-memblock operations from per memory block operations
  in try_remove_memory(), and rename the inner function appropriately.
  This does expand the scope of the memory hotplug lock to include
  remove_memory_block_devices(), but the alternative was to drop the
  lock in the inner function separately for each iteration, and then
  re-acquire it in try_remove_memory() creating a small window where
  the lock isn't held. (David Hildenbrand)
- Remove unnecessary rc check from the memmap_on_memory_store sysfs
  helper in patch 2 (Dan Carpenter)
- Link to v4: https://lore.kernel.org/r/20230928-vv-kmem_memmap-v4-0-6ff73fec519a@intel.com

Changes in v4:
- Rebase to Aneesh's PPC64 memmap_on_memory series v8 [2].
- Tweak a goto / error path in add_memory_create_devices() (Jonathan)
- Retain the old behavior for dax devices, only default to
  memmap_on_memory for CXL (Jonathan)
- Link to v3: https://lore.kernel.org/r/20230801-vv-kmem_memmap-v3-0-406e9aaf5689@intel.com

[2]: https://lore.kernel.org/linux-mm/20230808091501.287660-1-aneesh.kumar@linux.ibm.com

Changes in v3:
- Rebase on Aneesh's patches [1]
- Drop Patch 1 - it is not needed since [1] allows for dynamic setting
  of the memmap_on_memory param (David)
- Link to v2: https://lore.kernel.org/r/20230720-vv-kmem_memmap-v2-0-88bdaab34993@intel.com

[1]: https://lore.kernel.org/r/20230801044116.10674-1-aneesh.kumar@linux.ibm.com

Changes in v2:
- Drop the patch to create an override path for the memmap_on_memory
  module param (David)
- Move the chunking into memory_hotplug.c so that any caller of
  add_memory() can request this behavior. (David)
- Handle remove_memory() too. (David, Ying)
- Add a sysfs control in the kmem driver for memmap_on_memory semantics
  (David, Jonathan)
- Add a #else case to define mhp_supports_memmap_on_memory() if
  CONFIG_MEMORY_HOTPLUG is unset. (0day report)
- Link to v1: https://lore.kernel.org/r/20230613-vv-kmem_memmap-v1-0-f6de9c6af2c6@intel.com

---
Vishal Verma (3):
      mm/memory_hotplug: replace an open-coded kmemdup() in add_memory_resource()
      mm/memory_hotplug: split memmap_on_memory requests across memblocks
      dax/kmem: allow kmem to add memory with memmap_on_memory

 drivers/dax/bus.h         |   1 +
 drivers/dax/dax-private.h |   1 +
 drivers/dax/bus.c         |   3 +
 drivers/dax/cxl.c         |   1 +
 drivers/dax/hmem/hmem.c   |   1 +
 drivers/dax/kmem.c        |   8 +-
 drivers/dax/pmem.c        |   1 +
 mm/memory_hotplug.c       | 214 ++++++++++++++++++++++++++++++++--------------
 8 files changed, 163 insertions(+), 67 deletions(-)
---
base-commit: 25b5b1a0646c3d39e1d885e27c10be1c9e202bf2
change-id: 20230613-vv-kmem_memmap-5483c8d04279

Best regards,
-- 
Vishal Verma <vishal.l.verma@intel.com>

