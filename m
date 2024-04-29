Return-Path: <linux-kernel+bounces-162153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2A68B56BD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18FD81C20F96
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5004C615;
	Mon, 29 Apr 2024 11:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="aRUD4h14"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFDD4501B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390399; cv=none; b=F/Shi7TzTQckQ3MSa1kDsgcvId0lxQytn7zbT7g/dIuj3Rrz5ZPrLqyI0MapXDNjLA4M0voVbBJ4MBnE0JZXtrSdalyV91CFLWQxjwXPCfOM46GPUfbcCf1l+VmNfn1xUu3IewNaDptygmo5G2TrKP4QTBCXEvYxuLlJjd1t6xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390399; c=relaxed/simple;
	bh=qjQ+LYbUEfrBtu3ymflLP9dmO9tQ6/Bs/eoY36v4nPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYiDYFlPQsDQs7rBtY/QM1SG7GaqIk+frEB9ktfphea6Wt+jpkHISkmiSKMXndouY8Md3zJGH+mg8Cl6bG+cHZHVD8fEyHsJf/CZ8gI+F2BQxMW+xNUZ83MMxYQfKb8yaL8PgOFNV4wu+ZxU4dj/koXt+LZec6Z23Ei/muT+sfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=aRUD4h14; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=jF+95jMp/45NMjGYJKM23B9xKBucPH4GAO56Jky3844=; b=aRUD4h
	14HkB1S+ge4YmGYHgC6e8z1QFZnIGEwb7VW6Wjs/dhS7SsCqi0J0cylMLueUjaEq
	AzQQSTtE2ukCCPvolzhDzwOet/OsyfJOcsP25SvVacjNnIPJWbyZdsFy8AWWXQjE
	JEN7NjXU5WZUMCKOJpmTB6Ol2U6ck+VZnD04dRml5NzTEEhWiHVaybCPCekVY0SX
	wmEad53AvSdMQtbMvJigWFQ9xmNYNoXjBHokUg6x7Y2SfWGm5GOz3V0j/rPqtQTq
	M79guIWLd/tJTTBZ5+/FF3GuhfhySodEF9CpOXSgD15S6MjKwX9XSsEl/ppis9Hs
	eSMz0D9XYsDRI+AQ==
Received: (qmail 2281021 invoked from network); 29 Apr 2024 13:33:16 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Apr 2024 13:33:16 +0200
X-UD-Smtp-Session: l3s3148p1@fvOInjoXqG5tKPB4
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-iio@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] iio: adc: exynos_adc: use 'time_left' variable with wait_for_completion_timeout()
Date: Mon, 29 Apr 2024 13:33:05 +0200
Message-ID: <20240429113313.68359-3-wsa+renesas@sang-engineering.com>
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
 drivers/iio/adc/exynos_adc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 614de9644800..78fada4b7b1c 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -538,7 +538,7 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
 				long mask)
 {
 	struct exynos_adc *info = iio_priv(indio_dev);
-	unsigned long timeout;
+	unsigned long time_left;
 	int ret;
 
 	if (mask == IIO_CHAN_INFO_SCALE) {
@@ -562,9 +562,9 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
 	if (info->data->start_conv)
 		info->data->start_conv(info, chan->address);
 
-	timeout = wait_for_completion_timeout(&info->completion,
-					      EXYNOS_ADC_TIMEOUT);
-	if (timeout == 0) {
+	time_left = wait_for_completion_timeout(&info->completion,
+						EXYNOS_ADC_TIMEOUT);
+	if (time_left == 0) {
 		dev_warn(&indio_dev->dev, "Conversion timed out! Resetting\n");
 		if (info->data->init_hw)
 			info->data->init_hw(info);
@@ -583,7 +583,7 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
 static int exynos_read_s3c64xx_ts(struct iio_dev *indio_dev, int *x, int *y)
 {
 	struct exynos_adc *info = iio_priv(indio_dev);
-	unsigned long timeout;
+	unsigned long time_left;
 	int ret;
 
 	mutex_lock(&info->lock);
@@ -597,9 +597,9 @@ static int exynos_read_s3c64xx_ts(struct iio_dev *indio_dev, int *x, int *y)
 	/* Select the ts channel to be used and Trigger conversion */
 	info->data->start_conv(info, ADC_S3C2410_MUX_TS);
 
-	timeout = wait_for_completion_timeout(&info->completion,
-					      EXYNOS_ADC_TIMEOUT);
-	if (timeout == 0) {
+	time_left = wait_for_completion_timeout(&info->completion,
+						EXYNOS_ADC_TIMEOUT);
+	if (time_left == 0) {
 		dev_warn(&indio_dev->dev, "Conversion timed out! Resetting\n");
 		if (info->data->init_hw)
 			info->data->init_hw(info);
-- 
2.43.0


