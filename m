Return-Path: <linux-kernel+bounces-62042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218F9851AB9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459181C20E53
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3825240BEA;
	Mon, 12 Feb 2024 17:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ketLq/a3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4723FB31;
	Mon, 12 Feb 2024 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757490; cv=none; b=HaSzRab7KNrFVYTNBAp7gYOtcBbn1F/CzvxApm56yxtsCwrz5zMP8pOJC177DZDgmmFZx6QKLK+8XvRWuLBb5SBLNba0+qtqFPLKLls4LV/Dp96geNj6O/LLWhTUwXKIpe7cY4uAualE2iJ627OqPhtqJGxtgTXfhvnTmk78ia4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757490; c=relaxed/simple;
	bh=HmO8BJAxHzacI5yK10Y9+ofU0L21g/VbhUyc1S5/3jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmRvP4d7/vNvkSY7QMUGt2NJoScmwgAFzKmu+cr2La6+7KO2EqXYE4RXmSrpM98yKCaHEa3ixijaSTzLxN7H38GmoAZW+jjvGgEc7cDgl4bASksc/0FP0gqUmNhu2NpzBOHQNb53WHf3Lc+tXutT5uUEYclUD0EjGu94oQSMrEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ketLq/a3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707757489; x=1739293489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HmO8BJAxHzacI5yK10Y9+ofU0L21g/VbhUyc1S5/3jg=;
  b=ketLq/a3NPAg1xAn5daJ/9KyKS+d1J/OMYrQYZdJmj59VunTrr7S50GG
   TCe/ro6R4Yt09v8Ox6OnMr2b2sLneIN1BPquKEmooy5mizmA+MkIwdpzs
   BuQumifUNwpUhY0W1RfmrBmV5eMKUiPdxH8V6WJFWUJZJ8McTXKS5XPuU
   ntYYZyCOUS52IZEDiPOOsWkfPvp0bws63q09qQznNxTK2jt0y69Mh/RmF
   vO7Jn1cn236B68xSgkzQ3USBn8FRr9Rf2VUS7ifIpNh79ODsdK+5CZYKu
   sCaf1lBT/Aa8KGRL/yf5sEg4+yWMkHLEUAANfodTwtzLztUPz6Pd94MKh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="19153175"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="19153175"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 09:04:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935116811"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="935116811"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2024 09:04:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 99AF2FB; Mon, 12 Feb 2024 19:04:42 +0200 (EET)
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
Subject: [PATCH v2 02/15] auxdisplay: linedisp: Free allocated resources in ->release()
Date: Mon, 12 Feb 2024 19:01:35 +0200
Message-ID: <20240212170423.2860895-3-andriy.shevchenko@linux.intel.com>
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

While there is no issue currently with the resources allocation,
the code may still be made more robust by deallocating message
in the ->release() callback.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/line-display.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/auxdisplay/line-display.c b/drivers/auxdisplay/line-display.c
index 03e7f104aa1a..310e9bfb41ae 100644
--- a/drivers/auxdisplay/line-display.c
+++ b/drivers/auxdisplay/line-display.c
@@ -188,8 +188,16 @@ static struct attribute *linedisp_attrs[] = {
 };
 ATTRIBUTE_GROUPS(linedisp);
 
+static void linedisp_release(struct device *dev)
+{
+	struct linedisp *linedisp = container_of(dev, struct linedisp, dev);
+
+	kfree(linedisp->message);
+}
+
 static const struct device_type linedisp_type = {
 	.groups	= linedisp_groups,
+	.release = linedisp_release,
 };
 
 /**
@@ -253,7 +261,6 @@ void linedisp_unregister(struct linedisp *linedisp)
 {
 	device_del(&linedisp->dev);
 	del_timer_sync(&linedisp->timer);
-	kfree(linedisp->message);
 	put_device(&linedisp->dev);
 }
 EXPORT_SYMBOL_GPL(linedisp_unregister);
-- 
2.43.0.rc1.1.gbec44491f096


