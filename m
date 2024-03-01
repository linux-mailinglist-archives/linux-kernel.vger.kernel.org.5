Return-Path: <linux-kernel+bounces-89213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583E286EC18
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870601C21DBD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D875F47C;
	Fri,  1 Mar 2024 22:59:01 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6F25EE9B;
	Fri,  1 Mar 2024 22:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709333941; cv=none; b=VCoRroxSO+V+eM9pIJfQCQYpuK68kIsE4a+X+EPdON6GYksa+3SSkReBrHforWuwlidlloK5NaEU8uJPIaJCYNZgqr0nUxUpRwJUTmZ+SzefWMxlWHBOEvno9eiixLIK+F++xD8oQmpRIOOcfn7Qr3PiruONBI0fEPPz5Yz1d3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709333941; c=relaxed/simple;
	bh=JL8wKNHOdoEnADynpbW3pJQDwz790tyACZpDiAY2J+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PCHAFiyB7u0SWRUhO5ilsORiwf63Vwb7cUc5wiTRFTWIRskEe9cmy8ZYixScOZ64+/xAuth/h68dAjN6w5Ib2rBQ/JqlFjItOYWMn88JlKZQ2xOhDDDh1Stf7Y9Fmn2yBefZhjhT7dNO/e9A1JhTTzwD0kszWFPfTUo4GGwkgvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF543C43399;
	Fri,  1 Mar 2024 22:58:59 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id C970410633E3; Fri,  1 Mar 2024 23:58:56 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 01 Mar 2024 23:58:27 +0100
Subject: [PATCH 2/2] power: supply: core: simplify power_supply_class_init
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-psy-class-cleanup-v1-2-aebe8c4b6b08@collabora.com>
References: <20240301-psy-class-cleanup-v1-0-aebe8c4b6b08@collabora.com>
In-Reply-To: <20240301-psy-class-cleanup-v1-0-aebe8c4b6b08@collabora.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1020;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=JL8wKNHOdoEnADynpbW3pJQDwz790tyACZpDiAY2J+I=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBl4l2wOC2K0zlJ0WXtxRjoKQH6jaqgh2vg7sb+p
 1/KPpzB8dSJAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCZeJdsAAKCRDY7tfzyDv6
 miZDD/98H5jw/LKNW4WYCHdko9enIu7PuopK372YXad3d24M8zGqE+aSnlS6So0ltFyHia7XwWY
 o3bih/n88uDuh4O1Le/a8BkFewDJOeBCWZrYkLd3FmJmWj9jEiuchPzdmAXh9kd6vdZoas4+W3+
 XpRNpooBmYjZmEgb4PIupMGvp8Z0LVc8rTqm3oezwIm5yNObky2fRE59kNl1Z6fh+Ni5IuieFEf
 OoT7ColKRy7aA9KMetWQxIUY7a9n8kQTopu6M2Tlr1yLO7u10t3CqTxv+WOfzelq7a3+08M6LgJ
 emZyNU6R9aKnYFIgoCfnSe2SiNSZcxcgdIUue618bSb2/el3uw58Q8u7+sIe5usDZ94/500QtlO
 z3nVl+fi/B7J5jRP3jPl2146Wne/Ue3cTT7W1WXooA2u6YCoV3m4DebtNG11QCRT5iYAfdH6MsS
 0hCsn+34torvdqlURPcMRLbK0QsDiAB0Yir9fkMlNQL6VSvhayaAcOmWzK+FaYVCdEZIC/eA1GR
 qZAd8/DhMdlCxCPedPar5IF/p0XRNA9YoXgHFQ6ouv+0C9BZW4Yfceo2jQ89BL6UcmZQM0t2jem
 06QANGMtEWDihNFmSCRgR17KvBF6qjku7EdPjLGVZRBvL4fvaN0agIj3MeHS9AAnHCRov5Ucyyx
 ZWRLOOflaclaZdg==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Technically the sysfs attributes should be initialized
before the class is registered, since that will use them.
As a nice side effect this nicely simplifies the code,
since it allows dropping the helper variable.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/power_supply_core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 0eb8a57dda70..4daea6ed8f1d 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1622,15 +1622,8 @@ EXPORT_SYMBOL_GPL(power_supply_get_drvdata);
 
 static int __init power_supply_class_init(void)
 {
-	int err;
-
-	err = class_register(&power_supply_class);
-	if (err)
-		return err;
-
 	power_supply_init_attrs();
-
-	return 0;
+	return class_register(&power_supply_class);
 }
 
 static void __exit power_supply_class_exit(void)

-- 
2.43.0


