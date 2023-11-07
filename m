Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0EA7E35C6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 08:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbjKGHXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 02:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjKGHXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 02:23:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15580C0;
        Mon,  6 Nov 2023 23:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699341797; x=1730877797;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=zxih+4WMqEN6PqGG1MzxNGemsJnW9/vzuClucSb0Eao=;
  b=N7+rvl3ShpMQTrM8esyq6BF9a24X2OLYoG5gCSC5FS67aYNUPpcLiLWj
   xxg0oQV8SBPNi2uJcmI649p+y02T7K+kM2TAojbLr9qQPCYx+FaqSo8WO
   YKZw0vEmorxG05MDeM+3P5eeJOE8IsIbust26FJL/2O66r+z5yQyb0Bn8
   bEv5A/iqYlT656DJrRY9ndnY4tBFExmBiyt5idrJpTPp/+ZXcFwr8vVxP
   2CBO9zrMUU1Niq3Ge8EZ2Y3WrhbE7q0RHScOQ/9g0RUQoj3i2pycoxes/
   voAptim7qELlWLA6MJJ27B7ggWUzfL/G5aKmOq1nCieI4vxEAH4lij1Hx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="475689615"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="475689615"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 23:23:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="712477201"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="712477201"
Received: from pengmich-mobl1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.212.96.119])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 23:23:14 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v10 0/3] mm: use memmap_on_memory semantics for dax/kmem
Date:   Tue, 07 Nov 2023 00:22:40 -0700
Message-Id: <20231107-vv-kmem_memmap-v10-0-1253ec050ed0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMDlSWUC/3XQzU7DMAwH8FeZciYoifPh7MR7IITcfLCItZvaU
 YGmvTvZDnQ0cMjBf+lnxz6zKY0lTWy7ObMxzWUqh6EWUjxsWNjR8JZ4iTVgSigQVgKfZ/7ep/6
 1vp6O3GiEgFFo5TyrqKMp8W6kIewqGz72+xoex5TL523M80utd2U6Hcav29RZXtN/+8+SC55tT
 D5YyirYpzKc0v4xHHp2bTWrhTslGq4qR+wiUQfae1hzWDgK2XCoXAubPFE2Fv2a64V7hQ3Xldu
 cHeQUjPS05uaHSyFMw03lZHSUHmUW1Hze3nFpG24rFw6ziBAEOLnm7o6rdrq77k7ORmeNitmsO
 S5c/nE6rNwkTQgAEhDX3N9z1XBfuXcQbQeEWf463eVy+QbJXVTSugIAAA==
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
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.13-dev-26615
X-Developer-Signature: v=1; a=openpgp-sha256; l=6235;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=zxih+4WMqEN6PqGG1MzxNGemsJnW9/vzuClucSb0Eao=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDKmeT+8lqLYqtqmsDr58Ui/2IUt13unTWaqnk5oNgluMl
 0RPKH3XUcrCIMbFICumyPJ3z0fGY3Lb83kCExxh5rAygQxh4OIUgIk0rmZkmPcy0yS6s6VQ7Min
 vef3v0wzk7Fesb/n3qdnd/2FG6tYJzAyvIw8+0r8ueoH447pXOpli1/+SOlb/fHw74RT3VOOBDL
 3sAEA
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
Changes in v10:
- Rebase on current mainline (Andrew Morton)
- Pick up Reviewed-by (Fan Ni)
- Link to v9: https://lore.kernel.org/r/20231102-vv-kmem_memmap-v9-0-973d6b3a8f1a@intel.com

Changes in v9:
- Fix error unwinding for the ENOMEM case in
  remove_memory_blocks_and_altmaps() (Ying, David)
- Misc readability and style cleanups (David)
- Link to v8: https://lore.kernel.org/r/20231101-vv-kmem_memmap-v8-0-5e4a83331388@intel.com

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
 mm/memory_hotplug.c       | 210 +++++++++++++++++++++++++++++-----------------
 8 files changed, 150 insertions(+), 76 deletions(-)
---
base-commit: d2f51b3516dade79269ff45eae2a7668ae711b25
change-id: 20230613-vv-kmem_memmap-5483c8d04279

Best regards,
-- 
Vishal Verma <vishal.l.verma@intel.com>

