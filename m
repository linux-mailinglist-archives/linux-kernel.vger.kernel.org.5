Return-Path: <linux-kernel+bounces-149115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CC98A8C01
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC99F1F22BAC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2551624B33;
	Wed, 17 Apr 2024 19:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oIgRsW3U"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B1A2BB16;
	Wed, 17 Apr 2024 19:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713381599; cv=none; b=F78zuYr/oLOAD2ONQRVPCKIR3iS17hXQXLSgNBc9Y+8CDEmZQKHBcm3krwTThHBZXR9RtZNxFHSs/QFoHW/CkM1DWVa5vonrYicO4XborJbAUlE9tzF1sVV3X4OzJSFdS5MDSsVZ4xqgtAVfNkBERGNJHnGJjYem91Uy59VWNpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713381599; c=relaxed/simple;
	bh=1WkTOQjl0bt6iavNqrnDeQegNFNYwXSEDpYVQxuGjJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbLZ/9SzyGRYbUJMrMMi3l1M0aUWOrPw+Z/tXqEtjg9/SFR616gXotypVzXSS5ydZ5xMK1MGnR3M6wN+8RrC0+Q82UwOjANyxlHgIUwMl/xOM+kYJ+EVlFWNkr37ZLV4FBUW/2d69iZhtJClFXXvKCU8FXEX4y9scHd8oJEO6MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oIgRsW3U; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4FB9460002;
	Wed, 17 Apr 2024 19:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713381595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jQo9vcuwNFak9EahRUpeiFOj0bXZpNg5mHU6fet7Il4=;
	b=oIgRsW3UbIUkZDmclmiZaDkSJLJ7avJgIK/ktpfLzl05AZRllOBSQFqJaaYSZwKWFpTGMH
	tnW98VdSuTYN2q0RO298pBc9j+23NzAzm6xeovJUTiy9DcRFfNQcHCcWj78Dzzs517bocA
	hQLFlp0KV67qLvRR5rpxytjQ/icmuvGVAyW+rkgZaEJkR9+lcp4lVoLn98DZDFVBgyMWPB
	X1sz8emUKahIZ++XYFsnuWwW0YHrX2wFVoLsrIx7OoWJgaHZ5Vvu5nbShRrAfb+9L9S7eq
	I4n0qazoUj3C8A7sdxjmk1ayRgJHZGi8dciuNpowoay0e4+kPExrpesO/cvbuA==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Waqar Hameed <waqar.hameed@axis.com>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rtc: rx8111: handle VLOW flag
Date: Wed, 17 Apr 2024 21:19:36 +0200
Message-ID: <20240417191937.33790-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417191937.33790-1-alexandre.belloni@bootlin.com>
References: <20240417191937.33790-1-alexandre.belloni@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexandre.belloni@bootlin.com

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Allow userspace to get battery status information and be able to warn when
battery is low and has to be replaced.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rx8111.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/rtc/rtc-rx8111.c b/drivers/rtc/rtc-rx8111.c
index 4a35bd921b33..8450d9f0b566 100644
--- a/drivers/rtc/rtc-rx8111.c
+++ b/drivers/rtc/rtc-rx8111.c
@@ -95,6 +95,9 @@ enum rx8111_regfield {
 	RX8111_REGF_INIEN,
 	RX8111_REGF_CHGEN,
 
+	/* RX8111_REG_STATUS_MON. */
+	RX8111_REGF_VLOW,
+
 	/* Sentinel value. */
 	RX8111_REGF_MAX
 };
@@ -129,6 +132,8 @@ static const struct reg_field rx8111_regfields[] = {
 	[RX8111_REGF_SWSEL1] = REG_FIELD(RX8111_REG_PWR_SWITCH_CTRL, 3, 3),
 	[RX8111_REGF_INIEN]  = REG_FIELD(RX8111_REG_PWR_SWITCH_CTRL, 6, 6),
 	[RX8111_REGF_CHGEN]  = REG_FIELD(RX8111_REG_PWR_SWITCH_CTRL, 7, 7),
+
+	[RX8111_REGF_VLOW]  = REG_FIELD(RX8111_REG_STATUS_MON, 1, 1),
 };
 
 static const struct regmap_config rx8111_regmap_config = {
@@ -276,6 +281,13 @@ static int rx8111_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 
 		vlval = regval ? RTC_VL_DATA_INVALID : 0;
 
+		ret = regmap_field_read(data->regfields[RX8111_REGF_VLOW],
+					&regval);
+		if (ret)
+			return ret;
+
+		vlval |= regval ? RTC_VL_BACKUP_LOW : 0;
+
 		return put_user(vlval, (typeof(vlval) __user *)arg);
 	default:
 		return -ENOIOCTLCMD;
-- 
2.44.0


