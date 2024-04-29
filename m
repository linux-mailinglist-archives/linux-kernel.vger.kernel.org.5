Return-Path: <linux-kernel+bounces-163148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B188B665D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1DA81F228F1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D3C199E9D;
	Mon, 29 Apr 2024 23:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IIsXhKOn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA56B190697;
	Mon, 29 Apr 2024 23:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714433712; cv=none; b=gma7uYg5aOrehLyrcC+7ywyVBVHAaKO30LUgX708kwBHtiAJPXlIMn3/0jYi98pL7ijp9q0xqA+MlF+4B1Sz2RsaTO/IU2rMEc85QSxdkLJJ2aKKJSeQQtgSdElr8+1IOn+rSYliR00sgWU+0aPUmHqcpkXM1rcugFhlxcBm6X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714433712; c=relaxed/simple;
	bh=09KM4l96TiB3LSdozRv/22chXIhMd0dxxprNLt4d82A=;
	h=From:To:Cc:Subject:Date:Message-Id; b=GBgdEBce5QfdRBW7EgodBcYD3jUgzKUt1mwj6ZaGEgQfXn3DbcJ4KV8sdrU1N67IcxmETzg073yWY61W22jefoB4KAB9KuELK+ftIOpDASd4Jqv9E/iJB1jzZbZXI8Kx+F68OQ6gBe/nXZrsAiFKw22nZo+rhLRnxLqJGIlPUOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IIsXhKOn; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714433710; x=1745969710;
  h=from:to:cc:subject:date:message-id;
  bh=09KM4l96TiB3LSdozRv/22chXIhMd0dxxprNLt4d82A=;
  b=IIsXhKOn7qltVz/BF6sjKQ68t4dVMiilDzMERSNMOQcngnSivcKzodJ3
   7tOMhtUrO6j9BFD+JCmugTfy80ybrCwx2AwJf0TsJLoKK5SJsgSu+3qIE
   tST1FWeodkmiRTpunB1jX0DuNFEZRVMolb2f1gTkwH1RB6jJyPmJG+SaO
   f2p5V7y+O9sR8ZLScC8njxmZOqM8mwyDHWDInoEgTr2g2UrDPQ2M4A/7Z
   cUrwt97ERKnWf/REJ2fs19CCjweRxxOl0D2qDJ1/I1lLnG+apP7eGFE8S
   M/yjCzQZyuUf2OIGmfdldFL6Op/AzpcUvsqhvixZNy6+sqCDQfzlSzHmO
   Q==;
X-CSE-ConnectionGUID: cOHRmrbXRVqQaci5PDEp2g==
X-CSE-MsgGUID: MbjWfSnkSWSi3r5R7wbBCA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10274507"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="10274507"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 16:35:09 -0700
X-CSE-ConnectionGUID: ex2prvGCRZKr/uUMSUQ56Q==
X-CSE-MsgGUID: GHPdIo1UQferdd5Y6b4Yeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="26200130"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa009.fm.intel.com with ESMTP; 29 Apr 2024 16:35:08 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <len.brown@intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: [PATCH 0/4] intel: thermal: hfi: Add debugfs files for tuning
Date: Mon, 29 Apr 2024 16:41:48 -0700
Message-Id: <20240429234152.16230-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi,

HFI uses thermal netlink to relay updated CPU capabilities to user space.
The delay between an HFI interrupt and its corresponding thermal netlink
event as well as the number of capabilities updated per event (its payload)
have been so far hard-coded in intel_hfi.c.

These hard-coded values may not suit all hardware configurations or
listeners. If the delay is too long, much of the information from
consecutive hardware updates will be lost. If the delay is too short,
listeners may be overwhelmed with notifications.

The payload size may cause unnecessary overhead if it is too small, as
single HFI update is broken up into several thermal netlink events.

Listeners are better placed to decide the value of these parameters. They
know how quickly they can act on notifications and know better how to
handle them.

Add a debugfs interface to let listeners experiment with and tune these
parameters.

These patches apply cleanly on top of the testing branch of Rafael's
linux-pm.

Thanks and BR,
Ricardo

Ricardo Neri (4):
  thermal: intel: hfi: Rename HFI_UPDATE_INTERVAL
  thermal: intel: hfi: Tune the HFI thermal netlink event delay via
    debugfs
  thermal: intel: hfi: Rename HFI_MAX_THERM_NOTIFY_COUNT
  thermal: intel: hfi: Tune the number of CPU capabilities per netlink
    event

 drivers/thermal/intel/intel_hfi.c | 117 +++++++++++++++++++++++++++---
 1 file changed, 108 insertions(+), 9 deletions(-)

-- 
2.34.1


