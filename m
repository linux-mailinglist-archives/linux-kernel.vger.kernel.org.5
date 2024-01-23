Return-Path: <linux-kernel+bounces-35544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ED28392FC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E5AFB275E4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B89660DC8;
	Tue, 23 Jan 2024 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DD3Epgh7"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFB9605DA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024076; cv=none; b=WPIwc0f1s+bGDtnsOwahBzNPYs4dDM60oaB01J+ehYc4ErR37SovHrsr05cvaXkWvgMuGBhgJ2iV+txqsB8fjyMH4z4T5wzBoDNbvlpc3b3NxP4VQ2n0IE4nim4wbWjjZi5uaRHTmW75Eb3eDjbD6Xp53sp0yDjBGotz4N9TKks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024076; c=relaxed/simple;
	bh=QjcMm60EHmrrPnLyPrTWWmevfQdmeVmDZZx9RXXvrVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5kolcbuKuuorHc2j1JUWvEYBVwRTPdH7e8dQLz52GpmnV+PQ8NbElZb5IBiY3NJsVkNe865UpLSonrsQCs+4byLm7WSTMH211+EkZOE1iOUNty/XtmqrFnEY64a7g7i5do9kNSc03nNe5Lyv9oVXyt7C67brBDHKg0Px34/xQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DD3Epgh7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40eb2f392f0so12141465e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706024072; x=1706628872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHAMCRAZbqujp5tmnqVlu3xbp4r52puiDbaaPDxhoS4=;
        b=DD3Epgh7opd+bJhGNw94Y4JVekJxZThMW/ROrirqEUd7XTr1bRcfptWq+zLsuOtRyt
         jMUuQuundcUB9sptCJRmoHl0tMIYjs4gcWRek7VjcyIBYLJv+tnrUSuL0q+eoHiHvJjI
         LxlT1KC2qva/WRhouSwScSrKoZoipMK9fqnhd8f4ihc0HWdfmhafDCb+PySFSkXXIbpx
         5/tM0BJS+tf66/DoVhfSDJDTweaBRuK2pbelPbFbHZ6cdnI1ivglN/0MQeNwW/7YG7nx
         Km8MslCYqVlqWj8hVTrcnHZa/ZuSQEz5nASOoLdOMEurVgPQaEbEZUgp8gttLe1EZ/cN
         qsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706024072; x=1706628872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHAMCRAZbqujp5tmnqVlu3xbp4r52puiDbaaPDxhoS4=;
        b=KKoT5FiyC63chM3St/DLCHTHTJjM7B4JOi72Zb6FmwxW/pt1dSXTv+slhiwTZFfCwy
         nShAFSEq4+6UZVo76SWf2RnPp0FONLeKKF3dUI6p5dvJmznuVg2kLeYrA102SLtEyNbB
         ixrzpnN1p41vKaoZcJ3/jBNy3s+QC1gqc4MCiqPcTQs02u0RUhGdgQqgmSHzaoOr9izx
         gbdxgFD0FYAyVBO1/t1adt3NkYYIuFdUIbphsJo6xIaQ3gegEEdSw8Aa5rjd2zP0r8yL
         zqAe6WG5E/S9Qxno2NEZItqtHza71tgQ3oGxzInW80URpnk5QLl8CYZVcGU1X6Zs397h
         uD0w==
X-Gm-Message-State: AOJu0YziSyWDz6jd0s2XENlsJnVOr7b2uAbEbuoYDvXijJi4T5BGHxqM
	TYRUk5Tmaco238AVa/OyB4PxFYYDufoyi5hpBch9VlgpBq/Cvms1X0j/8WCKYOA=
X-Google-Smtp-Source: AGHT+IEawZ2QUjKQsybqiQMynrw5FMreS9VpG6oekTM7Bcb7Eww/T8JFnJKSGqnlZXecULPsUM+uMQ==
X-Received: by 2002:a05:600c:21d7:b0:40e:53f7:a254 with SMTP id x23-20020a05600c21d700b0040e53f7a254mr255145wmj.73.1706024072434;
        Tue, 23 Jan 2024 07:34:32 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b0040e3488f16dsm42457536wmq.12.2024.01.23.07.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:34:32 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	arnd@arndb.de
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 08/21] spi: s3c64xx: move error check up to avoid rechecking
Date: Tue, 23 Jan 2024 15:34:07 +0000
Message-ID: <20240123153421.715951-9-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240123153421.715951-1-tudor.ambarus@linaro.org>
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the return value of wait_for_completion_timeout() immediately
after the call so that we avoid checking the return value twice.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 16eea56892a2..128c3b8211ce 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -519,17 +519,17 @@ static int s3c64xx_wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
 
 	val = msecs_to_jiffies(ms) + 10;
 	val = wait_for_completion_timeout(&sdd->xfer_completion, val);
-
+	if (!val)
+		return -EIO;
 	/*
-	 * If the previous xfer was completed within timeout, then
-	 * proceed further else return -EIO.
+	 * If the previous xfer was completed within timeout proceed further.
 	 * DmaTx returns after simply writing data in the FIFO,
 	 * w/o waiting for real transmission on the bus to finish.
 	 * DmaRx returns only after Dma read data from FIFO which
 	 * needs bus transmission to finish, so we don't worry if
 	 * Xfer involved Rx(with or without Tx).
 	 */
-	if (val && !xfer->rx_buf) {
+	if (!xfer->rx_buf) {
 		val = msecs_to_loops(10);
 		status = readl(regs + S3C64XX_SPI_STATUS);
 		while ((TX_FIFO_LVL(status, sdd)
@@ -538,13 +538,8 @@ static int s3c64xx_wait_for_dma(struct s3c64xx_spi_driver_data *sdd,
 			cpu_relax();
 			status = readl(regs + S3C64XX_SPI_STATUS);
 		}
-
 	}
 
-	/* If timed out while checking rx/tx status return error */
-	if (!val)
-		return -EIO;
-
 	return 0;
 }
 
-- 
2.43.0.429.g432eaa2c6b-goog


