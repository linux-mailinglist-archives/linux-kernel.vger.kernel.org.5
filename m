Return-Path: <linux-kernel+bounces-162196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5441F8B5782
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB2C1F23D20
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3245A65BAD;
	Mon, 29 Apr 2024 12:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U4/0xUXY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEFC54919
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392568; cv=none; b=aEiajFyDwpcxyZwa1jZinIHoSHA4uXqD7vCLziuX3vCHO9CtRkk22dPycoynvlw32AAOJQxedTudJYwGLifwUszR/+MWpZTiSyTyArGtzFwNdPlBJFPIR7husU11uzJAbkYfeVQexQdD/KCYFG9AN0STcSHJNzsXwVpCDklAtxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392568; c=relaxed/simple;
	bh=NfZcypoD1CZ34fuMUBVKQlaVjj4H35Y4xSOcxQL65lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lv9iBMjKCkPh1N4b1rJiQ6PqEEatc4sAvVZK29luI4WDG96PtTTWKK+WsZIMcyDqA44+gD2pM6rJnFQzUKrFp9URhQPZJsVYkMwuLLkSuIwh0Lx1wOGL1a2h1AAYv1cx0KgzlAzH/cXS95qj4jUMmdoLwM/aWGKgjZxev0888WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U4/0xUXY; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714392568; x=1745928568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NfZcypoD1CZ34fuMUBVKQlaVjj4H35Y4xSOcxQL65lQ=;
  b=U4/0xUXYLiXM7tNClTzaDxPtFeskchT9N6RhKnyac69XFnlY+UHug5uC
   LNkN/7wn+X4NgBXcvccKWTbbrRpGI/GHKDdNRmzYSDJ+BmAJoJSvbLZeY
   TjnxSu++GQVOJuW+IsdivWlv41XMlURlvKHzTrNNkXHZODIrlvpBDhwYv
   Bq9n5/VqpcRuWPl/qQ+ZGciDzH/95X54axJ5JDW1np28qAA2zhalz9yLU
   5eE84w03H3lq+yxmEOshTOJwhBa/t7iAE/do1TGkgRblboCyE1BkoWI91
   RGcgrxXQBPVkxt5x+jinnjSmyoRPUN53Er7iW/DxNSxmeaoVGNg0OLBaU
   g==;
X-CSE-ConnectionGUID: EcZN3ZbzTg2eaxRl6hf3tw==
X-CSE-MsgGUID: Glqko+JXSh+dIZBPspGETw==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="9908249"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="9908249"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 05:09:27 -0700
X-CSE-ConnectionGUID: jGbHB7zUSOm2Cra/AexmAQ==
X-CSE-MsgGUID: d4ABijVXQX+IkYWI/rcQBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26166625"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 29 Apr 2024 05:09:25 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 06/14] intel_th: Convert sprintf/snprintf to sysfs_emit
Date: Mon, 29 Apr 2024 15:09:00 +0300
Message-ID: <20240429120908.3723458-7-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429120908.3723458-1-alexander.shishkin@linux.intel.com>
References: <20240429120908.3723458-1-alexander.shishkin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Zhijian <lizhijian@fujitsu.com>

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

sprintf() will be converted as weel if they have.

Generally, this patch is generated by
make coccicheck M=<path/to/file> MODE=patch \
COCCI=scripts/coccinelle/api/device_attr_show.cocci

No functional change intended

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/intel_th/gth.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/intel_th/gth.c b/drivers/hwtracing/intel_th/gth.c
index b3308934a687..3883f99fd5d5 100644
--- a/drivers/hwtracing/intel_th/gth.c
+++ b/drivers/hwtracing/intel_th/gth.c
@@ -154,9 +154,9 @@ static ssize_t master_attr_show(struct device *dev,
 	spin_unlock(&gth->gth_lock);
 
 	if (port >= 0)
-		count = snprintf(buf, PAGE_SIZE, "%x\n", port);
+		count = sysfs_emit(buf, "%x\n", port);
 	else
-		count = snprintf(buf, PAGE_SIZE, "disabled\n");
+		count = sysfs_emit(buf, "disabled\n");
 
 	return count;
 }
@@ -332,8 +332,8 @@ static ssize_t output_attr_show(struct device *dev,
 	pm_runtime_get_sync(dev);
 
 	spin_lock(&gth->gth_lock);
-	count = snprintf(buf, PAGE_SIZE, "%x\n",
-			 gth_output_parm_get(gth, oa->port, oa->parm));
+	count = sysfs_emit(buf, "%x\n",
+			   gth_output_parm_get(gth, oa->port, oa->parm));
 	spin_unlock(&gth->gth_lock);
 
 	pm_runtime_put(dev);
-- 
2.43.0


