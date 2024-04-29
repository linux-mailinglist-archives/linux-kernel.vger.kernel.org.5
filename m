Return-Path: <linux-kernel+bounces-162152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FA28B56BB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2651F241DE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B6E481D8;
	Mon, 29 Apr 2024 11:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="b3o54+FB"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2A74501D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390398; cv=none; b=pKfCqYBwTH8Ih7/0+4gVWvKiPxZeGaHrPzH+eg0dUlp+HLv3T0/t27z5qdOL//f/v6DzyxGSdERHie9gwpAPh4Mugpj/s5EEMg6uh5DWyxw2EpLscj5sF6rr1Cm5Zj9IIwk3werldA0LGZp3E+BJKgXdq9mywKx74aujKmtB1VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390398; c=relaxed/simple;
	bh=V06hBJ0AbH+QLN6vjA3YFpErKpkzt+h3vT6AjALWIu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXpjxzZJ1020cpKejup6PCJobgZlGhN22U3GhglcPffjI1VV51TcQcA1TSTmjnC0XwvVa5AhHLlPFcdZ7xvZRHai95v+SaQPsTHtktOHYjh0zxQJK+dLxIuiKdCyH3kxTTvXHV6coRxN55E0DDrn5VlCnEi7AFx3NrfTtfBlNXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=b3o54+FB; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=ytaMDbrRHYTkVlHscVH3Jk5trLpcIFOkGRyH/ZBVpu4=; b=b3o54+
	FBrZMOOENh3SFIj9rXzdWDB/PlMnG8ozVY6pIS70/2X2gDbHZh7H5/OaLvIdk10Q
	SGkowgG2M3LM/2Fv76mbrNXLogK9XXlIG8m0du4N6MiddcbLQ2tql2FMRoi2rdFH
	+67ppN7OH0BrBmUlPfOzeRhXcly+NgABG9vRkN6ZFYg92iQbIRdvZ/twGC3odSbi
	sXm9EIA2wLjnDAqy8d9mavlUOZiYeFXUXGAZB57swnNffTEUcTuwb2+FRDaqhrYu
	uwWxLEiTnz/30pRG0WfuVVaKhEjM1Qgubcwd+OB4iC1pSV26uJZAFpkg3hzwSF9m
	Lsl9AZOTeskRDuLg==
Received: (qmail 2280987 invoked from network); 29 Apr 2024 13:33:15 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Apr 2024 13:33:15 +0200
X-UD-Smtp-Session: l3s3148p1@rkh5njoX3kFtKPB4
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-iio@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] iio: adc: ad_sigma_delta: use 'time_left' variable with wait_for_completion_timeout()
Date: Mon, 29 Apr 2024 13:33:04 +0200
Message-ID: <20240429113313.68359-2-wsa+renesas@sang-engineering.com>
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
store the result of wait_for_completion_timeout() causing patterns like:

	timeout = wait_for_completion_timeout(...)
	if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
self explaining.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index a602429cdde4..40ba6506bfc1 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -206,7 +206,7 @@ int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 	unsigned int mode, unsigned int channel)
 {
 	int ret;
-	unsigned long timeout;
+	unsigned long time_left;
 
 	ret = ad_sigma_delta_set_channel(sigma_delta, channel);
 	if (ret)
@@ -223,8 +223,8 @@ int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 
 	sigma_delta->irq_dis = false;
 	enable_irq(sigma_delta->spi->irq);
-	timeout = wait_for_completion_timeout(&sigma_delta->completion, 2 * HZ);
-	if (timeout == 0) {
+	time_left = wait_for_completion_timeout(&sigma_delta->completion, 2 * HZ);
+	if (time_left == 0) {
 		sigma_delta->irq_dis = true;
 		disable_irq_nosync(sigma_delta->spi->irq);
 		ret = -EIO;
-- 
2.43.0


