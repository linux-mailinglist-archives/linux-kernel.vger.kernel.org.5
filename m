Return-Path: <linux-kernel+bounces-58562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FF084E812
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25C429044F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3518B2E651;
	Thu,  8 Feb 2024 18:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ull0gAfJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E2728699;
	Thu,  8 Feb 2024 18:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418171; cv=none; b=Zr5v2YUk3Co+3L/O8vg5bbEpg5ThLOVQpKZEdST3USMK/4OTKq3iLjGU+y55gqcf53tuLw0oUdoq7baXiZJMiwqvURXr5olSvNK8pRc0EBHq0Ty4Zzw/6rCNmtOcsVJsCBhwHMcW9yMtDFMYCxkMubZ8gcmSLWq/C+LKT8CDd00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418171; c=relaxed/simple;
	bh=HmO8BJAxHzacI5yK10Y9+ofU0L21g/VbhUyc1S5/3jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AU7KGpekw2luZvZiVoLSHvcyY4/aqdECwvfytXrbU8R7trXSVCPU67ZB2DfNn0/RS8y4QT86n89PytLlQIDTL2VXutD+b5uwoHkuukiuvgnmNpOCG3PMevmqJB1hnhqwsC9WZ1kCf/31kiJDH43zJynhffxyIRg5IOXj9S1I63Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ull0gAfJ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707418169; x=1738954169;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HmO8BJAxHzacI5yK10Y9+ofU0L21g/VbhUyc1S5/3jg=;
  b=Ull0gAfJM6EgYPO9Fzm1s1DlV/Yedc+qV8TUHOf3/0kHNSuFmqbkRCf1
   9O3raJpxjc1cOZy1Ew66oYALq+f9taZwGKcj3lKUV6yOeawz7Qoh52FVU
   2vrf0ZrT+hu1Cs8RSL+3TKGaJGPkpShX1A9KdqEZGrFzRBsKLbZVGZIw0
   yq/PwwLadF8+pg7r80EFv6J4cUCriX+jKmYBGBEvWOgNlKtM5rVW4WYxl
   2n92zBsj8GJ8ziBhvvjDgjRUwaIZ+4q+58iW4FMVMAtFCw2ij8EDRWqTO
   i0C84p6IanuwjNiYFyjSxg84i1YLOBe0rIha4t0buvSOffW7zCJSdh8B/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1186100"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1186100"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:49:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934215516"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934215516"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 10:49:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 44C0113C; Thu,  8 Feb 2024 20:49:21 +0200 (EET)
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
Date: Thu,  8 Feb 2024 20:48:00 +0200
Message-ID: <20240208184919.2224986-3-andriy.shevchenko@linux.intel.com>
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


