Return-Path: <linux-kernel+bounces-91056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FF387090B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603A428250F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED37961691;
	Mon,  4 Mar 2024 18:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S8axCc+3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC613CF40;
	Mon,  4 Mar 2024 18:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575516; cv=none; b=MnQzMPhfB5klulXq5aMy+4uE5euFSGgYV4ev732I1a70e1hJoeg1BHnG2LXO8SKqTN7XjqlfOJ88tT8PWAn9r9oj7SB2rSs+2cGaWXmOuEd8YOFRK6Akp6GQziRBX3PADYgFTCGsVWP9BuXkGH1EpPdbD+YbUHzR+NPnXx+cufA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575516; c=relaxed/simple;
	bh=+PqoMC6PQY8ox0RzrFV0Txo65ucWo6osZJCfNRoWvEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iLkyht/CnWK+Zpqg12zuJNGSTQyUY1AI6PozJGVTk8/NRahE45DSYUmgCP0+vR2X9uZHSz7qlVw+lYRFeWo+Ga9tAZqltZorh60EXm/B4NuEmJTKf1ghZ7UMshQPzcT81u76CY5sfIBnjCSP2qYqyJ+Qbx4HukNej8OesMmvyUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S8axCc+3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709575515; x=1741111515;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+PqoMC6PQY8ox0RzrFV0Txo65ucWo6osZJCfNRoWvEE=;
  b=S8axCc+34IXxoLzUPF0GpZQ2F28S+7PqQNReM8HbHVAB7QM8LkPYkwDc
   nJZUzUJhPwrdivhIjQ2PExwTAOTKhbK/bHJkesr96WYWLyExxHz6TvpRs
   eKoXU6R4xMa7Rnnw4sBM4YXNbeEmOzFnfnR6tvzLpCFmH8ZAX7ePt+Kf7
   X4eNmGEd/WXnSKM2GDegPFj+7ZsDN/PA/x5HPsIOr2FyXDrEAa288Mlti
   r1XfGCWY7CZcUMe8e1SVMcoQTR2mWrMLBEwl+KeSULIGZFGymr9sacR9t
   eUmnMZGYi94/ODw+YAK417KElZfH+0yA3PNoSeWl+UL/9AbBLdPEco7IC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="7855294"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="7855294"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 10:05:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="937040916"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="937040916"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 10:05:12 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6991715C; Mon,  4 Mar 2024 20:05:11 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] media: rc: gpio-ir-recv: Remove unused of_gpio.h
Date: Mon,  4 Mar 2024 20:05:10 +0200
Message-ID: <20240304180510.1201042-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_gpio.h is deprecated and subject to remove.
The driver doesn't use it, simply remove the unused header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/rc/gpio-ir-recv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/rc/gpio-ir-recv.c b/drivers/media/rc/gpio-ir-recv.c
index 41eeec648803..b29a1a9f381d 100644
--- a/drivers/media/rc/gpio-ir-recv.c
+++ b/drivers/media/rc/gpio-ir-recv.c
@@ -9,7 +9,6 @@
 #include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
-- 
2.43.0.rc1.1.gbec44491f096


