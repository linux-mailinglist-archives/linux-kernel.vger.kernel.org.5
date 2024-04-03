Return-Path: <linux-kernel+bounces-129302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA76E896858
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17C601C2302E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1C213F44D;
	Wed,  3 Apr 2024 08:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWv8o1wp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC61C13F425;
	Wed,  3 Apr 2024 08:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131874; cv=none; b=U5bLDp4cAZWyckf5VobunivZfpKWoMrpN+XbecG3hyJFcnkbBJ64L1rHnIZijIhMzV+qb3X9WkeIuObGOICw80iYeQk/RwMgIhF9w9iL9jXXpgmGsO8XPUwqJKWxqWHu/GrK8nOoVWD1ZEs6dMqJTfBaanGMTppEz+hoqyYBBJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131874; c=relaxed/simple;
	bh=76Xr54el70ulr/k/75H8vH6vpKWaADYSBbvRqxqkFes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HXR5mecq3xCzPcjLec/ui1oAOTdPI+po8ZpnBXF9Bkgj2pSpwKJx/xoJuSXPg5fmJLBd6GunRzeqOe03kvKYQxIuxOP6hwwNbZKxMxSWO+aMRh9P6+R7nSrOftMhKyosem5VHfp6AiQcbvX6wSsgswxXIBrq4n/USeGZCuhyoZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWv8o1wp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B06C433C7;
	Wed,  3 Apr 2024 08:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131873;
	bh=76Xr54el70ulr/k/75H8vH6vpKWaADYSBbvRqxqkFes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FWv8o1wpk5CWOhTbZ+We/eBhRTQU2fOMPfrRiTyWHTfl/uKhv1Pgg6IEfoFtigE2G
	 sVwmX8e+2XuUC0TULUzTfrjpk9oAm2+Mer2itkYt+5u5B8Ci2PqAuLJoIQ/D938/yi
	 BtYtN2+p5vaUpLMAlgLQx3aaYs75HPsAs3V0WlcSWPwY1ulxe4iQg0yZv+t5+CtD8Q
	 72F9j2M45Tcoh1eSjGgdUIii9R5KwCHdWOhYKh2pY2yaAsEpsVPJnLldyA7p13BqAU
	 vaCgiYHsZVoWe/nWy5MFTAmx/FpVfMcVlGIuMUi2dzhGn/rm9Kyo2M79jiO5PHn28S
	 N1CPxhmkwHxRQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	John Allen <john.allen@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-crypto@vger.kernel.org
Subject: [PATCH 24/34] crypto: ccp - drop platform ifdef checks
Date: Wed,  3 Apr 2024 10:06:42 +0200
Message-Id: <20240403080702.3509288-25-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403080702.3509288-1-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When both ACPI and OF are disabled, the dev_vdata variable is unused:

drivers/crypto/ccp/sp-platform.c:33:34: error: unused variable 'dev_vdata' [-Werror,-Wunused-const-variable]

This is not a useful configuration, and there is not much point in saving
a few bytes when only one of the two is enabled, so just remove all
these ifdef checks and rely on of_match_node() and acpi_match_device()
returning NULL when these subsystems are disabled.

Fixes: 6c5063434098 ("crypto: ccp - Add ACPI support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/crypto/ccp/sp-platform.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/crypto/ccp/sp-platform.c b/drivers/crypto/ccp/sp-platform.c
index 473301237760..ff6ceb4feee0 100644
--- a/drivers/crypto/ccp/sp-platform.c
+++ b/drivers/crypto/ccp/sp-platform.c
@@ -39,44 +39,38 @@ static const struct sp_dev_vdata dev_vdata[] = {
 	},
 };
 
-#ifdef CONFIG_ACPI
 static const struct acpi_device_id sp_acpi_match[] = {
 	{ "AMDI0C00", (kernel_ulong_t)&dev_vdata[0] },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, sp_acpi_match);
-#endif
 
-#ifdef CONFIG_OF
 static const struct of_device_id sp_of_match[] = {
 	{ .compatible = "amd,ccp-seattle-v1a",
 	  .data = (const void *)&dev_vdata[0] },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sp_of_match);
-#endif
 
 static struct sp_dev_vdata *sp_get_of_version(struct platform_device *pdev)
 {
-#ifdef CONFIG_OF
 	const struct of_device_id *match;
 
 	match = of_match_node(sp_of_match, pdev->dev.of_node);
 	if (match && match->data)
 		return (struct sp_dev_vdata *)match->data;
-#endif
+
 	return NULL;
 }
 
 static struct sp_dev_vdata *sp_get_acpi_version(struct platform_device *pdev)
 {
-#ifdef CONFIG_ACPI
 	const struct acpi_device_id *match;
 
 	match = acpi_match_device(sp_acpi_match, &pdev->dev);
 	if (match && match->driver_data)
 		return (struct sp_dev_vdata *)match->driver_data;
-#endif
+
 	return NULL;
 }
 
@@ -212,12 +206,8 @@ static int sp_platform_resume(struct platform_device *pdev)
 static struct platform_driver sp_platform_driver = {
 	.driver = {
 		.name = "ccp",
-#ifdef CONFIG_ACPI
 		.acpi_match_table = sp_acpi_match,
-#endif
-#ifdef CONFIG_OF
 		.of_match_table = sp_of_match,
-#endif
 	},
 	.probe = sp_platform_probe,
 	.remove_new = sp_platform_remove,
-- 
2.39.2


