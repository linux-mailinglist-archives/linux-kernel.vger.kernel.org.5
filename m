Return-Path: <linux-kernel+bounces-57271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF9984D602
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844F31C216FF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C081CFAB;
	Wed,  7 Feb 2024 22:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7ZlLYm9"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1EB1CF8F;
	Wed,  7 Feb 2024 22:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707346004; cv=none; b=VbLAWHhdbtkZ44qmCKAKRc+r6MVww2SxdCE6ecLNiVu7bahCEvbH2qA8TxmkcMpM5NVVwI1SLfEt1/w2dWcCzO6Cc6oXlURJkxys7PyibXPPfPpHWs5h/+khM2dBBJgX1I1sBtNy9reuHjJuE29wdpLdwn8ZCtKSnzaDYJbLC6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707346004; c=relaxed/simple;
	bh=srEnOo609aZRRPxf38hr0wuZqh+Fyi8S9QuHLXUVF24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDVfPdMjoHBZx4MAm+2hjmTsDeO3vNaWfGHkseBKiHGpEN+mmcEM85Ir0ZZzwQrROPhnvG2xQQd5SMTjJJg5IPINlGz7XaH3zaAk/XUVOWypUbx6YuvOAu/gOUzuLhSPsS5vdFtVPCxYZsw5nw6Q/1bSoHHYNMJnIEXytBrXgO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7ZlLYm9; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51165efb684so2203782e87.3;
        Wed, 07 Feb 2024 14:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707346000; x=1707950800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPVQAbb7Z8lRSdP7gtfoXxA2k3RMbSoKja9V/cBhniE=;
        b=C7ZlLYm9kf2xSzicCQRr54ASLnJfl3TsZuS3igh3aHnoQRhupJlCJfyxnbRGF5OZJ/
         aIIEUwrbY6yZ3+NPkWXi74/xjIcJRixJYQt9ssymDom72txSyeL73Br/OPLIaXQy7o6c
         4/QrHHymT4YOS/TzUcOaQBDoMngX7UOiY3r7WfUhol/2r7aT8leWSY+LECnKanBLiN2a
         q6VYf2eshDwCEKwotzqooPdPCX6d2CizIBlesXc5LytvYYcdZFL2haMRBSAnDz2zlz8b
         HL/z6uY4/Cb7xvIjEWruF9BCIGMDad42JBgaEj/aQImejKZdG4lZr7jqCnjar/MM+M2H
         qMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707346000; x=1707950800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPVQAbb7Z8lRSdP7gtfoXxA2k3RMbSoKja9V/cBhniE=;
        b=r0RTP2hfNv8pcxETs4f1Rh14hjnWvjseAJ+Tc0Db7X3LaorBNfvH5Io4r0XRXwLeGG
         AJAvBoNi0wIx7UIPBuxXNfTsZe8w+qWw8NbQFqJQJ4hU7stBbSlxW40T6SnyGshDFEJN
         im6U+1Z/F3RBm0oECt2wzTc55qV34pY5BNMIh7BY91SdbAyX3NFASIL7iKdoe1k2bUbA
         clCxbExQZ1XcAhq/qEOTNQd5gTyW97W94O1fpEepKPEs4UJNeGlpv1XXlzcsq6py5rD/
         1rS7BXujB08QqECfZeb0jeP8LvrkWP/NmK0OZm7Wm+0oElGv4yJqGRLqlLWsIqbXjGRr
         dGNg==
X-Gm-Message-State: AOJu0YzdCHHdKsgexo1M5jsEVMS9hT+tvq5pi34FhTPECcwOqV8gY6Ad
	Pl/mb/n3DbTLxLRFO1tHCkXsoz/Cj0lkiNbb0cNNhP9TukhbZso=
