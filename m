Return-Path: <linux-kernel+bounces-58583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC03A84E880
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8D291C29DCD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156DD4205E;
	Thu,  8 Feb 2024 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bjm5WjVe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9E5381B1;
	Thu,  8 Feb 2024 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418180; cv=none; b=Z9TmrAf0h0tVt41SoNiWEA+cKsi1yhZs+Jw6tZ4pnqZ/nuYiKFV9S80SkWHKTf9VmpLUS4YeqQHAr/cvBOGNUWbwE26SGeZj1RVSxfe+z76eocOdXs+fmUwvwAFDb/PbPnOvB9OHe7u5UwasB5DFXwdrqOWISdjMu0DL1mruA2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418180; c=relaxed/simple;
	bh=5fFTptxgaNSrb8/J39Uzrc6cETbfYvICnOp+m4GRuCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6x0ra63uzz6g/QZPWIwmyA9JwK52BkxdNGpQM/9JW32ijPWn1oxKXTNPB0S7f/nfvsz+CDOQybjySU74N1mhxqtF3Eip2egk/2RRwsU+mDaDHuClkmA1niyqUG9xdCHD6Cit1XVUbEpVS29M57oIxcOhjpplwMgwChULPqy9eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bjm5WjVe; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707418178; x=1738954178;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5fFTptxgaNSrb8/J39Uzrc6cETbfYvICnOp+m4GRuCg=;
  b=bjm5WjVesqNwJwuCMUWtLhfJ7HWddeJ7PTrzZApt1GjCW3drJASlUYX6
   3S+Yni2MQcLVpDer7WTqCdJ11B/DmeiFSwtvAXaC2W01Q+q0oKc6ZWIJm
   F9SCooJTKAM4RZRvOaC5eCWl4nB0eEWLCMNyxYyeeScMw/IlYFoSYDa1z
   +9xOARo4DQ5lI1w4kC7RwA4QHUO+IF0hBA8dCsrCA5lq9S8yTC7h52JgI
   PJuU1pqqkhbhV85EdbUczUVo+0J45f9e0N1JwjLmrUBClxyrFxtZISBsM
   gDChrU/kgU64LbH6yUXkSHdg9f0iJG9Nc3oW6TkVlDUYCfNf9lVBR2QXi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1186157"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1186157"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:49:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934215537"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934215537"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 10:49:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9306DE1; Thu,  8 Feb 2024 20:49:21 +0200 (EET)
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
Subject: [PATCH v1 11/15] auxdisplay: ht16k33: Move ht16k33_linedisp_ops down
Date: Thu,  8 Feb 2024 20:48:09 +0200
Message-ID: <20240208184919.2224986-12-andriy.shevchenko@linux.intel.com>
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

We will need the update functions to be defined before
ht16k33_linedisp_ops. Move the latter down in the code.
No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/ht16k33.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
index 0cdf3fbdf81e..75c4a8d31642 100644
--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -440,18 +440,6 @@ static void ht16k33_keypad_stop(struct input_dev *dev)
 	disable_irq(keypad->client->irq);
 }
 
-static void ht16k33_linedisp_update(struct linedisp *linedisp)
-{
-	struct ht16k33_priv *priv = container_of(linedisp, struct ht16k33_priv,
-						 seg.linedisp);
-
-	schedule_delayed_work(&priv->work, 0);
-}
-
-static const struct linedisp_ops ht16k33_linedisp_ops = {
-	.update = ht16k33_linedisp_update,
-};
-
 static void ht16k33_seg7_update(struct work_struct *work)
 {
 	struct ht16k33_priv *priv = container_of(work, struct ht16k33_priv,
@@ -489,6 +477,18 @@ static void ht16k33_seg14_update(struct work_struct *work)
 	i2c_smbus_write_i2c_block_data(priv->client, 0, ARRAY_SIZE(buf), buf);
 }
 
+static void ht16k33_linedisp_update(struct linedisp *linedisp)
+{
+	struct ht16k33_priv *priv = container_of(linedisp, struct ht16k33_priv,
+						 seg.linedisp);
+
+	schedule_delayed_work(&priv->work, 0);
+}
+
+static const struct linedisp_ops ht16k33_linedisp_ops = {
+	.update = ht16k33_linedisp_update,
+};
+
 static int ht16k33_led_probe(struct device *dev, struct led_classdev *led,
 			     unsigned int brightness)
 {
-- 
2.43.0.rc1.1.gbec44491f096


