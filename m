Return-Path: <linux-kernel+bounces-88048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E3086DCB1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 941EF283A38
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB2569D12;
	Fri,  1 Mar 2024 08:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YPkDYd2X"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6498A69970
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 08:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709280467; cv=none; b=Lvj07yGuhg8WUu61ADuB2VbNIgCwBC0vZ5xapG8VwdJOGPuwbCDWhjrbxFqEt1MkEpTWqlInRkUdDlDDT9tynXUJn9aIA6QV2whwxDtC/jwExgUFGG1jwyqyj8pSiyTdTPosXJHGa/qHMbJealc4suZz6U5gUWHMqFdYmIbxB2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709280467; c=relaxed/simple;
	bh=vtBsxDUN0mZSlkutEWcnxc6lRCMfEsZZFVzveFyo3e0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NlAu0dIqUDNhay3wWY5BPHIloY/nSB1OkFASKa0oa47i1HZ86RtkA5iSeHN2YPx8vvv5oXYFh11XkKp85w1lS/MLhQEDJ9cmZWxhfL2aHneS8C+/LfGP1EF9dgj9Jjalug8JH3OZnntgpLqmPqLCOkGm4QpkQEJy9HViueb7YGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YPkDYd2X; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709280466; x=1740816466;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vtBsxDUN0mZSlkutEWcnxc6lRCMfEsZZFVzveFyo3e0=;
  b=YPkDYd2XgIlW4wzSomwfjhR3Sj2fSuV0ARCOCmQq4sk4DuWhfT9uZ/RE
   OwXw4CTQKKktycHystDryk9/GOlsKQK27o1shNgOZj153RnQkge8SR7Vp
   rdacUoiqzPDEt1qzEV34cZGUz5kFYgatmSkslQnzkXR9U+FLkhpyD/h1B
   bDc6AOhE/gjTDSO7opE5tbpvihAe6YNvbEw+RrR4lWMGdGNBgpW1UMQcw
   YlgTFWvhg2dMBHyconjhijWujYT9OvU1qJtPVPj0Mc7aD+9F7pdKFBQaP
   jHTnOotQBubLrftJKeuDDq935pqQwB1HbdC+70wDetVKwZW5vX8Ht0KSu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="15240393"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="15240393"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 00:07:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="8187457"
Received: from unknown (HELO ply01-vm-store.amr.corp.intel.com) ([10.238.153.201])
  by orviesa009.jf.intel.com with ESMTP; 01 Mar 2024 00:07:40 -0800
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: baolu.lu@linux.intel.com,
	bhelgaas@google.com,
	robin.murphy@arm.com,
	jgg@ziepe.ca
Cc: kevin.tian@intel.com,
	dwmw2@infradead.org,
	will@kernel.org,
	lukas@wunner.de,
	yi.l.liu@intel.com,
	dan.carpenter@linaro.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ethan Zhao <haifeng.zhao@linux.intel.com>
Subject: [PATCH v14 0/3] fix vt-d hard lockup when hotplug ATS capable device
Date: Fri,  1 Mar 2024 03:07:24 -0500
Message-Id: <20240301080727.3529832-1-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset is used to fix vt-d hard lockup reported when surprise
unplug ATS capable endpoint device connects to system via PCIe switch
as following topology.

     +-[0000:15]-+-00.0  Intel Corporation Ice Lake Memory Map/VT-d
     |           +-00.1  Intel Corporation Ice Lake Mesh 2 PCIe
     |           +-00.2  Intel Corporation Ice Lake RAS
     |           +-00.4  Intel Corporation Device 0b23
     |           \-01.0-[16-1b]----00.0-[17-1b]--+-00.0-[18]----00.0
                                           NVIDIA Corporation Device 2324
     |                                           +-01.0-[19]----00.0
                          Mellanox Technologies MT2910 Family [ConnectX-7]

User brought endpoint device 19:00.0's link down by flapping it's hotplug
capable slot 17:01.0 link control register, as sequence DLLSC response,
pciehp_ist() will unload device driver and power it off, durning device
driver is unloading an iommu device-TLB invalidation (Intel VT-d spec, or
'ATS Invalidation' in PCIe spec) request issued to that link down device,
thus a long time completion/timeout waiting in interrupt context causes
continuous hard lockup warnning and system hang.

Other detail, see every patch commit log.

patch [1&2] were tested by yehaorong@bytedance.com on stable v6.7-rc4.
patch [1-3] passed compiling on stable v6.8-rc4 (Baolu's rbtree branch).

This patch set is based on Baolu's device rbtree patchset
https://lore.kernel.org/lkml/20240221153437.GB13491@ziepe.ca/t/

change log:
v14: 
- made some adjustment to patch[3/3] per comment from Baolu, Dan, Bjorn.
- add fixes tag to patch[3/3] per Dan's sugguestion.
- add ack tag from Bjorn to patch[1/3]
- add review tag from Dan.
v13:
- rebased on Baolu's rbtree patchset.
- removed refactor patches [3/5][4/5] in v12.
- amend commit description of patch[3/3].
- https://lore.kernel.org/lkml/2d1788da-521c-4531-a159-81d2fb801d6c@
linux.intel.com/T/
v12:
- use base-commit tag to format patch.
- fix building issue on v6.8-rc2 repported by lkp@intel.com.
- https://lkml.org/lkml/2024/1/28/535
v11:
- update per latest comment and suggestion from Baolu and YiLiu.
- split refactoring patch into two patches, [3/5] for simplify parameters
  and [4/5] for pdev parameter passing.
- re-order patches.
- fold target device presence check into qi_check_fault().
- combine patch[2][5] in v10 into one patch[5].
- some commit description correctness.
- add fixes tag to patch[2/5].
- rebased on 6.8rc1
- https://lkml.org/lkml/2024/1/25/1314
v10:
- refactor qi_submit_sync() and its callers to get pci_dev instance, as
  Kevin pointed out add target_flush_dev to iommu is not right.
v9:
- unify all spelling of ATS Invalidation adhere to PCIe spec per Bjorn's
  suggestion.
v8:
- add a patch to break the loop for timeout device-TLB invalidation, as
  Bjorn said there is possibility device just no response but not gone.
v7:
- reorder patches and revise commit log per Bjorn's guide.
- other code and commit log revise per Lukas' suggestion.
- rebased to stable v6.7-rc6.
v6:
- add two patches to break out device-TLB invalidation if device is gone.
v5:
- add a patch try to fix the rare case (surprise remove a device in
  safe removal process). not work because surprise removal handling can't
  re-enter when another safe removal is in process.
v4:
- move the PCI device state checking after ATS per Baolu's suggestion.
v3:
- fix commit description typo.
v2:
- revise commit[1] description part according to Lukas' suggestion.
- revise commit[2] description to clarify the issue's impact.
v1:
- https://lore.kernel.org/lkml/20231213034637.2603013-1-haifeng.zhao@
linux.intel.com/T/


Thanks,
Ethan


Ethan Zhao (3):
  PCI: make pci_dev_is_disconnected() helper public for other drivers
  iommu/vt-d: don't issue ATS Invalidation request when device is
    disconnected
  iommu/vt-d: improve ITE fault handling if target device isn't present

 drivers/iommu/intel/dmar.c  | 22 ++++++++++++++++++++++
 drivers/iommu/intel/pasid.c |  3 +++
 drivers/pci/pci.h           |  5 -----
 include/linux/pci.h         |  5 +++++
 4 files changed, 30 insertions(+), 5 deletions(-)


base-commit: e60bf5aa1a74c0652cd12d0cdc02f5c2b5fe5c74
-- 
2.31.1


