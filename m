Return-Path: <linux-kernel+bounces-62055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E105B851AD5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200F91C226F1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789594D9F0;
	Mon, 12 Feb 2024 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OMdePW/9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086A43DB91;
	Mon, 12 Feb 2024 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757497; cv=none; b=emhMFCdm18isDK02kWGD17nqNPez9GSf0HknpMlNr9WWWJEdu265Dyq5q75xteM7vzP8CkLvIIEV35p4efpa21/hPgZzaoVceim1K98/zhs4GsrUky3sNwGwUMp7Mr3CTuyi010mpgzPmv6gWPAzxv3yPtkFEI0JtAcROjYHToE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757497; c=relaxed/simple;
	bh=5fFTptxgaNSrb8/J39Uzrc6cETbfYvICnOp+m4GRuCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCiUmE69CGr+BvVMdbEM1inc+R4bjYGmcawCJy8p9h+W96F5G4Q/6+drba/xaBIcjAozaxsDMHfPDsyKtI1xOiPKEgpse73RRsvd5JgvN0Oxl4BHUXrk7YZFbSY7b9Ee4QFvAApL2+qUiNpx/ib6JdPYME49QJBmlthIvRVb8sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OMdePW/9; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707757496; x=1739293496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5fFTptxgaNSrb8/J39Uzrc6cETbfYvICnOp+m4GRuCg=;
  b=OMdePW/9xIUPxFEXT6IiC9GrQziBbcASWrlTI9YCtfoX3rlmZTNJe9px
   VzaEw9M2VITtJQREcA/wXVG2km9xXeXhUHJmaq5wqmf2Nm6F20ZV1Yz6c
   9oqaPtcziIE6nCrU3cslbWhx+eXloZvftAOA7LHwroTZ70Qg2cly7paoK
   xPsJueaZP65fBzGXY8kwaY/rbGCXk1jLAlC/i2m4OGl6y5fZR5JJwXtrw
   +UbrZuG+Q30i7KOgzWu1a5/7Gt4EP5YC4je4BhE71dYKc9iALaB6scbXi
   o42UeBzo9Q8AG9OFKuA6eE7NnNHDKciiB1+6S8At5mwFvJ0ALY5h0/Rlx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="19153235"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="19153235"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 09:04:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935116828"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="935116828"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2024 09:04:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1402933F; Mon, 12 Feb 2024 19:04:43 +0200 (EET)
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
Subject: [PATCH v2 11/15] auxdisplay: ht16k33: Move ht16k33_linedisp_ops down
Date: Mon, 12 Feb 2024 19:01:44 +0200
Message-ID: <20240212170423.2860895-12-andriy.shevchenko@linux.intel.com>
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


