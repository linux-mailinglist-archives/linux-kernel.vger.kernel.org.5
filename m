Return-Path: <linux-kernel+bounces-58435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CAD84E680
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9C31F28589
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717528565B;
	Thu,  8 Feb 2024 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T1oRVPtq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12954823B8;
	Thu,  8 Feb 2024 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412654; cv=none; b=UbND9KlPvWqeFLDbN6qs7FfXiTY/lG1gLKcCF8n7f9OPKhzszMUjHJbViBK0kzaqItMjHaUuZPx45gHfoUwPd9F8nIoGQ4FpypgcRjUSv8PiHuuiJkfPpDEv9/YssuQ/O8bo3gZdPvSzthF4c5hnUsfYxX4ydwuFnZYh+j91Pzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412654; c=relaxed/simple;
	bh=T8KmXvh0YgA9eNWvtIJ49Y3WYjlHB5MaL3TkD79lAqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZN7TqNnLOXUJ/ITgc3mNzcpePZjLGMBTq0zwmOVmn27rbhjq7UlPzx+XSa6zSpX/lwAsKJZy0/PxPd6pOUHRUHSDsyocD/Mg03vUo8//jxz9WpIlIVez/OC5kDGgAr01hjJb2UnPrWGNLNPe8nwfMm/pWUxZz+C3r0TeZ4EAdZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T1oRVPtq; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707412653; x=1738948653;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T8KmXvh0YgA9eNWvtIJ49Y3WYjlHB5MaL3TkD79lAqw=;
  b=T1oRVPtq7PMGIWzM+VknHMyrmM8jSHoSGWQxn4tPpEpwMCLJl1Ze0qhs
   b3tixGLW7UwH22X4IfcDjs0B+LNCIDFVq2qaJIoRARgu1m2MzyOV/0S45
   NXsDiVfXjJ0R/Pk+dxtPyVy08Tj9UDPvuLt/3q6dJgIuuLYB3wEa71VKu
   5WwOZtkwP2/qwYDghRdPprJkl6qo/vDT4w97WIyM5LKfZ1egD1vXzCvnc
   7oETkAUuHOTytJWvN+eYt6WYlnG/E7pVSsFHGiYiQUooRQ6dBWHM+qLa8
   rrR5Ym4x41GBru/EvSd6VJ/Vzryb5104S3RgniCsRyRSuRizWfS/JLYug
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1565648"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1565648"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:17:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934195357"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934195357"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 09:17:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 78AF314B3; Thu,  8 Feb 2024 18:59:41 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v1 10/15] auxdisplay: linedisp: Provide a small buffer in the struct linedisp
Date: Thu,  8 Feb 2024 18:58:53 +0200
Message-ID: <20240208165937.2221193-11-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240208165937.2221193-1-andriy.shevchenko@linux.intel.com>
References: <20240208165937.2221193-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a driver that uses small buffer for the string, when we
add a new one, we may avoid duplication and use one provided by
the line display library. Allow user to skip buffer pointer when
registering a device.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/line-display.c | 4 ++--
 drivers/auxdisplay/line-display.h | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/line-display.c b/drivers/auxdisplay/line-display.c
index da47fc59f6cb..a3c706e1739d 100644
--- a/drivers/auxdisplay/line-display.c
+++ b/drivers/auxdisplay/line-display.c
@@ -330,8 +330,8 @@ int linedisp_register(struct linedisp *linedisp, struct device *parent,
 	linedisp->dev.parent = parent;
 	linedisp->dev.type = &linedisp_type;
 	linedisp->ops = ops;
-	linedisp->buf = buf;
-	linedisp->num_chars = num_chars;
+	linedisp->buf = buf ? buf : linedisp->curr;
+	linedisp->num_chars = buf ? num_chars : min(num_chars, LINEDISP_DEFAULT_BUF_SZ);
 	linedisp->scroll_rate = DEFAULT_SCROLL_RATE;
 
 	err = ida_alloc(&linedisp_id, GFP_KERNEL);
diff --git a/drivers/auxdisplay/line-display.h b/drivers/auxdisplay/line-display.h
index 65d782111f53..4c354b8f376e 100644
--- a/drivers/auxdisplay/line-display.h
+++ b/drivers/auxdisplay/line-display.h
@@ -54,12 +54,15 @@ struct linedisp_ops {
 	void (*update)(struct linedisp *linedisp);
 };
 
+#define LINEDISP_DEFAULT_BUF_SZ		8u
+
 /**
  * struct linedisp - character line display private data structure
  * @dev: the line display device
  * @id: instance id of this display
  * @timer: timer used to implement scrolling
  * @ops: character line display operations
+ * @curr: fallback buffer for the string
  * @buf: pointer to the buffer for the string currently displayed
  * @message: the full message to display or scroll on the display
  * @num_chars: the number of characters that can be displayed
@@ -73,6 +76,7 @@ struct linedisp {
 	struct timer_list timer;
 	const struct linedisp_ops *ops;
 	struct linedisp_map *map;
+	char curr[LINEDISP_DEFAULT_BUF_SZ];
 	char *buf;
 	char *message;
 	unsigned int num_chars;
-- 
2.43.0.rc1.1.gbec44491f096


