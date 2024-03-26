Return-Path: <linux-kernel+bounces-118600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7531688BD21
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31BAB2E4AB2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213F153809;
	Tue, 26 Mar 2024 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jsYHJa9H"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8203F9ED;
	Tue, 26 Mar 2024 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443691; cv=none; b=oyk0GsorJ6nIEmp7aLZuxlsr9E30BqTSvgICSNrKZBQpfriYMq4SkhvpJ+lVuLsxgivDazL7PnAyBX/biwvSnbM9ZdeyyEGH/gMfl5LlvnjlPwuFg+HCo2KZzJW7peLpvAjY4XDAliAVEdgyAbkE/ScSRTRA09f+h5cu5+4zyhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443691; c=relaxed/simple;
	bh=aeAlxxiSWXGtTBb2CCLfneJVNFMz2/J2DPOEfqvuvXg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PtPCBkYG6JK2Qj0Vls1pz9ida+ssmggW9AIf645SCksr1nAS/o3p1sK1Hd2/dVvJNx+ooHT69qlld1nkInii5sywhQHtRSg+CkXThnNyP2C4xH13Jhe8F4wVbwCugT652+Kl6zrYx8wrJF2aE5zsCz7dz8OfwRooON1uD7zfML0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jsYHJa9H; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711443689; x=1742979689;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aeAlxxiSWXGtTBb2CCLfneJVNFMz2/J2DPOEfqvuvXg=;
  b=jsYHJa9Hp8gkMJKeERUwIfy/oW8nurTGydG6xtIRz2W9lnSn1jlxJqIe
   DH3X0oetkKFB5x/n0GkSgSwwPAeZfzn5Y22UrD5DMk3Yzwcx8OXPF5ccj
   n/0aU2BBY9CXjR+chyjHCU5Tw0iJTR2IuJKe2xHlIbK83mCiBRlgEBExg
   UP8Qb69IPJa3dWkTxMZgXXvK031LlDPmW92KY5xceRWj4VPE0jYBxijC/
   G7nfv+HQhstVj7MBv+5CJ9ONeuiK9Y7oow9g+QTcia54g4s9T1v5PqNEo
   YujF8EmEAkkDI2o34l80U3pHEe7kl7cVEVXoPCAQ4gXB59qpT7T2cRK+1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6343342"
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="6343342"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:01:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="20614502"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:01:28 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 0/7] soundwire: add BTP/BRA prerequisites
Date: Tue, 26 Mar 2024 09:01:15 +0000
Message-Id: <20240326090122.1051806-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some prerequisites for BTP/BRA.

Pierre-Louis Bossart (7):
  soundwire: cadence: fix invalid PDI offset
  soundwire: cadence: remove PDI offset completely
  soundwire: remove unused sdw_bus_conf structure
  soundwire: reconcile dp0_prop and dpn_prop
  soundwire: clarify maximum allowed address
  soundwire: debugfs: add interface to read/write commands
  soundwire: bus: add stream refcount

 drivers/soundwire/cadence_master.c      |  30 ++---
 drivers/soundwire/debugfs.c             | 150 ++++++++++++++++++++++++
 drivers/soundwire/stream.c              |   5 +
 include/linux/soundwire/sdw.h           |  21 +---
 include/linux/soundwire/sdw_registers.h |   2 +-
 5 files changed, 170 insertions(+), 38 deletions(-)

-- 
2.34.1


