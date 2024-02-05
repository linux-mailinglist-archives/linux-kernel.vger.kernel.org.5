Return-Path: <linux-kernel+bounces-52641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E6C849ACA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A311F226D5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE91732C6C;
	Mon,  5 Feb 2024 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aQG2RCUB"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E853D2C86E
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137131; cv=none; b=sMtB8nsYGC9uRuRxNzCC9FPAiMFg6GIKNjSFdcN54dRDRQkGLQsy4TNwXfyiDoD4OAdgC0l4bqJynUENrAuVBcUl2cz8auqMNDpFp9st6N1IOBxsym73JSsKXUs7bjLGx8pZmnaDk9iMwDesPEUOsZ2T3+1q8lphTIObfQUegFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137131; c=relaxed/simple;
	bh=V9Bd3RiB2MaAfeHPX6FTsIe958CWx6bC/20prl79JuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvRpqzp0XYMr2XK7fKQGt2jKio8y2NK79XIt5luhmaQrZkEsT4BLAEhn0yWbf4NxyG3AA2fSwENtOk1NvmTJy57VPDlBbrZdSptR6LZUdtGm/Zxpcjrw/EvbMb04c4QOPLTPeRgkJyydaxgwA/VnEl2W/rCjcnRqdc8ZHCB1B+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aQG2RCUB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40fd72f7125so10981865e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 04:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707137128; x=1707741928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZvfaKKEFRvfmSDe4W0tI5jmLTFflp/Gm8s0A/HkuUc=;
        b=aQG2RCUBU4C8svSaJbS+bD+syrZDfCap1VpQ7fJKNeyd4XgU0Way/WDJLvAWfjSrhb
         XtHj5Ts9G+I21l2mTP6wH/+g/QXSagHJuqwn7ZWYXhxxWtt+8LFy6K6FVKOl/zaNxn3t
         QoXJN4aDURrkod8Ggsvq04A1teb4bp4neeYJP806Ximyv6+84LEpUbGUCoeB5goz9AlH
         456FwGUznZASEHrts+F78J1ZptJRilG15atC2DSdFfC2jiSp/VtYpialJ7ySM9P5jc/R
         BJsEHI79aqOOfoXXi394bZn8B/Wuhvh1/MCVvkkTmN80n+1s1z5wnkDJZSPSMDaeAH+I
         8OIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137128; x=1707741928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZvfaKKEFRvfmSDe4W0tI5jmLTFflp/Gm8s0A/HkuUc=;
        b=nP+EcJ7iRbtd69cSl4l4bvmiX2gL2m0azh0XMYWljle97eDGwPzmlgslYVZYA0H7a2
         oo2st6EPPTyTicBmfSjYDXNJbnt1AqDTmlHJFc25huzyV3T/nA4SC/bBncxP161nGkrx
         zmMui386NjyGn+yxLCxFyKok1mgtMoP07e+a4CnZ2LIMKK9AN17ZHma97r1uuoInGTBR
         Ou9ClPfQzqrjDhaB2siM7hatvgoZZ2TymBt1QNipbFH1SfHhgQlGdUShQlN8nG1KTrtW
         EyrHfJg6kkxX4VL9PQRsH7TSqxGR3hlgxPlWdtJMLhkFGUNqqwWh1elk9kU9O/nt6kcf
         AFYA==
X-Gm-Message-State: AOJu0YzJ8n8tcK1oflr2zImI7+qDgABWkISYL27b1vSNQLHwAqhcjnu5
	D40AyLVK4UIzW9kaUsqYCzJeUtPUb4uaG0di5FhsiEmV00rbnKx4gBwgFsDYS+I=
X-Google-Smtp-Source: AGHT+IGT76ECdpse5+FEjXiQNGRSUJHWZEYOj01Gi0tuS340doxMhwBI/+wWnW/4nShfRUwus4E5AA==
X-Received: by 2002:a05:600c:20e:b0:40f:ccb1:7d90 with SMTP id 14-20020a05600c020e00b0040fccb17d90mr4588864wmi.12.1707137128331;
        Mon, 05 Feb 2024 04:45:28 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVjJyP66heDdgX7AE01HkbJQ2VlHEGVuAMdf000jcqKqKCWDD6ajy1vpmjw/HT/oqqSheMnqZWnlI5Gu24ypc3Yp3DrG9CDy6JsHFBo/vKGpeNyc2wue5+Bfq/2q9cpy5Zuorl9hvv9IUl4Jw+AbCdaW1uQqLmYL/oC5BMEgHZZb7issd5ZW9PoiXyPw540IjIfcCKS1e5gUveV6ldLB73NDUtg3wdMHuk9LQIhWpPmoKLlMJo3tYiUprmQSRWvzMfF8e5EvVKC+qK4dPkLSa/iSxhBPvBDsk/fEduAg+Xpic/b4n2DrcGi6Eyq/0VO5H3rgh/EluNQha1oMRL4N/V0v2tItrAnQeEcn1AgLJ9dKUziwskkr2KWb7YoOLaBJCHeI/7d/piTASe19rnKdL0ohVLrlMNZ4ZZA3b5rl3Y6pk6RugmAWUrsC09LT4hhoUDSqs9H+UziXCqkZeOvFNtk0bFHL0eUPbrVOr0PUBGOHy8360tuR6Fq5IBmgA==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id n9-20020adff089000000b0033b35da384fsm3650812wro.33.2024.02.05.04.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:45:27 -0800 (PST)
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
Subject: [PATCH v4 11/16] spi: s3c64xx: rename prepare_dma() to s3c64xx_prepare_dma()
Date: Mon,  5 Feb 2024 12:45:08 +0000
Message-ID: <20240205124513.447875-12-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240205124513.447875-1-tudor.ambarus@linaro.org>
References: <20240205124513.447875-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't monopolize the name. Prepend the driver prefix to the function
name.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 7a37f5d0abd9..a51b5ff27d5a 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -278,8 +278,8 @@ static void s3c64xx_spi_dmacb(void *data)
 	spin_unlock_irqrestore(&sdd->lock, flags);
 }
 
-static int prepare_dma(struct s3c64xx_spi_dma_data *dma,
-			struct sg_table *sgt)
+static int s3c64xx_prepare_dma(struct s3c64xx_spi_dma_data *dma,
+			       struct sg_table *sgt)
 {
 	struct s3c64xx_spi_driver_data *sdd;
 	struct dma_slave_config config;
@@ -444,7 +444,7 @@ static int s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 		chcfg |= S3C64XX_SPI_CH_TXCH_ON;
 		if (dma_mode) {
 			modecfg |= S3C64XX_SPI_MODE_TXDMA_ON;
-			ret = prepare_dma(&sdd->tx_dma, &xfer->tx_sg);
+			ret = s3c64xx_prepare_dma(&sdd->tx_dma, &xfer->tx_sg);
 		} else {
 			switch (sdd->cur_bpw) {
 			case 32:
@@ -476,7 +476,7 @@ static int s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 			writel(((xfer->len * 8 / sdd->cur_bpw) & 0xffff)
 					| S3C64XX_SPI_PACKET_CNT_EN,
 					regs + S3C64XX_SPI_PACKET_CNT);
-			ret = prepare_dma(&sdd->rx_dma, &xfer->rx_sg);
+			ret = s3c64xx_prepare_dma(&sdd->rx_dma, &xfer->rx_sg);
 		}
 	}
 
-- 
2.43.0.594.gd9cf4e227d-goog


