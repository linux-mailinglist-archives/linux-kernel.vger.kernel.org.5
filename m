Return-Path: <linux-kernel+bounces-162157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 234418B56CA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86D11F24E10
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D8D537ED;
	Mon, 29 Apr 2024 11:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ZYN+XvwW"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF85C524D3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390405; cv=none; b=sH72uSPlJwEc7rvMTG4K2x6ZRK6+F8EhDaKYmISrF2BMUVhsNnps9YMb7WPrjHQ300dWpSLGUKmC7xRwjWMS+V9EANrhWIXdIc8FwpV2G3uh+FKFE1BdEiyV+VH6CnsFv5blOSZHlFiAu8YAS3MAjMsbw6oB7Kyai1d/HfTzY8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390405; c=relaxed/simple;
	bh=TXBJ8kRFQEVxHoBSaGXMRzgHJL9lguRH+McDdALDhbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTrIzrrAgfF4eZnFACT49SjVWmTv6LRwUOfLDxJACrjkcE01LWoQWl+psb15ZyhwmSqu6TVuDSTwmp+wy4JkS8cP7owwOchrY51B5rc2z9T+mDPqvV51wH/DvAMZ1GNopJJBj4IE0Y24OvUUaMyu1W7JNgM7aJQ3HTZ8+1fzij8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ZYN+XvwW; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=bO1DtnMljUne5cLDZB1KSz1EuNPq+xZvMkPybT2DdrE=; b=ZYN+Xv
	wWeFNBOF4Y8yRRdjLfpuYYiOie4X6UwOAzSuoFW71Fm6/CrsOObdfXp3ZzJ6SeNL
	PFO348ThErNZ/rU+bjEP2bEMd78KMiWNLiwJE4S5jFIe+M0tGYpQr43qG2B83WIo
	98aPenf+xGgbq413oFMgJ/3dQsU9DDWdKDaTcq4L6xRR4z6kjV7NBJa8R0dnNgyo
	CeKLaJXT3Hae7NfDW+lO1wHhYrEaDQmPXTlj9jo7e97NqNUXlpYHXe7eYSNpIfFl
	IBjFj4e4NBgZuraYXNpnOUvZiHJFookG0aIjHvU0hdHF/yNBIhxQ0q29KhzT7rCy
	9skzpGb4Q0ZH7hHw==
Received: (qmail 2281181 invoked from network); 29 Apr 2024 13:33:20 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Apr 2024 13:33:20 +0200
X-UD-Smtp-Session: l3s3148p1@JvPGnjoXHnRtKPB4
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-iio@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] iio: adc: stm32-dfsdm-adc: use 'time_left' variable with wait_for_completion_interruptible_timeout()
Date: Mon, 29 Apr 2024 13:33:09 +0200
Message-ID: <20240429113313.68359-7-wsa+renesas@sang-engineering.com>
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
 drivers/iio/adc/stm32-dfsdm-adc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index ca08ae3108b2..9a47d2c87f05 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1116,7 +1116,7 @@ static int stm32_dfsdm_single_conv(struct iio_dev *indio_dev,
 				   const struct iio_chan_spec *chan, int *res)
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
-	long timeout;
+	long time_left;
 	int ret;
 
 	reinit_completion(&adc->completion);
@@ -1141,17 +1141,17 @@ static int stm32_dfsdm_single_conv(struct iio_dev *indio_dev,
 		goto stop_dfsdm;
 	}
 
-	timeout = wait_for_completion_interruptible_timeout(&adc->completion,
-							    DFSDM_TIMEOUT);
+	time_left = wait_for_completion_interruptible_timeout(&adc->completion,
+							      DFSDM_TIMEOUT);
 
 	/* Mask IRQ for regular conversion achievement*/
 	regmap_update_bits(adc->dfsdm->regmap, DFSDM_CR2(adc->fl_id),
 			   DFSDM_CR2_REOCIE_MASK, DFSDM_CR2_REOCIE(0));
 
-	if (timeout == 0)
+	if (time_left == 0)
 		ret = -ETIMEDOUT;
-	else if (timeout < 0)
-		ret = timeout;
+	else if (time_left < 0)
+		ret = time_left;
 	else
 		ret = IIO_VAL_INT;
 
-- 
2.43.0


