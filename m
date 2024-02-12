Return-Path: <linux-kernel+bounces-62051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6FC851ACD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADCF51F28B60
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1344C634;
	Mon, 12 Feb 2024 17:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HLItknqn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF9F4776F;
	Mon, 12 Feb 2024 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757495; cv=none; b=ULi6FFrOfR9GFSzag23dPOiXfixjRfxqx4+hCQ0Gp7FkdOe2il8Y9poIS5fONSUhKz4z/b0nwIR8w/ZbLNxFim2K/+5oAF6Ei3gtMoGrTwwzlTBDdYQKpcYyCSD3Z+P/QoQpW5NreA+y3GClQjL+PlMR83hwBA5KBL/ytJbw9N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757495; c=relaxed/simple;
	bh=bZSIwuNODdqGZ3IZxNzcIUdpLQwmXGNmwkHg29fDE5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHFvWHKHNGGAbRNiXhW2ikgGWD2gWighTwDq2L0m8N/ubwAefJ9Wi0webPARCg8evQHoQXz2F0Roz+NAZKFSYyLzNtTuLwSZT33XzyqMjUgqZzvBFHFUWoMm6bN/F1AGsn4fCEyp691wewp/5P8TnKtvbOD72j00qDN0HUDcBW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HLItknqn; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707757494; x=1739293494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bZSIwuNODdqGZ3IZxNzcIUdpLQwmXGNmwkHg29fDE5g=;
  b=HLItknqnrSl76axjDpRdgjb6axGJNLnDp0gr3Ewsuv8GeLOLJa+DFP4J
   KcvvdZ86Bx5BgbgAfmuYlU5scywnY2pSQLqYO9O8UscssSNo4hiF1sKBV
   yQEGbMszB09Hxv/Mk/DdE6wejlIaKfMfZcENr4Bpw7Pn6a8qJVT0BVLaQ
   udiylNtgX4wPyfDCjrt5eswjTY6vI4KnHXqftPEgpAULoypmqH802/dSW
   yD/6YLUTUTaaJVkRIEDyq6eyTugdDPTLhxvTeg/xeO8xD90FGa3YX43KN
   OTWop5xVGH7qI8ER7OfMm/0ByiX7exZw1v2f0FlC8kGoR1pvtrBXoB73I
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="19153224"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="19153224"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 09:04:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935116826"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="935116826"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2024 09:04:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 09521338; Mon, 12 Feb 2024 19:04:43 +0200 (EET)
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
Subject: [PATCH v2 10/15] auxdisplay: linedisp: Provide a small buffer in the struct linedisp
Date: Mon, 12 Feb 2024 19:01:43 +0200
Message-ID: <20240212170423.2860895-11-andriy.shevchenko@linux.intel.com>
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
index 75852ce6cc8d..d730cd0e1d03 100644
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


