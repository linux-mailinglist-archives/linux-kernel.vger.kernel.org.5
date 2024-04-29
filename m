Return-Path: <linux-kernel+bounces-162155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6428B56C4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 409301C20BCA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DF5524CA;
	Mon, 29 Apr 2024 11:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="KtbDFO51"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7006D4E1AD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390403; cv=none; b=OpCqfv+k5Fq4HVoFzbnZvoMfooJNPvmRADoql/HNQvTbh5lUC2kv5mg7FGJhdKx8J+jw2CYl4TOH24XRxq7DV0P9GrfVG6W8Q4tW5JabVBus+PjWf1/89tc23cwWg7boGjWutTuzw6sFnE0TfDOv5R3DkAPbKzkFoyUQN9Lf+0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390403; c=relaxed/simple;
	bh=IGIx1rZpf+QAHUeiwtXKxVkLhI5SUIAGbDNEWThgGrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hd18PHCC2mdeeNGs74XZFElQXPHeoyCQvygAg1A0ovxVEwrkFLLjgRNvYPsn3U2M2BYjgIOd9JF9yVJHG9m5ac/K49ymEyu7B2dutXJ9UUp6PRR9t4fg+XCneU2YXfeV4Pk0L3vB5vK2ysOqNCJVOvwsIaCDUj8gUd8sK2dqOc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=KtbDFO51; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=kESE1b6S6hgZwP/UL/YPJJaCZtdxWblO0NQ4nm3v/zE=; b=KtbDFO
	51nAKvleMvjxjL+SqADxQf1vuV85E1TX7lAu9hDHurd01LvOchlc+m1ILLLXTvMa
	l8tc0OTHeDc9P+q2t9TH6H24sxfbtvCj6UcsLGoWbVrw4xoYK4R/mP0+zapslkFu
	xUqf+2V6ZdzBcsdJk/l6XcEmvIJ9Vr1kw/a9uI6YpEgD8QtA0F0xrXvqS1oDTfIR
	dfwyEhXsGQiVlTRyqPO84prfqbenN5i5c3JaCtYXSIbyqHzWIaM7R+S4RQuEhXm4
	D8PFS8GmiFC/lmYcSmgLwxSGmERbum8pdguVAeWacj5gJuHqfHVASEQtSP651Jbs
	z9wBC7rSIoThFcUQ==
Received: (qmail 2281106 invoked from network); 29 Apr 2024 13:33:18 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Apr 2024 13:33:18 +0200
X-UD-Smtp-Session: l3s3148p1@My2onjoXDRxtKPB4
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-iio@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] iio: adc: intel_mrfld_adc: use 'time_left' variable with wait_for_completion_interruptible_timeout()
Date: Mon, 29 Apr 2024 13:33:07 +0200
Message-ID: <20240429113313.68359-5-wsa+renesas@sang-engineering.com>
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
 drivers/iio/adc/intel_mrfld_adc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/intel_mrfld_adc.c b/drivers/iio/adc/intel_mrfld_adc.c
index 7263ad76124d..c7f40ae6e608 100644
--- a/drivers/iio/adc/intel_mrfld_adc.c
+++ b/drivers/iio/adc/intel_mrfld_adc.c
@@ -75,7 +75,7 @@ static int mrfld_adc_single_conv(struct iio_dev *indio_dev,
 	struct mrfld_adc *adc = iio_priv(indio_dev);
 	struct regmap *regmap = adc->regmap;
 	unsigned int req;
-	long timeout;
+	long time_left;
 	__be16 value;
 	int ret;
 
@@ -95,13 +95,13 @@ static int mrfld_adc_single_conv(struct iio_dev *indio_dev,
 	if (ret)
 		goto done;
 
-	timeout = wait_for_completion_interruptible_timeout(&adc->completion,
-							    BCOVE_ADC_TIMEOUT);
-	if (timeout < 0) {
-		ret = timeout;
+	time_left = wait_for_completion_interruptible_timeout(&adc->completion,
+							      BCOVE_ADC_TIMEOUT);
+	if (time_left < 0) {
+		ret = time_left;
 		goto done;
 	}
-	if (timeout == 0) {
+	if (time_left == 0) {
 		ret = -ETIMEDOUT;
 		goto done;
 	}
-- 
2.43.0