X-Google-Smtp-Source: AGHT+IHi3Ybg74ylC26r5ZmpeRYFBH/+gKQ/b2ir9l8j4ciISpDHHPV52kHPKl1u1+JRqO2w+G71iw==
X-Received: by 2002:a05:6512:2009:b0:511:48fa:5c5a with SMTP id a9-20020a056512200900b0051148fa5c5amr4622070lfb.16.1707346000301;
        Wed, 07 Feb 2024 14:46:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXrC6l247Q5YZ2Qw7iNCkNPQoUyOjsVpmAlFUFEuN6iEQH66UrB1i6y6f5d2Hy5n2O0hzsMhByegLxiVyYgvocIyjS/LChEzN/EXRBKiO6a25Zn02aN0pS5PKo8gdNW6lSpzqNjK3vIXFLNUlF6W0EC2H2kDcQDq0k1qOmFiD2SYbSJKE61PNHpNSduS2oFi3ty+VKSCa8zQTCfO6rvPNAZmMfsElVWezrvFcuRS7WigotO09qrxRGi8ZR5WK47qNPCJ7jBk+/KkCDuJUbevUvITBA35FodKS7D4UcFJatRcikVyFbi3RUbnWLZ7rCY8KkGgU4SjXecRzO6T6rHLDYPSQDTMdHqHtkYIcHPwgspwyu2kia4INDO1ySw1PewIf86FfetaMz97YJmzRV5wv7ucKub9ButQV7GwgG2IiQzLxq6TLdwlg5Wxj5VxpvXlF6yMMu1ykKC+BOfocrvtNj27bjKl0fJXXzu4oKXnpenCIXwxofPdFIjlkS/i7IP2FZEr7nyY++ADfv6+fpcPxw2xJqd0u+9gt6j/BI0SgDHw9e9+DPzCxR39dTMj3YSaA5pmf3XFQXe5n60363OVCI2xxVFfJJbnyQEdYOc38t53Et0YbbP42a4MNqNA3KX6tM4yCRk+93hG9aaIeIhsZs=
Received: from frutis-latitude7490.lan (public-gprs393011.centertel.pl. [37.47.166.116])
        by smtp.googlemail.com with ESMTPSA id rs6-20020a170907036600b00a358b6242fcsm1217449ejb.114.2024.02.07.14.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 14:46:39 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Robert Marko <robimarko@gmail.com>,
	=?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Marek Vasut <marex@denx.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andre Werner <andre.werner@systec-electronic.com>,
	Lakshmi Yadlapati <lakshmiy@us.ibm.com>,
	Fabio Estevam <festevam@denx.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v2 1/2] spi: spidev: Add Qualcomm qca4024 device compatible
Date: Wed,  7 Feb 2024 23:45:22 +0100
Message-ID: <20240207224546.44030-1-frut3k7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZcH9u7Vo2sFERIHJ@finisterre.sirena.org.uk>
References: <ZcH9u7Vo2sFERIHJ@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add compatible string for Qualcomm QCA4024 device.

Signed-off-by: Paweł Owoc <frut3k7@gmail.com>
---
 drivers/spi/spidev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 655f2c959cd4..0126a457a38e 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -710,6 +710,7 @@ static const struct spi_device_id spidev_spi_ids[] = {
 	{ .name = "spi-authenta" },
 	{ .name = "em3581" },
 	{ .name = "si3210" },
+	{ .name = "qca4024" },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, spidev_spi_ids);
@@ -734,6 +735,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "lwn,bk4", .data = &spidev_of_check },
 	{ .compatible = "menlo,m53cpld", .data = &spidev_of_check },
 	{ .compatible = "micron,spi-authenta", .data = &spidev_of_check },
+	{ .compatible = "qca,qca4024", .data = &spidev_of_check },
 	{ .compatible = "rohm,dh2228fv", .data = &spidev_of_check },
 	{ .compatible = "semtech,sx1301", .data = &spidev_of_check },
 	{ .compatible = "silabs,em3581", .data = &spidev_of_check },
-- 
2.43.0


