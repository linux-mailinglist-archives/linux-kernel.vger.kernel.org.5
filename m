Return-Path: <linux-kernel+bounces-51648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA75848DE3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0BE1F22729
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C045121363;
	Sun,  4 Feb 2024 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OZaTUHxJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8402322085;
	Sun,  4 Feb 2024 13:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707051817; cv=none; b=WFF0y3Z7EmE27HReiniZvs47khh/tSJpKfYIJJ/6V8vTKKvR4yLAO7KFxg3aIde2WZoxRY5n8iTvkPWD6ae7af19gGs2U5wL1pqlb7vATmN8QSonx5XLXVjPyVasfJIf1nW+Ba33mU70TAoFUKQ31EI8OGo18K0lfzYdVI7hmDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707051817; c=relaxed/simple;
	bh=lo/lRKSchpFgmgBMpdWzE5wDAxMBkriW7GDjqrwUQBI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N9j8aY1NLk6Egyz3cvJi0T0M1kEx+K1k7N8VxMxGThwiqHQY9LeEwykx8M7cJK5lRHkPs65Syyt+EQW9I935TBpw+5htNPrBeqNtHUCi2+5tmisivMe2/0ZoZcWi4WJw/aC5rOZlsN7GZlK/eNgtJWC8z9JDJumOtODtnEr+nk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OZaTUHxJ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707051816; x=1738587816;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lo/lRKSchpFgmgBMpdWzE5wDAxMBkriW7GDjqrwUQBI=;
  b=OZaTUHxJL258+Xvq8aF/ynJzesLRQqqdThJyjEtgjaZ5iU3D82GOPPkv
   Sv7PlnZeL50wA3ovw9wElf5RaU2z3VcptSClBom26qhasv+ooODwlBnkO
   RR4ZMf9nA+Kd/22y7OZujXwBO8zYQ9fUed4Hv2tLAhUMIEbI1OvzI6Hd7
   fGGuL12zTEviWVPL1xvDUlbTVuL8p+c70wR/8+9l2U1LbS84CfSBFqt7D
   D6vdO4qbT3uJC9eY5y9a1XIXYyMkeEYozomi9Qu5Yva/WmQf+GIPKQKyu
   iZn3ndoo9QaT+mYRFPL7z/H7yMG5ZKNUzRP5dUHKRdn2mMKOI2c3haAyu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="4283230"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="4283230"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 05:03:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="37918235"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orviesa001.jf.intel.com with ESMTP; 04 Feb 2024 05:03:34 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	lars@metafoo.de,
	Basavaraj.Natikar@amd.com
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 0/4] Add support of color temperature and chromaticity
Date: Sun,  4 Feb 2024 05:03:28 -0800
Message-Id: <20240204130332.2635760-1-srinivas.pandruvada@linux.intel.com>
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

 drivers/iio/light/hid-sensor-als.c | 123 ++++++++++++++++++++++++-----
 include/linux/hid-sensor-ids.h     |   4 +
 2 files changed, 109 insertions(+), 18 deletions(-)

-- 
2.43.0


