Return-Path: <linux-kernel+bounces-92786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB0F8725F9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADFB71C250FE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54641AAD3;
	Tue,  5 Mar 2024 17:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YjRofGoI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E10217BA7;
	Tue,  5 Mar 2024 17:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709660984; cv=none; b=RdDNWz5Jh+zxZeC8NP3MAHO0WVs/tu3WeVYI70+cMGpXURT0QnpyimsJx4HMp6fwaduiVoAvryVOfsjUwNjLupRrb367PL2Y3E/1xiJbivx/h/7RmzkBBEVGIRp3+zBs9LwuLAhUwgDSM/18AbAsDiJ8e8Buki5c8EwmUnVb434=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709660984; c=relaxed/simple;
	bh=q66Wb9ahMc8HcoBEjdZcQx4TA4GGv5WTs+e4hGRLHx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/lpb2Z6AYtpltlQG6TgMgwWC6fYDM3FjCXz2pPTgK8ZMttneXWxbBSBdub5c68wJy8yjC547dE+fr3aZ4l6pIaSMR6Vwje1Qttu3E8sNjrBIoOYDRSWd6+Da9IZOFs4ENVVNcD/bGFppE7xa4Wq76vRWr8mtotnHzvUzE72xlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YjRofGoI; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709660982; x=1741196982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q66Wb9ahMc8HcoBEjdZcQx4TA4GGv5WTs+e4hGRLHx0=;
  b=YjRofGoIkEyuWAZ64qfiigWdeB6VCTWr6Dg/LoZp71B9hS7aY5rrXLKK
   z3VmTxqLFeHhaDextH6mKFZgsmKHv6TOohidyu2iOT/BFoCWXOPH4TaL7
   s+NLip7FX6O1LPk9PbKTPbMie/exV4GBiInL9aSd26XbX58ZXGNmNCh1n
   H3Nsh2DQUm4VLq57XWGyTwprhIbVgP/HYYyizJ5n+nWYtkyU+d0unWt0a
   Y53IrEB9ulZF2oOtCCTDEiF65DU34+Nft6GEq0XEJFs50u1LhNV9QLZO2
   /YlbcDs5xOM57phK4sZN9splgRxMFDdUM3mTLIf+crqSFgYBC/DX5B/uy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4092456"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="4092456"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 09:49:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="937042798"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="937042798"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Mar 2024 09:49:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6BAC374C; Tue,  5 Mar 2024 19:49:35 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH v1 5/5] media: ir-spi: Unify indentation and comment style
Date: Tue,  5 Mar 2024 19:48:30 +0200
Message-ID: <20240305174933.1370708-6-andriy.shevchenko@linux.intel.com>
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

Unify the indentation and multi-line comment style.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/rc/ir-spi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/media/rc/ir-spi.c b/drivers/media/rc/ir-spi.c
index 801de3d108cc..8fc8e496e6aa 100644
--- a/drivers/media/rc/ir-spi.c
+++ b/drivers/media/rc/ir-spi.c
@@ -36,8 +36,7 @@ struct ir_spi_data {
 	struct regulator *regulator;
 };
 
-static int ir_spi_tx(struct rc_dev *dev,
-		     unsigned int *buffer, unsigned int count)
+static int ir_spi_tx(struct rc_dev *dev, unsigned int *buffer, unsigned int count)
 {
 	int i;
 	int ret;
@@ -57,7 +56,7 @@ static int ir_spi_tx(struct rc_dev *dev,
 			return -EINVAL;
 
 		/*
-		 * the first value in buffer is a pulse, so that 0, 2, 4, ...
+		 * The first value in buffer is a pulse, so that 0, 2, 4, ...
 		 * contain a pulse duration. On the contrary, 1, 3, 5, ...
 		 * contain a space duration.
 		 */
@@ -146,9 +145,9 @@ static int ir_spi_probe(struct spi_device *spi)
 	if (ret)
 		dc = 50;
 
-	/* ir_spi_set_duty_cycle cannot fail,
-	 * it returns int to be compatible with the
-	 * rc->s_tx_duty_cycle function
+	/*
+	 * ir_spi_set_duty_cycle() cannot fail, it returns int
+	 * to be compatible with the rc->s_tx_duty_cycle function.
 	 */
 	ir_spi_set_duty_cycle(idata->rc, dc);
 
@@ -177,7 +176,6 @@ static struct spi_driver ir_spi_driver = {
 		.of_match_table = ir_spi_of_match,
 	},
 };
-
 module_spi_driver(ir_spi_driver);
 
 MODULE_AUTHOR("Andi Shyti <andi@etezian.org>");
-- 
2.43.0.rc1.1.gbec44491f096


