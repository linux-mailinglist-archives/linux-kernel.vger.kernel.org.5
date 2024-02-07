Return-Path: <linux-kernel+bounces-55767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB26E84C177
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907081F254C0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5525256;
	Wed,  7 Feb 2024 00:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cd83sOQM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669D67F9
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 00:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707266671; cv=none; b=CkhcuC8GS5pbcj6sMAdQiP+yzGwwFutuI6YqWm9ZYeFXINFB6VYMB1NflzcjS6mXAd/lzH0OlGzjcyQwrLObqcGsTw8UWOhZy1i5xiOZW5EIdAer6STe9898SS2S3whPbfo6WjjHRdhU8Ig6+WjZ8mOEWvmTexLZJ2YPl76vi8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707266671; c=relaxed/simple;
	bh=fMuKPsYwnODDC0nihnCn4FKR6XEa+Tak5zZxm94aJ8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GWGOw0tgksZx79/CZxf6HQ8X8iHThGfWMGSn8vaq5urlbTVBTTzPf767a/ZduYerWyMXykNYBtBLSbRUqBvY4nKexTCCXnTmGF9TTousFXBGYqx4OZqNqVsmd68aN8X0wNvu+1c+6t3moj5Ys06jjfRuu1hLlnAARQVQAQJc9nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cd83sOQM; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707266669; x=1738802669;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fMuKPsYwnODDC0nihnCn4FKR6XEa+Tak5zZxm94aJ8k=;
  b=cd83sOQM9Gx8yyQjtHNRtzeivBvfpyU3PZzzd/C5eSLCRCVR2mbywiMi
   MySrFAFAJWu99MYDmq7zbCFYug8pYUC/ja+pXMKnCaqtfNmQErr1qtRKl
   1aS3ZTgbn7nL1tkxLNCtpEi3dpUs5+YHHKXXMw45GZhtzI/zfHceJHnVk
   CXgAas8Qbzs1b82BFYRXXk+FHm8A7wq745Nm2woQKNJZgcN1v3WHQxOnW
   bHsP/gCxuJwGt+O4eclJwOOesFcgFFBH4UeONdfXeVinwRfvUgSgQWg8U
   1SK04DSfjpdTJDCvFVLbPDl7rU4Ug06FG4aYO3dGxJEbyl8eMS705a3B+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="11525833"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="11525833"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 16:44:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="824345146"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="824345146"
Received: from shsensorbuild2.sh.intel.com ([10.239.134.197])
  by orsmga001.jf.intel.com with ESMTP; 06 Feb 2024 16:44:26 -0800
From: Wentong Wu <wentong.wu@intel.com>
To: gregkh@linuxfoundation.org,
	tomas.winkler@intel.com
Cc: sakari.ailus@linux.intel.com,
	linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>
Subject: [PATCH] mei: Add Meteor Lake support for IVSC device
Date: Wed,  7 Feb 2024 08:43:04 +0800
Message-ID: <20240207004304.31862-1-wentong.wu@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add IVSC device support on Meteor Lake platform.

Signed-off-by: Wentong Wu <wentong.wu@intel.com>
---
 drivers/misc/mei/vsc-tp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index 6f4a4be6ccb5..55f7db490d3b 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -535,6 +535,7 @@ static const struct acpi_device_id vsc_tp_acpi_ids[] = {
 	{ "INTC1009" }, /* Raptor Lake */
 	{ "INTC1058" }, /* Tiger Lake */
 	{ "INTC1094" }, /* Alder Lake */
+	{ "INTC10D0" }, /* Meteor Lake */
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, vsc_tp_acpi_ids);
-- 
2.43.0


