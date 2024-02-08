Return-Path: <linux-kernel+bounces-58585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B8C84E88B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451E41C25361
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BB94EB53;
	Thu,  8 Feb 2024 18:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ma/RGIMH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865173C481;
	Thu,  8 Feb 2024 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418181; cv=none; b=ZTqDOJm6xaurCGKtVNkH5aKTN/Zvyibr+N2PhK30RwFgfP8gZ/hEFgWfdKXKBjubztfwEj/VzxWr4ng/Zm7FPZ0Z9x0aXaijxxkotyoJljjZfbTTmawaaf1hUKwTkVTZFZG8NNEn8LVIbSxagp8pc6KY1j3BdMaDZXY4fsByn9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418181; c=relaxed/simple;
	bh=T8KmXvh0YgA9eNWvtIJ49Y3WYjlHB5MaL3TkD79lAqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxCJSZXfgH6/q3R1qlDumce8iT+5E4CX59LB6Pm4m3Sos55kqErTX6eOSP+MzsHG47ibeYChUysWIYUYy6zG6sSq8IKcCM9HI0lafDullG2tNEakZKulDBTWawhMKI3RZAeynxdX3idFBGZ3dTXWkNjkUDXoe1+9MzDr8GyUVaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ma/RGIMH; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707418179; x=1738954179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T8KmXvh0YgA9eNWvtIJ49Y3WYjlHB5MaL3TkD79lAqw=;
  b=Ma/RGIMHvJv6U1/NI4+GYuSP+A2np48lLQjbU8D8IOY1Cssf3IN9T2II
   XBi3SV2XP9RHD7IUZ25LYGfqnqxmr0cf0KaSkWWfWNV4kwvTZVbvlcg2d
   9HbGvh/UHc+FSjtcg6NTIY1UGBR+wHaOqQKnLBj+jyNt+hVzSComAZE9o
   pPyOGc5sirnsA9RYU9p5Vo8g6lES73GN22gn6Io8f1m4snt38f1qXFkpY
   9ReV/pEamDS9e/AXqHBKLu969F5KZHOfMB94GDBKlsif1RxDSLHH1ka8D
   mlXlbABwsmYOYhy3pBnUGL6oaAdwSaBWR46YgcVB1AHo+fAhf90ZlofeT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1186162"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1186162"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:49:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934215538"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934215538"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 10:49:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8DDA4F3C; Thu,  8 Feb 2024 20:49:21 +0200 (EET)
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
Date: Thu,  8 Feb 2024 20:48:08 +0200
Message-ID: <20240208184919.2224986-11-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240208184919.2224986-1-andriy.shevchenko@linux.intel.com>
References: <20240208184919.2224986-1-andriy.shevchenko@linux.intel.com>
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


