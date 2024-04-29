Return-Path: <linux-kernel+bounces-162158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE728B56CC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514961C20ECE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D35853800;
	Mon, 29 Apr 2024 11:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="MAcOPI0n"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF8152F6A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390406; cv=none; b=OVXfzCu94opsjDf5j7f4FaS+TPA4rLkia1ZYdwwUlCxKPCQeBKk0+osxhO5i/5oyfkob0TiRokgi6mbOooJOJsYsBgsOJcbySBIbAci7S6F/WsUGlWsyTQFGS/XmR8wmXt/On1PnE9MJrxisY4KNQRfzWePYQol8Le2Tng60fpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390406; c=relaxed/simple;
	bh=IdhLliF3I34ob0fmKFJFFe1MNaGnbf324kblqz/L3Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OxdJuiXVEGTdobJT8g2sSfa7iX5N6GxccrxP/Lm1czAer6ZSuAvwAv0t0MfgTbWBNFzHYKQ8UJB4hfJ3uiknwXkXCst1fWfmjofUggop3X2mWSe8dSbyO/y/X3wuSMZbD06L0lBIQETYmadU2DBjGybnCoQ09VGXVEWDaGxbr7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=MAcOPI0n; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=7WxOY8Hqqwt7I9BFZQWHS3JVVzhT3Xl4XwRHu/Qd27g=; b=MAcOPI
	0nVZbpF/9LmEWS+jfhT6KB5iGcddFfw3W2h1I/GkPINuWNAOe91u9LkMvbRVfKu0
	htmVWfgJ936SU9etiRTSq5DEkdzudVwN/DipUwQjudjxwYvfNECJp3/RNrrzmLGv
	4frOCNdzrmTeuFDRFNrsu3YTYcS6qXzW0+MF63SJvuHkJeOkTtJVD7ewChf7b6AN
	ThRKejPl1aM+sgRM/aCc/I0qi/9a/ODYWLRdIewBkQmafOcO9knhbhlpd6WD8kvc
	LXi2oawrYGEatSc2ODKDmHw1t2LRShRVipIwoL7dHsOvbzyL8nQN0CLuwI8kQE7I
	G+pqdtVCfWGFSEJQ==
Received: (qmail 2281230 invoked from network); 29 Apr 2024 13:33:21 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Apr 2024 13:33:21 +0200
X-UD-Smtp-Session: l3s3148p1@L1fWnjoXpy5tKPB4
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-iio@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] iio: adc: twl6030-gpadc: use 'time_left' variable with wait_for_completion_interruptible_timeout()
Date: Mon, 29 Apr 2024 13:33:10 +0200
Message-ID: <20240429113313.68359-8-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429113313.68359-1-wsa+renesas@sang-engineering.com>
References: <20240429113313.68359-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_for_completion_interruptible_timeout() causing patterns like:

	timeout = wait_for_completion_interruptible_timeout(...)
	if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
self explaining.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/iio/adc/twl6030-gpadc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index 78bf55438b2c..6a3db2bce460 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -519,7 +519,7 @@ static int twl6030_gpadc_read_raw(struct iio_dev *indio_dev,
 {
 	struct twl6030_gpadc_data *gpadc = iio_priv(indio_dev);
 	int ret;
-	long timeout;
+	long time_left;
 
 	mutex_lock(&gpadc->lock);
 
@@ -529,12 +529,12 @@ static int twl6030_gpadc_read_raw(struct iio_dev *indio_dev,
 		goto err;
 	}
 	/* wait for conversion to complete */
-	timeout = wait_for_completion_interruptible_timeout(
+	time_left = wait_for_completion_interruptible_timeout(
 				&gpadc->irq_complete, msecs_to_jiffies(5000));
-	if (timeout == 0) {
+	if (time_left == 0) {
 		ret = -ETIMEDOUT;
 		goto err;
-	} else if (timeout < 0) {
+	} else if (time_left < 0) {
 		ret = -EINTR;
 		goto err;
 	}
-- 
2.43.0


