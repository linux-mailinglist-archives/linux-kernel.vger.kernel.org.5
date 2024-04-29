Return-Path: <linux-kernel+bounces-162159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 617618B56CD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226852831D4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E81D45018;
	Mon, 29 Apr 2024 11:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ihc0ZqSZ"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2211C4C610
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390406; cv=none; b=WRob/1eR14yuWjjpFyDs/uHF66HvNLHgbyRfizxSQmOcWQ9Dxkkn8Rbt/FZnGE4/NYXhzPysjbs/ZdkldWf7e21snw5wrFVMSKCmw9jrCiOgmYnr3TaHO0dvCp6Et2PmdkDqB/AI8iAgnGURQykXsiWOX2g/vHHuuj7DbrTR10g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390406; c=relaxed/simple;
	bh=2uX3wkKhmFCqFWQCxlFoe6vDeE4dnIiY2m9s/rKq9oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=htcXIvGhfXKsIWwdbVLMRktg1BufMQoglihBAcov+r4aNUacMxXhCeLuXklaAhRohY72sm9WapXiZKvk0DZO3kOozWGu2GLFBbgxZs5ro5GezK9VNcHINzxpMC3xoa52pEUEDr+2jPrhyguKP4Y+B/tIn4xWvZgSxUx5tyWT3Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ihc0ZqSZ; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=9jrudQes/oY0ss0zHQRh6mDwrbJoU9KkQ26G3FR9LtI=; b=ihc0Zq
	SZ+nOKe3RRSC5eQoHXP8j8Hk/Po3Xqz96sq8eRhN1khue2jt5X4jQN58u6jU8SFJ
	2JVq/t8DKkv9Srcoj5KncOteHfb8dj4CS9ZOlqRupOPuMya5hb6u+3+uyt07Lpui
	TJ5sboFZvNBWE739ZvfnbptMghuQkUAj6LqAo7stf/vp+qEbd1aDCGE8aPw2BaWd
	2OVKIH/oXEg72lsXa9npyf6wNzpKwghDhdAhEPGSEC1UvvSQiufL9+fP2caxGCVj
	j2FoS0LLbD0nPO8Ei5nze1Ic7PPsdS6bvjh35p3Ooc7ssLLK9y1cwjUkpYZUQ5sv
	CXoCgO/OVKFQEF8Q==
Received: (qmail 2281276 invoked from network); 29 Apr 2024 13:33:22 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Apr 2024 13:33:22 +0200
X-UD-Smtp-Session: l3s3148p1@tgrlnjoXfEVtKPB4
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-iio@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] iio: pressure: zpa2326: use 'time_left' variable with wait_for_completion_interruptible_timeout()
Date: Mon, 29 Apr 2024 13:33:11 +0200
Message-ID: <20240429113313.68359-9-wsa+renesas@sang-engineering.com>
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
 drivers/iio/pressure/zpa2326.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index 421e059d1f19..dcc87a9015e8 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -861,13 +861,13 @@ static int zpa2326_wait_oneshot_completion(const struct iio_dev   *indio_dev,
 					   struct zpa2326_private *private)
 {
 	unsigned int val;
-	long     timeout;
+	long time_left;
 
 	zpa2326_dbg(indio_dev, "waiting for one shot completion interrupt");
 
-	timeout = wait_for_completion_interruptible_timeout(
+	time_left = wait_for_completion_interruptible_timeout(
 		&private->data_ready, ZPA2326_CONVERSION_JIFFIES);
-	if (timeout > 0)
+	if (time_left > 0)
 		/*
 		 * Interrupt handler completed before timeout: return operation
 		 * status.
@@ -877,10 +877,10 @@ static int zpa2326_wait_oneshot_completion(const struct iio_dev   *indio_dev,
 	/* Clear all interrupts just to be sure. */
 	regmap_read(private->regmap, ZPA2326_INT_SOURCE_REG, &val);
 
-	if (!timeout) {
+	if (!time_left) {
 		/* Timed out. */
 		zpa2326_warn(indio_dev, "no one shot interrupt occurred (%ld)",
-			     timeout);
+			     time_left);
 		return -ETIME;
 	}
 
-- 
2.43.0


