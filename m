Return-Path: <linux-kernel+bounces-62044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A003F851ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC4928652D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B468245BE8;
	Mon, 12 Feb 2024 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LynqWGE8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320323FE22;
	Mon, 12 Feb 2024 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757491; cv=none; b=jq9dp7Qt92Po8mQk8FqgWD78dkEer0WtsgPZxIjwHACfS8tjcGkY2vgJba59xMtPV4lX6qXA/fJwEal17yKLhZUJk73dSo89R49qgzmf/3+ORcgP3OUZv3bjuQkIK72V4//LAe0hMzc0nPWqZIozmON61oqP2K1rOhuD9rmGcBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757491; c=relaxed/simple;
	bh=LvC0jNLSvlISq+pfX0tunOut+CloWPeckMMVxbBHVes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3rgEtMKZuVG/l5tR9dhdb1uuJ1DH+cASQn/oUGg4/uL1mAQ8Ii0HUanVAAFe279TkNjOlBHAKvY+D+uZ2+TzNCS3R2BqBMA9ma9OmELGB2YLM69Jq4x2HMvkQgvu9QTcYPs8KeQN6+F+h2XBk+ksewdIzF5FYuyGoyb6nszi2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LynqWGE8; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707757491; x=1739293491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LvC0jNLSvlISq+pfX0tunOut+CloWPeckMMVxbBHVes=;
  b=LynqWGE8tHLRz/g63tYhFPvqI082pSK9xAdvxatg9Rpw86Cpf/Rz5+Ng
   75UUJhizNmy4peZTrH38RDKpuf/emAp+SU9YJCBiN3QA3z0/o/whpNBmK
   zhrMUHvgd59yf3EoEyQ3sg07xbv6SaIbWoVcUOFhnArn9jfb4Fi9u+iEw
   HNijb5arUW0Gs8PW5XsmfxKnXYgqIW7vevqruwHSLTOoKcnRWi7gmT7Sv
   /QYkGczvfRbrjE1gApJRx2evkaUNZ2fB7BXlPYiQOZgCPFRbz2xInuEJw
   lFMRY6jiuUOvjs1mIPgrlgnXPnR1fxQvfKef1H+29xrmOlNTf//7DUQMR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="19153187"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="19153187"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 09:04:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935116809"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="935116809"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2024 09:04:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A9268138; Mon, 12 Feb 2024 19:04:42 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: [PATCH v2 03/15] auxdisplay: linedisp: Use unique number for id
Date: Mon, 12 Feb 2024 19:01:36 +0200
Message-ID: <20240212170423.2860895-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The absence of decrementation of linedisp_id is incorrect in two ways,
i.e. it may cause:
- an ID exhaustion
- (and if the above is addressed) a duplicate id number may be allocated
  next time a device is added

Replace above mentioned approach by using IDA framework.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/line-display.c | 13 ++++++++++---
 drivers/auxdisplay/line-display.h |  2 ++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/auxdisplay/line-display.c b/drivers/auxdisplay/line-display.c
index 310e9bfb41ae..c4dbb13293d1 100644
--- a/drivers/auxdisplay/line-display.c
+++ b/drivers/auxdisplay/line-display.c
@@ -11,6 +11,7 @@
 #include <generated/utsrelease.h>
 
 #include <linux/device.h>
+#include <linux/idr.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -188,11 +189,14 @@ static struct attribute *linedisp_attrs[] = {
 };
 ATTRIBUTE_GROUPS(linedisp);
 
+static DEFINE_IDA(linedisp_id);
+
 static void linedisp_release(struct device *dev)
 {
 	struct linedisp *linedisp = container_of(dev, struct linedisp, dev);
 
 	kfree(linedisp->message);
+	ida_free(&linedisp_id, linedisp->id);
 }
 
 static const struct device_type linedisp_type = {
@@ -214,7 +218,6 @@ int linedisp_register(struct linedisp *linedisp, struct device *parent,
 		      unsigned int num_chars, char *buf,
 		      void (*update)(struct linedisp *linedisp))
 {
-	static atomic_t linedisp_id = ATOMIC_INIT(-1);
 	int err;
 
 	memset(linedisp, 0, sizeof(*linedisp));
@@ -225,9 +228,13 @@ int linedisp_register(struct linedisp *linedisp, struct device *parent,
 	linedisp->num_chars = num_chars;
 	linedisp->scroll_rate = DEFAULT_SCROLL_RATE;
 
+	err = ida_alloc(&linedisp_id, GFP_KERNEL);
+	if (err < 0)
+		return err;
+	linedisp->id = err;
+
 	device_initialize(&linedisp->dev);
-	dev_set_name(&linedisp->dev, "linedisp.%lu",
-		     (unsigned long)atomic_inc_return(&linedisp_id));
+	dev_set_name(&linedisp->dev, "linedisp.%u", linedisp->id);
 
 	/* initialise a timer for scrolling the message */
 	timer_setup(&linedisp->timer, linedisp_scroll, 0);
diff --git a/drivers/auxdisplay/line-display.h b/drivers/auxdisplay/line-display.h
index 0f5891d34c48..1fbe57fdc4cb 100644
--- a/drivers/auxdisplay/line-display.h
+++ b/drivers/auxdisplay/line-display.h
@@ -14,6 +14,7 @@
 /**
  * struct linedisp - character line display private data structure
  * @dev: the line display device
+ * @id: instance id of this display
  * @timer: timer used to implement scrolling
  * @update: function called to update the display
  * @buf: pointer to the buffer for the string currently displayed
@@ -25,6 +26,7 @@
  */
 struct linedisp {
 	struct device dev;
+	unsigned int id;
 	struct timer_list timer;
 	void (*update)(struct linedisp *linedisp);
 	char *buf;
-- 
2.43.0.rc1.1.gbec44491f096


