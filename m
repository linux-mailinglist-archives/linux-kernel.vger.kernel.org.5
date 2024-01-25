Return-Path: <linux-kernel+bounces-38761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA7783C58F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4322B25DE8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B15386129;
	Thu, 25 Jan 2024 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j2xL2+b1"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D99B7762E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194226; cv=none; b=ih9H7orGE6NbVf8e612/OaTgShN/QxNYDZJB0ZgyVzHsiLPxKJ3QiN+rLxvHmK0nJP0iBuiIojwaWemNaX+FLU1gGFnjj7N02kO4WD8+E0w/WPImL04b3Owvl6UxbhCr/cSPxR7YvMw0O3IC3W79vGBfifodW5RMjiEn5Y+uySY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194226; c=relaxed/simple;
	bh=eEybk3Jo0wZ9G9bdwxi2zNuwMUfX4DvNccSPl13enOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QApSCAJnXeTebajKAxrCSZvZdnEKBgs0SOx/2FNs8EDcUP5bu5wjU7s/Pp7CJuDbVMwtfbZhJWmAA+4grEpFGpzLEP9NkrVCIgsCmE7Kbtxb+82xUfmov3toTcuBDcuYTGsDPkjOnmAYhhxJ2R11qXMVc2Y/PdG1C4bOzBCITpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j2xL2+b1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40eacb6067dso54901695e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706194220; x=1706799020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyD58l2q8nhDuUGflXpNsuJj2JpRaUrHNBwM4NRI1zM=;
        b=j2xL2+b1fB2fM9Ulhs2CE7knLePucDBIZ3yWSXtG9WfPPttVGDHEL5CfCWYagHi7pr
         YcDsq7sZc4To2rLl89mqq250uPaCcsfpSENQKPdTqy31SwmBMk2lehwveSOliB8aemJd
         v3ASjSJOWKMJxqK9QnmgQDnsWkyT15+kA6/eGd2cCQbrVzl6fCLW2u74lSOlgJo47opS
         Nw+tKAdF+c76rvOGz7ilf+MV21zrgYmzWEV1tYZrupM96EQWUu3HNkj5Y6M1BUf/+Epp
         h+mhqjdmCLCxaG7SbB3H+kMtM7KA31PZ7JEAVjYkejn+7bspXw5xzKUIa8XAiwpH++Wo
         /7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194220; x=1706799020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hyD58l2q8nhDuUGflXpNsuJj2JpRaUrHNBwM4NRI1zM=;
        b=T7v1xFzLj168mwUx+8B4CBG0Gja2ZttxJVO7ZIo0gkPbQ9lkDDTD9jVOlVwb6nnjJp
         bqUi1y9jepr0LPLvS08H+/xgRHIAnO00x7pkQrs1GznMkpakWfNHEVjC128hs5ffXY8G
         TgiRY7qgD97ER6Zh5bEioVBulb/KynEjniLmRvyq6vdXQjX64Euh7Aun/6eYRNag0FiC
         5ExLTZnjk6laao46b+8ErbE2iEBIkH3752qSbnNq7mAAysJhKMulnmeW8+0e3g2LzoXM
         oKrIiLxWjS4iNsalIDFeW6FrUvKY3cwFla6KlsmAVw2y6and0TuQi0TY1iBLzIqwSGj8
         WKGg==
X-Gm-Message-State: AOJu0YxpEjYl/+ld/0cPlRlKAS633UPtBJV6vgvyBouROVr4nQPJSllN
	gMOeeLLiF/GPXPxibkTWwi9VyhvrDEayuDH+YJOFKdrqq++KF91lVgXUoIgyv1E=
X-Google-Smtp-Source: AGHT+IFZ3UUBgZszn/1wxPMDahDYbmeO132hJ61mryKHgvR3GcuAuY7RIRfAUkP4M4TdvC1n34cQtw==
X-Received: by 2002:a05:600c:2a4a:b0:40e:46d5:144f with SMTP id x10-20020a05600c2a4a00b0040e46d5144fmr290304wme.373.1706194220403;
        Thu, 25 Jan 2024 06:50:20 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b0040d91fa270fsm2875875wmo.36.2024.01.25.06.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:50:19 -0800 (PST)
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
Subject: [PATCH v2 11/28] spi: s3c64xx: move common code outside if else
Date: Thu, 25 Jan 2024 14:49:49 +0000
Message-ID: <20240125145007.748295-12-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240125145007.748295-1-tudor.ambarus@linaro.org>
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move common code outside if else to avoid code duplication.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index b048e81e6207..107b4200ab00 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -286,20 +286,18 @@ static int prepare_dma(struct s3c64xx_spi_dma_data *dma,
 	if (dma->direction == DMA_DEV_TO_MEM) {
 		sdd = container_of((void *)dma,
 			struct s3c64xx_spi_driver_data, rx_dma);
-		config.direction = dma->direction;
 		config.src_addr = sdd->sfr_start + S3C64XX_SPI_RX_DATA;
 		config.src_addr_width = sdd->cur_bpw / 8;
 		config.src_maxburst = 1;
-		dmaengine_slave_config(dma->ch, &config);
 	} else {
 		sdd = container_of((void *)dma,
 			struct s3c64xx_spi_driver_data, tx_dma);
-		config.direction = dma->direction;
 		config.dst_addr = sdd->sfr_start + S3C64XX_SPI_TX_DATA;
 		config.dst_addr_width = sdd->cur_bpw / 8;
 		config.dst_maxburst = 1;
-		dmaengine_slave_config(dma->ch, &config);
 	}
+	config.direction = dma->direction;
+	dmaengine_slave_config(dma->ch, &config);
 
 	desc = dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
 				       dma->direction, DMA_PREP_INTERRUPT);
-- 
2.43.0.429.g432eaa2c6b-goog


