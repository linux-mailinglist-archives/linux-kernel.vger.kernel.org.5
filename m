Return-Path: <linux-kernel+bounces-95267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F21874B85
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49C81F2A119
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CAC128806;
	Thu,  7 Mar 2024 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GVyKiu3m"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C78128396;
	Thu,  7 Mar 2024 09:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805323; cv=none; b=CEeiJWS8j0kZ/Pgse4nB6pMPvxSfVyh0OcjSNT+j0T/BUKLIXlXmFZIm8ta65dKbtrhN5tcAiyS2/q9mHja3As1chlwZK4a3vsOFJqrmqA5zrlNKF92SIPtxJsCP/KVjubirdvkwD67S0ciBFesalQjbKd7M2lBHinvpxFC9guE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805323; c=relaxed/simple;
	bh=0tZdFeijHB9YMUxabiDXE3y6atvPRlg0wA4sm39K8sA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fj3f8b26AKUrMT5HZhiwvMgbcjYfFQ2FUM9w9LOA2k8RbMt0HlxXBcmrtZgnHCvwzwPLXvskcXM/G7JZU7eFxw/55XJOUdh02VlWRisb2v/WMdIgCjey/3L85iF8zYjFT+JXkv03GHAA5x+4HLlnh7l42kq2TsYyHFMhBhweIFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GVyKiu3m; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 44F551C0014;
	Thu,  7 Mar 2024 09:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709805314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SGwpJdmrXnr5kCZ7jekdFRDPw/Wb1kTlGDHTcb2LulM=;
	b=GVyKiu3mOGix73RAAo10YDgwzKGGEwexrved6rLPs2VZBOhJie6KSBxn8ebNTKl+kLGejA
	BXWvO0aJeEsv6ulxFQZkCBcf8kHJ6mq5nydhLme3zyJTliHtOumKpM+T5wMwt/25IKh6Im
	ukjRVrDDrQRxYLXa6swnz+1DOgwNB1AS5TXG0ML6ealSEo+wBTp/1POJQtd8WBucIyMCKC
	f2AftKM/PFvJQCJtv9pF3f4jFJzQEH34YOiIm+ePS8QpNxuXz+cdBULjdS/UUR+pbBCM7O
	ta5VSCFxl+Oka+t1+qZQVCm1yYyMiEjXTuk9orIEI+C3th5QxDjlMUj2/FBijQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Thu, 07 Mar 2024 10:55:07 +0100
Subject: [PATCH v4 6/9] usb: cdns3: add quirk to platform data for
 reset-on-resume
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240307-j7200-usb-suspend-v4-6-5ec7615431f3@bootlin.com>
References: <20240307-j7200-usb-suspend-v4-0-5ec7615431f3@bootlin.com>
In-Reply-To: <20240307-j7200-usb-suspend-v4-0-5ec7615431f3@bootlin.com>
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
2.44.0


