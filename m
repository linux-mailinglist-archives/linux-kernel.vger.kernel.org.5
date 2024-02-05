Return-Path: <linux-kernel+bounces-53265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A563B84A2DE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75C01C235F2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A27481D3;
	Mon,  5 Feb 2024 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UR9hjqYD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190F247F76;
	Mon,  5 Feb 2024 18:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159571; cv=none; b=cxXRq4aHEb9tlLSdvvRfsECg4U/wgw245fgIhZrYHLJs0CLVES6cFius10RwjU9M4c5L4gdlbEIuOsa3o/IsFX6dT1StCNEhi0FNmBxlt7ESCAiDPT1/oQUuWexAZVXF6L6Hc6uL4x8f/rNS/M3Im633svhJUYMDKwU3vCGTrhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159571; c=relaxed/simple;
	bh=I6XU5XsYRE2NHAAxGmZrdatZKdxaAuExtRZOBdx8Z+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jEU0UBn88KsTebyfQORf2K8eISTihOf3UHG0hadZyYiCQSAoosUfov1HHKFYvNzC+dJw9kNu01H/tFr8F6sKsNR1Cx2sXGXU0HgdzRa+qSfUkKprB95ybfzNo4c7d0wtfD7hpcyugoIkX/Wi5zH95GQ2pln1LRpNfpXm91zT7VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UR9hjqYD; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707159569; x=1738695569;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I6XU5XsYRE2NHAAxGmZrdatZKdxaAuExtRZOBdx8Z+o=;
  b=UR9hjqYDCoC3W/c4rb1jvkyghPhisE8toVdPkc8fZSjObfXY7aixIsXu
   BS/QnA/7fzFk7bakKC48oPn5orHfAiyVNs8efYT3niB397FkftYQbHG4z
   skt/E4PN9EyZ4Xq8RkXjaH2ypD9Gpa1yqxYt/VDOEOUfR3zq0cP2GJcVL
   cUpSUdyOBE5/xMBij87EPUB+Y5GWqejcNgZUMD/kip3omEx2zEScfkeuE
   k3ghB/veULsmPgPeaT15SBzjN+O6OGBNmVDYC5Pslt9m0MT2rRcSpe1a3
   Doj3GE9c+JQxjzBRmAdAfd2zjzoa/6evWbh6UtCxXqX4RV9p2elkMKKHw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11320378"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11320378"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 10:59:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="31879441"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmviesa001.fm.intel.com with ESMTP; 05 Feb 2024 10:59:27 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	lars@metafoo.de,
	Basavaraj.Natikar@amd.com
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v5 0/4] Add support of color temperature and chromaticity
Date: Mon,  5 Feb 2024 10:59:22 -0800
Message-Id: <20240205185926.3030521-1-srinivas.pandruvada@linux.intel.com>
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

v5:
Change als_scan_mask to per state instead of global
v4:
Addressed comments from Jonathan and Basavaraj
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

 drivers/iio/light/hid-sensor-als.c | 122 ++++++++++++++++++++++++-----
 include/linux/hid-sensor-ids.h     |   4 +
 2 files changed, 108 insertions(+), 18 deletions(-)

-- 
2.43.0


