Return-Path: <linux-kernel+bounces-157551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2EA8B12CD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 241BEB28F1A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638791C6A4;
	Wed, 24 Apr 2024 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PfL5gwbR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AF81DA21;
	Wed, 24 Apr 2024 18:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713984290; cv=none; b=oF161vBppNRFysh0HwPmTFCrC0Xf3VRddjOZakaXmHujvOHqlaloMwqJoApzOcmAn9gL2vtFM/gtGQT64K8sWV21yEISRjtF7AUjmMNWAKr6oQriM8Ms4Fz5vDnKuvEG0in+OYXdGKA7dO5vgfaChpefcG8B+F8y7Jlia1+kQcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713984290; c=relaxed/simple;
	bh=8gIaXDNEUwMuLPcADBfY8qmuXHqxs1fdQRxqtQL+O0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BGtw4hcgi7JOGBMlTtjvbI3hQpsr4itxZiGD78DpIx0mDrAq9RjDDt/15pKNHt//iNRkJngpxkYJkpJKXhOfoiVZZ7JHlhHlXHA0Fvi95ka+7oo0uRa2TIjTU2dNvFPZGXpeoB5bmW6bizmhDEEfjqeoN0v6woIjEiG/1DwC+iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PfL5gwbR; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713984289; x=1745520289;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8gIaXDNEUwMuLPcADBfY8qmuXHqxs1fdQRxqtQL+O0M=;
  b=PfL5gwbRpk96X4AEstwoTTXWnZJmKombWZWPf3As99HVIStjpw23tgCg
   Pr8h/VI6oMjVigUFCjH5VzwxyvcCzPcSczYRIkgD7QHXioqoU0tbNUw/6
   eAJHDSUQdDLeSkdNRYE9spgCBj++VS8vcnoSs1VbNu1DB38phGO132FR0
   5E4hpjxfS2+zfCdjoQGRiDCeVRI4e8kRVpbEPEsWV1OuR8DA1CfiPZiX0
   8uACph7VSZaL5S9PSA5fL0bP/EIifMv8NwELviWWXES2la0/IwmzbYzhk
   ftJM5yLyM7HTREXf55lCdcuZx0RIRMnAwlAVm2OV+RVQvy4Sj79pxLKzl
   g==;
X-CSE-ConnectionGUID: 6lVlB1OfQUKuMCSD6maUvg==
X-CSE-MsgGUID: dqo8O3ZRQAWxmqREYsVIUw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9507785"
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="9507785"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:44:48 -0700
X-CSE-ConnectionGUID: LqwW6PaoTPSookDLHZVo0A==
X-CSE-MsgGUID: IgqSBZl9QByRq1tC0XUyMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="24810440"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 24 Apr 2024 11:44:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B8A1FA5; Wed, 24 Apr 2024 21:44:22 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kate Hsuan <hpa@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 0/2] media: atomisp: A couple of cleanups
Date: Wed, 24 Apr 2024 21:43:30 +0300
Message-ID: <20240424184421.1737776-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1/ Drop a lot of unused math related macros.
2/ Replace homegrown static_assert()

Andy Shevchenko (2):
  media: atomisp: Clean up unused macros from math_support.h
  media: atomisp: Replace COMPILATION_ERROR_IF() by static_assert()

 .../circbuf/interface/ia_css_circbuf_comm.h   |   6 +
 .../pci/camera/util/interface/ia_css_util.h   |  11 --
 .../media/atomisp/pci/camera/util/src/util.c  |  25 ++--
 .../pci/hive_isp_css_include/assert_support.h |  23 ----
 .../pci/hive_isp_css_include/math_support.h   | 110 +-----------------
 .../pci/hive_isp_css_include/type_support.h   |   5 +-
 drivers/staging/media/atomisp/pci/ia_css_3a.h |   5 +
 .../staging/media/atomisp/pci/ia_css_dvs.h    |   4 +
 .../media/atomisp/pci/ia_css_metadata.h       |   4 +
 .../staging/media/atomisp/pci/ia_css_types.h  |   2 +
 .../kernels/xnr/xnr_3.0/ia_css_xnr3.host.c    |   6 +-
 .../atomisp/pci/runtime/binary/src/binary.c   |   2 -
 .../spctrl/interface/ia_css_spctrl_comm.h     |   4 +
 drivers/staging/media/atomisp/pci/sh_css.c    |  38 ------
 .../staging/media/atomisp/pci/sh_css_frac.h   |   4 +-
 .../media/atomisp/pci/sh_css_internal.h       |  15 ++-
 16 files changed, 60 insertions(+), 204 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


