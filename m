Return-Path: <linux-kernel+bounces-30253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B356831C43
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8C81C22BD2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BA525639;
	Thu, 18 Jan 2024 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="oEn4fNk4"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA29928DA1;
	Thu, 18 Jan 2024 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591345; cv=none; b=H02/l9U8IcdIWqdB9x+IjD1T/xV2O5I7zf/lMhVeAlpeS1MG61Qa1QE9mgX+GbY8m20rIB7lDhFoi3oyDmb1qSNwrxFB5Eya/SidEnzISpuYjuSQAdzhKHKdmdOvrHVahzNnjrWWSG/NgV8Wktzmempi2VBW+IBNYXv6iOfYqVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591345; c=relaxed/simple;
	bh=djY5HcTqyB8uYMPbfrCAyzSYCGDSIBxMLSDCsNJ0pgM=;
	h=DKIM-Signature:Received:From:To:Cc:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Report:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned; b=kI0Qsz0FBHE+UmcBFASy8lnxM90NdQUNF0IXI+AyXVgPDx3x6ZggW23BYPEeIey7GHg3frBs3jYXQKlE/Z/x6dxfhv4kw2lengd5h1CqOIrGdzn32dxMA2tkAVz8IXIH837rAmxSOSY9mvVD4GIbIijy9lFsBgozLW+Wl2Lfjak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=oEn4fNk4; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=CIspq8yyWy8Vq0FZhwlYRVvFdI4Ek9Z6Pk7OK1kUNro=; b=oEn4fNk4tZcG3X+mwuv0wuNE9a
	pobB+OW43W3ZeIbc4iiJJhK/MzReqCe9TSEk0mhJ+lUVOspZZZTACbOYydiIlxhEkaBuV/JslOqJV
	ilANAZY6yzOeDeXvJLFow12ZSUOrIiiitNZshiclOdVOKn7+/xcQUvZ1mk9/UQcmz6ag=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:57058 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQUDj-0002lf-Lc; Thu, 18 Jan 2024 10:22:20 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	cosmin.tanislav@analog.com,
	andy.shevchenko@gmail.com,
	shc_work@mail.ru
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Thu, 18 Jan 2024 10:21:58 -0500
Message-Id: <20240118152213.2644269-3-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240118152213.2644269-1-hugo@hugovil.com>
References: <20240118152213.2644269-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
Subject: [PATCH v2 02/17] serial: max310x: add I2C device table for instantiation from userspace
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

This allows to instantiate a max14830 I2C device from userspace.

Helpful when testing driver with i2c-stub.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 4a33fd950ed2..053cf2458264 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1639,6 +1639,15 @@ static void max310x_i2c_remove(struct i2c_client *client)
 	max310x_remove(&client->dev);
 }
 
+static const struct i2c_device_id max310x_i2c_id_table[] = {
+	{ "max3107",	(kernel_ulong_t)&max3107_devtype, },
+	{ "max3108",	(kernel_ulong_t)&max3108_devtype, },
+	{ "max3109",	(kernel_ulong_t)&max3109_devtype, },
+	{ "max14830",	(kernel_ulong_t)&max14830_devtype, },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max310x_i2c_id_table);
+
 static struct i2c_driver max310x_i2c_driver = {
 	.driver = {
 		.name		= MAX310X_NAME,
@@ -1647,6 +1656,7 @@ static struct i2c_driver max310x_i2c_driver = {
 	},
 	.probe		= max310x_i2c_probe,
 	.remove		= max310x_i2c_remove,
+	.id_table	= max310x_i2c_id_table,
 };
 #endif
 
-- 
2.39.2


