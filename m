Return-Path: <linux-kernel+bounces-58554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC85E84E7F5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C011C27234
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35842C69E;
	Thu,  8 Feb 2024 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UR/MFjBi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E012562A;
	Thu,  8 Feb 2024 18:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707417958; cv=none; b=A5S33koOkNEhDdhV33tGykQnwNVvn5WE0bX/5DcttMtrUZffbeLwxTpfpccUw89DQYIM5aeaIcL/30Nv/dk9RVXAVZgYqk/U5pxtOess7h61W/HxDNu3jPXWCzSYRIqaBdAL5Nil/quyRHDWBXLwWF0w+n80CFX9rSpJxzyn79U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707417958; c=relaxed/simple;
	bh=xSKeAKNBA96roisQYOcxV4QilUZU+Ks7Czd6oPoWOHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhVTXmIHPj3Tvo4hXEnhtAAJPeHoHAxCAkANgmq9xXp9gv92nwVJscXrbjDkGKPmyJ9Wau1AIrYPbAy1SK+85VEoQIDHBImrHNBo25/3PUtQkXBBGeOi1L2vNixf2kTv+aUW2e1DBtBzs8RXjTt4A7LWvCQaj38Jc7mZ/4wa1kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UR/MFjBi; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707417957; x=1738953957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xSKeAKNBA96roisQYOcxV4QilUZU+Ks7Czd6oPoWOHU=;
  b=UR/MFjBiVReft1FQ0unS0YgCo3WyzG1AsdBR2ipGEozVVzBEaP7AMokA
   aF4MOXbDk5nSN5gTq5ZbXNELDROb9f9sEkPYj0ius5gyBhP+Jd6IETXgY
   d4oVA4lRZ/cDpDkOOb3L93vyTvxDK7na0rSyNiC/ezP9u4Zcim9qgJt7f
   6HtJwouQYMfNKGjI4benqvhr0m3SZDJ0rL1Hq4QLl6gtvwommtS3FRWO8
   CPie1DYG7GD3DYmIA6zq4MYLCHNTZU18Xh2ZLo/giAwKDNxnAI8uF3N4Z
   5sVDdXuRtkH/XtwVJKoe8PaXFKMVJvIGaXHpQZw6j92ePBihfYTN5b71M
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1185260"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1185260"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:45:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934214478"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934214478"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 10:45:51 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 397BF142C; Thu,  8 Feb 2024 18:59:41 +0200 (EET)
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
Date: Thu,  8 Feb 2024 18:58:47 +0200
Message-ID: <20240208165937.2221193-5-andriy.shevchenko@linux.intel.com>
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


