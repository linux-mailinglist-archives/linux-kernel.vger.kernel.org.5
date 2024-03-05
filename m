Return-Path: <linux-kernel+bounces-92783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB028725F1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E440828915D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3128017C60;
	Tue,  5 Mar 2024 17:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G0LgqDzg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F25175AE;
	Tue,  5 Mar 2024 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709660982; cv=none; b=hh/xKYWGmB5i4+AWJr1RTtLrDR7Upkul6wpo/dQPuDDW2R43SpmIpufqoDCSzBEhKiTakw5xdS6c/OdiMtj30Cbn9JGEa2ifjMsxzSKgKAZAERXwW2qRqvUD7WCKujQkvRgVovoHGEi21Nylgr9J6QGxrJLax/xlYE4Hh+3YPuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709660982; c=relaxed/simple;
	bh=SGAjMyyUJKvoSZpDLONlB+1giYVnwmizKPUz/44JYUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NomFU76J46b+xPnSpV4ZD0O5oHqLQ2GP/mu8MURG7BDH/9Y60nJ+Zi39rqZWA3W/zMnm9mvaRoByOUULiwkJLsFbhjR7pakYby05kQcTXlsDRqPcKIWeyxaSgkorQJbqHftbUxl3BXXJANKBZIcRIkjHPbxaA+Htm1M7bzi59bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G0LgqDzg; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709660981; x=1741196981;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SGAjMyyUJKvoSZpDLONlB+1giYVnwmizKPUz/44JYUM=;
  b=G0LgqDzgLsfMQilcd1r7ebr5PwoAI2nduAX4Pxq/D3EOzpYAiQGTeSng
   o3mNvQvaRe4QgzcJh1q3zju02kY5IQNhMwj0GUx1C/gZz3TiUEp6m48Oa
   B6aTVEYauU5owb3K/ZV6soohHv85dABpwjdx3l7XSXjO9rTu0Csyg6m5J
   qi59ZIYW5eRpqr5EuT33iLljW9Dlt4rHYEXlvHbQ3RfaBh1kafPTdGUVB
   deeAYMQl54TRGSVShTtejIT4R95mRKWxRKm0h/UhE2mW/RxZe7y8DCSpF
   CT2Y9f+pBSoRpZWyUPFE2uz1aNx/0RMlquav9DRPSSvmbNPljb23nnItN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4092438"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="4092438"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 09:49:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="937042793"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="937042793"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Mar 2024 09:49:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 48069697; Tue,  5 Mar 2024 19:49:35 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH v1 3/5] media: ir-spi: Utilise temporary variable for struct device
Date: Tue,  5 Mar 2024 19:48:28 +0200
Message-ID: <20240305174933.1370708-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240305174933.1370708-1-andriy.shevchenko@linux.intel.com>
References: <20240305174933.1370708-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have a temporary variable to keep pointer to struct device.
Utilise it inside the ->probe() implementation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/rc/ir-spi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/rc/ir-spi.c b/drivers/media/rc/ir-spi.c
index 846d407a1f7e..19102bdcfd6f 100644
--- a/drivers/media/rc/ir-spi.c
+++ b/drivers/media/rc/ir-spi.c
@@ -121,11 +121,11 @@ static int ir_spi_probe(struct spi_device *spi)
 	u8 dc;
 	struct ir_spi_data *idata;
 
-	idata = devm_kzalloc(&spi->dev, sizeof(*idata), GFP_KERNEL);
+	idata = devm_kzalloc(dev, sizeof(*idata), GFP_KERNEL);
 	if (!idata)
 		return -ENOMEM;
 
-	idata->regulator = devm_regulator_get(&spi->dev, "irda_regulator");
+	idata->regulator = devm_regulator_get(dev, "irda_regulator");
 	if (IS_ERR(idata->regulator))
 		return PTR_ERR(idata->regulator);
 
@@ -154,7 +154,7 @@ static int ir_spi_probe(struct spi_device *spi)
 
 	idata->freq = IR_SPI_DEFAULT_FREQUENCY;
 
-	return devm_rc_register_device(&spi->dev, idata->rc);
+	return devm_rc_register_device(dev, idata->rc);
 }
 
 static const struct of_device_id ir_spi_of_match[] = {
-- 
2.43.0.rc1.1.gbec44491f096


