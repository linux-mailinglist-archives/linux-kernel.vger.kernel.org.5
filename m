Return-Path: <linux-kernel+bounces-71546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB5C85A6E9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C46128499B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CB53CF66;
	Mon, 19 Feb 2024 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jei8VxlL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505FE381C8;
	Mon, 19 Feb 2024 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355199; cv=none; b=STGwZXrD//bBtknf+Ltba1WbbxXdffhbhidnm/ASmf/AZhS5OBoOm0Owrl6u3lma52PhU85QHYpG0KRY8AhYp5oCnHbEkJWjo/LzBeGM1lwHMvENsmZ+1UsMW7PiNvz2CCnhf4PVZtS1QRU/MVBID17iJktkpknujeWbq3iusPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355199; c=relaxed/simple;
	bh=Oubb+Ppgmcr6fsN+mjfb+NkY8mywNOxbf3wmKOoo4jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYq+3YYpMiFJIxXYUx3OvCs9eAEoY6SVHlc3PxnoFo/kLNbF9wGtucLSEE27aA42l9GeoA44+3N6Wjzl7sn3D86AjDn5dzS2+fAbLIbpSMbwUzvhnINh7OqzID3zsE8TatXdrM+KOoSUs00CMmiSuxcAP5oLCBi8uno7rGn9KlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jei8VxlL; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708355197; x=1739891197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Oubb+Ppgmcr6fsN+mjfb+NkY8mywNOxbf3wmKOoo4jE=;
  b=Jei8VxlLwYtgZ/aITZAG2uRUN4A3WPXlMdgKnSMN6iHAH17CkNuvil04
   YiRHib6DtthcXrA8M4zP+a2j74gwZTsgrYZ37r0rshyU3y7L1UhFaIXBk
   QIBy9MZ20uoovh4CVe97TjU9kJsJjcbLBVpoD5rZAxrUJIhWmrXNxbAoh
   qUPBdcmojryhu29UzeOz6lVOianqoT7CciL2wfL2aOiaZ53EturQGGMHV
   7mjEeC4Pfy3MS/T1xSA8dSMEa941JbFuHQE2N0GeomNVzP4Zw1FfidHvB
   yVC+4855ui6o/pcQmWtBBogOzOlFtmEy2ob6Zg9FbOqZprFJJ9rfA2+gA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2543779"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2543779"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 07:06:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="936302992"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="936302992"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Feb 2024 07:06:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 00BCA403; Mon, 19 Feb 2024 17:06:28 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 3/7] serial: 8250_exar: Clear interrupts before registering handler
Date: Mon, 19 Feb 2024 17:04:59 +0200
Message-ID: <20240219150627.2101198-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240219150627.2101198-1-andriy.shevchenko@linux.intel.com>
References: <20240219150627.2101198-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While now there is no issue if IRQ is fired before we clearing
the interrupts as the handler does the same, but strictly speaking
it might be problematic if IRQ handler wants to do something more.

Move clearing interrupt code to be called before registering the
IRQ handler.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 28478b9c537b..c7afa06a420e 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -701,14 +701,14 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
 	uart.port.irq = pci_irq_vector(pcidev, 0);
 	uart.port.dev = &pcidev->dev;
 
+	/* Clear interrupts */
+	exar_misc_clear(priv);
+
 	rc = devm_request_irq(&pcidev->dev, uart.port.irq, exar_misc_handler,
 			 IRQF_SHARED, "exar_uart", priv);
 	if (rc)
 		return rc;
 
-	/* Clear interrupts */
-	exar_misc_clear(priv);
-
 	for (i = 0; i < nr_ports && i < maxnr; i++) {
 		rc = board->setup(priv, pcidev, &uart, i);
 		if (rc) {
-- 
2.43.0.rc1.1.gbec44491f096


