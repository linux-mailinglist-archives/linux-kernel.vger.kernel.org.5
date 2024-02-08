Return-Path: <linux-kernel+bounces-58552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F27CC84E7F1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C11F1F22570
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923FB2562C;
	Thu,  8 Feb 2024 18:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PL5U/jqa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFB0208DC;
	Thu,  8 Feb 2024 18:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707417955; cv=none; b=sl2PvgEX4Cuoo4LSgTFfpXY8qCcKD+bsyxzZFc0WkO7ACFkL85KASlRWqRQpaLVMSDokCtX56hc7SVqRGjJGJ8XdzMk+0Y5KtSR+lw11bBqGO6yedaH0tQK80+S3cEmG3qSHhj+n0JCIGWdtCDJFnAEb7agtXUy5FGvZrCml7zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707417955; c=relaxed/simple;
	bh=5fFTptxgaNSrb8/J39Uzrc6cETbfYvICnOp+m4GRuCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZaSlBxmJnSFOYEpWp+yfwccduVqjtuQZeM3B99CAYFG3wjeA27fUf2X33lPfaqhfETU/hPp321wL9jujhYzyctZeNU0tYYyjuw9+u8vSrMWIjGL5Kw3SOjU/E8gvSvvzzhhUgLEQezMe1olGS0NIRup7gMMYYxGGGM/2HyMaDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PL5U/jqa; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707417954; x=1738953954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5fFTptxgaNSrb8/J39Uzrc6cETbfYvICnOp+m4GRuCg=;
  b=PL5U/jqaYvanJNb1WeP9R17EfjaHTUI9mCROp5OAvtmcR/gim5r68/9q
   rk9Dvuti3lnxUJayJhC6+kRrTgY9lo+tHcVOiDKkhxSA9TKuh7pkm/KSR
   /GUQ7ZU4Fq0Hd4ibtKOExn7lbBbipDC4GgZ8EDs6+ywcC0NEfpxfL4027
   YvBrj5I1t88BQvVg40HYUH+GuRTmvpBxMGIHQNPhjz/+YaEgazxKXQzqz
   jKGwTJxT8QJzgCq1IM6MwGKxi0iMWvR5dzkq/MJDuPT7xjr/1NO9uykCy
   /kWTZQXW5qId6StBSOg0PHfYqetH1rdG71h2b78R+5W4sGEQzZBI9oASf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1185242"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1185242"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:45:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934214462"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934214462"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 10:45:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 82899157E; Thu,  8 Feb 2024 18:59:41 +0200 (EET)
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
Date: Thu,  8 Feb 2024 18:58:54 +0200
Message-ID: <20240208165937.2221193-12-andriy.shevchenko@linux.intel.com>
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


