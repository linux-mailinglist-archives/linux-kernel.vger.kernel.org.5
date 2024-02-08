Return-Path: <linux-kernel+bounces-58560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B9A84E80A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5204B1C277DF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F11228DC1;
	Thu,  8 Feb 2024 18:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R3btefzz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD07F2556D;
	Thu,  8 Feb 2024 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418169; cv=none; b=QID3bS/xMfCKdIA+nzGefU7ztGzolgYpTx4eqTlltASIp/aVEVF63Kh4mNSVk+hmZHa3gxODpEtBcG2Rjwje1vNnHwcOQ8ayP8/5t+ne5Di//swgnJ5iuw1XovF/0Ln4u6BLbagPkCL6+3z95EpIHy0gsYNhVPUbtiamdpdcktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418169; c=relaxed/simple;
	bh=xSKeAKNBA96roisQYOcxV4QilUZU+Ks7Czd6oPoWOHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HcLMgYOJEkumR2LJj0R1iH1xrnNa2lAvOZ9ILp2CmefqAv5e5MZxV/yK5itE7YijORoMSemzfNIuik+hpWBCZnwH0hPyfrZ7bI+xtSWqmsZIHE6m3PgTC+nyz3dJpbnh/EGG8hBBD0wnX2v1aLGKsfFRv78VzyBDTECNjQIBkE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R3btefzz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707418168; x=1738954168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xSKeAKNBA96roisQYOcxV4QilUZU+Ks7Czd6oPoWOHU=;
  b=R3btefzzCOmPypUcdfnxzpNw3uuaOhiP2dje0z/Jh8UGVUesKjrIq0GW
   68F3L2zIGyH3Y2i4w/0cxNEDNQuHDen/FO5djOOwTXKAZjHlAjHsd69Ws
   yJjqoED7VQa723nZpQ03dOm0FVx/i+HW3aoXGLZ8dPvOA++GslzqMzfrB
   uE8ahgWVQXKW6fFBPd7mARsKL6BDPf5hFyaDwry25WLRRD8JSQJ6r8Pu0
   PtSGtKdHB21CfQnF06xejPbHI2pZ6PePUks/BA9WKnZIIWvazCsPvq/Zy
   olwQUI23SA6I0ayQqT50iVTMs5gwPeWHljfXdttQd6S453uRtKtmxdll4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1186088"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1186088"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:49:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934215514"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934215514"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 10:49:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 557F532F; Thu,  8 Feb 2024 20:49:21 +0200 (EET)
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
Subject: [PATCH v1 04/15] auxdisplay: linedisp: Unshadow error codes in ->store()
Date: Thu,  8 Feb 2024 20:48:02 +0200
Message-ID: <20240208184919.2224986-5-andriy.shevchenko@linux.intel.com>
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

kstrtox() may return different error codes.

Unshadow them in the ->store() callback to give better error report.

While at it, add missing kstrtox.h inclusion.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/line-display.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/line-display.c b/drivers/auxdisplay/line-display.c
index c4dbb13293d1..4b92ae7781f1 100644
--- a/drivers/auxdisplay/line-display.c
+++ b/drivers/auxdisplay/line-display.c
@@ -12,6 +12,7 @@
 
 #include <linux/device.h>
 #include <linux/idr.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -166,9 +167,11 @@ static ssize_t scroll_step_ms_store(struct device *dev,
 {
 	struct linedisp *linedisp = container_of(dev, struct linedisp, dev);
 	unsigned int ms;
+	int ret;
 
-	if (kstrtouint(buf, 10, &ms) != 0)
-		return -EINVAL;
+	ret = kstrtouint(buf, 10, &ms);
+	if (ret)
+		return ret;
 
 	linedisp->scroll_rate = msecs_to_jiffies(ms);
 	if (linedisp->message && linedisp->message_len > linedisp->num_chars) {
-- 
2.43.0.rc1.1.gbec44491f096


