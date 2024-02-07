Return-Path: <linux-kernel+bounces-56444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3127184CA3E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C3A1F29526
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4D31B803;
	Wed,  7 Feb 2024 12:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WEzeKvAi"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903193C6BF
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 12:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307492; cv=none; b=HEUbfu03YGOYAnpVsC3RVShULGN38VRuECl9ONOo1Jf3Bd3lag5FakUOccWRr5uCtZbZILvEQNqgCOSOU/kQN0Sr1tgdhf5mko9CDxje4SM0T3HcRNwxC9DOgkHft6KBIPLeZ46wuhWfzUkSlUQIQmCOy+zRNDWCJtcFoB5WtxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307492; c=relaxed/simple;
	bh=tcvkG3IuArguTBs5+oJ4pHS+pBXtBmiVEQi3ZFzSJVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eIGo2iAiHGp/ngpFCJv1yS9K7S3QBo93ZuWHYcnpX0fYzqJ6/3xjQ7UX2dIhqCyltgElkNbm0BIRlYTscr/mi5YzbYmEGdqyNyex97QZeZuZdisM5QQCbFgHRozNZgSTQrzKHDy5ndx6O/f28KwqAHOpnjptvq/blLSMKcqMqh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WEzeKvAi; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33aea66a31cso347825f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 04:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707307485; x=1707912285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVi6POW2wsm4t/zvRlXFF0rH5aMJzAofhX+zIRsv7I8=;
        b=WEzeKvAiBYJ11nViHOd83qD6En8/8FvY/Lrt7E6VmP5kHWpJWAiPNteXf781b8Z0KN
         M4I2rLgW5y6J/6Fvt1anoT6ljNBAGFy7jYVAh9efx0mz9x10C6m1FLCzEYWrN6oYHMAA
         EhdzIqLCU/Y3FoeDJaqB0nlXtMEcF4Nxyw6qVyVVzeesbhr0C/W01UiUZ+5M7SpAnY52
         TaEfgEvb+yGxuZvbGpj2Yk7eF3RkcNq7Wmg+rwif7ubLxstwLpBwvppRMZ4QJ9eYNltx
         G83rR9UcTw0ZV99b1Q9zVLZ8951tyKOJgiKnY+CoszvUWLkVCeX1QXThYziM48Wvi8SJ
         wB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707307485; x=1707912285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVi6POW2wsm4t/zvRlXFF0rH5aMJzAofhX+zIRsv7I8=;
        b=pLca3Xnxi/sNiCzUszKORjyp/kKVEuRYBws6rvRsO/pHpfRM+UMBjfIPK5x9iGwolI
         AiFUUPuIXn3T4BPY21bkLpLRgsZ0xeUkXI18Ej4J0YIRx9JVgmCWyahU+B/BBZlZPkeT
         8isfMA+4CGWXhMsIOE3cQ+OUvHUudb/pyhBUp9zt3+OMy1H80BJn24ApNzJCHDkjQyjo
         45GBLSB50pCzSYzXGnnaMrj/soEg2AgUHkOac2mbXJHx+tCkMHyi20W7ijAu0lEyPLWK
         gYf9sAAK9BG2zvjlPypNcKGBR0fy7Xlzn2KtKreHgj/CFY98v7L5cq4Vdc6zA5TOKyUI
         ctgw==
X-Gm-Message-State: AOJu0Yz+uuPvFEUrNpBVpHHNNaUYl5uJFcKQ3TJoiDEN5G3n8OOt2J3Q
	yfOZ21j2+Xq6zFBra9PeEojz7XyrtwrmZSoico+M7ktBLaxgxvwNRMnj78BlZhpLmFA8BWZlc7T
	Opu8=
X-Google-Smtp-Source: AGHT+IEiKXZUvH731o7GliloWXlxKgtG4B9CbYUf5uY0sP6JI94NUhDGFRu1cbzz0NaYABDxc/IaVA==
X-Received: by 2002:a5d:4607:0:b0:33b:470b:a377 with SMTP id t7-20020a5d4607000000b0033b470ba377mr3299506wrq.14.1707307485006;
        Wed, 07 Feb 2024 04:04:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXi65c/JIRFTcB5no6O1BT/UfOn7r6G5SsTR4Z1TpJ0xLXYSEO2dQ8pmguXkT9/GofcRmzGYPdz0fLqHy9WI4a9XJLu3ZnH2Y9FhQi4PDPTefydw/FXp0JQtGr82udzshBWEwHTq/ukZqEGmTgQDxXgZKKcMQz4293qjEAvXeXRXEjw+2LJFJFzkMCAjUPIy2EwFnSSn1Rcf3TD4M9DSGgPluoqPt7AOM3bC8R3yqBTqe257ajA3dLN+Nb9xI1RvZ3e8jl5a0QbUHAU/4cqLTRo9wqmHEMMeE+sp293eRNHt+Pb26Q9/k8suUDvadfCyMwnnfIlezqEhf5mn+b0C9ciQO/h6jcD6zZICEw8NhICH3JYbAJvPF2oW3veyX2zvgE2xfCgHAsF58hu8iAECJH5ek3RQOAwpxUnoez02e0fHyx6RJVrC5Ol2XZ5DCo6HWiI/P7Q+Y7q+ObowYJyZv0UtKdvVf1kNWBr9zFS+g9ndwPxU+PgHm2AjDBBYQ==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id d15-20020a5d644f000000b0033b44a349e1sm1349967wrw.38.2024.02.07.04.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 04:04:44 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v5 08/17] spi: s3c64xx: remove else after return
Date: Wed,  7 Feb 2024 12:04:22 +0000
Message-ID: <20240207120431.2766269-9-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240207120431.2766269-1-tudor.ambarus@linaro.org>
References: <20240207120431.2766269-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Else case is not needed after a return, remove it.

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index e3e7d625f3fe..0b42d28d2019 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -410,12 +410,10 @@ static bool s3c64xx_spi_can_dma(struct spi_controller *host,
 {
 	struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
 
-	if (sdd->rx_dma.ch && sdd->tx_dma.ch) {
+	if (sdd->rx_dma.ch && sdd->tx_dma.ch)
 		return xfer->len > FIFO_DEPTH(sdd);
-	} else {
-		return false;
-	}
 
+	return false;
 }
 
 static void s3c64xx_iowrite8_32_rep(volatile void __iomem *addr,
-- 
2.43.0.687.g38aa6559b0-goog


