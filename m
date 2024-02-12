Return-Path: <linux-kernel+bounces-62045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE399851AC0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ABA9284FC3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE7D45BF9;
	Mon, 12 Feb 2024 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eTZdTodF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552C83FE2B;
	Mon, 12 Feb 2024 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757492; cv=none; b=RXFvdjon08wvdcmCjKlG4ZcdGuR63rs74Jcivm8P0q2gFVhb6xIb2WJ2y2L8enFYdtbRtN2agmYy5SpnRS+PmD86qfUdu0+XA+gr0Rs7dkcq09+WH0JWmpZIIcETLCRiPnnzC0QYvdJPNA6GJr/UXqaocSwUXhrED82nxb2uQbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757492; c=relaxed/simple;
	bh=2toHElackSZZyXwXNBaTI+oFom4ViAe7S5c8+PQ2aGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XC5Lp2SnyMqAmVACPOWafl+8lDQwZczWk9kD9mH0nDd3ZAoDoAOZTAco+f74XJRe4aVQpEqoFCWrLs10xud/Bhk/9GFgRlsPAKx10iOt4zUoJTUM7jkEVKOUP35wjxOlvnz5n+7Fg5viZMXwyxOnFGvUyCANZ4RhRL7RmG4+2cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eTZdTodF; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707757491; x=1739293491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2toHElackSZZyXwXNBaTI+oFom4ViAe7S5c8+PQ2aGc=;
  b=eTZdTodFSzzrKE3Dyd7YeTDByOHRyfJETBTUSYKLuwXoHslyTZpdaMjC
   cZozG2DjeYxWceIDlYUXx35BHDY3X1cavzsa0wA9iCSbjkVacZCM11Fkg
   vSkUgJUmE7Imv+9ZWT/Zq902wVtzU2vLRyhl7xFnkGsrxakNhRy3esAKJ
   /dOXu0+/7Kpl83WCrdLbXTBtBUuPsSPW6WC/GOSuu11G5x9JyAOKpObh6
   aL4Pv/Nw2u+hD/1FdkQLR7+VryVKcpRb0y2hRqdm058d5T17lFsgRoUSN
   xQI2rE9wmSVSsDWzlbcithvfTDnLEDGw4+9nwciuOkgmBzPgPT1XNgioW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="19153181"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="19153181"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 09:04:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935116810"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="935116810"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2024 09:04:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AF1E911D; Mon, 12 Feb 2024 19:04:42 +0200 (EET)
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
Subject: [PATCH v2 04/15] auxdisplay: linedisp: Unshadow error codes in ->store()
Date: Mon, 12 Feb 2024 19:01:37 +0200
Message-ID: <20240212170423.2860895-5-andriy.shevchenko@linux.intel.com>
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

kstrtox() may return different error codes.

Unshadow them in the ->store() callback to give better error report.

While at it, add missing kstrtox.h inclusion.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/line-display.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/line-display.c b/drivers/auxdisplay/line-display.c
index c4dbb13293d1..8d91c2099661 100644
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
+	int err;
 
-	if (kstrtouint(buf, 10, &ms) != 0)
-		return -EINVAL;
+	err = kstrtouint(buf, 10, &ms);
+	if (err)
+		return err;
 
 	linedisp->scroll_rate = msecs_to_jiffies(ms);
 	if (linedisp->message && linedisp->message_len > linedisp->num_chars) {
-- 
2.43.0.rc1.1.gbec44491f096


