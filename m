Return-Path: <linux-kernel+bounces-137301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9501789E064
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8488B2A3D6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EB413DDC2;
	Tue,  9 Apr 2024 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j3DE68XL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B9B13DB90
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679331; cv=none; b=u9jOv11k1YNSqJ/vnpqlHD9dy9xseMy1Pxm7kWYxzfVKQPChRA3xrgECH8eD5ApRPvG52WX4gdqU4j1zuQPJA40stn4PLvxQHWkkdpRTEwlm/zRdOeHg+utiDufUUfU1p9PFMNU1+4pCFWP/IJdNHNqOAkd0vcpioe3WYsrAweE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679331; c=relaxed/simple;
	bh=tquQcscQg2VUyGjSzRTkLvgJjpDLbwWYpnqfct1sEjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U9tfmBIFtQi3Le6sjptudoIUWWL+fnq6vMTzvl6GCxPjBR6E2fMHJCMYuRtY8GIn3khkYDz8sH50XymePBtYG7deu2RKikXYYH85NzsPO7TmxmvtrHpxN/zn0akxnWoOYcv31Md/kjojXoY+BzeOVXGawIh4mqbWnab0hvDvYZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j3DE68XL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712679329; x=1744215329;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tquQcscQg2VUyGjSzRTkLvgJjpDLbwWYpnqfct1sEjQ=;
  b=j3DE68XLyjxsDcwY/MLhJ/5DJNaQcRGvYzwwIOF67XU9Vwptd72YW63s
   n7z6djCgyvFWJL7U18CHTU6TviuIJrvi3rBUjD9W08xDYNFpc1rFLlsEM
   PGgVguDS6F5lEEiJdhH4sXEDuo1pbxI0NzsoVJkCdJbAdcHmxMDrHer73
   K/sCzvdziRVKzW9ozBiacsh+0ii5rqDXNBpuwl3wUJIAlp9rlK2K8iVSZ
   FJFcJa5qU9YzsuDLhXRpDTCOOWNBX00TmSlpwDm3keygld+S2eykGSa7d
   bBEOAn3DtvyyBnBdViq3j/BiTNUfcn347lauOB+s/nTbVr/bc4Am311wN
   g==;
X-CSE-ConnectionGUID: cbx0nYBCRkKtyiOxcFM9vA==
X-CSE-MsgGUID: W9YJdyhrQ4OVs3EE7Cqi5Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="33409815"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="33409815"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 09:15:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937093592"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="937093592"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2024 09:15:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 90A7B279; Tue,  9 Apr 2024 19:15:25 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v1 0/2] auxdisplay: charlcd: Add missing macro and forward declaration
Date: Tue,  9 Apr 2024 19:14:43 +0300
Message-ID: <20240409161523.935384-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing macro and forward declaration.

Andy Shevchenko (2):
  auxdisplay: charlcd: Add missing MODULE_DESCRIPTION()
  auxdisplay: charlcd: Provide a forward declaration

 drivers/auxdisplay/charlcd.c | 1 +
 drivers/auxdisplay/charlcd.h | 2 ++
 2 files changed, 3 insertions(+)

-- 
2.43.0.rc1.1.gbec44491f096


