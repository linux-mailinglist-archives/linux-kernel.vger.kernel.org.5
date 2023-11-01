Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0B77DE854
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 23:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347105AbjKAWwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 18:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKAWw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 18:52:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C2F10F;
        Wed,  1 Nov 2023 15:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698879144; x=1730415144;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=7Zwws/L01GXfN5fAEQOoQCagibq/5sDrCEtzSmit9ns=;
  b=O7Z9hJhQRE6PqcadO2p9glv79IKNCU5YYBM/01vbezhSmGYoAXnOqJGx
   Sk6L4Tb0nZTa55ljU2BSftTV3bZnqDyZk3dplav/jKrQIU9cCfrThO9Zo
   uvHEhSdgz8teWVwlArDznh1K+UxC0ww9JuKTr1fdZJxlntFJCkFydUD7A
   S5DnRaVSpgCtnGrInzQRUmpekg+wdnkBc/8eEnETSpoIog4NBGXpyOusH
   A7NEmS+9dcHUP0V5F5ugjELrT3E6B6K0FncsfjVDfaUZsdvbvCAhSmd41
   232CmZKsolmRvBo8sScRVEjGGgzNLJ+osw6dYLBT3+IPVDcA+Adwvxw5n
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="10133599"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="10133599"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 15:52:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="796033553"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="796033553"
Received: from dgopalan-mobl.amr.corp.intel.com (HELO [192.168.1.200]) ([10.212.98.103])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 15:52:21 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v8 0/3] mm: use memmap_on_memory semantics for dax/kmem
Date:   Wed, 01 Nov 2023 16:51:50 -0600
Message-Id: <20231101-vv-kmem_memmap-v8-0-5e4a83331388@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIbWQmUC/3XPy2rDMBAF0F8JWldl9Jay6n+UUsZ61KKxHezUt
 AT/e+UsamPRhRZ34MzV3MkUxxwncj7dyRjnPOWhL8E+nYhvsf+INIeSCQcuQDNB55l+drF7L6/
 DK1XSCm8DSG4cKajBKdJmxN63hfVfl0sZXseY8vej5fWt5DZPt2H8eZTObJ3+u39mFGjSITqvM
 XGvX3J/i5dnP3RkXTXzjRsOFeeFW9sExEZI58SRi41bYBUXhUvQ0SEmpa07crlxx23FZeE6JSN
 S9Io5PHL1xxmAqrgqHJUMzFmWAKvP6x1nuuK6cDA2QRAehGFHbnac1+1mvR2NDkYrHpLa82VZf
 gFS9LEBOwIAAA==
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
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5789;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=7Zwws/L01GXfN5fAEQOoQCagibq/5sDrCEtzSmit9ns=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDKlO1xZaNnlzN74y9ZSc5PYlY8WSz4wCee2Hvti7R+Q7P
 owvnc3WUcrCIMbFICumyPJ3z0fGY3Lb83kCExxh5rAygQxh4OIUgIk8zGRkeMP461hG657V+oHf
 u/v+NBS9XhHLcHQZx1fOl7d6Jtq6f2Fk2PeXr64/lvW8rl3FoRvOa9XNA38p6p7omfS8JWuml6k
 VBwA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Patch 1 replaces an open-coded kmemdup()

Patch 2 teaches the memory_hotplug code to allow for splitting
add_memory() and remove_memory() requests over memblock sized chunks.

Patch 3 allows the dax region drivers to request memmap_on_memory
semantics. CXL dax regions default this to 'on', all others default to
off to keep existing behavior unchanged.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
Changes in v8:
- Fix unwinding in create_altmaps_and_memory_blocks() to remove
  partially added blocks and altmaps. (David, Ying)
- Simplify remove_memory_blocks_and_altmaps() since an altmap is
  assured. (David)
- Since we remove per memory-block altmaps, the walk through  memory
  blocks for a larger range isn't needed. Instead we can lookup the
  memory block directly from the pfn, allowing the test_has_altmap_cb()
  callback to be dropped and removed. (David)
- Link to v7: https://lore.kernel.org/r/20231025-vv-kmem_memmap-v7-0-4a76d7652df5@intel.com

Changes in v7:
- Make the add_memory_resource() flow symmetrical w.r.t. try_remove_memory()
  in terms of how the altmap path is taken (David Hildenbrand)
- Move a comment, clean up usage of 'memblock' vs. 'memory_block'
  (David Hildenbrand)
- Don't use the altmap path for the mhp_supports_memmap_on_memory(memblock_size) == false
  case (Huang Ying)
- Link to v6: https://lore.kernel.org/r/20231016-vv-kmem_memmap-v6-0-078f0d3c0371@intel.com

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
 mm/memory_hotplug.c       | 211 ++++++++++++++++++++++++++++++----------------
 8 files changed, 152 insertions(+), 75 deletions(-)
---
base-commit: 25b5b1a0646c3d39e1d885e27c10be1c9e202bf2
change-id: 20230613-vv-kmem_memmap-5483c8d04279

Best regards,
-- 
Vishal Verma <vishal.l.verma@intel.com>

