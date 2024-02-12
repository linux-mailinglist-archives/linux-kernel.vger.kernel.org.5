Return-Path: <linux-kernel+bounces-62534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB5C85227B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55E63B23F58
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C8F5102A;
	Mon, 12 Feb 2024 23:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="n2weUlzU"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9204F895
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 23:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707780479; cv=none; b=gQ5H46E+MT4S1Sl+r3C7+vbsPcUBIjE/E1y2u8kPklTH0qSwz+icQlJPmIes6pJ/mTmINuq2cySnPFbMVj+OfFhb0R97InKfCOO2EGruJ8dOwzzLBv8g+oXwgoajgQLPTaEqWnD1vTKWCPJNdld3Ug1E2d8SN+IcHt37TrjTdJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707780479; c=relaxed/simple;
	bh=gJ2uzCt6zEhXarHM9Z30NiaY+auYzoaf143QGmaQzOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjcVR0udCSX3l3AFvfQJHhMlYwA/yh2dgoocf+/pwIWyajCgNvA3DZBSrWlhNtwTulzhWhT6XgEjfjLv06QhvVlsZK880Ax56Ge4eYcy3KPdMycZPYZNIKYI25hnwHRx76xD3kjjJaQ99+3pvFY4+tpWYiz2JE8BPV/BeD5+trE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=n2weUlzU; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-21432e87455so2433983fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707780477; x=1708385277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wgg1LuqsL+txmWYsX1bhtUmhJO0NDo1N/7wvtQZvjZE=;
        b=n2weUlzUesDczyqsWvOYbEhW44P0aDqv2zPmd+NrhziMBHOa7tEioDjvcmAXTrMefH
         WyxWAnUXkkRnJLA21/rDjN1KewOy5vuT335ZVi0dTZ1qnq5HhplLTWdPK3QBOphJrSVb
         nyWkLI9zifSilye7OOM1XMl99hWe+q0csxTqczgSzLXV7OB4L/lkC3RLJ3fNk9WGwQzu
         wMtLyRdpjE7hBiUZCz1gYkyQoo6C/jwONPyMPvuchkfrDazV5yRhbZsGcgiUdRzWcv8n
         MPHLDkSQKVgeLTws0yIkRso5xitohWtG68UmSO6PSr7KCYzKWvSXFXJvTA7RdPdSul6/
         n4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707780477; x=1708385277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wgg1LuqsL+txmWYsX1bhtUmhJO0NDo1N/7wvtQZvjZE=;
        b=skrU6RNZf0ld763f37cHHOgMj+hA7rzCjmEitEvgO9EGbsw2Nla0twC7zABwLKvTbv
         mrAlfvh7fVuGm43Z9L2vnZSgYzxmDZ9bC3190Hxavv4YO6H7Bcno38egr3NDvxXMQvf/
         LkLJkDLCOkhrY2qCU9krZmu2YZKncPgKRPPeFcHbuAYyTt4TS+9IvE9EN5XalpULrdic
         BNfbed3etNGFcE8VyFoq+NXkFsOR2d+3VLNW/Pm7FEdawOQXB9V/lHdrxsMzJJX4fdHL
         Wvgz71tccVa/DCcXkjxptsnrsT2qV6IZOtS2XumWvwgIPSjULMyL6Zj1VjZdA7RNi1uw
         aIow==
X-Gm-Message-State: AOJu0YwOnHmSBKvlzCELg/LFCQ0fS4BAJZtZfonOGYojUGgpoBF/jrmV
	E4BkD9CAAAO6Aku7AWXKHCLDC14yNeDJff6LiKglfPgfeQV0b6G+5CcEmmDI+ws=
