Return-Path: <linux-kernel+bounces-88875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A306086E7D9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36C81C22BAD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B39225D0;
	Fri,  1 Mar 2024 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LnnkGwPL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71113134CB
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709315808; cv=none; b=p5H5nZ8E/uMi5iLq/ApiJS8fVF63oOsgV5jZqMf6M+9dkP6/eKUSNTOnVvtwCICzHkLB++JJQNB6I+/kp+jK1imhoa2Yml1s5Vw8vgWYlQT24eWHUl0Rkv2JlJWw4JRCfFmuObjcRcwT6Wa76ySn92vrDV1B+VRyicZ4m3rEYBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709315808; c=relaxed/simple;
	bh=kMz954nBvgW2o4FoUK1az2mgv1DJs80476p6evrV/nM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lUch/hIvC5g5X8/wFJd6G9aKc9Z3xtmiGfIUC1WQiI31wNnKcm7VDzo60sEyzgkFp03Dvho82K/EEMy06Jkk/gtPwnKsqA5cds0CXB6h1Lv11EWnQqcklXSSgtOC3vrOU/bZ12h61x9qMQ59l3WL3A4aKdL+L1ahO2biwA/lIAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LnnkGwPL; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709315807; x=1740851807;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kMz954nBvgW2o4FoUK1az2mgv1DJs80476p6evrV/nM=;
  b=LnnkGwPLttUZ8uovJlJ3SxsgTlS+7wmTw3Ep3D7dKPS1+PlpLF7esLwB
   2lsat51HjQ2ccWSQxbgQTZ/dWZM0mI/Lk33ZMZ5a6R2Bi3c8/4ZApXwMh
   e5cxNA4n2IHLeH+NpVFbGgyMUqLgoboTfbWjC/fABdgjhFD3i47/P4WXP
   PFv3VHQigSiBCBKZAAKMtqtUPy0w7EyExgjzX0q+69Qxwc3YN7YJFamTG
   wKkKmwU1RXzt9IZmmXMCLdABsb0pOjuTx0yl0mAUrPVJ6bH9HVjwAASgm
   70fJkhrQobj3owP0At4XXNIEVHVgl1YkDsLx+RwtdpOlKV5fGPYHD+jIH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="7684220"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="7684220"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 09:56:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="937037841"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="937037841"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 01 Mar 2024 09:56:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C7DC528A; Fri,  1 Mar 2024 19:56:42 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 0/2] devres: A couple of cleanups
Date: Fri,  1 Mar 2024 19:55:35 +0200
Message-ID: <20240301175641.270020-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of ad-hoc cleanups. No functional changes intended.

v3:
- rebased on top of driver-core-testing (Philipp)
- added tags (Philipp)

v2:
- fixed plural vs. singular "to have" (Philipp)

Andy Shevchenko (2):
  devres: Switch to use dev_err_probe() for unification
  devres: Don't use "proxy" headers

 lib/devres.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


