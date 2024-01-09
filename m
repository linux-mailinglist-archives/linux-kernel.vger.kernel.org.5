Return-Path: <linux-kernel+bounces-21200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC14828BA6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DC1D1C24737
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A72D3BB38;
	Tue,  9 Jan 2024 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iEtVn1UX"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D467A3BB24;
	Tue,  9 Jan 2024 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704823219; x=1736359219;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e+lcf15WJHRqtnxBwNL/me25x8MLVT679d4nZrYyias=;
  b=iEtVn1UXDlBLdFxMdTRPlTD15gITOKEsFO5djW/Lpgeup+GPVwd0i2de
   DKsWBwn1O0JjZyic7xd5Ddrsm8wq3fIrfoiJccB7iHf8cw7soWvnr6JTz
   2ERvMg2lxvL6CliypoSONAKhNb2CfihAg5zBKfsXHj72AQ6rHM5uenHSc
   5dnGqj1/IoImr3ti8+9mqKDwRsF9cPQD2Py3Tezt0ofBlXv0LipYoXXny
   deSUwd+u/Lu99xrrr7AxICSWctyE3DRV9cqEGAfL5kkKFvxHou/S0opGe
   WTz1jOkJa9fNpntPCv8U3RLSdWgl9YfsOBymt+wDExUbcWP39YttxwbWC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="429458602"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="429458602"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 10:00:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="852269562"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="852269562"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jan 2024 10:00:17 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	lars@metafoo.de,
	Basavaraj.Natikar@amd.com
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 0/4] Add support of color temperature and chromaticity
Date: Tue,  9 Jan 2024 10:00:03 -0800
Message-Id: <20240109180007.3373784-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original series submitted to 6.7 (before revert) is modified to
solve regression issues on several platforms. There are two changes
introduced before adding support for new features to allow dynamic
addition of channels.

v3:
Addressed comments for v2, details in each patch.
v2:
New change to add channels dynamically
Modified color temperature and chromaticity to skip in case
of failures


Basavaraj Natikar (2):
  iio: hid-sensor-als: Add light color temperature support
  iio: hid-sensor-als: Add light chromaticity support

Srinivas Pandruvada (2):
  iio: hid-sensor-als: Assign channels dynamically
  iio: hid-sensor-als: Remove hardcoding of values for enums

 drivers/iio/light/hid-sensor-als.c | 130 ++++++++++++++++++++++++-----
 include/linux/hid-sensor-ids.h     |   4 +
 2 files changed, 115 insertions(+), 19 deletions(-)

-- 
2.43.0


