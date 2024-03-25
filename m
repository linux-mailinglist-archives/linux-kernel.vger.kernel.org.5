Return-Path: <linux-kernel+bounces-117564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E82B988ACA2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 257CC1C3BFDD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F696D1AF;
	Mon, 25 Mar 2024 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bwUsFYHl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C145A4E1AD;
	Mon, 25 Mar 2024 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387092; cv=none; b=lSpp0CreSi+JvUAE7SshUlXwthrKBNlE7LQaJfZAuhC/c7xlTEBM06/IZQMfqi1fPoLiKfJR/PnknW/98D24VuaIY3JsmTCWKmkLyYDYKNl0maLcCSz562F5JakvPEF5aFnbWCm5pN32vuh1yd98yY7xQi+3vt6ZNm6oPyspM1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387092; c=relaxed/simple;
	bh=EsZ7DYs0uLdg3p61Jl6f297OkczXhJruCuaScJCVEqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T2yEgbFsEk84jWM6ADMYs2WKx7qdz9F3MsOEE/VQDrJVm9vXEwKvpc69cjEYLKqZvQHDNTuaViGwWfFEDAaamSz61vdgRuJ+7R7ohZMQ6xb63I8hPFRWc57d7SK29IhQhZ5y1aLNmqKA/RhL1XF1+Y8YZz47Wu8vzJo591frVc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bwUsFYHl; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711387091; x=1742923091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EsZ7DYs0uLdg3p61Jl6f297OkczXhJruCuaScJCVEqg=;
  b=bwUsFYHlVTgzNNbnaE6LNBA68zTwD6emZF6PjrImtJ/jgwvR6q5aWrzc
   rXcsW3eEbOcOG8vn4OngXjHdB205jXsMHULJD7MvqrJrojN4Dh9rBf0lu
   UVCgGMV+fHEJKqsRtWJBYXH2ynwxbKiVDKzUl/dnjxUo5lYdtf/6LT+gN
   IawXSF91HGaQB4nn8WW9u2EdQkI1hcak0alpQXNpnTsUBnptl6GTQloOa
   ozNIvTyN85Wwp4vOu703YpjqgS0UPaW1dv97QNRvlpGaFYLaPOosWgUtA
   twBgSqA7hF7wPvKj305/UtWS7SdAv+RULTK01RPpE/kfRMYaWX+lOIjcu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="17546542"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="17546542"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 10:18:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="937070689"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="937070689"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 10:18:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BA569643; Mon, 25 Mar 2024 19:18:05 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Peng Fan <peng.fan@nxp.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 2/2] gpiolib: use dev_err() when gpiod_configure_flags failed
Date: Mon, 25 Mar 2024 19:16:26 +0200
Message-ID: <20240325171804.3375280-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240325171804.3375280-1-andriy.shevchenko@linux.intel.com>
References: <20240325171804.3375280-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peng Fan <peng.fan@nxp.com>

When gpio-ranges property was missed to be added in the gpio node,
using dev_err() to show an error message will helping to locate issues
easier.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index b98cbf4335e3..5589e085ba25 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4236,7 +4236,7 @@ struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 	ret = gpiod_configure_flags(desc, con_id, lookupflags, flags);
 	if (ret < 0) {
 		gpiod_put(desc);
-		dev_dbg(consumer, "setup of GPIO %s failed\n", name);
+		dev_err(consumer, "setup of GPIO %s failed: %d\n", name, ret);
 		return ERR_PTR(ret);
 	}
 
-- 
2.43.0.rc1.1.gbec44491f096


