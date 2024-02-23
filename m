Return-Path: <linux-kernel+bounces-78669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C94F8616F0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF461F262B5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B88127B7E;
	Fri, 23 Feb 2024 16:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mLuKiL/Y"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051CA84FB1;
	Fri, 23 Feb 2024 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704339; cv=none; b=hz56/IvNGiOdk3rHrCxkarANnTFxQzQZBRCOkSby1HgUaWiAQ/Ic5QcK7/k0qQuhvywUED4Gi+1fs/OvRguLIujuWWkAoLO38oLMKm7lrLH/XO9pvrKTC1td3GwI16QT7xwyQAC0rvnCzCduKk5jVUw+HD8aRi4gbb83Q5bQwG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704339; c=relaxed/simple;
	bh=rpv4qi5Z6eTUa2IMqz85N1MvbMDX7qjpFaTwD8sTp3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RkfudhE4mnNutvdnsZ82D5ihK9CgG0CDlSlCH09y8qJaaTXIbgtZv/olbEUfoZokBkQedweW7fwOQMhAl5IceXV8wnP8ykHVYk01xyzvVzt0xHbDEcXmt+Sk5gXGbUpt99l/inIuyxSmeWX+OdrxROGg7SQLbbjqsd5wKxHUuZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mLuKiL/Y; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 820951C0002;
	Fri, 23 Feb 2024 16:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708704335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gQ4y/VEIeiumEnjB4J+Uqc13LinCxq5gzHE+LkRNKeM=;
	b=mLuKiL/YjpInWAvicL9rw00uFm5cJOy0efmORr8oL2qc7i+CLbyBhQtE8gjJ0hsZDsAUhc
	aQL1K+k/N+D1RNfQbCsstk+mXxrRlmBdtSSL6oX+Mq3YKU03m6MCGeGLVBh0/DuETcHxYd
	2x/y9k1XwUBNp/OOKksMsiMc22SubR0orf6rEN2FNv1+aU5XPQFUFhDOG5aYaqs0TPM2+b
	0yufs8EcgQ2wyo9kPAUyetqeYnxhKUUxyH0DtCnvHrW8yS7oaIEVYN+O8GFeIdyayp0lKS
	qZRUS3607Gkw3hSqhYTjWvtc5JgQ+d1PucmK1lQQTHSU8ZpCOq7mK8iz6Jn5jw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 23 Feb 2024 17:05:29 +0100
Subject: [PATCH v3 5/8] usb: cdns3-ti: pass auxdata from match data to
 of_platform_populate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240223-j7200-usb-suspend-v3-5-b41c9893a130@bootlin.com>
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
2.43.2


