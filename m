Return-Path: <linux-kernel+bounces-33487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB620836A3F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963A82838FF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A0E136653;
	Mon, 22 Jan 2024 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJJKFBy5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AD213664D;
	Mon, 22 Jan 2024 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936475; cv=none; b=fcz7i6jz4RNajPVWS6FF3wJdNjeFJBsswwvijNkGpNm2or4rQXqjivTtJUtSN2v6R3fVyrcw/LUnhhzNJlRE+lXzRZMN4U8+eyrv6ZKwKqyx28foW+4CEf1JuUkAYfse4VMDNQv/riw2SadZaexX1BzUAhtMZl9ljZL5lhEyqNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936475; c=relaxed/simple;
	bh=iixuK5k7tZTGX4UWwRqmbV7O4zWm8JoQ9r2t5AgM3zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHaMZykh7dE/HrbCd3eTbLmhdmqKh1YTpC99zRLTt/3sILkEl6bSeY6Wbeim/7gGtYrVQhNzo6FC0P64xzD00QmyulwRQwFYMpRaayfkwvBnDP+ANu1CQqdwwMtYzbJnsGkI0JGQUM9SPC1GSP9MATm22iNfBtlcEbJ0UIblBg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJJKFBy5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2694C433B1;
	Mon, 22 Jan 2024 15:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936475;
	bh=iixuK5k7tZTGX4UWwRqmbV7O4zWm8JoQ9r2t5AgM3zM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AJJKFBy5EKSkZmyX58giaj5BMCsoS+RTcj6b3I7acNeZ143tSk8Z3HuMsSGBnRQvy
	 DUwMiAhKBx7kEbkU9KlmSX1ZkqpKzBxoS/UcdMsVHlLO9OE4PYl/nBRsiWlE8cJBkX
	 tpo6oE9SULvCFmdpxpECI0DF3s2+pMai3F/HAYnnMy4UT3FwRAIn8+Gi1TMOr6T0xP
	 gsdYAZNdJa3Jjy1S6auBPF9eEvE0QX2TOunlS3qQSA8WEa9DL/EKN1LJDsBP8uwOJb
	 sX8uuqagqdhmmk6JXX+FHbkytCyHfg+iTJUmuXV8Kq0xfjHLXYHa17TS1fuv2rM039
	 E65X7q12zbX+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Werner Fischer <devlists@wefi.net>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 29/35] watchdog: it87_wdt: Keep WDTCTRL bit 3 unmodified for IT8784/IT8786
Date: Mon, 22 Jan 2024 10:12:26 -0500
Message-ID: <20240122151302.995456-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151302.995456-1-sashal@kernel.org>
References: <20240122151302.995456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
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
index bb1122909396..843f9f8e3917 100644
--- a/drivers/watchdog/it87_wdt.c
+++ b/drivers/watchdog/it87_wdt.c
@@ -255,6 +255,7 @@ static struct watchdog_device wdt_dev = {
 static int __init it87_wdt_init(void)
 {
 	u8  chip_rev;
+	u8 ctrl;
 	int rc;
 
 	rc = superio_enter();
@@ -313,7 +314,18 @@ static int __init it87_wdt_init(void)
 
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


