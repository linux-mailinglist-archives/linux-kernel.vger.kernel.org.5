Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0975F7D7829
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 00:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjJYWo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 18:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJYWo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 18:44:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB6610A;
        Wed, 25 Oct 2023 15:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698273896; x=1729809896;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=gz3VKimBJsZyyZ3LjSgqRdUvkSLq5Ho3PrPRQJbwLaE=;
  b=ZfQz3OhJt7G01IRgXcTIs4/JxOoVsYzUrRAYxkiwEygOi8+IU7jg9dMe
   9GU5SNEdbKftcPmEOPcmhFDbtfv9+BjnCNNKUqza03sggwgztm6uoLW9l
   WY9DnyLBtQVMUzBa+w6wgIVqoxAVpn5qZD/cXoXaS95tmx3k11UWxxI+1
   0XNTS3ev02RKMeX2XUjByqRySpOvL5Rwp2fIHK4I+P39pDbuR46bt8dAa
   K4iDF+nlHepyPhEfAXPigRv0eZI4N+GYlMYr+85OuSdR6H3XU4B0GSBBA
   t6EewMSq7Yw6kIuG9kpgQILyLOIV5cEnDNL04fH0Mf8U6OpAgqCi6LxhK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="473650434"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="473650434"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 15:44:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="708846714"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="708846714"
Received: from nmckubrx-mobl.amr.corp.intel.com (HELO [192.168.1.200]) ([10.212.68.190])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 15:44:48 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v7 0/3] mm: use memmap_on_memory semantics for dax/kmem
Date:   Wed, 25 Oct 2023 16:44:32 -0600
Message-Id: <20231025-vv-kmem_memmap-v7-0-4a76d7652df5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFCaOWUC/3XOy07DMBAF0F+pvMZo/La74j8QQhM/iEWTVEmxQ
 FX+HbcLUsViMYs70rkzV7LEOceFHA9XMseSlzyNNZinA/E9jh+R5lAz4cAFaCZoKfRziMN7nQH
 PVEkrvA0guXGkog6XSLsZR99XNn6dTnV5nmPK3/crr28193m5TPPP/Whht+2//YVRoEmH6LzGx
 L1+yeMlnp79NJBbVeEbNxwaziu3tguInZDOiT0XG7fAGi4ql6CjQ0xKW7fncuOO24bLynVKRqT
 oFXO45+qPMwDVcFU5KhmYsywBNs/rB850w3XlYGyCIDwIwx75uq6/2p5LvPwBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5215;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=gz3VKimBJsZyyZ3LjSgqRdUvkSLq5Ho3PrPRQJbwLaE=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDKmWs6JrZ+qF9p6322j1bOmdkx/C10WeM2NjWCn+YpvUq
 5Mng2MMO0pZGMS4GGTFFFn+7vnIeExuez5PYIIjzBxWJpAhDFycAjCRGdwMf3h8BM5+ttaqfBCy
 W+dW3QG25oofO94ISn6pib/C9FZ28nOGP3z/lThPeWQKVbxrlP52IaF/VV3IFWd3oVimw/kblmd
 MZgIA
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

Patch 1 replaces an open-coded kmemdup()

Patch 2 teaches the memory_hotplug code to allow for splitting
add_memory() and remove_memory() requests over memblock sized chunks.

Patch 3 allows the dax region drivers to request memmap_on_memory
semantics. CXL dax regions default this to 'on', all others default to
off to keep existing behavior unchanged.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
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
 mm/memory_hotplug.c       | 207 ++++++++++++++++++++++++++++++++--------------
 8 files changed, 158 insertions(+), 65 deletions(-)
---
base-commit: 25b5b1a0646c3d39e1d885e27c10be1c9e202bf2
change-id: 20230613-vv-kmem_memmap-5483c8d04279

Best regards,
-- 
Vishal Verma <vishal.l.verma@intel.com>

