Return-Path: <linux-kernel+bounces-84783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1CA86AB7F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4309A1F2193E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA2F36123;
	Wed, 28 Feb 2024 09:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/T/R9hc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6E52E85D;
	Wed, 28 Feb 2024 09:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709113216; cv=none; b=ihmzKP56hAItFLZO+aEyIlTjmJW/yBzwinhdWVHJHL+QnrLOznft7fpauw10bqazWDgBM4DVTBe7eUhVGEI/+DIx5jzcqPumpdVGwyJ+218s5ErmQbKk1c/5BGGs92EgciK4L0g1OsHLydOEgltY9tqqgYORB0vg/tdF1N5BavU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709113216; c=relaxed/simple;
	bh=jwmkIJlXr+YpnOJWmEPMvayj5hIai57OdCRtqOAIick=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QhKGtpRNRGV4epCdosI+gYfcS7/XxMA70D8Zz0H6p7j4XZ2b2i4il16T2RIIVw0i3YwmgmTAQYb69A0KpLjWiBm0lH87qS2aNR9mRBpsT15lHAtg9wDAAxtKGEzUSEsCpRPU+9zgFISN0dadNiUGh9h96Os7R3gaPr5OJNzj1kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/T/R9hc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC507C433C7;
	Wed, 28 Feb 2024 09:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709113215;
	bh=jwmkIJlXr+YpnOJWmEPMvayj5hIai57OdCRtqOAIick=;
	h=From:To:Cc:Subject:Date:From;
	b=J/T/R9hcd0MhwTrjNCvIrve9syFI/xC8GPhi419uWg3fyAfBEsojaZbNOuw89ghgF
	 dGyS9gNNnJQxHokbc9q7N04mqUg02xRSjmtq5Xup1SH11sn/OWQZeRP/BGJTFP+uyd
	 AqiTBjWjPB1xrS4YmsZys/CxeHkkSzrj9z2CxFaZsXXW2jEt9mkDn/yuX/GpwveLqt
	 D6BKQx6PlmAtQnB5KjboEy9IzHhoIMHf+oQhdYOKjHuzpWoSQBa9R5V3coyabk7BWX
	 VEq8pnRX7Jzl78B6X6jhkoB96FzZbarKd2tmyWXljlkmg92z294QHYEBLtt38zlapX
	 mgONNInhdHFww==
From: Arnd Bergmann <arnd@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Szilard Fabian <szfabian@bluemarch.art>,
	Jonathan Woithe <jwoithe@just42.net>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86/fujitsu-laptop: add ACPI_BATTERY dependency
Date: Wed, 28 Feb 2024 10:39:51 +0100
Message-Id: <20240228094010.2254245-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The dependency is required to avoid a link failure after support for
battery hooks was added:

ld.lld: error: undefined symbol: battery_hook_unregister
>>> referenced by fujitsu-laptop.c
>>>               drivers/platform/x86/fujitsu-laptop.o:(acpi_fujitsu_laptop_remove) in archive vmlinux.a

Fixes: 611d56d76dee ("platform/x86/fujitsu-laptop: Add battery charge control support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 6dbd40e2aeda..d9851b79bfe5 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -371,6 +371,7 @@ config FUJITSU_LAPTOP
 	depends on INPUT
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on ACPI_VIDEO || ACPI_VIDEO = n
+	depends on ACPI_BATTERY
 	select INPUT_SPARSEKMAP
 	select NEW_LEDS
 	select LEDS_CLASS
-- 
2.39.2


