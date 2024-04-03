Return-Path: <linux-kernel+bounces-129307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C979C89685F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02DE01C25C9B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAAC131E43;
	Wed,  3 Apr 2024 08:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLElWixn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5F26FB80;
	Wed,  3 Apr 2024 08:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131910; cv=none; b=jPUUd16TyBqAPwi8LQPGqna8DBVYatdKW2q9/WmS8c4aNO7FjnBuKHf3KhMVJ5enmzwgghkKvJEInitUxFi9sLeqpsxi/VlvOqRRrWu8MVz1fv5yjOq9AVWmhvjHhCTfjEvUBgaweqrDSNEXlMccXlZYUEJ1v8WYfYsrmD47gfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131910; c=relaxed/simple;
	bh=yJ2PAYn/BqgcesEAALoWnwKCP+9vQcY4vqPA3T6h0Fw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VQzzWP7DqWM8ErEg4h9xB9ZFX/p1mNq+xsH2dOBUiAu+bnP6HUeF4v9aPHQN2WwNipk0RoBye8eUAgGnWRWJfgE7FF4sWfEvITCMBGBSXbF8mvDECl/IsJQYiSq+DXtLlPePsVzDDhyx1gw+c/eVRCBJRJGQBqlrNZ9j5FLf0nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLElWixn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBC2C433C7;
	Wed,  3 Apr 2024 08:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131910;
	bh=yJ2PAYn/BqgcesEAALoWnwKCP+9vQcY4vqPA3T6h0Fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kLElWixnuR6/r1TXlNW/C+kLhE4L3gwqjZqwBNB1iRvPKzM2ER7g+4niBeEOANZPJ
	 lmmB7HNzp9Le5vlirfPPW7CRaTNmoWBc1263uW1C00fKh1e6g5UIFWWJIRVcPsnC2o
	 kI7IXPUJ4BjGKD9hgARGtjLuW7Lzqf6UWsHz17AoMXRJUwaee993g73UWXtQ7fyWKM
	 hQs4LlHUuM1bhfbn9Y7YibuU+N8vvA+aLy7bx/pjP1pO/IUIGiMtdkXWCnC7/LKOTk
	 qiDxN3Gd2qWratpGIxHsSKjgZilvv8E3adxlwRmqq5yyZgcmiNeszjJCpV9oGqb65j
	 N4yILxOWBTbBA==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH 28/34] net: xgbe: remove extraneous #ifdef checks
Date: Wed,  3 Apr 2024 10:06:46 +0200
Message-Id: <20240403080702.3509288-29-arnd@kernel.org>
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

When both ACPI and OF are disabled, xgbe_v1 is unused and
causes a W=1 warning:

drivers/net/ethernet/amd/xgbe/xgbe-platform.c:533:39: error: unused variable 'xgbe_v1' [-Werror,-Wunused-const-variable]
static const struct xgbe_version_data xgbe_v1 = {

There is no real point in trying to save a few bytes for the match
tables, so just make them always visible.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/amd/xgbe/xgbe-platform.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-platform.c b/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
index 9131020d06af..7912b3b45148 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
@@ -538,7 +538,6 @@ static const struct xgbe_version_data xgbe_v1 = {
 	.tx_tstamp_workaround		= 1,
 };
 
-#ifdef CONFIG_ACPI
 static const struct acpi_device_id xgbe_acpi_match[] = {
 	{ .id = "AMDI8001",
 	  .driver_data = (kernel_ulong_t)&xgbe_v1 },
@@ -546,9 +545,7 @@ static const struct acpi_device_id xgbe_acpi_match[] = {
 };
 
 MODULE_DEVICE_TABLE(acpi, xgbe_acpi_match);
-#endif
 
-#ifdef CONFIG_OF
 static const struct of_device_id xgbe_of_match[] = {
 	{ .compatible = "amd,xgbe-seattle-v1a",
 	  .data = &xgbe_v1 },
@@ -556,7 +553,6 @@ static const struct of_device_id xgbe_of_match[] = {
 };
 
 MODULE_DEVICE_TABLE(of, xgbe_of_match);
-#endif
 
 static SIMPLE_DEV_PM_OPS(xgbe_platform_pm_ops,
 			 xgbe_platform_suspend, xgbe_platform_resume);
@@ -564,12 +560,8 @@ static SIMPLE_DEV_PM_OPS(xgbe_platform_pm_ops,
 static struct platform_driver xgbe_driver = {
 	.driver = {
 		.name = XGBE_DRV_NAME,
-#ifdef CONFIG_ACPI
 		.acpi_match_table = xgbe_acpi_match,
-#endif
-#ifdef CONFIG_OF
 		.of_match_table = xgbe_of_match,
-#endif
 		.pm = &xgbe_platform_pm_ops,
 	},
 	.probe = xgbe_platform_probe,
-- 
2.39.2


