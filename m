Return-Path: <linux-kernel+bounces-21924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304428296A6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA6ADB24E2F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D323FB07;
	Wed, 10 Jan 2024 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="VXdF1PI6"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947E83FB01
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 09:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1704880445; x=1736416445;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=irLnxZpzpQ8b3CTf9ZAB4EynhbjfsBkKzcVQF/zih7A=;
  b=VXdF1PI68LXjpLNLqfU3GifMCGopfYx3EONza5KAgzfucd8pUBO/IPM3
   D9xMwNo18Ls8gut6/Wj2s4uhfsby1ndJgd9AQulBfUliRkg+QWbueZ13m
   JC/RS0TwfE+L7dhiDwg4E2by0oaxWt3UpDDwqg+TTZwS6rTPxyLDifnd1
   2NFJAMHSwQQBXtUxZ9iTDAVci3YN/lHMNiCos2qs28PtZ3XPT6ZyYUL+T
   LEjEUWONABDYYVd7j+L/zD+cv/WxcWtXC/N6Q0XD+u+9r4v9EIEpCgYsF
   u6u+WZEJadtB7UMglR5XEw0nkylktl9IlbI3IldnqBb+pduWclYM1CRa+
   A==;
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="34824823"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 10 Jan 2024 10:54:02 +0100
Received: from steina-w.tq-net.de (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 4D47B280075;
	Wed, 10 Jan 2024 10:54:02 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] regmap: debugfs: runtime resume a device when reading registers
Date: Wed, 10 Jan 2024 10:53:58 +0100
Message-Id: <20240110095358.473663-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the registers shall be read from device, runtime resume it in order
to enable a possiblly attached power domain before accessing the device.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/base/regmap/regmap-debugfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index fb84cda92a753..063ede23173af 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -12,6 +12,7 @@
 #include <linux/uaccess.h>
 #include <linux/device.h>
 #include <linux/list.h>
+#include <linux/pm_runtime.h>
 
 #include "internal.h"
 
@@ -233,6 +234,10 @@ static ssize_t regmap_read_debugfs(struct regmap *map, unsigned int from,
 	if (!buf)
 		return -ENOMEM;
 
+	ret = pm_runtime_resume_and_get(map->dev);
+	if (ret)
+		goto out_free;
+
 	regmap_calc_tot_len(map, buf, count);
 
 	/* Work out which register we're starting at */
@@ -277,6 +282,8 @@ static ssize_t regmap_read_debugfs(struct regmap *map, unsigned int from,
 	*ppos += buf_pos;
 
 out:
+	pm_runtime_put(map->dev);
+out_free:
 	kfree(buf);
 	return ret;
 }
-- 
2.34.1


