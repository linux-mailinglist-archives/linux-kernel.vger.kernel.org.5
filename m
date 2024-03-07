Return-Path: <linux-kernel+bounces-95265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C902874B81
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4251C2114D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8739112A14D;
	Thu,  7 Mar 2024 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y/Ue+XNx"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689098562A;
	Thu,  7 Mar 2024 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805322; cv=none; b=iknBk4yhL4TKkvFoBE2jqHECS7pL42cdrynOo71EBbKsrG7e5vHkAkiQ2Z5oiTdO7SfNWz8Nmk+TMF6G/tLjoAvaQahDQ5mieqz3KEk5WnzRqY+gsf6DOrY4bPg7IvKagw+fq12YcmOJQ+ivRIMHlT8w/oxWJqAsuOABdX2eliQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805322; c=relaxed/simple;
	bh=DFDQiyzlGF6+kLshWht4zWnnot6KQjotNmJUWDkVAh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DjwZwbisnVFKaG843/Ng9XGTiVqOt03ZE9DzjAdted+thEfWRbFZhToynrMhgyowdK512vdvfZ5fL1mcF73bqOY3wsXu4wFI9AHLOy2fVYN6jxcUUuLUHFwoTv1732cH910ZD2wX2fWBtn2cP7s/Kw2rCO7HKAmyov5qfCFha98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y/Ue+XNx; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 72B7C1C0011;
	Thu,  7 Mar 2024 09:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709805313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/o7zeZi0zs41+v++mktfx9Xs/6T+zXBb880PpMxs3XU=;
	b=Y/Ue+XNxcZlqlJGaFIwGKKSLD8dA0fGKW3q4L8bEf/bQp7WsSccqGHjhMJNJZB4IOuxkxf
	qLLvFkravYeg5ilEedkhHHoWaIZ6UUjabBbkHX/6rR5tktrCPpU1H84u6PLbS6mDE3WMez
	wtSUsgRNFgOUuS7MzC43jX4qrXA1RA5/WIy1IlLk/L8s+/0IfM8IULJeAb+iRwS8Q6hYkx
	u0cIcknTLkwrzVwLGa/cwkC0tZThreVt6NprIV357IKKQrrdZnM+Rf3EHeCJJoWcSgjZPD
	S3YSLdAgluojq2+FGTFdd92LG8yAobqPRnAFBwrzxnqsqDG3VaE+OG3Mj/yitw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Thu, 07 Mar 2024 10:55:06 +0100
Subject: [PATCH v4 5/9] usb: cdns3-ti: pass auxdata from match data to
 of_platform_populate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240307-j7200-usb-suspend-v4-5-5ec7615431f3@bootlin.com>
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

Allow compatible to pick auxdata given to child platform devices.

No compatible exploits this functionality, just yet.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/usb/cdns3/cdns3-ti.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
index f76327566798..29fb24c811b3 100644
--- a/drivers/usb/cdns3/cdns3-ti.c
+++ b/drivers/usb/cdns3/cdns3-ti.c
@@ -62,7 +62,8 @@ struct cdns_ti {
 };
 
 struct cdns_ti_match_data {
-	bool reset_on_resume;
+	bool				reset_on_resume;
+	const struct of_dev_auxdata	*auxdata;
 };
 
 static const int cdns_ti_rate_table[] = {	/* in KHZ */
@@ -95,6 +96,7 @@ static int cdns_ti_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = pdev->dev.of_node;
+	const struct of_dev_auxdata *auxdata = NULL;
 	struct cdns_ti *data;
 	unsigned long rate;
 	int error, i;
@@ -149,7 +151,9 @@ static int cdns_ti_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	error = of_platform_populate(node, NULL, NULL, dev);
+	if (data->match_data)
+		auxdata = data->match_data->auxdata;
+	error = of_platform_populate(node, NULL, auxdata, dev);
 	if (error) {
 		dev_err(dev, "failed to create children: %d\n", error);
 		goto err;

-- 
2.44.0


