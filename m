Return-Path: <linux-kernel+bounces-58438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D234284E686
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F761F29CFA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7892B1272A7;
	Thu,  8 Feb 2024 17:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fp0c+kZE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A2684FAD;
	Thu,  8 Feb 2024 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412656; cv=none; b=BYjJ5vZSIxIvFFc3cU9CVlNac9PsKRWmxlxtz7eRqLzkRRs9nCmRthCCjh1qt9dq7xDTVPmfaJ8EFIxj/IlPlBWNldhtoD3FllVCDW0OMbY/9Yy8YqEEefjkFdWyiJvyKl6U293g5LIxekqkcP3WxSiFSaNYjwdkfBOckAfmzgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412656; c=relaxed/simple;
	bh=HmO8BJAxHzacI5yK10Y9+ofU0L21g/VbhUyc1S5/3jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQzI0p83QScPd7J5kLD4xkhEu63XhVUXgVHo4sJUS0pvCB/CwljWyCKHSHoS2jSb+aF0e3La8s3ZfFgYPypV3Ixze56RQBhp0/ZuIVSV9kCwn4Q0oPMYjCLM84qZqqZtLZsRQL9bgpk8XEjDH0LoLTmh3HSuKHF36mR63XKr81Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fp0c+kZE; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707412655; x=1738948655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HmO8BJAxHzacI5yK10Y9+ofU0L21g/VbhUyc1S5/3jg=;
  b=fp0c+kZEowmfNUNS9/4Jd/LUh9xAaXlw14STOlzb+SRcCIOOvuGQKgVN
   Tl1IAVql6UUkNjrnpTpSqfpuGsXAyahmB4fv3ON7FPXAmY4FfDMqpA+o1
   NrQ/doaAcVS6Rga7GO31fwqC9dSBdn5gDY2hIiqEWWc2QYIFozv7kyrbx
   qNT6vkLPRaGVkjpCknFgD6TVi0/AYfFUAnuqY69fdHakF6bscpjWhc6iQ
   3g409BqEu3b4UoZ2a5GvaXprWIVtzzl3QDDhboWZDvAd5CsK7sda90P/y
   VCMmpDgGpohWDOLfq3KyzwTu7oKV3T5toJTg/aeXA8zLYpQcsWQmAvfPb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1565672"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1565672"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:17:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934195372"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934195372"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 09:17:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1BCD013C5; Thu,  8 Feb 2024 18:59:41 +0200 (EET)
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
Subject: [PATCH v1 02/15] auxdisplay: linedisp: Free allocated resources in ->release()
Date: Thu,  8 Feb 2024 18:58:45 +0200
Message-ID: <20240208165937.2221193-3-andriy.shevchenko@linux.intel.com>
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


