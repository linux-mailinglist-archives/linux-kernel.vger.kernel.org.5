Return-Path: <linux-kernel+bounces-123921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38588890FCC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A49F1C263F5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E447A33070;
	Fri, 29 Mar 2024 00:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kphj1Rg0"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A182624B33;
	Fri, 29 Mar 2024 00:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711672848; cv=none; b=DUjfjBECpgPHZByhL7DjMGBGQCdITb5UFPG7GxlJiwGOoo5jHQGRlQWEVa23YJNfuoMW9vTNERbdXLG4kLk3trEKsjC1SgvlSS6m2Yx+mO3pt6QF4amD39tElvbYZ0eyLQXXjAJkeRhC6vVb0POsBqGWsgeDNlXOkRBjz0W/LKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711672848; c=relaxed/simple;
	bh=iOF5ooHVjmTm3e7N+9rAkLaE53H/GI+M+pLn/x/dElM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WhgzB0Q/7yCJVaWKKA35F0mzBbMIZlJ5kscAi6tWj8troNFaMsqjGwvYVRCVhvcVqAUfy31VIT7kUXMz6eNXVYtLW749JhEmTkr4ceRVLyx1/1fegOhHT389AlCyDojgtJbdNnxcyhQ9ZbUdSOq6EzBK9FS7w4y7pk57/yq9AeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kphj1Rg0; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56c0d1bddc1so1818538a12.3;
        Thu, 28 Mar 2024 17:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711672845; x=1712277645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/svIv2C9e15PTWNlhHZar/uQPSIv6vw8UjxI/6w5Ts=;
        b=Kphj1Rg0yfP5jrYzPIgdxZV8s+uvx+ezFeblQgPly0gODhT0hCseD/JwFt8umtH+ok
         TX5WYopagF826pTJpM+Gl87cKCJ/4jX3rdxElUMWpb5tqe8T+DDjz4pwjugAM1QbGH5N
         v4G3UqO2FEMaOkC1u+A58D/CYyAfUEwKdJA2sIYti1rsyE5K230qmhDpZVhukTQVo7wY
         ZcfF6MvKt5yfEtJISsbby1388WoHvRZ4GBj+Cm4AgebnLMmaPZd3V+2k1mwUa1SjmZ1K
         MmWH8bQ+QKfgUh+YgmqR91QA+1fzJV6cCM5yitaRfAqYjHsimGGQb5hhs+9SIUHjcntl
         vmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711672845; x=1712277645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/svIv2C9e15PTWNlhHZar/uQPSIv6vw8UjxI/6w5Ts=;
        b=VohGOgweR+MMsDxfKUxhSH5ZI2qdMm75xVkU/U2NbWR0zRtLp2hRaFFhtpIepPgfAT
         a9H5l6qGk2kJUpzxAKZPlEKAEZIC1qgy9S2E96vjWowEsZVjvowhwbbPQQotR58QfLLd
         rblvCpSUxuZg4Bfb74GnmGGcNEB3BbKS5n4TjLk2hn7lNoW+wVHsaA7XV3cXJ02QPjHN
         mgXCncI0qNphu/MQSxLlJDtUENyRpJL076OKJizuN7HiHne4foKJ0cCPGFfZ17KxKqaA
         f25M1RnnV1KaNmnNXU0uNwk52g6m1oInYgeASz82+jIOU2QObqwGnD+7p8ncOEf8g3s8
         rXRg==
X-Forwarded-Encrypted: i=1; AJvYcCV5YpIMIH1m27iOdrYAqC/XIda1oebGtaNj3aXqKdH4hlDgIgTCamqgRl9lkWggqe3QZAb5aa417kEH7OoWzsUcCHlAYo3aIyLqPypsffILmLWOfjQ811fYgJqu3ph+gBHu8iQzboti1A==
X-Gm-Message-State: AOJu0YyvmELRt0aPrGErk7oIDKKFiOWItwSsO0kju46Qa58OwPfD0/Su
	QTcreAldAm3l6XlDx27nvR0fc0JogLsIRL9qhd5H2BMDn4JplddvRxiCRpyjcpw=
X-Google-Smtp-Source: AGHT+IFjJ3isLdm6BOegHgDg3syqe14nVS5fl3grTRapiWx4hSObTvmjEDblmElILTh4IvbUKm2vIw==
X-Received: by 2002:a05:6402:35ca:b0:56b:b5a1:4685 with SMTP id z10-20020a05640235ca00b0056bb5a14685mr555668edc.27.1711672845138;
        Thu, 28 Mar 2024 17:40:45 -0700 (PDT)
Received: from 13a4f82a8f12.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id h7-20020a0564020e0700b00568e3d3337bsm1391679edh.18.2024.03.28.17.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 17:40:44 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v6 6/7] iio: accel: adxl345: Add comment to probe
Date: Fri, 29 Mar 2024 00:40:29 +0000
Message-Id: <20240329004030.16153-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240329004030.16153-1-l.rubusch@gmail.com>
References: <20240329004030.16153-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a comment to the probe() function to describe the passed function
pointer argument in particular.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 83d7e7d4e..511c27eb3 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -168,6 +168,16 @@ static void adxl345_powerdown(void *regmap)
 	regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_STANDBY);
 }
 
+/**
+ * adxl345_core_probe() - probe and setup for the adxl345 accelerometer,
+ *                        also covers the adlx375 accelerometer
+ * @dev:	Driver model representation of the device
+ * @regmap:	Regmap instance for the device
+ * @setup:	Setup routine to be executed right before the standard device
+ *		setup
+ *
+ * Return: 0 on success, negative errno on error
+ */
 int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		       int (*setup)(struct device*, struct regmap*))
 {
-- 
2.25.1


