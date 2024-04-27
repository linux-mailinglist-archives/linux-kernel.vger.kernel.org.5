Return-Path: <linux-kernel+bounces-161171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7FE8B47F6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 22:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9282AB21981
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 20:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5D2155730;
	Sat, 27 Apr 2024 20:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="fJiHsU0F"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2E9147C64
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 20:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714250185; cv=none; b=VIoNiaHKa5mXyLgWCwxZog3DQxsdcxDnhJBq85jYYH5jNxwJzwAUQadjwoHjMIvKkZfQ1+ptiANFBTxiRxSWaV2U28xdirRyD7kLh+v8aeRtwnEgkr29p+9p3QfV6JBQomkPpZtvwFU45WR0LAvP2C90faOu1I5dx4i6eh3IbSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714250185; c=relaxed/simple;
	bh=5bodQvN8FujH0DNsbxAsErbliMjmBltn92WZuAMz57w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FsvBQf/eZzONiP3UBmwxIZthdCRFpL/Gz2AxYgpwmz2n9YZQ7QhL5nTllINpJHdzGzoPyD3g+qLKS/gmQtGButVWXVhcFwhsyvBGx20Rsgnv95pZPICJacVKFdTFG6tG5CQkYVXGbl9CPo18GJ1tFS/3yL+KoBK4XMWKOzvac6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=fJiHsU0F; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=2F3yQc5OYq/TjttbywN55Gd7XF7kO1dQ9WqJ4zJk1sI=; b=fJiHsU
	0FrDuj2rFjcEbPa/eFwf2/IKpYn2fIMHQmySsrwP8DoakwcW0k8eSgz7Sm7/2pxJ
	RaPpfO1YZg+tyPq84O8nUBNIUH5VQK+QNGiizJ35zDwL47RUQlonvtZsPOY/UbcA
	t9ug/su/9zwYFCGRPxLz4gfeH1ITq1viJBYOmVLBKaZukMTsdl93JIaHaSp/I7MV
	NMMOdwSA++ql2q3tNkY9t9/sfFcleDLqoBLtwmMoHuWbPqfPZzBY4zhJdAHFsrEg
	B0Or6avYVZKuZci2VOYxuXtqQhj2yDvu3tBDbJ2nv7/d29ElcsmQyGGDaZYi3VId
	TCIHT6pvTPCDxt1g==
Received: (qmail 1781878 invoked from network); 27 Apr 2024 22:36:16 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 27 Apr 2024 22:36:16 +0200
X-UD-Smtp-Session: l3s3148p1@bqHO+BkXwo9ehh9l
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/15] i2c: exynos5: use 'time_left' variable with wait_for_completion_timeout()
Date: Sat, 27 Apr 2024 22:35:55 +0200
Message-ID: <20240427203611.3750-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240427203611.3750-1-wsa+renesas@sang-engineering.com>
References: <20240427203611.3750-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_for_completion_timeout() causing patterns like:

	timeout = wait_for_completion_timeout(...)
	if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
self explaining.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-exynos5.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index 385ef9d9e4d4..d8baca9b610c 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -763,7 +763,7 @@ static bool exynos5_i2c_poll_irqs_timeout(struct exynos5_i2c *i2c,
 static int exynos5_i2c_xfer_msg(struct exynos5_i2c *i2c,
 			      struct i2c_msg *msgs, int stop)
 {
-	unsigned long timeout;
+	unsigned long time_left;
 	int ret;
 
 	i2c->msg = msgs;
@@ -775,13 +775,13 @@ static int exynos5_i2c_xfer_msg(struct exynos5_i2c *i2c,
 	exynos5_i2c_message_start(i2c, stop);
 
 	if (!i2c->atomic)
-		timeout = wait_for_completion_timeout(&i2c->msg_complete,
-						      EXYNOS5_I2C_TIMEOUT);
-	else
-		timeout = exynos5_i2c_poll_irqs_timeout(i2c,
+		time_left = wait_for_completion_timeout(&i2c->msg_complete,
 							EXYNOS5_I2C_TIMEOUT);
+	else
+		time_left = exynos5_i2c_poll_irqs_timeout(i2c,
+							  EXYNOS5_I2C_TIMEOUT);
 
-	if (timeout == 0)
+	if (time_left == 0)
 		ret = -ETIMEDOUT;
 	else
 		ret = i2c->state;
-- 
2.43.0


