Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A573812982
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbjLNHiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjLNHiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:38:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7686DA3;
        Wed, 13 Dec 2023 23:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702539492; x=1734075492;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=h6iwtR+Emw2EX9lZjGEXRQCb3JKoPyQmhXB1JkGLNZE=;
  b=DHFjAJPTQQqzUfMwsqBd71kL8avEX6nkCsuX6jPY4NCUrGjVONKIeMFq
   aSn/UJtPnd0u0B0NB3zbss/gTwSlKqLhftK7WMmc8tDpBm7pnMfsqKTpJ
   fvuEgyzS/o6XinjjFAb1ynqcGMzxyeUzupyEjk0TE3euOskGU2iyIDPYR
   wsnXCMYCOF6GkpH0ZCYf2JG3d+okEwBM7msml6/bJ4akskSRmVM+M2z/K
   RKlTsZdCXmoFqDs1rTmmZm4G3vkUyV597cay07nQwOfyUbKJORHKOqMlD
   vO+OxFcs4xRSTmfoO/kOehLKaiOEKYaTieHk+L/P0J/AOTZAYuxl0hE9a
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="481275504"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="481275504"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 23:38:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="723972055"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="723972055"
Received: from llblake-mobl1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.213.191.124])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 23:38:10 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v5 0/4] Add DAX ABI for memmap_on_memory
Date:   Thu, 14 Dec 2023 00:37:53 -0700
Message-Id: <20231214-vv-dax_abi-v5-0-3f7b006960b4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANGwemUC/3XM0QqCMBTG8VeJXbfYOZtTu+o9ImLOsxyUhsowx
 Hdv2o0Kca6+A7//yDpqPXXsfBhZS8F3vqnjSI4HZitTP4j7Mm6GAiUITHgIvDTD3RSeQ2oQcqu
 0SDWL4N2S88MSu97irnzXN+1naQeYv78MCr3OBOCCq1RRkWWEAuzF1z09T7Z5sTkT8D/FSJ2Kh
 1LqUmR7KlcUYENlpMY6bS0UJeVuT9Wa4oaqSEEmkCaZEzbHNZ2m6QsSnChrVQEAAA==
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, Joao Martins <joao.m.martins@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Li Zhijian <lizhijian@fujitsu.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.13-dev-433a8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3873;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=h6iwtR+Emw2EX9lZjGEXRQCb3JKoPyQmhXB1JkGLNZE=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDKlVG+499hN/bHjHzIXZ4f2aqSon9dUneh0P2eQcxcVfK
 /DPnkeoo5SFQYyLQVZMkeXvno+Mx+S25/MEJjjCzGFlAhnCwMUpABPJtWL4n2F/7nClCXdxvPpS
 YYsUNav9Z7eYdszbHpJ1n++8vc6BPQz/fWdYypxe3vOiMflFb6D3rHenfu58/z3m1ls3/dQ1b1e
 o8gAA
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
in patch 1. Switch to guard(device) semantics for Scope Based Resource
Management for device_{lock,unlock} flows in drivers/dax/bus.c in patch
2. Export mhp_supports_memmap_on_memory() in patch 3. Add a new ABI for
toggling memmap_on_memory semantics in patch 4.

The missing ABI was spotted in [1], this series is a split of the new
ABI additions behind the initial documentation creation.

[1]: https://lore.kernel.org/linux-cxl/651f27b728fef_ae7e7294b3@dwillia2-xfh.jf.intel.com.notmuch/

---
This series depends on [2] which adds the definition for guard(device).
[2]: https://lore.kernel.org/r/170250854466.1522182.17555361077409628655.stgit@dwillia2-xfh.jf.intel.com

---

Other Logistics -

Andrew, would you prefer patch 3 to go through mm? Or through the dax
tree with an mm ack? The remaining patches are all contained to dax, but
do depend on the memmap_on_memory set that is currently in mm-stable.

---

Changes in v5:
- Export and check mhp_supports_memmap_on_memory() in the DAX sysfs ABI
  (David)
- Obtain dax_drv under the device lock (Ying)
- Check dax_drv for NULL before dereferencing it (Ying)
- Clean up some repetition in sysfs-bus-dax documentation entries
  (Jonathan)
- A few additional cleanups enabled by guard(device) (Jonathan)
- Drop the DEFINE_GUARD() part of patch 2, add dependency on Dan's patch
  above so it can be backported / applied separately (Jonathan, Dan)
- Link to v4: https://lore.kernel.org/r/20231212-vv-dax_abi-v4-0-1351758f0c92@intel.com

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

Cc: <linux-kernel@vger.kernel.org>
Cc: <nvdimm@lists.linux.dev>
Cc: <linux-cxl@vger.kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <linux-mm@kvack.org>
To: Dan Williams <dan.j.williams@intel.com>
To: Vishal Verma <vishal.l.verma@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
To: Oscar Salvador <osalvador@suse.de>

---
Vishal Verma (4):
      Documentatiion/ABI: Add ABI documentation for sys-bus-dax
      dax/bus: Use guard(device) in sysfs attribute helpers
      mm/memory_hotplug: export mhp_supports_memmap_on_memory()
      dax: add a sysfs knob to control memmap_on_memory behavior

 include/linux/memory_hotplug.h          |   6 ++
 drivers/dax/bus.c                       | 181 +++++++++++++++++---------------
 mm/memory_hotplug.c                     |  17 ++-
 Documentation/ABI/testing/sysfs-bus-dax | 153 +++++++++++++++++++++++++++
 4 files changed, 262 insertions(+), 95 deletions(-)
---
base-commit: a6e0c2ca980d75d5ac6b2902c5c0028eaf094db3
change-id: 20231025-vv-dax_abi-17a219c46076

Best regards,
-- 
Vishal Verma <vishal.l.verma@intel.com>

