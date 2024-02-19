Return-Path: <linux-kernel+bounces-71729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 562D985A990
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893B81C2379B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA4D4594A;
	Mon, 19 Feb 2024 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IHxkQt26"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45241446BF;
	Mon, 19 Feb 2024 17:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708362231; cv=none; b=Z3WXs/D3j0NYyEHG5dOL39PhEdEHYnEtXbN1g6k1fyp3jrq9VcD4IJPDfsFo+iO8Yysi0q+QkStURewSpZgP9LU4742JxSS4vZKwsK7N3q+NBr2lQskbfPx3M/MakSTVXwKQGEXDK5UcaSloUSzQiyGitw2zH3ebfsX2tA/qXCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708362231; c=relaxed/simple;
	bh=GmwQL6cecvWhO8sF6HOT2jJDb+yjghM1Cc5l5FQr/Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uj0NXxAdSt4rXU9BL52JorkAbY13v40su71nql3BzkuRjjP5q3+OthsHR1pp2lagtqPNzHy22J6EDfiPYa4gXdI0VvoLE0RQ8rn/bR/09bA1OGiIzFDr9rBo1Z93KSdhoClB685iXj5tMjedzd3aa52PklzB4ed6rpXapBZRQek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IHxkQt26; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708362229; x=1739898229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GmwQL6cecvWhO8sF6HOT2jJDb+yjghM1Cc5l5FQr/Hk=;
  b=IHxkQt26MD53QHbjantoBkHAXwDBTdXbMH8It6CwEsZsh4H1Ls/stYtX
   4ERGX3MDRY6rZNmo9xvGBKkdAKroyqpJIbnehHw43cdMgT4h4U69s60cc
   aDJ1QNhpzH85STgB8vsQfg0etIMVMs20ZV9zexoTfe6ZOrqtXmX1WiwhL
   iNw4bQXSiCdGkCsQ0ci6SuvWhMj8yUMvxvKA+YQGo9fNGAZVWhnfdxHH8
   tMbFXI3aR5Fyen2B3T0gmw18qKDdWKR0LojKOZuzoO+BDu4slH8/zRjuL
   W44xJKcf4ZX2DLOe+vW4tq1e+pmXopho+0zIL9zeEvbWz7R/BR+aRrd8O
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2577410"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2577410"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 09:03:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="936315354"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="936315354"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Feb 2024 09:03:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 48BBD52F; Mon, 19 Feb 2024 19:03:41 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: [PATCH v3 3/9] auxdisplay: ht16k33: Add default to switch-cases
Date: Mon, 19 Feb 2024 18:58:02 +0200
Message-ID: <20240219170337.2161754-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com>
References: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the compiler (GCC) is able to figure out that there is no
other choices possible than those that are already listed in the
switch-cases. However, if we want to move some code to the callback,
compiler will start complaining that no default is defined. Make
sure we have all switch-cases equiped with default.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/ht16k33.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
index 19805f39a257..c0067a3b2b61 100644
--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -677,11 +677,6 @@ static int ht16k33_seg_probe(struct device *dev, struct ht16k33_priv *priv,
 		return err;
 
 	switch (priv->type) {
-	case DISP_MATRIX:
-		/* not handled here */
-		err = -EINVAL;
-		break;
-
 	case DISP_QUAD_7SEG:
 		INIT_DELAYED_WORK(&priv->work, ht16k33_seg7_update);
 		seg->map.seg7 = initial_map_seg7;
@@ -695,6 +690,9 @@ static int ht16k33_seg_probe(struct device *dev, struct ht16k33_priv *priv,
 		seg->map_size = sizeof(seg->map.seg14);
 		err = device_create_file(dev, &dev_attr_map_seg14);
 		break;
+
+	default:
+		return -EINVAL;
 	}
 	if (err)
 		return err;
@@ -772,6 +770,9 @@ static int ht16k33_probe(struct i2c_client *client)
 		/* Segment Display */
 		err = ht16k33_seg_probe(dev, priv, dft_brightness);
 		break;
+
+	default:
+		return -EINVAL;
 	}
 	return err;
 }
@@ -796,6 +797,9 @@ static void ht16k33_remove(struct i2c_client *client)
 		device_remove_file(&client->dev, &dev_attr_map_seg7);
 		device_remove_file(&client->dev, &dev_attr_map_seg14);
 		break;
+
+	default:
+		break;
 	}
 }
 
-- 
2.43.0.rc1.1.gbec44491f096


