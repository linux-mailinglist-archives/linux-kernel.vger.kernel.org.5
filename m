Return-Path: <linux-kernel+bounces-65620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 784E9854F7E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A18288D9F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4652D60DFD;
	Wed, 14 Feb 2024 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jil45KuT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0583D6088E;
	Wed, 14 Feb 2024 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930655; cv=none; b=olGfz4lvbVNZMXLZznOymKvl/At2ywjZ38//RAeSZuAf9oLg+X19rJN93ptnPoo7nEbnENVBFy7RVi/szbNT2zFLLpNlgagY20SQVxNYDup/k0VQgQgYTTfbSVigym/j0Nz59U71QEn9+wjVM0ZWUP0fznkd44Ikg99oWHWvCbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930655; c=relaxed/simple;
	bh=6SSOUnIBqCm1UlIPDdIu3o/LhTRQZBXFqS1PUYB3XUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvxlkhqysQyIU68Nwjlm9S8G6YFSf2zt+QfanJCOERZea3jStT7MPYp6bBaWZrh4r4tBTpU7976mUw8kxPgsXU94hzYAjHHaQndhDBCFJDCBHQrBj5y47PeDp5haqP5hc7qwO7pTzb/wLae7LeDu/scxHWdZhIF1qhus4KPmkoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jil45KuT; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707930654; x=1739466654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6SSOUnIBqCm1UlIPDdIu3o/LhTRQZBXFqS1PUYB3XUQ=;
  b=jil45KuTZP8wEccwSX/Avc2xP4QG07kUPh5aY1NubwKO8S5NFnIsCy9U
   45rz8w6SXtvOjZQ+jP6XdktjgzlHgHu7jwuhGk32B1ijJeJ0vsC7yNNzu
   y8YPSOh6RdVLbOB3okOnDE4DHvXpmGgyBbHqQYi6FRtOAUwxyY8x8PAw+
   i+a0aqiKIBazoo9t4VCtD2G4qpIdRktTk/hL7bnTBqcVORmZeOjmPbyOV
   Nr8boVZvrkeSH2/SjD9wIKCH/ENEgPwVBo9hs0i+S3GTcDFkmoUOiUSHR
   Wl0Bk4BQIfpzMv8DtHsr5Zirst3dsupMPo0mUjdcqk9RzEFwGG62ZZogW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="24458023"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="24458023"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 09:10:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="935617216"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="935617216"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2024 09:10:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A70A6A3; Wed, 14 Feb 2024 19:10:48 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/5] serial: 8250_exar: Clear interrupts before registering handler
Date: Wed, 14 Feb 2024 19:09:34 +0200
Message-ID: <20240214171044.3551032-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240214171044.3551032-1-andriy.shevchenko@linux.intel.com>
References: <20240214171044.3551032-1-andriy.shevchenko@linux.intel.com>
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
index 23366f868ae3..32a56ce626b5 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -713,14 +713,14 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
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


