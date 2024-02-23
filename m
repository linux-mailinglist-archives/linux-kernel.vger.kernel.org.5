Return-Path: <linux-kernel+bounces-78670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9484F8616F4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35FD4B2718F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA9A128386;
	Fri, 23 Feb 2024 16:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CbYTeVT1"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A678528C;
	Fri, 23 Feb 2024 16:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704339; cv=none; b=ZObeik9mcIHBjRo8UMzlrOJpHoZYQdgnCwrrHYCfJ/Fy7cIp8bq8cm8a1Y4xfxOBL32YJq4gXmwzMGmqjZ1lCezJTGYqVZRWZRHqOCE/m9vHafeiUNuYmPPdDwVbzCENb2GirSlDIqI5QVPI6sfiBXaCjNEkAIWqSY/C8IuhRWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704339; c=relaxed/simple;
	bh=bFDA1LotbYhuGH+XHfjRA2gzFAO3dmkWnhvDgj5Uwl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UmQTP0xaRpZF5wtSDCCDkIe85yO0mLAmyC/SlZKE0daAgI9J6+F1ELSyDYqPRPcKGbRIQ84dwXBdcq8I9vbfHckjePTq0mEqI3y0GFBPdH/cRFBAdmNDXUHcwKa2jI53mqu7Brwk7IW1nurtwDR/2pzfdm8Ez4JBL7pa/6JbkoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CbYTeVT1; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 542621C0009;
	Fri, 23 Feb 2024 16:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708704336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=niMPY3vxyYJLUrRJjUWlI9ZbKbPa7LOQCtP7P5fEvVA=;
	b=CbYTeVT1n4jzdpnFH9hgwWoam5OME+Lgp6+zcANJCgji931QgArC204kIdPKTiWfmTMYOq
	QMf/i9pOg4wRb5xEx3KOlcRaTUjd5ikZvEz1ohjrfky6plUOkYG0FNNN/T9R/BbDCedvqW
	o4EBWRNCNqcCaeASWWpfi/b9m3yUESL/GE04dD83N40PUyL9Z2pkRNo8R4Q4sKb+Nj/h1v
	zFIZyPDbBdOpaQx8Zs8ciIn9o+dE1fZnHxhhBQspkwUEMaiCZ9k/8kLxMfIpBOE9s5G+rL
	CiF4MHfz2XyLyUKrQ7F+d0Kd097nOjAk/Voqs6YXrN58oXTCjA4YKituAIx2tQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 23 Feb 2024 17:05:30 +0100
Subject: [PATCH v3 6/8] usb: cdns3: add quirk to platform data for
 reset-on-resume
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240223-j7200-usb-suspend-v3-6-b41c9893a130@bootlin.com>
References: <20240223-j7200-usb-suspend-v3-0-b41c9893a130@bootlin.com>
In-Reply-To: <20240223-j7200-usb-suspend-v3-0-b41c9893a130@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Roger Quadros <rogerq@kernel.org>, 
 Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>, 
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Kevin Hilman <khilman@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

The cdns3 host role does not care about reset-on-resume. xHCI however
reconfigures itself in silence rather than printing a warning about a
resume error. Related warning example:

  [   16.017462] xhci-hcd xhci-hcd.1.auto: xHC error in resume, USBSTS 0x401, Reinit

Allow passing a CDNS3_RESET_ON_RESUME quirk flag from cdns3 pdata down
to xHCI pdata. The goal is to allow signaling about reset-on-resume
behavior from platform wrapper drivers.

When used, remote wakeup is not expected to work.

Acked-by: Peter Chen <peter.chen@kernel.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/usb/cdns3/core.h | 1 +
 drivers/usb/cdns3/host.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index 81a9c9d6be08..7487067ba23f 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -44,6 +44,7 @@ struct cdns3_platform_data {
 			bool suspend, bool wakeup);
 	unsigned long quirks;
 #define CDNS3_DEFAULT_PM_RUNTIME_ALLOW	BIT(0)
+#define CDNS3_RESET_ON_RESUME		BIT(1)
 };
 
 /**
diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
index 6164fc4c96a4..28c4d1deb231 100644
--- a/drivers/usb/cdns3/host.c
+++ b/drivers/usb/cdns3/host.c
@@ -91,6 +91,9 @@ static int __cdns_host_init(struct cdns *cdns)
 	if (cdns->pdata && (cdns->pdata->quirks & CDNS3_DEFAULT_PM_RUNTIME_ALLOW))
 		cdns->xhci_plat_data->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
 
+	if (cdns->pdata && (cdns->pdata->quirks & CDNS3_RESET_ON_RESUME))
+		cdns->xhci_plat_data->quirks |= XHCI_RESET_ON_RESUME;
+
 	ret = platform_device_add_data(xhci, cdns->xhci_plat_data,
 			sizeof(struct xhci_plat_priv));
 	if (ret)

-- 
2.43.2


