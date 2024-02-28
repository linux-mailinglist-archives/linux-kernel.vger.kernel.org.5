Return-Path: <linux-kernel+bounces-85315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED9B86B419
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD371C22F14
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DE615D5D5;
	Wed, 28 Feb 2024 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aMiwYxcu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0509E1487DC;
	Wed, 28 Feb 2024 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136253; cv=none; b=bVohblCorm+qbD/ZEptBLRnw1TIefYHXa/LQ74GqGLSmyWSYJgcqEjWG/ccOfzsWmqr2jj+CRJo9SgdkCM+Kmloe60TPaPWBzt4P+xE5c1BxY2/AQolvrPf2NrZU6SKR89WmHardN29BszOS8kst3QHCZwYXVUqVNF7OCN2pFyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136253; c=relaxed/simple;
	bh=HmhSwJzywo2VHhaxf4zsr70ZyAx8N40+pr9JK+rKZj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cxLSibARAwx7myUHZcSMuK/zXthJT2We6QEVhYu3Yf4qyHwpNGXVraQalgiCD4FSp+ARr2vTsAWfY/NsAjA5NMbMBSIgPIsPN4w6HKktJasZ4MvVjF/uUfDjOJD+gZ6V4A3FbHR9JsjpXRHiNjFO4vze9w8CFsd1KO2xwu0Q6qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aMiwYxcu; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709136251; x=1740672251;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HmhSwJzywo2VHhaxf4zsr70ZyAx8N40+pr9JK+rKZj4=;
  b=aMiwYxcu+xQE8H4QLP+fBfqD/4IbwIJy/EOw1vVh1LXj41vi5g/KbpsF
   gNNNOz/tpmkCjNwtOpznghfpST+GCiKbSqWeb0974+Nbeyn9VpKXOL/xd
   WtiQNrH4io04856fbmp8GdotOXmHteglB9b1RibLy59iBuBnut4Cx5t+n
   CKequBHc0DViJEtICgkC/1i8g0PKJi5NukDGgMvETDvwo1R9DbWPQHrcK
   zBIlqEeRn5efAegeVkhF6viI7wuznzWeL7jI4LaU+Kxu+I/fxEOiicWrN
   fNaNWq8e/ZJpK62P2JKupJ4JzOjWR03zBfjif1xyVSeR44QSXO5MSbCuf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3706562"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="3706562"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 08:04:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7527674"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa009.jf.intel.com with ESMTP; 28 Feb 2024 08:04:07 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id A506936820;
	Wed, 28 Feb 2024 16:04:00 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mateusz Pacuszka <mateuszx.pacuszka@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Lukasz Plachno <lukasz.plachno@intel.com>,
	Jakub Buchocki <jakubx.buchocki@intel.com>,
	Pawel Kaminski <pawel.kaminski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH iwl-net 0/5] ice: LLDP support for VFs
Date: Wed, 28 Feb 2024 16:59:44 +0100
Message-ID: <20240228155957.408036-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow to:
* receive LLDP packets on a VF
* transmit LLDP from a VF

Only a single VF per port can transmit LLDP packets,
all trusted VFs can transmit LLDP packets.

For both functionalities to work, private flag
fw-lldp-agent must be off.

I am aware that implemented way of configuration (through sysfs) can be
potentially controversial and would like some feedback from outside.

Larysa Zaremba (1):
  ice: Do not add LLDP-specific filter

Mateusz Pacuszka (3):
  ice: Fix check for existing switch rule
  ice: Implement VF LLDP RX support on VF
  ice: Implement VF LLDP TX support for VF

Mateusz Polchlopek (1):
  ice: Add function to get VF from device struct

 drivers/net/ethernet/intel/ice/ice.h          |   2 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   1 -
 drivers/net/ethernet/intel/ice/ice_common.c   |  26 --
 drivers/net/ethernet/intel/ice/ice_common.h   |   2 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   6 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  83 +++++-
 drivers/net/ethernet/intel/ice/ice_lib.h      |   4 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  58 ++++
 drivers/net/ethernet/intel/ice/ice_sriov.c    |   4 +
 drivers/net/ethernet/intel/ice/ice_switch.c   |   4 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 252 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  26 ++
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  11 +
 13 files changed, 439 insertions(+), 40 deletions(-)

-- 
2.43.0


