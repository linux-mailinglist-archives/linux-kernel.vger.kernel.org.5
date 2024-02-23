Return-Path: <linux-kernel+bounces-78668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D4C8616E8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296D91C25E95
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301FE126F3E;
	Fri, 23 Feb 2024 16:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cOD7OspL"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFEC84A3B;
	Fri, 23 Feb 2024 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704338; cv=none; b=Mq8OGpmUE7sVIDMYJmjg1OjeWhu9xAoy+ldrrqxXklFmKj6Ug2SDsHfTh7boKXW7+qIY0ygHZ9xlYeEgW2rGed4yZfI6ysWwywEd1bgoxpaiUMDpoO6FEiTem0sYmuGmCXc/RHrRQbhUhx6Gl5kaR+0jwYsJtx7SjEtOHbve2U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704338; c=relaxed/simple;
	bh=97EOv05Zvt8CODTX+l/7VHsmXG1xRa8W1GdqMMOu4S4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R7c8hIRz6IV14Hn21Mu2Bg/vj/7swX/hBhFrslifUHtXM5MrdrbEZQTUuUo3B9SQBLCIhzkwiwRmDrqo0J9WGmJuRVtipkfvjXhexEARqXXaRnhJVW4+oRLOTQr9kkRJIvbmjxLZxUeq2XFcyWkt35U2inqHBEIajCITB0eUxmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cOD7OspL; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B24741C0008;
	Fri, 23 Feb 2024 16:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708704334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9FINWLp/w0HN6A+6t4rg5b6XzSr+dwLhUgwTrZyKrbg=;
	b=cOD7OspLvGU9jVADF5Hs8xu3HGeAENLLkI5Ccu/rnM7Nb6QAN993aq6F6blcocec/8zYOU
	kt1fGZgX3RevRgRzg0stoXbRmz/b7rTLu+uNiqGkX5jIrPy9HYWZFdm7TmqdGiwLqv527R
	C9SQ4kyCbS5k5Fk04BCbRQCa5S3lUF5sbzzT8sbVDP11szXnSuq6OKmHVybNDt3fa77CSj
	zYPTB8ZXxt2friE/EDQ+gAx7+JAwDLtxOO8YHo8RtqqFGy665GLQgcWqxQhnO+h19JoxX3
	Ep6/7ylAX6DHDXwMBPHUlFp1EB3h+ETaxlQQ0SLC0lqFyLtplZ6A1RwLXBFlVA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 23 Feb 2024 17:05:28 +0100
Subject: [PATCH v3 4/8] usb: cdns3-ti: support reset-on-resume behavior
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240223-j7200-usb-suspend-v3-4-b41c9893a130@bootlin.com>
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

Add match data support, with one boolean to indicate whether the
hardware resets after a system-wide suspend. If hardware resets, we
force execute ->runtime_resume() at system-wide resume to run the
hardware init sequence.

No compatible exploits this functionality, just yet.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/usb/cdns3/cdns3-ti.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
index 4c8a557e6a6f..f76327566798 100644
--- a/drivers/usb/cdns3/cdns3-ti.c
+++ b/drivers/usb/cdns3/cdns3-ti.c
@@ -57,9 +57,14 @@ struct cdns_ti {
 	unsigned vbus_divider:1;
 	struct clk *usb2_refclk;
 	struct clk *lpm_clk;
+	const struct cdns_ti_match_data *match_data;
 	int usb2_refclk_rate_code;
 };
 
+struct cdns_ti_match_data {
+	bool reset_on_resume;
+};
+
 static const int cdns_ti_rate_table[] = {	/* in KHZ */
 	9600,
 	10000,
@@ -101,6 +106,7 @@ static int cdns_ti_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, data);
 
 	data->dev = dev;
+	data->match_data = device_get_match_data(dev);
 
 	data->usbss = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->usbss)) {
@@ -220,8 +226,29 @@ static int cdns_ti_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static int cdns_ti_suspend(struct device *dev)
+{
+	struct cdns_ti *data = dev_get_drvdata(dev);
+
+	if (data->match_data && data->match_data->reset_on_resume)
+		return pm_runtime_force_suspend(dev);
+	else
+		return 0;
+}
+
+static int cdns_ti_resume(struct device *dev)
+{
+	struct cdns_ti *data = dev_get_drvdata(dev);
+
+	if (data->match_data && data->match_data->reset_on_resume)
+		return pm_runtime_force_resume(dev);
+	else
+		return 0;
+}
+
 static const struct dev_pm_ops cdns_ti_pm_ops = {
 	RUNTIME_PM_OPS(NULL, cdns_ti_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(cdns_ti_suspend, cdns_ti_resume)
 };
 
 static const struct of_device_id cdns_ti_of_match[] = {

-- 
2.43.2


