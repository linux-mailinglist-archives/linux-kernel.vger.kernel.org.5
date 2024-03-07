Return-Path: <linux-kernel+bounces-95266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9F2874B82
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 068EBB2158D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818A112A149;
	Thu,  7 Mar 2024 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eDt6wKeW"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A42384FC8;
	Thu,  7 Mar 2024 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805321; cv=none; b=GIV7M0B6V4vIPDo+MlbKPWnEwLrZ6XxEO6KaG+AzxUVqo8cIHFQkSM+vRhj56vQuDtQPYrlGhR5Fmp7SpX++rkzf3kvIAEakAqHQITIBdezCANKG0XzPLqFZNH+WBYogdoDrNOLeiXtaPC2xhZ6wLnBpI9cTMiL9Rm54T1VoKrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805321; c=relaxed/simple;
	bh=ywTxIisOOTpj+HDN2NsOLT9qLjcBWovcybVHSKaAnsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lVpa4cShoaSOQPILw+z8iWi/1PnFhRuW1Vpyh4snxwp9rkOysW8jtHYKlBWFnxzo5dVSIg4C3UZJyHiTtRQb71hvKVzeOhzOOY329g/Z/FwGebWIQ+mgKN4JLigGLjxqbe9peKzEptkjtiFU4EFmKJRGOve3faHSKmmGucNWLUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eDt6wKeW; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A77021C000C;
	Thu,  7 Mar 2024 09:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709805312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ORK3ooFzTv7MrS/tadWslkKnebORiux/zlJ4WhF6LKM=;
	b=eDt6wKeW0kg+C/fqGb1QlxB5PIOaEmhPkzdXT1ncVRdX9OLvPmnke2BQSNI4Ll+kWP3Tt0
	RDQvSJO6++eZVDNwgVvncNk2Wt7HjxvOx3FiANhP95MYHAjx17LNeNtVUFdlGnhWziCrfw
	IpET2iwG6JPfM6F/i51B+xlKMOZWIGoDB7aZGWZDcGxkDf3d4uzkn1sADVACcvuIvUB7S5
	pwl9f6lwlwMCP+CKOPA04stLPE6t82LkB5QLIJsnqKjZ/tV6byty9Pc+r7K0c6K8Ji+Uun
	+Rpz3sz/4Zi6LtXUogCEAO5iA+nRtefKXrLMDzTt6iUwnmVO4CXuDUujRT02ag==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Thu, 07 Mar 2024 10:55:05 +0100
Subject: [PATCH v4 4/9] usb: cdns3-ti: support reset-on-resume behavior
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240307-j7200-usb-suspend-v4-4-5ec7615431f3@bootlin.com>
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
2.44.0


