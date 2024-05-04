Return-Path: <linux-kernel+bounces-168491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D59578BB933
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 04:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131481C22F9A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25C510795;
	Sat,  4 May 2024 02:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b="phcGVvHB"
Received: from mail.kaechele.ca (mail.kaechele.ca [54.39.219.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3183539C;
	Sat,  4 May 2024 02:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.39.219.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714788485; cv=none; b=jugULHSrd2tGjRuKFiZ/GAfXrhipIJoDcDpDrJIEXoVrRil/gqh6D3tt9gUqpUMzxQKJPu79InCIZ2iFaz+PpZ6l3V8fg2WCM+ucQSVTKqntQ5we7wzaWygtjuFk70Bx+eSEvMPOaAW9lOQ2qgeKwhK4lwsce0KD9D3LwvKpL7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714788485; c=relaxed/simple;
	bh=Pe7QETLG9b6pCpN9wEnqqft2nXgNoO+6kB1TkY+IC+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSu6umkp4ABZOr2hYtTPXKJP24FYH7rR6MoDgA5FpVb14nBUrqBsMPMai1ohESCfqf7ZNH3FU6Sqy7aJDj1Rurngds02VIdLUJlVdGOM1ba7Fh4VCJljKxJzZZ2K9QUSVU92FkypQ4SFE+gfu6z6ufSS0QpejijpKFCRqL0+HnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca; spf=pass smtp.mailfrom=kaechele.ca; dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b=phcGVvHB; arc=none smtp.client-ip=54.39.219.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaechele.ca
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 692DDC0076;
	Fri,  3 May 2024 22:08:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaechele.ca; s=201907;
	t=1714788495; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Js+Zw4ZWqNvFMC47UtCh2KmzrfI0HQ6+4EhdmIXK07Q=;
	b=phcGVvHB/akJpzBsxB0+PWlrLVr9iYWsvD+PQ44gOmxos0bcl7+3hBGhQwcSG/5z/j8iZK
	pV0LGHODZZhNR8kDQy5CTyQ4sJ508B7AN1bAb7eiF7qtcBH9V0cZU55jogFzgLbo77sRRW
	ftc/DfMawSkSFfh+t/eeAkmirR9rBkc=
From: Felix Kaechele <felix@kaechele.ca>
To: Job Noorman <job@noorman.info>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Paul Gale <paul@siliconpixel.com>
Subject: [PATCH 6/6] input: himax_hx83112b: add support for HX83100A
Date: Fri,  3 May 2024 22:04:45 -0400
Message-ID: <20240504020745.68525-7-felix@kaechele.ca>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504020745.68525-1-felix@kaechele.ca>
References: <20240504020745.68525-1-felix@kaechele.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The HX83100A is a bit of an outlier in the Himax HX831xxx series of
touch controllers as it requires reading touch events through the AHB
interface of the MCU rather than providing a dedicated FIFO address like
the other chips do.
This patch implements the specific read function and introduces the
HX83100A chip with an appropriate i2c ID and DT compatible string.

The HX83100A doesn't have a straightforward way to do chip
identification, which is why it is not implemented in this patch.

Tested on: Lenovo ThinkSmart View (CD-18781Y) / Innolux P080DDD-AB2 LCM

Signed-off-by: Felix Kaechele <felix@kaechele.ca>
Tested-by: Paul Gale <paul@siliconpixel.com>
---
 drivers/input/touchscreen/himax_hx83112b.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/input/touchscreen/himax_hx83112b.c b/drivers/input/touchscreen/himax_hx83112b.c
index 667611c5a018..984baef495e1 100644
--- a/drivers/input/touchscreen/himax_hx83112b.c
+++ b/drivers/input/touchscreen/himax_hx83112b.c
@@ -4,6 +4,9 @@
  *
  * Copyright (C) 2022 Job Noorman <job@noorman.info>
  *
+ * HX83100A support
+ * Copyright (C) 2024 Felix Kaechele <felix@kaechele.ca>
+ *
  * This code is based on "Himax Android Driver Sample Code for QCT platform":
  *
  * Copyright (C) 2017 Himax Corporation.
@@ -37,6 +40,8 @@
 
 #define HIMAX_REG_ADDR_ICID			0x900000d0
 
+#define HX83100A_REG_FW_EVENT_STACK		0x90060000
+
 #define HIMAX_INVALID_COORD		0xffff
 
 struct himax_event_point {
@@ -291,6 +296,13 @@ static bool himax_verify_checksum(struct himax_ts_data *ts,
 	return true;
 }
 
+static int hx83100a_read_events(struct himax_ts_data *ts,
+				struct himax_event *event,
+				size_t length)
+{
+	return himax_bus_read(ts, HX83100A_REG_FW_EVENT_STACK, event, length);
+};
+
 static int himax_read_events(struct himax_ts_data *ts,
 			     struct himax_event *event,
 			     size_t length)
@@ -436,6 +448,10 @@ static int himax_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(himax_pm_ops, himax_suspend, himax_resume);
 
+static const struct himax_chip hx83100a_chip = {
+	.read_events = hx83100a_read_events,
+};
+
 static const struct himax_chip hx83112b_chip = {
 	.id = 0x83112b,
 	.check_id = himax_check_product_id,
@@ -443,6 +459,7 @@ static const struct himax_chip hx83112b_chip = {
 };
 
 static const struct i2c_device_id himax_ts_id[] = {
+	{ "hx83100a", (kernel_ulong_t) &hx83100a_chip },
 	{ "hx83112b", (kernel_ulong_t) &hx83112b_chip },
 	{ /* sentinel */ }
 };
@@ -450,6 +467,7 @@ MODULE_DEVICE_TABLE(i2c, himax_ts_id);
 
 #ifdef CONFIG_OF
 static const struct of_device_id himax_of_match[] = {
+	{ .compatible = "himax,hx83100a", .data = &hx83100a_chip },
 	{ .compatible = "himax,hx83112b", .data = &hx83112b_chip },
 	{ /* sentinel */ }
 };
-- 
2.44.0