X-Google-Smtp-Source: AGHT+IELT5R44AE8dFtwqd5bl+J3kkdcmv8gPvy1/OPh7cRterQinbELctzOchigcD1RHaK44PYXvQ==
X-Received: by 2002:a05:6871:20a:b0:219:77b5:efea with SMTP id t10-20020a056871020a00b0021977b5efeamr9731725oad.52.1707780476826;
        Mon, 12 Feb 2024 15:27:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVC+/BMjkbKS/YbJkbW+yDdREhJQUURkROBdWkmvdgRrc4cmkOXx308t4GOolDYtSDjDM4HHnBMbUlxYSyyBsZcnfq1pLOJPF1oWxWk+zFOQY+ub9Z3iflpRl3q/QflYQh9UbrZtPKEPnnZMGKjsTCpXvqIH2flK1o/rPQYVBd3YfK7H7H8RABG1U8jTCfjhFL7DiRSQZNeelRZRZmhWBzsFEUhtOu1564EhwvNzr/gDVT5spJByD6wHVyvHex1sasvrnGLyi2jxwKPJgBwlUK2wXNw5vuat3K3S9Nk2vra0WgOf+JOXZndnhfTDdJgm51LYnCIPmwumgUzRD0jAlbH9vEkRHDdfw5S+8hrGkbFiIWX/SBpaUaaBJiL8cZ54jW8JcRGdKHmm5dQd76JHjX78uoX8NMgKNMpcTxmzHSk2zqGRh8/Xqeaa+fcMSfACkuZ9BVZjuGOUo0ZyHGGGAqhme0nqmaSTsP34XSiGFNloQm86nymrhYFEvhsUyYbchCU8/NnRS6yWt7hJiblyWzf44YQ/3Y=
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id pk17-20020a0568704c1100b0021a7a45e0b1sm330141oab.35.2024.02.12.15.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 15:27:56 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Martin Sperl <kernel@martin.sperl.org>,
	David Jander <david@protonic.nl>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 3/5] spi: stm32: move splitting transfers to optimize_message
Date: Mon, 12 Feb 2024 17:26:43 -0600
Message-ID: <20240212-mainline-spi-precook-message-v1-3-a2373cd72d36@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212-mainline-spi-precook-message-v1-0-a2373cd72d36@baylibre.com>
References: <20240212-mainline-spi-precook-message-v1-0-a2373cd72d36@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Since splitting transfers was moved to spi_optimize_message() in the
core SPI code, we now need to use the optimize_message callback in the
STM32 SPI driver to ensure that the operation is only performed once
when spi_optimize_message() is used by peripheral drivers explicitly.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-stm32.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index c32e57bb38bd..e4e7ddb7524a 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1118,6 +1118,21 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int stm32_spi_optimize_message(struct spi_message *msg)
+{
+	struct spi_controller *ctrl = msg->spi->controller;
+	struct stm32_spi *spi = spi_controller_get_devdata(ctrl);
+
+	/* On STM32H7, messages should not exceed a maximum size set
+	 * later via the set_number_of_data function. In order to
+	 * ensure that, split large messages into several messages
+	 */
+	if (spi->cfg->set_number_of_data)
+		return spi_split_transfers_maxwords(ctrl, msg, spi->t_size_max);
+
+	return 0;
+}
+
 /**
  * stm32_spi_prepare_msg - set up the controller to transfer a single message
  * @ctrl: controller interface
@@ -1163,18 +1178,6 @@ static int stm32_spi_prepare_msg(struct spi_controller *ctrl,
 		!!(spi_dev->mode & SPI_LSB_FIRST),
 		!!(spi_dev->mode & SPI_CS_HIGH));
 
-	/* On STM32H7, messages should not exceed a maximum size setted
-	 * afterward via the set_number_of_data function. In order to
-	 * ensure that, split large messages into several messages
-	 */
-	if (spi->cfg->set_number_of_data) {
-		int ret;
-
-		ret = spi_split_transfers_maxwords(ctrl, msg, spi->t_size_max);
-		if (ret)
-			return ret;
-	}
-
 	spin_lock_irqsave(&spi->lock, flags);
 
 	/* CPOL, CPHA and LSB FIRST bits have common register */
@@ -2180,6 +2183,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	ctrl->max_speed_hz = spi->clk_rate / spi->cfg->baud_rate_div_min;
 	ctrl->min_speed_hz = spi->clk_rate / spi->cfg->baud_rate_div_max;
 	ctrl->use_gpio_descriptors = true;
+	ctrl->optimize_message = stm32_spi_optimize_message;
 	ctrl->prepare_message = stm32_spi_prepare_msg;
 	ctrl->transfer_one = stm32_spi_transfer_one;
 	ctrl->unprepare_message = stm32_spi_unprepare_msg;

-- 
2.43.0


