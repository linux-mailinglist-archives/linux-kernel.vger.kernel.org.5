Return-Path: <linux-kernel+bounces-84167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D763486A34A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47A031F215E3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF71658AA9;
	Tue, 27 Feb 2024 23:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X8ng9Z2P"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4939E56468;
	Tue, 27 Feb 2024 23:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075104; cv=none; b=aF/EKIZvR9abLyI4JXkgqUGOoCPUmoMK180gj157SjuBP7Ur3LwcbD3w4o5gTPhUYKeo5E98giP51xKRszPEHtD51ZO0eLemeopb6IrrU7a8P3ggtQHIlDuVFGVApFUHaBbopbqDnXCpEkB4+6Er5opOVnD+WokOlUzzmww9Tbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075104; c=relaxed/simple;
	bh=rq6RFPSWoMlRYMCpq0Sb4yHcqI8t099LkX3OT8uPleM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ptAxDfy0Bi3FfLoZrfVCut6qmibGTQefdCBiGx+cxevcXuHjT4rbi4MK7n6ZbuWMUWl5OrtRuHW4kXseQ+6MNY3Xyp6IaIIzqq0isOvbww9Ek/Hr/ozs2rRMHr7LxXE+5OkDMzd/Ov3qo9P2pkjSqKg2CnStv02EeU5ot+A5sM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X8ng9Z2P; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2261C60003;
	Tue, 27 Feb 2024 23:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709075100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kGY1Lhw9NrTAfEs+9MBkqd4BWCrhYqYXS/EilsGRZFU=;
	b=X8ng9Z2PXSiRtWBJu3rmw9tN7ajybSxGOOxiGFKJrcTp9tFB0dslWMag554sah18BtE2I4
	7FvI8b6bJ//1qjf2Xx62jcJ+h2k1n5fLHR2KcgBAQjLSoNx64SFXm4RrGfpYgtnNR7hDLF
	b08qN1w1bKa1zG09rQmQNF2vZ8jW5XGi8yDOUfGoBLT7zJ3inqEclrELcUNUO+9eFcaeUv
	uHN6ynsTtCHvpUckWA2T0QVRvCczarC02hpg8cyo9yzVoSSmb762PLzeS7bxKEM6ANPylE
	UYI7OZsqFUc2aMqvILDVT9iao0vvsQEncl7Bpe/6tt1sbSQUal1kL0xEeagPJQ==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] rtc: ds1511: remove partial alarm support
Date: Wed, 28 Feb 2024 00:04:24 +0100
Message-ID: <20240227230431.1837717-9-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227230431.1837717-1-alexandre.belloni@bootlin.com>
References: <20240227230431.1837717-1-alexandre.belloni@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexandre.belloni@bootlin.com

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

The RTC core will always provide an alarm with all its members set, it is
not necessary to support partial alarms.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1511.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
index c81f464e6a50..d5d59a948c59 100644
--- a/drivers/rtc/rtc-ds1511.c
+++ b/drivers/rtc/rtc-ds1511.c
@@ -196,14 +196,10 @@ static int ds1511_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		pdata->irqen |= RTC_AF;
 
 	spin_lock_irqsave(&pdata->lock, flags);
-	rtc_write(pdata->alrm_mday < 0 ? 0x80 : bin2bcd(pdata->alrm_mday) & 0x3f,
-	       DS1511_AM4_DATE);
-	rtc_write(pdata->alrm_hour < 0 ? 0x80 : bin2bcd(pdata->alrm_hour) & 0x3f,
-	       DS1511_AM3_HOUR);
-	rtc_write(pdata->alrm_min < 0 ? 0x80 : bin2bcd(pdata->alrm_min) & 0x7f,
-	       DS1511_AM2_MIN);
-	rtc_write(pdata->alrm_sec < 0 ? 0x80 : bin2bcd(pdata->alrm_sec) & 0x7f,
-	       DS1511_AM1_SEC);
+	rtc_write(bin2bcd(pdata->alrm_mday) & 0x3f, DS1511_AM4_DATE);
+	rtc_write(bin2bcd(pdata->alrm_hour) & 0x3f, DS1511_AM3_HOUR);
+	rtc_write(bin2bcd(pdata->alrm_min) & 0x7f, DS1511_AM2_MIN);
+	rtc_write(bin2bcd(pdata->alrm_sec) & 0x7f, DS1511_AM1_SEC);
 	ds1511_rtc_alarm_enable(alrm->enabled);
 
 	rtc_read(DS1511_CONTROL_A);	/* clear interrupts */
-- 
2.43.0


