Return-Path: <linux-kernel+bounces-58664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D045B84E99C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852EE291C18
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593A23C680;
	Thu,  8 Feb 2024 20:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MrI34b5e"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA2039879
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 20:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707423724; cv=none; b=P0wG/HSQ/hsGZPcS4hf+gLPp/2x/e4bGBITcj1V36iteLHfO/hpQtdZfC3tNqgbfed4927qXy3g1PVc0U5bhywh2kieiW9K1+e2WEA0WZZdxjGRrHOVpjbcUe3y8L3VnspoAuevVPG/u7SsLX17Bj9eu9JjO4dt6KnxYUJE2iqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707423724; c=relaxed/simple;
	bh=EuC6sp3zgUZwELtrdAh8RcNfJzcbA+xXFU1f1/D83Z4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iBnxwwPcC4mYsiDy9WLrqK2PhnhAzskc4A7jzGsUC8Y3XXUWst21y7eD06TOKlI5rN0KNlUrI7u8awVWpIXBPdg59hTEL3eYN20OWhfScpCv8ngjGJT2cTz45sOp4VHABS9XJfPmVQVYGmO3jIk85l13ULQ7CiV4MAkD7yQ+jFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MrI34b5e; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-511234430a4so369953e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 12:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707423721; x=1708028521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUkNFYshyeua4flK0SyOI4wZ1pzqdwJE/n1h1Pd676U=;
        b=MrI34b5eo+C9IsfjMQyu6JvgEl/GZd5BOYEQf2SXBW8cokU09FiWumqP9g9YPpzhzi
         V7e2M0MvpooLZurv4WmfGxEaX7XBugm2anQet8xBiGynrA5O4G36sICRTeIg+AOKkY9c
         zm4LBq7m2zRL/PGhgQxhbzSW+ISKbNvw163bSxKbSHCz5ORh0ijwK89PQFNtSjnX2+/u
         bksCxGr2+7/QlbS2fxClsxfbIklGiDuR84FFqjgpfz2ajE3fqC3zHFQJRt5N9dgf/Xal
         eJe/DAD4fHFlDsbWwz18uMoNBBhbCfbOflP6yok2fds/tWkm17A1d9Yil/IdAA+WnXK9
         BY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707423721; x=1708028521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUkNFYshyeua4flK0SyOI4wZ1pzqdwJE/n1h1Pd676U=;
        b=TXxcPpdb4kp+jDoss/uAoD1Tk1bwhahrx6EQ1CqUg/ok6beTgftn7CeuoRZrjJKBXJ
         /TWBnxa1NgVVF+Z5zHN12FradE/zMO370Tq2q0mXrlYu+KMvGmm46N9PdfvrM0Gs58X2
         bzRiyHGJ0WI5FdmrMaV1T+6Z+Bzh2EODcNmZCn1VXeLMnof1X7wkd18nOs5wipIRhlW2
         wKRhFMIBMNch9IJhNgpiZlWaHbLvyHpueQyfXdrXaL0KiBESEar3+pFlaIxDA5T4sbO9
         tyPAlHVN/n6Md1xpjDbIBy0hTxvo7THlrAwJZCJpMnajfpzVNpAGGut6AKm85I1AfVqt
         ngdA==
X-Forwarded-Encrypted: i=1; AJvYcCUc/3UU2u7qm76KNjfSKSHOahgp3i548Er0t1WrdBWAWtH/S8CI1hFlc4uT2joUg5htGw4ceGOAeDK5OLUtRSkLoAfGWJYYALvPU2pb
X-Gm-Message-State: AOJu0YzRHJxp9V88ADBjZntWKOSk1GkzOEKsBJkjah1w6m5lQe5absMo
	WwpYOD3MzogA5XgSS49NQR0kQdaSb1lVIiNI5pcky+hzNEvBqjIESd0VZOc7xCc=
X-Google-Smtp-Source: AGHT+IESze3UOcaMRoHdLMtWz55kE16wKlmEO7fUIhskAP1XvPi0xGliLVBZ0pS6wVwu8akJ/DWbug==
X-Received: by 2002:a19:910c:0:b0:511:696d:87cb with SMTP id t12-20020a19910c000000b00511696d87cbmr229963lfd.26.1707423721289;
        Thu, 08 Feb 2024 12:22:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVqXV/uVGQiQy36ATGYttAxe9QlOz0BaJN0UtwLo3HN53h+Cdz9xLBP5PmppGm0OcEtQChd9Pikit0CF/bAKe4BsVukYVD4Nz+gCKgnpSGfPLiQHbDscdxihexpQZC04LJIJJ35gywW
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id o25-20020a05600c511900b0040fdd7cbc8dsm361481wms.47.2024.02.08.12.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 12:22:00 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] spi: pxa2xx: Use typedef for dma_filter_fn
Date: Thu,  8 Feb 2024 21:21:54 +0100
Message-Id: <20240208202154.630336-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208202154.630336-1-krzysztof.kozlowski@linaro.org>
References: <20240208202154.630336-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use existing typedef for dma_filter_fn to avoid duplicating type
definition.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/linux/spi/pxa2xx_spi.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_spi.h
index 0916cb9bcb0a..ca2cd4e30ead 100644
--- a/include/linux/spi/pxa2xx_spi.h
+++ b/include/linux/spi/pxa2xx_spi.h
@@ -5,6 +5,7 @@
 #ifndef __LINUX_SPI_PXA2XX_SPI_H
 #define __LINUX_SPI_PXA2XX_SPI_H
 
+#include <linux/dmaengine.h>
 #include <linux/types.h>
 
 #include <linux/pxa2xx_ssp.h>
@@ -22,7 +23,7 @@ struct pxa2xx_spi_controller {
 	bool is_target;
 
 	/* DMA engine specific config */
-	bool (*dma_filter)(struct dma_chan *chan, void *param);
+	dma_filter_fn dma_filter;
 	void *tx_param;
 	void *rx_param;
 
-- 
2.34.1


