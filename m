Return-Path: <linux-kernel+bounces-5814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 668D0818FD4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9DB282CD8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D41539854;
	Tue, 19 Dec 2023 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LAyy/qXR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A4439844
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 18:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D4AC433C8;
	Tue, 19 Dec 2023 18:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703010791;
	bh=U9Chc4nw4v5xsa925ipJYoSw+cB0DtWMJa5KKZOXWkE=;
	h=From:To:Cc:Subject:Date:From;
	b=LAyy/qXRYJGzjKTcGPohJxDxilcCrJgtUHcmiRz+dL8aWhjaqjsxiiKJTJ4gpM4iP
	 rlJVvY/a+ZEdlQ7vIPK5YGyUTn/O+jn6QmR0mMhc7ORsSAx8JbHNcwd8wxYs5snE9g
	 Zp7Oyd/uc/tYfDHRjkmeCkLRSEFb8X5HSBYCrOaA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] [ARM] locomo: make locomo_bus_type constant and static
Date: Tue, 19 Dec 2023 19:33:06 +0100
Message-ID: <2023121905-idiom-opossum-1ba3@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Lines: 55
X-Developer-Signature: v=1; a=openpgp-sha256; l=1910; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=U9Chc4nw4v5xsa925ipJYoSw+cB0DtWMJa5KKZOXWkE=; b=owGbwMvMwCRo6H6F97bub03G02pJDKmNDx8W7SkpEpwYqLd0VkJpWEXaZXauoFjmVxpnZS9HL bvY6dfVEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABMpVGJYMF/YJ1aev/m9TeZC q5OvXtzM/d6jz7Cgr9g4gfd/VOa0LSxOGgI1cX+it04HAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Now that the driver core can properly handle constant struct bus_type,
move the locomo_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

It's also never used outside of arch/arm/common/locomo.c so make it
static and don't export it as no one is using it.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/common/locomo.c               | 4 +++-
 arch/arm/include/asm/hardware/locomo.h | 2 --
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index 70480dd9e96d..6d0c9f7268ba 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -68,6 +68,8 @@ struct locomo {
 #endif
 };
 
+static const struct bus_type locomo_bus_type;
+
 struct locomo_dev_info {
 	unsigned long	offset;
 	unsigned long	length;
@@ -842,7 +844,7 @@ static void locomo_bus_remove(struct device *dev)
 		drv->remove(ldev);
 }
 
-struct bus_type locomo_bus_type = {
+static const struct bus_type locomo_bus_type = {
 	.name		= "locomo-bus",
 	.match		= locomo_match,
 	.probe		= locomo_bus_probe,
diff --git a/arch/arm/include/asm/hardware/locomo.h b/arch/arm/include/asm/hardware/locomo.h
index aaaedafef7cc..9fd9ad5d9202 100644
--- a/arch/arm/include/asm/hardware/locomo.h
+++ b/arch/arm/include/asm/hardware/locomo.h
@@ -158,8 +158,6 @@
 #define LOCOMO_LPT_TOH(TOH)	((TOH & 0x7) << 4)
 #define LOCOMO_LPT_TOL(TOL)	((TOL & 0x7))
 
-extern struct bus_type locomo_bus_type;
-
 #define LOCOMO_DEVID_KEYBOARD	0
 #define LOCOMO_DEVID_FRONTLIGHT	1
 #define LOCOMO_DEVID_BACKLIGHT	2
-- 
2.43.0


