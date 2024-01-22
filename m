Return-Path: <linux-kernel+bounces-33442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2293A8369B9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD73F1F24250
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1005F12AAC5;
	Mon, 22 Jan 2024 15:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZatEiKc2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5176612A177;
	Mon, 22 Jan 2024 15:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936309; cv=none; b=SNwwE6R5N6B5No4/CTtHycpLo1mN+aaIKnMNItHiqWnLHoKTd95KXVhLp2piYxvkbPFmAvsrCqK10nEqj1z6YdGn7BrjuSFHFQbykRJRB59ZNWDmulAMSXEPyp7DQv36ewWks/5vvliQqowxBYDK2+DKkp25zgJkC2T2yNGT55U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936309; c=relaxed/simple;
	bh=iixuK5k7tZTGX4UWwRqmbV7O4zWm8JoQ9r2t5AgM3zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MeuG5/0Y79HfbLf1PKrJ9zdiTMHrsP/RM/2nEUtAwQtVsuLct/oEUbg+FZCiE7k7mXYO0A/fHEdxf4mSyWC1+q79qu4FEPRCabhHTTpwDcKqBpPzU0cm6JL3pebgkD7vkDgitzGrZm8xDe9qTR42ZdM7FkVejLNSoyT4T5OMRSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZatEiKc2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A074C433F1;
	Mon, 22 Jan 2024 15:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936309;
	bh=iixuK5k7tZTGX4UWwRqmbV7O4zWm8JoQ9r2t5AgM3zM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZatEiKc26VBMCDa9SSw1nFs0vwBEfHlzEbKXr47LCgWEYvDCterx3u4cBeoBlrAkh
	 9tEXMHcM9nanI5Z216ZEFBYhp6gtbFkeJ9LOA5E2kOXVJ8+/odp49tNfqEEpUFOZ+E
	 lcZ98WBPtm0oDb5zDk/vliij+hGSHXQsYJwQscPQkS+k6xyPDIIfjR4upK+FEAU/f2
	 eu4c4KAqY9TUc/0yWcKrOeYlxii/YgkbTkr8Oq/nRQ/g2w3cq568itdcE6nhoe7ROu
	 VQbW+GPSuVU/I460dFtFR1i/+xHEHmXTwqjPTIVICTu0LPhmTetVLIxC4Mrx9lrRvU
	 QXCOCbBwDZCcQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Werner Fischer <devlists@wefi.net>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 41/53] watchdog: it87_wdt: Keep WDTCTRL bit 3 unmodified for IT8784/IT8786
Date: Mon, 22 Jan 2024 10:08:42 -0500
Message-ID: <20240122150949.994249-41-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150949.994249-1-sashal@kernel.org>
References: <20240122150949.994249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
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


