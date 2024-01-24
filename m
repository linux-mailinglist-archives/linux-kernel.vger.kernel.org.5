Return-Path: <linux-kernel+bounces-37624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2C383B2C6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C231C23012
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6EA133430;
	Wed, 24 Jan 2024 20:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KQz7OhdZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5A8132C17;
	Wed, 24 Jan 2024 20:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706126665; cv=none; b=N95ZQ/pBC2vRLQJvqkRNxnc2kghkA4lTyO1RnfmSH8peUhXgGGm2NDCvylNUJXgLEK8bopYn15S8RhWj6u8RwXRjcmp4XQRmK2FMmiUbVx/0Ocfse1qMHKlVqAOT3EZPmwv9HG3e2Ps6l28JTzan7L+UFfDO5PPKcSmpEgqYfSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706126665; c=relaxed/simple;
	bh=KBoevL7pFQqn9JaE6qf9oRs9atS556fSspZ1qrOgK+8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ikCYFZzBwYrIU/6Glfd2BeL+zo0cnA9Os08JeBu37exs31RCG9tQmmFFYHeYztslED9VSMH8vk1VrJ8AsuaDNkha7NcpGZBTEMfFwnw2e4+mmab9iFioqcphIq1ofGeGr+2Mxa7KKenE0db6qha0iwsQT54TMXt5MY8IBlh2O/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KQz7OhdZ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706126662; x=1737662662;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=KBoevL7pFQqn9JaE6qf9oRs9atS556fSspZ1qrOgK+8=;
  b=KQz7OhdZBAy0CgUjMIZr91FaphHIqTp/K9u0pGamz36K8Es3fMWCSbiT
   +qNAuqPsSTcdCVlcqxcwmYhp9VP2QsAMVxckydwLYEwDWzIzGWM0TFZK8
   4fntpjOO6kC28/NrNOFCH8qA+kNgda4fzeD9+76vas5b5uULz0OhuTGmB
   5BVpCjeMJHlooCsVoHUCLcQNGXeE/RWCTXUD2EijZO1MjEocudn8XQ/uI
   /F9bKEC/pussrUc8SAF0rEZzYgvR6Bs4eLqXOy3956jXWcM277MhzW43F
   jnVHeEn9nHQ9xuouVP4HOvvV3+6TU/ZJlX6kcpdG4KZUJvEsg7eXgsRW8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1836084"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1836084"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 12:04:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1117735099"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1117735099"
Received: from vverma7-mobl3.amr.corp.intel.com (HELO [10.0.0.223]) ([10.251.14.61])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 12:04:19 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v7 0/5] Add DAX ABI for memmap_on_memory
Date: Wed, 24 Jan 2024 12:03:45 -0800
Message-Id: <20240124-vv-dax_abi-v7-0-20d16cb8d23d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACJtsWUC/3XPzUrEMBSG4VsZsjZyzsm/K+9DRPLrBLSVdggjQ
 +/ddNy0hSGrL/C8JDc256nmmb2cbmzKrc51HPowTycWz374zLymvhkBCQRSvDWe/PXDh8rReEI
 XpQajWQc/Uy71eo+9vfd9rvNlnH7v7Ybr7X+GQG8zDTlwaWQO1mYCjK91uOSv5zh+szXT6DGlT
 ovsh4TQCeyRig1F3FHRqY9Fx4ghZVeOVG4p7ajsFIVCo2yB6OhI1ZbKHVWdimICgHYagjxS/Zj
 q9cHJASTtrBS7vy7L8gcFHVbTywEAAA==
To: Dan Williams <dan.j.williams@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-cxl@vger.kernel.org, David Hildenbrand <david@redhat.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Huang Ying <ying.huang@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
 Michal Hocko <mhocko@suse.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=4046;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=KBoevL7pFQqn9JaE6qf9oRs9atS556fSspZ1qrOgK+8=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDKkbc21ebFWes/V/Bl/qjS/z3yko7fbKuMXazp1muWJR4
 nHPSc84O0pZGMS4GGTFFFn+7vnIeExuez5PYIIjzBxWJpAhDFycAjARYW6G/0Xhkqwzgj1FclT0
 j+Zvm/lhm1VFx6YJHl7P65eypS+X1GP4Z7s1USX54Ppf7juasqw/M1+RieQ4v5Oj3JrvzJutKb8
 nMwIA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF

This series adds sysfs ABI to control memmap_on_memory behavior for DAX
devices.

Patch 1 replaces incorrect device_lock() usage with a local rwsem - this
was identified during review.

Patch 2 is also a preparatory patch that replaces sprintf() for sysfs
operations with sysfs_emit()

Patch 3 adds the missing documentation for the sysfs ABI for DAX regions
and Dax devices.

Patch 4 exports mhp_supports_memmap_on_memory().

Patch 5 adds the new ABI for toggling memmap_on_memory semantics for dax
devices.

---
Changes in v7:
- Rebase to v6.8-rc1
- Remove an unnecessary 'size' variable. (Matthew)
- Replace device lock (ab)use in dax/bus.c with local rwsems (Greg)
- Replace sprintf() usage with sysfs_emit() (Greg)
- Link to v6: https://lore.kernel.org/r/20231214-vv-dax_abi-v6-0-ad900d698438@intel.com

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
Cc: Matthew Wilcox <willy@infradead.org>
Cc: <linux-mm@kvack.org>
To: Dan Williams <dan.j.williams@intel.com>
To: Vishal Verma <vishal.l.verma@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
To: Oscar Salvador <osalvador@suse.de>

---
Vishal Verma (5):
      dax/bus.c: replace driver-core lock usage by a local rwsem
      dax/bus.c: replace several sprintf() with sysfs_emit()
      Documentatiion/ABI: Add ABI documentation for sys-bus-dax
      mm/memory_hotplug: export mhp_supports_memmap_on_memory()
      dax: add a sysfs knob to control memmap_on_memory behavior

 include/linux/memory_hotplug.h          |   6 +
 drivers/dax/bus.c                       | 295 +++++++++++++++++++++++---------
 mm/memory_hotplug.c                     |  17 +-
 Documentation/ABI/testing/sysfs-bus-dax | 153 +++++++++++++++++
 4 files changed, 381 insertions(+), 90 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20231025-vv-dax_abi-17a219c46076

Best regards,
-- 
Vishal Verma <vishal.l.verma@intel.com>


