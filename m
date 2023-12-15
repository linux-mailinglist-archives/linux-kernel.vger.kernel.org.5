Return-Path: <linux-kernel+bounces-443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 041B2814133
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA5E1C223FE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 05:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1BC6AA7;
	Fri, 15 Dec 2023 05:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CIVEIeHH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D972D569C;
	Fri, 15 Dec 2023 05:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702617937; x=1734153937;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=gpIMG98kSfTR7IkA5YlRDrASpRxzVoLtmbllKBAG/Uo=;
  b=CIVEIeHHUjlmGEACu7ueGXwlbOVAvx1pIDe5lI+Uxs6UGTUPQ6TAPcHV
   C3GO1imcmlhDHGAhzodvmK7LLI50MHYC3Gzb184Z7/Qbwf0dxTEx/cIx+
   tY1j0qLDK7zdqPhmsumq9Xg8RxTDMoEpwM4fyCjTaRoBqQQ1aht7cZd6M
   hrDGyZk4AMguFBX9tWkdcq/v9pPHtfmHSVfTHO9lah8Aq+jAuylK7V2WC
   t/vAmsTOSCiTLZPRtAvCYFgIG2E9D1R6ytIrbTOHc6ZAzgwtILaqO3KcW
   kRmEf0VtQBZPVlTo0HzjQdTPY15Nfcdw85y5YmtK/EMp2qcc1gOq8Yk4l
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="461695008"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="461695008"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 21:25:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="808847923"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="808847923"
Received: from mmtakalk-mobl.amr.corp.intel.com (HELO [192.168.1.200]) ([10.212.109.101])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 21:25:36 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v6 0/4] Add DAX ABI for memmap_on_memory
Date: Thu, 14 Dec 2023 22:25:25 -0700
Message-Id: <20231214-vv-dax_abi-v6-0-ad900d698438@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEXje2UC/3XMTWrDMBCG4asErasyM/qzs+o9SgmSLDWC1i52E
 AnBd+8k3ciGMqtv4HnvYklzSYs4Hu5iTrUsZRp52JeDiGc/fiZZBt6CgBQCGVmrHPz15EOR6Dx
 hH7UFZwWDnznlcn3G3j94n8tymebbs13x8f3LENg2U1GC1E6n0HWJAONbGS/p6zVO3+KRqfQ/J
 aZZ85FSdoBuT1VDETdUMfUx2xgxDKnPe6pbShuqmaIy6EyXIfa0p6alekMNU5VdALC9haBbuq7
 rL8jHlC+QAQAA
To: Dan Williams <dan.j.williams@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-cxl@vger.kernel.org, David Hildenbrand <david@redhat.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Huang Ying <ying.huang@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org, 
 Joao Martins <joao.m.martins@oracle.com>, Michal Hocko <mhocko@suse.com>, 
 Li Zhijian <lizhijian@fujitsu.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.13-dev-433a8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4201;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=gpIMG98kSfTR7IkA5YlRDrASpRxzVoLtmbllKBAG/Uo=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDKnVj72DBQy7+sMEDkbc+rzgzleWNY1mWxuk89a8jnoaV
 PSzoedXRykLgxgXg6yYIsvfPR8Zj8ltz+cJTHCEmcPKBDKEgYtTACZSwcXIcGXl8Xs8j+yjThxc
 Jbroe5bpd089t8czdrTOkznRxMi4Sonhv2sN97OFe/XlLrqbdk0091qxU+vMhicVbluO37/4K2u
 DKR8A
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF

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
Changes in v6:
- Use sysfs_emit() in memmap_on_memory_show() (Greg)
- Change the ABI documentation date for memmap_on_memory to January 2024
  as that's likely when the 6.8 merge window will fall (Greg)
- Fix dev->driver check (Ying)
- Link to v5: https://lore.kernel.org/r/20231214-vv-dax_abi-v5-0-3f7b006960b4@intel.com

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
 drivers/dax/bus.c                       | 179 +++++++++++++++++---------------
 mm/memory_hotplug.c                     |  17 ++-
 Documentation/ABI/testing/sysfs-bus-dax | 153 +++++++++++++++++++++++++++
 4 files changed, 260 insertions(+), 95 deletions(-)
---
base-commit: a6e0c2ca980d75d5ac6b2902c5c0028eaf094db3
change-id: 20231025-vv-dax_abi-17a219c46076

Best regards,
-- 
Vishal Verma <vishal.l.verma@intel.com>


