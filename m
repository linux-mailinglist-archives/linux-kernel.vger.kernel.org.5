Return-Path: <linux-kernel+bounces-33520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FBE836BD3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7530BB26B1A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEE456466;
	Mon, 22 Jan 2024 15:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpF/EgAK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDA014462E;
	Mon, 22 Jan 2024 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936588; cv=none; b=sTA2K2JPMUm+e2vayryb4a7zZGLlyEeHktBbwqNkzirYlwjbT4xPIy6PVKygYGH3qtHY3Zw+WsaE2rBBY77IgXAf8ln+EKcnY76UivNyEC3N4gLHkZdHgaY+lO0wYPF2s8VpxYk58N6TWaPr+L+yczX9mYTW4TeE8x0Aac8kmlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936588; c=relaxed/simple;
	bh=dpF652h/RhEB/QU5aKRU+m7DwyUEfrdiM/kueyndIjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etKZy1i9zEsOLAa0caPSBwgTa7bOmkkrVvE+n1Y4b4MMusFUUooWdYDxnQ/3u7JcYrbb3VoSI242y0WCLwRo8xKB3dESB5qbVyWpkSQY+mmtMhDzWNMGsbEU0CyKP8jc/q+7KlWyX+XK0qSEaurK9/qE72/C89PvUta2dJQamS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpF/EgAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8034C43601;
	Mon, 22 Jan 2024 15:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936587;
	bh=dpF652h/RhEB/QU5aKRU+m7DwyUEfrdiM/kueyndIjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WpF/EgAKOyyQzJ+nP8Vy09QkKNKa/nSMYvbGu5sSeOjQ4OD+qsQOTkLNBipu6odfp
	 kwGjuPxq4wXAdOtD/ZXFOFFjEVWJBhi/T44Kxq0sShUUSrYhX5zrKdcE7W9Wl/dpnp
	 QknPqFEbeYOh8/qanKw4wRmUq38D4zbNX8PJrn8BqF8W0jEfXFvLlbIMwtOsnvQ5gW
	 LxmCWLcBoPjqcD/gINuq/gqZHkHZhWLch2J7AqBSjipI358/W5LGtH1Lg8spAIFZeJ
	 opmmruDCKjo5FFZqEXMv+PYyXCv/wJ9NborxkuqKmIsNH3ZifZCPxg5MAqrv54/TRP
	 /LV0wBIZaWydg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Werner Fischer <devlists@wefi.net>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 25/28] watchdog: it87_wdt: Keep WDTCTRL bit 3 unmodified for IT8784/IT8786
Date: Mon, 22 Jan 2024 10:14:51 -0500
Message-ID: <20240122151521.996443-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151521.996443-1-sashal@kernel.org>
References: <20240122151521.996443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
Content-Transfer-Encoding: 8bit

From: Werner Fischer <devlists@wefi.net>

[ Upstream commit d12971849d71781c1e4ffd1117d4878ce233d319 ]

WDTCTRL bit 3 sets the mode choice for the clock input of IT8784/IT8786.
Some motherboards require this bit to be set to 1 (= PCICLK mode),
otherwise the watchdog functionality gets broken. The BIOS of those
motherboards sets WDTCTRL bit 3 already to 1.

Instead of setting all bits of WDTCTRL to 0 by writing 0x00 to it, keep
bit 3 of it unchanged for IT8784/IT8786 chips. In this way, bit 3 keeps
the status as set by the BIOS of the motherboard.

Watchdog tests have been successful with this patch with the following
systems:
  IT8784: Thomas-Krenn LES plus v2 (YANLING YL-KBRL2 V2)
  IT8786: Thomas-Krenn LES plus v3 (YANLING YL-CLU L2)
  IT8786: Thomas-Krenn LES network 6L v2 (YANLING YL-CLU6L)

Link: https://lore.kernel.org/all/140b264d-341f-465b-8715-dacfe84b3f71@roeck-us.net/

Signed-off-by: Werner Fischer <devlists@wefi.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20231213094525.11849-4-devlists@wefi.net
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/it87_wdt.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/it87_wdt.c b/drivers/watchdog/it87_wdt.c
index 2b4831842162..6340ca058f89 100644
--- a/drivers/watchdog/it87_wdt.c
+++ b/drivers/watchdog/it87_wdt.c
@@ -263,6 +263,7 @@ static struct watchdog_device wdt_dev = {
 static int __init it87_wdt_init(void)
 {
 	u8  chip_rev;
+	u8 ctrl;
 	int rc;
 
 	rc = superio_enter();
@@ -321,7 +322,18 @@ static int __init it87_wdt_init(void)
 
 	superio_select(GPIO);
 	superio_outb(WDT_TOV1, WDTCFG);
-	superio_outb(0x00, WDTCTRL);
+
+	switch (chip_type) {
+	case IT8784_ID:
+	case IT8786_ID:
+		ctrl = superio_inb(WDTCTRL);
+		ctrl &= 0x08;
+		superio_outb(ctrl, WDTCTRL);
+		break;
+	default:
+		superio_outb(0x00, WDTCTRL);
+	}
+
 	superio_exit();
 
 	if (timeout < 1 || timeout > max_units * 60) {
-- 
2.43.0


