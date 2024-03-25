Return-Path: <linux-kernel+bounces-116977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A4888A6F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 552A3CC13A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0BB17F211;
	Mon, 25 Mar 2024 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBiJJ9ZB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1C0CA6B;
	Mon, 25 Mar 2024 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711368600; cv=none; b=RbICcXQcqFLeV0+q1193c0of6A8+XYkpc3Bd3fHOFncLH8nPSxJVro+fzwGOU8BoC2OjgTNo5+chgshI9htEcGKy8F09BkUCfAKzJqfWU0MIo+CBwmTejPjAbIzIv57wYMVe/ovAwWhgcT4GOpRG5ksYZ8BdSicLbmn0AyxtD6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711368600; c=relaxed/simple;
	bh=0NKiHG7ZlFjs7TiosmHvTOqi/ShFoTyI/Q4Yj+MHyWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXBbV5dQSD+aFZeWXULUOlvDu7fjjegFobGLsQs1Ihue3a5O3Jr85+vTYYhpaK/AfxR239Yck1CYTueqfJJW5r6S8uto+B0D6HNAk+zy6ffuEh54wwW0hoLY6T82IoVQtkUb0pwW6MQtyC88yisOp72MJOhpTtQ2oJq8wzpwgx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBiJJ9ZB; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711368599; x=1742904599;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0NKiHG7ZlFjs7TiosmHvTOqi/ShFoTyI/Q4Yj+MHyWo=;
  b=HBiJJ9ZBTEspO2TqR1h168O6pncSI57B6deJW7eI1ArDGifAE67itkSC
   Qgt9ThiLLpuAT52KP0E+ObZ9sYkIRhw7780XctUCrDIBnG7J0rlo/oPQw
   gmxHgFu76m/zB2xxhaZLXRLylBizMwLhaHy8SKURdJaZv82EsyaCXR5bl
   CSt/gs9QqFdX6yeVKifah3E0NI7zvLXi+sxhj9bFYbYxFQVLSunRlC9QU
   rVfRjnkEncxNhFXNUKG7E75Lzahs5K/8RiaSouxP7kTpVA7qBuxwCPVX4
   LtMPwrfEl2JP/8C4DJ6EWUKX3jf884SUFde4LxzThHoIdE6o4JNjsofzO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="17757431"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="17757431"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 05:09:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070313"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="937070313"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 05:09:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0F97B2CA; Mon, 25 Mar 2024 14:09:53 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/3] hwmon: (pmbus/mp2975) Constify local pointers to pmbus_driver_info
Date: Mon, 25 Mar 2024 14:07:43 +0200
Message-ID: <20240325120952.3019767-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240325120952.3019767-1-andriy.shevchenko@linux.intel.com>
References: <20240325120952.3019767-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Constify the local variables pointing to "struct pmbus_driver_info" and
other encoding params to annotate the function is not modifying pointed
data.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwmon/pmbus/mp2975.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
index af118087c4ee..bc7558dc87ee 100644
--- a/drivers/hwmon/pmbus/mp2975.c
+++ b/drivers/hwmon/pmbus/mp2975.c
@@ -942,7 +942,7 @@ mp2975_vout_per_rail_config_get(struct i2c_client *client,
 	return 0;
 }
 
-static struct pmbus_driver_info mp2975_info = {
+static const struct pmbus_driver_info mp2975_info = {
 	.pages = 1,
 	.format[PSC_VOLTAGE_IN] = linear,
 	.format[PSC_VOLTAGE_OUT] = direct,
@@ -967,7 +967,7 @@ static struct pmbus_driver_info mp2975_info = {
 #endif
 };
 
-static struct pmbus_driver_info mp2973_info = {
+static const struct pmbus_driver_info mp2973_info = {
 	.pages = 1,
 	.format[PSC_VOLTAGE_IN] = linear,
 	.format[PSC_VOLTAGE_OUT] = direct,
-- 
2.43.0.rc1.1.gbec44491f096


