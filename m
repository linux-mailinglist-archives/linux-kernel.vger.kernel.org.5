Return-Path: <linux-kernel+bounces-129292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A08A896848
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BD011C203D8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19081129A7D;
	Wed,  3 Apr 2024 08:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEQ6K0nu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAB284FD3;
	Wed,  3 Apr 2024 08:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131790; cv=none; b=NVYh7StEqjNwYsKP0TNXJM30g0OGXyKrRD0QeAMVlxl5CCk6Aw87IODcJK9r6HYx5MyeLqV/T71Ns9FugOTLDQGQfPzliwXCYg7Dy7a3bf9Ordtmma1WcuYh8BrhwLcEeh968vNWnFh3m3pz2DmgYepjRNciSnScWIH1itwnV6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131790; c=relaxed/simple;
	bh=N9B1/h+N2wjlrIeRE4YeleUmB2UVWiJzUOQ8atEllXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=plnsXOlJru8BH6kNsRuiZvPTeAbQiTxM8f63kuWgA7wfBg7qpoi6bASBsiJdg+nuZhW6pNBx5/lEy22l25bwUNN8Qy9y1G4eT/YGhj7z7QxoW7lvoNUZDTwr2We1hVe+E1EJsLO3UYaC5RVyuto651YuSl7ujj6ftbZoyZ0hpJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEQ6K0nu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CCEC433F1;
	Wed,  3 Apr 2024 08:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131789;
	bh=N9B1/h+N2wjlrIeRE4YeleUmB2UVWiJzUOQ8atEllXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vEQ6K0nuV/TLSHTv+lYRcs9uzwwB7Vyiys8pqRAkURJ9CAAZUj11k4ze3eDZWJtrD
	 jBC7aB5dxl8mNgNiB8Pl/lYX86x7PL4LDi1fJznmbt0yv055Nno54zfIctKCbiJPkR
	 3r8tWetmuYV1lEl3GGi3dVlPIAh0lCt7h+wY+gMwdI+k9/PHa5OhHWiVj/7X0GdvfE
	 1VB0IIuSE8DIhV/npVSr4uTJCuGfbnlyf+0RWEPyR7o93bducZo0/5Vk0UJ9ZxgcsQ
	 uE9E79RpRN6J5G1jHrKUNpfTuq8FPC6cE9fwh4BJXbPsu5lPjiAWk3Ceq3g8SEET0T
	 NADHAJOAl8EbQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-leds@vger.kernel.org
Subject: [PATCH 15/34] leds: apu: remove duplicate DMI lookup data
Date: Wed,  3 Apr 2024 10:06:33 +0200
Message-Id: <20240403080702.3509288-16-arnd@kernel.org>
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

Building with W=1 shows a warning about an unused dmi_system_id table:

drivers/leds/leds-apu.c:85:35: error: 'apu_led_dmi_table' defined but not used [-Werror=unused-const-variable=]
   85 | static const struct dmi_system_id apu_led_dmi_table[] __initconst = {

Since the current version doesn't even do anything about the different
implementations but only checks the type of system, just drop the
custom lookup logic and call dmi_check_system() using the table itself.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/leds/leds-apu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/leds/leds-apu.c b/drivers/leds/leds-apu.c
index c409b80c236d..1c116aaa9b6e 100644
--- a/drivers/leds/leds-apu.c
+++ b/drivers/leds/leds-apu.c
@@ -181,8 +181,7 @@ static int __init apu_led_init(void)
 	struct platform_device *pdev;
 	int err;
 
-	if (!(dmi_match(DMI_SYS_VENDOR, "PC Engines") &&
-	      (dmi_match(DMI_PRODUCT_NAME, "APU") || dmi_match(DMI_PRODUCT_NAME, "apu1")))) {
+	if (!dmi_check_system(apu_led_dmi_table)) {
 		pr_err("No PC Engines APUv1 board detected. For APUv2,3 support, enable CONFIG_PCENGINES_APU2\n");
 		return -ENODEV;
 	}
-- 
2.39.2


