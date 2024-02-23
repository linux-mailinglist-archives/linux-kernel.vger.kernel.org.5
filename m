Return-Path: <linux-kernel+bounces-78671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D10B98616F8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71A1AB27392
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B8212AAC0;
	Fri, 23 Feb 2024 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NEzmvm4U"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7126384A47;
	Fri, 23 Feb 2024 16:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704340; cv=none; b=JXfxiVZ2rGHjtAtGMTOn64W1Sk3hYGZV2Bjgc53VY4pt6sYDEjs7f3w4mE92oC+JiIVcm8cOGfohkLVAJfXz62Tyb50llNiIIzBJnhIRAixyqe7DAyrDLfIKKp8WOVBl3btDtqVAeVtJFVYGwwMeeGAfQlCuHUJbIc8DgjANJ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704340; c=relaxed/simple;
	bh=pOwI5GqJccR2V6G6RA9AszwHgBeEwP4jFC1YS6Zf6zk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZBYF79hdPZtvpcl0zASU9qLOhAWuqndNVFltFgf/c84Pp2X2GiIWQoINbnWwnBLYKhZMXCBis9gGUpxZ4bnBgG77D9DgklLcYulzyH0AC0PvYoMk/dwZ3mxu3HjDoVw1xb7WUmvR0hh4rzGf/Z+KZk+zpsSfBg98GedGBy2S+Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NEzmvm4U; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 215831C000C;
	Fri, 23 Feb 2024 16:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708704336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wF2GEFIGDf1EoCX/WDH7UWK4GOrP+0T9MYnwKzq1lNc=;
	b=NEzmvm4U1Qt5t0hcgSEFjjIouzNmvAR3cOFKlNu6MbUu5OjE0Y0X4ZUFs7DDWGon/MJIKN
	I7oOYJ7kqC0SlplEaxb0OWaz3xPegu3mcqr6jLLzUwHb6YY6j+OOOrVF7y7otmDsN0Fx0m
	HUShbNCkwob8+61DMz5BXnH2nuyM9eR3Ag17mHuSpfN9Z7bmx/yfqe5KbfhNBjsu8wgFGI
	anSQFw4RD8Lv8+p3ty3HQSl5HQC3kEHnBmmUzXdoV8xupZnarmXsh5snp4ldezmo9+lwgA
	V2Qmj8DgVA9GCOTP4ctqnPJQqOs2VrhT/QPWuh8/aU5C1D1q3X4JB32KP6hC2Q==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 23 Feb 2024 17:05:31 +0100
Subject: [PATCH v3 7/8] usb: cdns3-ti: add J7200 support with
 reset-on-resume behavior
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240223-j7200-usb-suspend-v3-7-b41c9893a130@bootlin.com>
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

Add ti,j7200-usb compatible. Match data indicates the controller resets
on resume meaning:
 - The cdns3-ti wrapper init sequence must be ran at resume.
 - Tell the cdns3 core that we reset on resume. This silences a xHCI
   warning visible in cases of unexpected resets.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/usb/cdns3/cdns3-ti.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
index 29fb24c811b3..648243a27987 100644
--- a/drivers/usb/cdns3/cdns3-ti.c
+++ b/drivers/usb/cdns3/cdns3-ti.c
@@ -17,6 +17,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
 
+#include "core.h"
+
 /* USB Wrapper register offsets */
 #define USBSS_PID		0x0
 #define	USBSS_W1		0x4
@@ -255,7 +257,25 @@ static const struct dev_pm_ops cdns_ti_pm_ops = {
 	SYSTEM_SLEEP_PM_OPS(cdns_ti_suspend, cdns_ti_resume)
 };
 
+static struct cdns3_platform_data cdns_ti_j7200_pdata = {
+       .quirks = CDNS3_RESET_ON_RESUME,
+};
+
+static const struct of_dev_auxdata cdns_ti_j7200_auxdata[] = {
+       {
+               .compatible = "cdns,usb3",
+               .platform_data = &cdns_ti_j7200_pdata,
+       },
+       {},
+};
+
+static const struct cdns_ti_match_data cdns_ti_j7200_match_data = {
+       .reset_on_resume = true,
+       .auxdata = cdns_ti_j7200_auxdata,
+};
+
 static const struct of_device_id cdns_ti_of_match[] = {
+	{ .compatible = "ti,j7200-usb", .data = &cdns_ti_j7200_match_data, },
 	{ .compatible = "ti,j721e-usb", },
 	{ .compatible = "ti,am64-usb", },
 	{},

-- 
2.43.2


