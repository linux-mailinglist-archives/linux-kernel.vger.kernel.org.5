Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E0A75A77E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjGTHOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjGTHOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:14:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052021FD7;
        Thu, 20 Jul 2023 00:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689837269; x=1721373269;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=go6W94T7bVzWJfRcg0tjdLa7TppzyTeQot8p3HsrXWc=;
  b=FxRcrh5HdGp42pKxnMYcOmBrXdamAv0kbVOLXx5FOmy1ApKhGKvCBT9o
   bJr5Kn7xrL11zhffkFPDIEep6u+vl0D/CwGlf1gKes7IPywlUdD+xmPp8
   E53CEW8sNDfEc+41sOf+IlENboOsk159blgcaKzmaxL5Sg/63DNKbTTGg
   8wIZesYEb9svPPiIAzjLI7Gw42HUkvUtqtw7h75wxvhZlBFFNXzAbI8qu
   6gcgdZqDvcAIamNsb8J+D3AsHruslrhjlFapwwyqc6GYTDApJMkeLGE6K
   p16OF0XK/xY18Y0zbYfs73FppzTsXL2pRXJPfYauQTjkkhGXNy39WuJRT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="430423986"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="430423986"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 00:14:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="794334960"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="794334960"
Received: from mfgalan-mobl1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.213.172.204])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 00:14:28 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2 0/3] mm: use memmap_on_memory semantics for dax/kmem
Date:   Thu, 20 Jul 2023 01:14:21 -0600
Message-Id: <20230720-vv-kmem_memmap-v2-0-88bdaab34993@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM7euGQC/3WNwQ6CMBBEf4Xs2ZpSsIIn/8MQU8oiG2khLTYaw
 r+7cvcwhzfJm1khYiCMcMlWCJgo0uQZ1CEDOxj/QEEdMyipCqnzQqQkng7dnePMLE5lVdiqk6U
 618BSayKKNhhvB9b8axy5nAP29N5fbg3zQHGZwmc/Tfmv/bufciFFrzusrTa9svpKfsHxaCcHz
 bZtX2Tn8LzBAAAA
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
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2452;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=go6W94T7bVzWJfRcg0tjdLa7TppzyTeQot8p3HsrXWc=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDCk77l34kVP6oD5yqjbXvvifH26/OLhsMWeb0oL4vJKSl
 zMZ/NYJd5SyMIhxMciKKbL83fOR8Zjc9nyewARHmDmsTCBDGLg4BWAiB6wZGRp7DLqke8W52T+n
 XDx9O8D2iChXRfDU/jLl/+cUlXs3ejMyfOvz/PbKueVXrYKZy2/rNo1bT0vW/5t6PPVEiGvSPyE
 JBgA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
memblock. To overcome this,allow the hotplug code to split an add_memory()
request into memblock-sized chunks, and try_remove_memory() to also
expect and handle such a scenario.

Patch 1 exports mhp_supports_memmap_on_memory() so it can be used by the
kmem driver.

Patch 2 teaches the memory_hotplug code to allow for splitting
add_memory() and remove_memory() requests over memblock sized chunks.

Patch 3 adds a sysfs control for the kmem driver that would
allow an opt-out of using memmap_on_memory for the memory being added.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
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
      mm/memory_hotplug: Export symbol mhp_supports_memmap_on_memory()
      mm/memory_hotplug: split memmap_on_memory requests across memblocks
      dax/kmem: allow kmem to add memory with memmap_on_memory

 include/linux/memory_hotplug.h |   5 ++
 drivers/dax/dax-private.h      |   1 +
 drivers/dax/bus.c              |  48 +++++++++++++
 drivers/dax/kmem.c             |   7 +-
 mm/memory_hotplug.c            | 155 ++++++++++++++++++++++++-----------------
 5 files changed, 152 insertions(+), 64 deletions(-)
---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230613-vv-kmem_memmap-5483c8d04279

Best regards,
-- 
Vishal Verma <vishal.l.verma@intel.com>

