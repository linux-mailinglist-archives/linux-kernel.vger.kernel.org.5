Return-Path: <linux-kernel+bounces-160099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C458B3919
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BC41C21CCA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59A21494B0;
	Fri, 26 Apr 2024 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFEw7VZj"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB22148FF1;
	Fri, 26 Apr 2024 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139635; cv=none; b=R7rw5pa7R4h+jOxCHMarqE8s7j+Jy65yfdWbTCp+C1Q/7HuyEkYpzshfp829um52N3MysV5AmLtqp6WDMf4Peh062Siox7dCzEQ0agBbdPpOVNay+8UQzq0bloqJV5qnnbVpwFonnQ0jYaONAbWJsVIDQK+2biSPcpMEsGDCefw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139635; c=relaxed/simple;
	bh=h/Hx+aYZbAbXmbGj0Ik8WkKfgY/vHtn/JI3zEtfWCgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cXZ9320Gemrf84EVcS+Izw4yygdTIVG51sN6GD7edCNOU13w46iG4z2M1mfZHmRqH+FC9rur6SrDPGx2hhX4NGa4Q3/2YWRNG5k/354R1Kue+CAoL9ermhbM1ivTXRHUie8h8/AKXx8Z2tAWYnDfMnM2P4j1xeT3dlsDQVVv6+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFEw7VZj; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-345522f7c32so836287f8f.0;
        Fri, 26 Apr 2024 06:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714139631; x=1714744431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MwfIQCOPvC6F/uoQcBOKTeL9AKl1tGcVcVmlDTCJlc=;
        b=YFEw7VZjRtZ1GKkdv7bdI9Fsb3zqxnQ85m+LRYpIL8XUx+nVSNsAj82ceVRv5B/bMj
         oeZbAExKcJHg6I5ye3uvokjNcHZO6w2FSbjDx2zfgvVhbPpkNdEtx7ygH0rpON7OZm7o
         PE4oAV/T+/lb44tPamb/pGE0xhz0R72ChX4T5V2wJr37Ml2u4N3XytgWfRJ6bM5um4YT
         GHhrimTz1Roa6RmkXQPzvuq3dfPGbDk9pFkKee/VJ4aKWzJivS8KfFq1ReM/bQpzmY66
         dkNP+zAlawf/fefuRPqJN2Kw3dsILuzU1ZRviW0sDuTXfdFA4DX80ap224TkzJ00NW1D
         e3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714139631; x=1714744431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+MwfIQCOPvC6F/uoQcBOKTeL9AKl1tGcVcVmlDTCJlc=;
        b=hKLpHOh7ES2t1uJFwQ26jdZ/rDniwrdN4uqtmO7GvxtqMP5N5ceXLDu2ul6vWQn/ii
         TJ8YFX1lHCqJLEgvJ1aJ5XFr5yff9JpSIVQSe9DkFR0stxbK1loZfKPf7fCR7TiSvMmj
         QgJcVwflGc0Ba4QWtEz+w47iK3Y7JO/n5MmbRkUtBcAPoQpiTlP/rFNxzhuCqg8+sHnF
         1+SuRmokO++sRNwu9josKuBBAzjAPJIq40zwiOTuekSsQxDShbjEzXHNXxU9rb5/tbfX
         TttZgRHdE/1OU23Z1rIdUj7d8Ye8pSwzLCr87XRxQzLGJnaNZYsvYU5RoLtQozM68D/n
         fv9g==
X-Forwarded-Encrypted: i=1; AJvYcCWQMCXi3CloYof3zm7+0ESNBi1IHMWkNZM1bWan5ZdSPLdKiNHeBJk+PSqUm69WonQV8RmJwAHvMbvQMhEKeahTabPrTbCc2pA4GYcp1wdQc4auVQG0Xh4V7HvVFsucuHj2/vptgA==
X-Gm-Message-State: AOJu0YyP4e/oSbUDeUj2RsAwp8kGds6Len0gbC9Cj4pFOZO3Z/7T54tI
	IXVCJfjzQN/jtq4tdQJ3xOuOTMd9Y8yokSk4KkOChA7iZZT5XumNrxnWGIRd
X-Google-Smtp-Source: AGHT+IEFbchIgRtrmoBqCudsM/hNiimstfW8TKY4Q1h8Ad5JRzvVeFpFEtTF8aJIjZoL4w96eXappA==
X-Received: by 2002:a5d:60d0:0:b0:347:5f71:9510 with SMTP id x16-20020a5d60d0000000b003475f719510mr2442145wrt.25.1714139631089;
        Fri, 26 Apr 2024 06:53:51 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:320d:e800:f4f8:b5e1:d7d4:bf65])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d6d46000000b003434f526cb5sm22302919wri.95.2024.04.26.06.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 06:53:50 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org,
	nuno.sa@analog.com
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Subject: [PATCH 5/7] iio: imu: adis16475: Create push single sample API
Date: Fri, 26 Apr 2024 16:53:37 +0300
Message-Id: <20240426135339.185602-6-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426135339.185602-1-ramona.bolboaca13@gmail.com>
References: <20240426135339.185602-1-ramona.bolboaca13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create push single sample API reposnsible for pushing a single
sample into the buffer.
This is a preparation patch for FIFO support where more than
one sample has to be pushed in the trigger handler.

Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
 drivers/iio/imu/adis16475.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 52333772fbe0..7cfef553f298 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -1249,9 +1249,8 @@ static void adis16475_burst32_check(struct adis16475 *st)
 	}
 }
 
-static irqreturn_t adis16475_trigger_handler(int irq, void *p)
+static int adis16475_push_single_sample(struct iio_poll_func *pf)
 {
-	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16475 *st = iio_priv(indio_dev);
 	struct adis *adis = &st->adis;
@@ -1340,6 +1339,15 @@ static irqreturn_t adis16475_trigger_handler(int irq, void *p)
 	 * array.
 	 */
 	adis16475_burst32_check(st);
+	return ret;
+}
+
+static irqreturn_t adis16475_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+
+	adis16475_push_single_sample(pf);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
-- 
2.34.1


