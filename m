Return-Path: <linux-kernel+bounces-120068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B74D88D124
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 796ACB25082
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624F813E3E8;
	Tue, 26 Mar 2024 22:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ClUU2fkc"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D260313DDC9;
	Tue, 26 Mar 2024 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492663; cv=none; b=Kh6Kw9iFcrd/JMa1wJ506xfMJqCm4KnUZf5eq2G9p1QIFkI/4XlEBkxiWLjZmz/d4SZm6Qb6Ia+bcc5WpmTqYEFKjjP15b1+XJOhqhzfZbhec7NEgek6iR0DLoK2gGyazuPveIMHnPAA8a8HYaKZpaqKIfJkoHwZZBK250DyaGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492663; c=relaxed/simple;
	bh=EGnGSlcI94Wgrvg3EqCknEs3tLsqXoAebcW8TAysYFU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rh+Rvll/8YDtziuWBzw63ezPXuFJShjMU29F9HjcD/fxv1RzQ9kXRAucLcjxyyUWj2IriFqki5EJXQ+Eg/Ve8716dLaBUv2qOeIBxFs4iF0kZ0REVmiy2OxkBaRTUmbK6k9RbEYaITODL+p+zwxbjSpXkq0fcOezXNbKfozOKrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ClUU2fkc; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QMbWDp092773;
	Tue, 26 Mar 2024 17:37:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711492652;
	bh=RROmykh+GXi1qU7J3euldybQGKdRbR+HJWggHHB28yU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ClUU2fkcDKhV6stl1V3qCZgvZ+fsU/whnXAvmUfquPeXbV63a/JrDilk6G9DVVfpA
	 mQ3mTPvUWZO0vD4qJ5hNsXaer46eBGXSdCOQyrV9ot3v+6CUEKq/Kyvi5EoelD73xu
	 vNyCoG4vf8uE1e1LGSu04EFbnfYsyZZRBqWrG8J4=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QMbWHw106463
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 17:37:32 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 17:37:32 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 17:37:32 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QMbVmZ109669;
	Tue, 26 Mar 2024 17:37:31 -0500
From: Andrew Davis <afd@ti.com>
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 2/4] firmware: ti_sci: Unconditionally register reset handler
Date: Tue, 26 Mar 2024 17:37:28 -0500
Message-ID: <20240326223730.54639-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326223730.54639-1-afd@ti.com>
References: <20240326223730.54639-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

There was once a limitation that there could only be one system
reset handler. Due to that we only would register this handler
when a non-standard device tree property was found, else we left
the default handler in place (usually PSCI). Now that we can
have multiple handlers, and TI-SCI reset is always available
in the firmware, register this handler unconditionally.

This priority is left at the default so higher priority handlers
(like PSCI) are still attempted first.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/firmware/ti_sci.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 9885e1763591b..160968301b1fb 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3299,7 +3299,6 @@ static int ti_sci_probe(struct platform_device *pdev)
 	struct mbox_client *cl;
 	int ret = -EINVAL;
 	int i;
-	int reboot = 0;
 	u32 h_id;
 
 	desc = device_get_match_data(dev);
@@ -3323,8 +3322,6 @@ static int ti_sci_probe(struct platform_device *pdev)
 		}
 	}
 
-	reboot = of_property_read_bool(dev->of_node,
-				       "ti,system-reboot-controller");
 	INIT_LIST_HEAD(&info->node);
 	minfo = &info->minfo;
 
@@ -3395,14 +3392,10 @@ static int ti_sci_probe(struct platform_device *pdev)
 
 	ti_sci_setup_ops(info);
 
-	if (reboot) {
-		ret = devm_register_restart_handler(dev,
-						    tisci_reboot_handler,
-						    info);
-		if (ret) {
-			dev_err(dev, "reboot registration fail(%d)\n", ret);
-			goto out;
-		}
+	ret = devm_register_restart_handler(dev, tisci_reboot_handler, info);
+	if (ret) {
+		dev_err(dev, "reboot registration fail(%d)\n", ret);
+		goto out;
 	}
 
 	dev_info(dev, "ABI: %d.%d (firmware rev 0x%04x '%s')\n",
-- 
2.39.2


