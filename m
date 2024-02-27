Return-Path: <linux-kernel+bounces-84180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C2386A36D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45929B2A83B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4549C56740;
	Tue, 27 Feb 2024 23:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GV+H7ERU"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA2D5577A;
	Tue, 27 Feb 2024 23:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075650; cv=none; b=OXsPQRXikudCCM4JjsMd16y1CL/wP6HiQK/tUclyevA0k2af/LdQ8FHOkfvsQ8yZLOB2FCsWtybBjvIQTzs1HpYXB9wHRS7uU6mtUQhX7apIivG23p8YNpGdCzUsVmqr0+YtMvrkH9gOXnEPTPUpnagbBvOkUCDY6W7HJolpPuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075650; c=relaxed/simple;
	bh=nsEziExjOLtmbpppbLO2Fb6/NxIhywmNgFfnncBJ1mw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=apmHxd4Fr/w8U1zSsaJrSxAoHC1iJSq7ZTcnJs57eXs835BEfWIU4qNuTcTcvIQsT4tObMZq0z0zLNvrb+xZi5I4Y/s5IE1e8r7qsNng2H2rhAVXtoN+KZlP6msiuVoWXmN3yVY9wGzAxWvTij8ncwVaFgOaCZLbWNfFUDKA8VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GV+H7ERU; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9B4691C0004;
	Tue, 27 Feb 2024 23:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709075646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UE7EiRd4bNA/hzZvwUNjNWHpGsJRtcTpEKCKzOC3+w8=;
	b=GV+H7ERUI3Uty2KdCDE651r2OvyRemaEYAtcIIFQwad5m+tcKg/BDx+H2mBPofxwL1vhDF
	qK8CNh1svxIXXArtzskktAcO6eTMiSXOnhfWXwtuVom28PneF9bx26u+tyEJLzxASpCJ79
	QpnjHCbYtp28c+/vdoWfQFwIk+iFrtcWsIg/k1lfD/zUwqaChnUzrLMKIIERNe7UmUdybC
	tSGhjZrRhSSpzC9RVMszVOKElhEvFO5SkzgNeKYOZHT4QXC7BiKazGA4HFYaiOXdUEPJta
	z+zcSNiWyTj2jHTfUP5a0/8w5AJ9qC9mU0PHaJX2siMcprvTW0dBR6i2MGbDQQ==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rtc: ds1511: set range
Date: Wed, 28 Feb 2024 00:13:54 +0100
Message-ID: <20240227231356.1840523-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexandre.belloni@bootlin.com

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

The ds1511 leap year calculation fails in 2100.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1511.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
index edb8d90812c5..6869d28d34cc 100644
--- a/drivers/rtc/rtc-ds1511.c
+++ b/drivers/rtc/rtc-ds1511.c
@@ -322,6 +322,7 @@ static int ds1511_rtc_probe(struct platform_device *pdev)
 		return PTR_ERR(ds1511->rtc);
 
 	ds1511->rtc->ops = &ds1511_rtc_ops;
+	ds1511->rtc->range_max = RTC_TIMESTAMP_END_2099;
 
 	/*
 	 * if the platform has an interrupt in mind for this device,
-- 
2.43.0


