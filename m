Return-Path: <linux-kernel+bounces-84181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E039986A36C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EA5AB2AB77
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361C357305;
	Tue, 27 Feb 2024 23:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WiQx2VbF"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1EE56741;
	Tue, 27 Feb 2024 23:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075653; cv=none; b=HWc/T0O3yZhRW4F1mfpPOE7/eJBpkdluFKIsLnvA+42T0/0wziLb8Wzz5SFSSWQ4klTQIeWRU829aVZIA7KwQqrBCRUYDsxtEYywWdYKsqraPo1fF0kO0GH/JkCfBkcQz+sdE2Ndm0ryS4ZX5ktj7fGFBwA2zrAjRqG2zbmtJ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075653; c=relaxed/simple;
	bh=LI4PM4UegSp+OIgjo5ROBmyzBvlxEi447Fy28Z5th+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FgyRUg7c6ZSThUU4Im031FDzLiY8FCzD6HOPv5j8t9/8jpATOChvjcGMwsQivN6IPiNzcxNJUK+CyXDR2atcPa9DdJCeWQld29j6vC71mfp1GgfM5THYjFXIFhEkK4EDJyXoO5vlzi5+7teh9dtMLsivIPP+QJBznnBGXplBV9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WiQx2VbF; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3B8D8240002;
	Tue, 27 Feb 2024 23:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709075649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xjAcQeJGSd5BcuSQbG0A8pilf5S0iMMnTwn+eoiNSfw=;
	b=WiQx2VbFi7fjyfycTuT5T78+hPrEXGkbUsEu2175Wi6DyG2mFiYxdfBAvsJj5m3k0XtShh
	T/f8Sh01z1hdshGhUWik0qQ7zJ+9pQKVN77MQO/dr0IAe0oc9yj9JnEZVIdMy7PJYKe4ut
	CIeYxN5FGWTdKx8G5mKmw2OZ0JMdJU9sjDKCXAyU9cUT94T//re56/MaQHCB1Yi3wbqX0L
	HAx0ep21oDiP6vWWOobjpDzYsT2kqjoknY+IVlehWXX7h6VXT8LwRyyKG/8D8G/rEeB/+A
	4gWXld5JwQ7MT9OrF6AaeIigfDW5IrD3rgduJ+WpwCZssuwDdepVgRKk9V+rVA==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rtc: ds1511: set alarm offset limit
Date: Wed, 28 Feb 2024 00:13:55 +0100
Message-ID: <20240227231356.1840523-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227231356.1840523-1-alexandre.belloni@bootlin.com>
References: <20240227231356.1840523-1-alexandre.belloni@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexandre.belloni@bootlin.com

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

The ds1511 can only support alarms up to a month in the future (which we
currently limit to 28 days).

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1511.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
index 6869d28d34cc..8b087d9556be 100644
--- a/drivers/rtc/rtc-ds1511.c
+++ b/drivers/rtc/rtc-ds1511.c
@@ -323,6 +323,7 @@ static int ds1511_rtc_probe(struct platform_device *pdev)
 
 	ds1511->rtc->ops = &ds1511_rtc_ops;
 	ds1511->rtc->range_max = RTC_TIMESTAMP_END_2099;
+	ds1511->rtc->alarm_offset_max = 28 * 24 * 60 * 60 - 1;
 
 	/*
 	 * if the platform has an interrupt in mind for this device,
-- 
2.43.0


