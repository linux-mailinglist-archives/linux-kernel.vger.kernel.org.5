Return-Path: <linux-kernel+bounces-84160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6336286A33C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94FC51C24497
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6550956745;
	Tue, 27 Feb 2024 23:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="p00F9w65"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F362E56741;
	Tue, 27 Feb 2024 23:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075089; cv=none; b=s/UYshg1frNxKE95T/cRmF4STDosGT/FGnXWJBVdOedTOd5QFsfEKmPv4Bpxs3VKLwZrIxO8H/fGn/ArdW0njhB9IdNzp8FjNe9vue292wAJlgSUyZENF7WfVd60x9sYTE6ETQ1Vo4wn+ApepPuxSofH0QsGVAGrOG75OTHJZKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075089; c=relaxed/simple;
	bh=zo9Df9JHxN0K53/19URRHka3gUcLUDl/foFb5EGQk34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+wtMYxLFG9Bnx9Q0o/7B9bANq2Nb77irZbx8kBF1vxVWWPOegoNhbODWIBDotCfp7Z8qayJyiYlS5mrb1bntPtzIIFrJN+GRoSn0mvWqZYwmQFFcdmiUuRyJcYT05TK6j+xta+4/8GtKgPyMb31MTCikwYZJbaQU9IAyCm9JC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=p00F9w65; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B2E2A60003;
	Tue, 27 Feb 2024 23:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709075084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xPWLS2vYXFua2bug0ohUqf0o99PQKgw61UA1Alu92Xs=;
	b=p00F9w65LHHP8MlKrCE93I07ZCFGBvO19baUFIUKaSdussHa1PfjLlBo/Jv8Qbx8LR5Vs5
	HP0sK6QgYYQ90pzv5Pn0HcTMuoSqa6DRWOyAIqKCuOl75IGwtlM4YFyo6dCpI7HKPDq1d7
	soTG0YS0nxKt685D+vmt/v+StMQn1ab4mg6SXyfUpqt9GMd1EM8cEHP4igle5RbvPQCudC
	00l0hGRnSr0e++Goa4BZ+CoMc/D7sJAM1YBVlsghnNI9oaMoUGwgRWypHTWejFbFsThgBd
	bmoL1eLbNvmQYW2sMii7RyNrVW1mAZx5R9lT4g8sdAtZodQuCzWr0RZJSUi/Zg==
From: alexandre.belloni@bootlin.com
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] rtc: ds1511: drop useless computation
Date: Wed, 28 Feb 2024 00:04:17 +0100
Message-ID: <20240227230431.1837717-2-alexandre.belloni@bootlin.com>
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

All the callers of ds1511_rtc_set_time will use the same epoch for tm_year
which is defined as the number of years minus 1900 since POSIX.1-2001.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1511.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
index 87c52d20d31a..a646bcf9cd56 100644
--- a/drivers/rtc/rtc-ds1511.c
+++ b/drivers/rtc/rtc-ds1511.c
@@ -166,24 +166,13 @@ ds1511_wdog_disable(void)
 }
 #endif
 
-/*
- * set the rtc chip's idea of the time.
- * stupidly, some callers call with year unmolested;
- * and some call with  year = year - 1900.  thanks.
- */
 static int ds1511_rtc_set_time(struct device *dev, struct rtc_time *rtc_tm)
 {
 	u8 mon, day, dow, hrs, min, sec, yrs, cen;
 	unsigned long flags;
 
-	/*
-	 * won't have to change this for a while
-	 */
-	if (rtc_tm->tm_year < 1900)
-		rtc_tm->tm_year += 1900;
-
 	yrs = rtc_tm->tm_year % 100;
-	cen = rtc_tm->tm_year / 100;
+	cen = 19 + rtc_tm->tm_year / 100;
 	mon = rtc_tm->tm_mon + 1;   /* tm_mon starts at zero */
 	day = rtc_tm->tm_mday;
 	dow = rtc_tm->tm_wday & 0x7; /* automatic BCD */
-- 
2.43.0


