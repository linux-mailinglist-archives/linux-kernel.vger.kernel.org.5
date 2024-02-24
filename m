Return-Path: <linux-kernel+bounces-79613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C584C8624B2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D2B3B21DC8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020EB4B5CD;
	Sat, 24 Feb 2024 11:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C9RvLeJW"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F46347F45
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 11:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708775157; cv=none; b=ETEfpMXxCHGw8cAZn3xfdvMF7ZqTb5qoIFr2+t9mhOGTID5cqST7+FunY/x5M9IFuQaHuiUfI9nxxwVwibjsicIA1r0dBvaLqeLReUp+W2+oG9uepZ3xh7iXLx3RV+hhaJFRpnMOFwf+6MohALdvtRvimgZgCVfKnIWz5e7WYcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708775157; c=relaxed/simple;
	bh=qePmAjtuUmkhoRgEQQyBxfVAGVP8TSqgY/vpB1bKGqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aMv5BqVmosQKpyOt8iTbY7B+k4ULIZlj9JCkrByWU2e3ifxdh/7I4nScJprpEB0QqEtMXcmeQJyGLVdrFMhd3yNc+rhIX4tz+pInKIxI9lMtZnZCvlvsB4MioWTWkafYAEkONO403aSqRtYhCm3IwDbmAoWPnvPXpptvnXimDm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C9RvLeJW; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3d484a58f6so235387266b.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 03:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708775154; x=1709379954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtChYB+TgygG9shwdHbx8fKoevWTRa0yIf7GVv2xElo=;
        b=C9RvLeJW5iaxq5inY3zmX/T9DViyc+3POeS9F97wYoXP9Gze83U520A1jQ/a+77TMc
         9rZqiFvyATABvBj+WWNVBxRGH4ADF4FOfnMZIiRz03Vm3MZqbB4q38F5tKyaOC4koV+o
         RMTFDfnPJv3wNbOmpJeVOxyrZO2JmOuMbEIDW6ocR1M3oejrDtHZWNdY98zj6cYvY4hv
         UTzp7ytW2AgxH7A0vF5QJnFIcI9AVEI8ndwvaO6tj+ktvk85jPGILzZoRCbawC8G9X1+
         znK08ZK8arAX0Fn4WV3SpKMRhdRNkuhNdLOjVQxwcs4TNoMDmI6BB/wD3TrBaUPr1Pn6
         VX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708775154; x=1709379954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qtChYB+TgygG9shwdHbx8fKoevWTRa0yIf7GVv2xElo=;
        b=XChamYsKcIALQhPHJ4/CMgIGjkLNefCkaA9YXmFVB+QuQRcQHkqawrhAvv/YPxZ9p5
         nMLADBV5kjuafFN/xYBvdg0Gue837oqCm80KZngN1yPW/+U1qOY9k0l8t4bIiAQGtM3Y
         bY7JAkfHocNND2TXpgpHjFnCeVl0sDSMuwZPPR4tmW5CKVRXuJ4My4/5onB7q5bH7CDr
         Hu4O3sUhvIhe+S7m7iiarGhmW4+XVKFavaYEIhms56ift58p8bRWM0hhDV0tChX8lMUp
         1RJFfslt1WciH18PzBwxJo/e5gINbCsqIyCea5QOFnPyHpFT6XUegEUBCdapwmIPWnfl
         c/Vw==
X-Gm-Message-State: AOJu0YzK1EsqRSCUfNMaYOuDOmXg5stDygsdcbQXXPBdwiotJN7dblIk
	RsI1TCuZ0BXpagTDZJmMpIug6EN0tBf3Z5yPTnuIDSnxCyAcKgugF+eURcE5u2c=
X-Google-Smtp-Source: AGHT+IGFsrg62BcQq4Hd2eYZW7TiW/+mgkewcoY6Z9gPT9nTFeLQQbtE+qKKR97GsR6U24rJTQzDIA==
X-Received: by 2002:a17:906:ae48:b0:a3f:4516:ecf2 with SMTP id lf8-20020a170906ae4800b00a3f4516ecf2mr1506415ejb.32.1708775153722;
        Sat, 24 Feb 2024 03:45:53 -0800 (PST)
Received: from localhost.localdomain (82-132-212-111.dab.02.net. [82.132.212.111])
        by smtp.gmail.com with ESMTPSA id jp10-20020a170906f74a00b00a3e209b225asm517826ejb.43.2024.02.24.03.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 03:45:53 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 10/11] nvmem: core: make nvmem_layout_bus_type const
Date: Sat, 24 Feb 2024 11:45:15 +0000
Message-Id: <20240224114516.86365-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240224114516.86365-1-srinivas.kandagatla@linaro.org>
References: <20240224114516.86365-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1198; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=oroRW+eWACABp1DyN2gHfe1cb5uDZcxEYMDPbkXgEzc=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBl2dbMU1i5dkCaPx0DtDqGaZ2hoRzjAiH1iUJY8 FBYasybkBiJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZdnWzAAKCRB6of1ZxzRV N7bNB/9oDtL9RE1lkQSk0+5RrKT6y3tqPK4C7Na//B1cH9J5y0gsgL8xV+bM9rLuO1y/fdcvxQg rHThGclMwNm7fYYCT7KzVC+O0aE0UEjwb4s63rk6LDX4LGNw2GsgQ6dkrK6neGfw4qYsWHVGnzi reMRvErbDNnBl7sEDBVUVb4X/6dqEiFxR8uwwiM9UPSe5Q1wIV7+FCxKzcy+ZSVAHOjoOJtLtMO ZDGHplP6cx5r7ocgS7/ra298UTVf9wW9iVlC7R83YtQc0mDS4rox504D4c5zVvTCfpmtcGGUG9t lMCixjzcQuzTgfudNHYltBgTgpdN77S308bOh/ibTIBrtsF+
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: "Ricardo B. Marliere" <ricardo@marliere.net>

Since commit d492cc2573a0 ("driver core: device.h: make struct bus_type
a const *"), the driver core can properly handle constant struct
bus_type, move the nvmem_layout_bus_type variable to be a constant
structure as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/layouts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
index 6a6aa58369ff..8b5e2de138eb 100644
--- a/drivers/nvmem/layouts.c
+++ b/drivers/nvmem/layouts.c
@@ -45,7 +45,7 @@ static void nvmem_layout_bus_remove(struct device *dev)
 	return drv->remove(layout);
 }
 
-static struct bus_type nvmem_layout_bus_type = {
+static const struct bus_type nvmem_layout_bus_type = {
 	.name		= "nvmem-layout",
 	.match		= nvmem_layout_bus_match,
 	.probe		= nvmem_layout_bus_probe,
-- 
2.25.1


