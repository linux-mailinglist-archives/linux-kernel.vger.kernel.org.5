Return-Path: <linux-kernel+bounces-59573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B4A84F929
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D40871F21BDE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BCE7C0AB;
	Fri,  9 Feb 2024 16:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NODS1jx9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8337BAFE
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707494623; cv=none; b=DU4tvJWFAMxAdfYcWR6XxHDuvxWqvejGbiHtyF0cQKhtvYaTy2A6xAkUQZsGRgo6X7VcM4cyl2HOuWHltK88FZ7FHqKQuH5Q3CEU1NxHriWxo1hMk7uTItDWjFkQHsex53vuIS8pn7KP8kZ3OdGINJaQ+X3WZDsHQiZLYTE0FIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707494623; c=relaxed/simple;
	bh=sxZgoQzRCkLciYTRnG7LsjTANpdXGKFB+KxqRFaktcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G33YGXyMIrwlgTMaw7pgwdpdC5M7eGuvQBZ4JVOua4fZsOph68I2vxSK9/aGrK4P1MSTf7zJij1wlAB5qMXjzYiJf1s8E2ujiZX5Jw74juV00NZPKO8PB2w440FJMNuK4UQ6H4NxnVO64dyBZr0XdJ52HNl+5Mgqvqp6ic0oi9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NODS1jx9; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707494622; x=1739030622;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sxZgoQzRCkLciYTRnG7LsjTANpdXGKFB+KxqRFaktcc=;
  b=NODS1jx9Uj9O1x5ivQrwpOQK+ofU43D16rs/VjS4AGjq3UI5Q1meymEQ
   X4+jXms72yGfot/hwlafDEyzDsUuKtBBhoZPdyvlZTOq3jpOPtmWcuiiG
   AmNtCr66Aur+aQoHgxjIcvtEWagM24tVLcqG5u1w5Cz6wWgNmoqKbsJ3A
   Br23qNdWCKjMmAq+WeawgWSM0iIwqDhG0GqKKZY4WH1TuoVEVTq+pexNF
   rR54cmqyYfaTOuur/WdKL5RWxp9SdsCe0lNKvWsjWugZq05HSpFAY+gZ0
   OPwTKEX9xOPiJL0t6ijDM8kA1T03ZWH3XRcusAZCnW9bfJ+Gxp/2wztA0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="4432019"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="4432019"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 08:03:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="934459658"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="934459658"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Feb 2024 08:03:37 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 80496159; Fri,  9 Feb 2024 18:03:36 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Subject: [PATCH v1 0/2] phy: ti: tusb1210: a couple of cleanups
Date: Fri,  9 Feb 2024 18:02:13 +0200
Message-ID: <20240209160334.2304230-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of ad-hoc cleanups. Nothing special. Has been tested on
Intel Merrifield platform (with DWC3 using this PHY).

Andy Shevchenko (2):
  phy: ti: tusb1210: Use temporary variable for struct device
  phy: ti: tusb1210: Define device IDs

 drivers/phy/ti/phy-tusb1210.c | 57 ++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 27 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


