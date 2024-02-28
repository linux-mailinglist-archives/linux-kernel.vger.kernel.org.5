Return-Path: <linux-kernel+bounces-84243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA3D86A422
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1F69B28372
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFF51852;
	Wed, 28 Feb 2024 00:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VpmFLmrR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E818383AC;
	Wed, 28 Feb 2024 00:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078419; cv=none; b=QvEGM5SnNWsG1RddYaRRapJEjGbSZF02ixvpeqzbOM+RvdrlcoUeVa+wa+UK6pw39eS1/+Qu4xi/Bgp4tmRjupH5fR4M5O5XV622narWyunaDbEJSdHRjz8M7R467XA7j/cREJ9f0TCHWa+NBw7fSoijQFeNOogNEZSkf81YShw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078419; c=relaxed/simple;
	bh=GXtl60Mymou2ZsPjCKtOv1efRkD66Z31CIFOkvncFhg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=sko4OLwmf8isSCe2ecJPsapLrK9u6FnaFd9OXD8OrbmQ9wslz2v5aK1qhsgH646Zc9uJpBQwsEfa2b3M8ubDVVuiwIkHdMuBVMPuI2hJprVurZbrFOArLpxsQiwWF3eujkhkLk1G+qzOk0EhvabOQNrLjoBRrA3Q8VsKfET2ZeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VpmFLmrR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709078418; x=1740614418;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GXtl60Mymou2ZsPjCKtOv1efRkD66Z31CIFOkvncFhg=;
  b=VpmFLmrRm8uAJSt6D7KeLzL5+m+KmjlPhtiuWrhL1ZXBZvD48Awha3xJ
   fW/RerVkABz6GFtmz4JwNpqhi7NJUZSmCxrm7P6KNGPlrzBNwlRJV8bD4
   F2jSiJyyDtDWrZopIdzUmLajjjBp9hlf0I78K4pAJHudP7fLDdO1ILCqr
   G8WmGTIUBwSIPmQ8tKL7XuMYKfcwScaoshk3xosHC6KNWAkOk1RFLOM8m
   wMVd84zlyUqIjaPpeDXV4FmToi0UI7IMxSTtuisskTgMUgdlNofsbiWg6
   imEX+sjeatLouGGApCR64yrautLLd+4v3/G2UZfECPfyDfAA8G8Mu48FS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14604933"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="14604933"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 16:00:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="7176938"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 16:00:17 -0800
Received: from debox1-desk4.lan (unknown [10.251.6.149])
	by linux.intel.com (Postfix) with ESMTP id 39CD8580B9A;
	Tue, 27 Feb 2024 16:00:16 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	rajvi.jingar@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH V2 0/9] Intel On Demand changes
Date: Tue, 27 Feb 2024 16:00:07 -0800
Message-Id: <20240228000016.1685518-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

V2 removes the Attestation support while is it reworked into a separate
series. This series now focuses on smaller changes that address firmware
changes and makes fixes in the tool.

David E. Box (8):
  platform/x86/intel/sdsi: Set message size during writes
  platform/x86/intel/sdsi: Combine read and write mailbox flows
  platform/x86/intel/sdsi: Add attribute to read the current meter state
  tools/arch/x86/intel_sdsi: Fix maximum meter bundle length
  tools/arch/x86/intel_sdsi: Add missing version field
  tools/arch/x86/intel_sdsi: Fix meter_certificate decoding
  platform/x86/intel/sdsi: Simplify ascii printing
  tools: intel_sdsi: Add current meter support

Kuppuswamy Sathyanarayanan (1):
  platform/x86/intel/sdsi: Add in-band BIOS lock support

 drivers/platform/x86/intel/sdsi.c      | 118 ++++++++++++++++---------
 tools/arch/x86/intel_sdsi/intel_sdsi.c | 100 ++++++++++++---------
 2 files changed, 138 insertions(+), 80 deletions(-)


base-commit: d206a76d7d2726f3b096037f2079ce0bd3ba329b
-- 
2.34.1


