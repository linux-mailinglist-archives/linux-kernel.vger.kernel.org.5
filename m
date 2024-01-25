Return-Path: <linux-kernel+bounces-38757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6FC83C573
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8FE1C249DD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334547CF13;
	Thu, 25 Jan 2024 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JLvIi5X8"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319EC74E12
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194221; cv=none; b=G6Xu9EUuwrXz5eZulT+ZQI2DrdfIhnqIpjVcwiLKACjfBjQt23cXmBJi96cwhTqBUJHZ6MsQddPIUpYH/Y/UaNVzmUyMYf9xVRxXZ4QlX/Ugfs9iVSpgpPcFP8CmSdYz83FaYdeJ14VZYToglobZ+N6+eF1lu1XfBqmCdRzvGjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194221; c=relaxed/simple;
	bh=K020vlgVWqdBCzbzUN616X7cpEMNNq74Txkp1+qbIy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mEm8yJcsaoMA9Kkci0b2mGI3fRn0RIDuaRS0JbQaluEzuxkNHa3s4BRP8gVIximN+UqyUiCZ/LrWiKQUrvSZTS0f1LRIxYPL8TSVQ7jBWH9qpXD9oD7IQTEJ5EWVEBLZc+hN0yGuzTImeEXIofnB65Ud62x6kQ+6dNdSvv1BPrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JLvIi5X8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40ea5653f6bso70947285e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706194217; x=1706799017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4fz9oIGVOkFGai6Cp4lYWrVDrbEsI2M8XA5EnCVP48=;
        b=JLvIi5X8WL9E70hYm9o5egYhO8HEBmdtbC2uOoym55kW29R/+OIy6sLTksvoJQIawH
         f1/rLFb78/XufHKnInQ9kD6ySuUhjjHJt3JuSZ+UzuFAOKVrX/jMatgKDjf11oNPFfv6
         dF4uSNNb1HsaW7o+FuuyLb0hWcbFreJztaXp90Iwh88aD4W2+/TplXgQ9a7Cr0zBbQWM
         Ywk29Rtqi1NN9trdTDFPT2iXGe3pSP63Volxi5Rk6q7Qrf7ImF4fQQoPnNFUmBxxtKwM
         x+J0q+cB5Tx9Q98VSb7jSd7rnJSg/SYTDyhIUDl+PkLrjluGdQnQiouoaMRh13feLXBa
         I8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194217; x=1706799017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4fz9oIGVOkFGai6Cp4lYWrVDrbEsI2M8XA5EnCVP48=;
        b=Vs/v2othFkqmAyPnFrXygE945EI7TVzOhDPpvseD7fNoiPvZOg6UAxItlWNRJVhWW5
         k4qT9EACAl2ciR8wbWx7P0wZIxGCeTF6kqQZ++g+FQecsus7/9naINPuzf7QNld7h23g
         hYl9PmmM4IBWfClAmQLgABdinTMCTTPCX5QUg81rwk2sTlr6FnJfbYt0XazH4G/fg5sI
         5q2WPYmPcUus/MjLWa2GWb/PZUu5nfCuUjfqnkLRCvCLif1mp8IB1c2BFmhlPXQ4WvLy
         859Xi0TOIqvwyKBbn9W6yNaLnLiBJZeTwOPavvlKl7b3MNJeogIvJM82a4D/QsIwvwpy
         OutA==
X-Gm-Message-State: AOJu0YwEyzTgVJk9zM9R0l4y6aVb+C3shLLFGsm7MTNIFZ80JfTVdtte
	qidiUtb7vF8osdo+Nf628f93oFjKcd42EzJV2MT85vnUCPSGKllYJAL1Z99I5Xs=
X-Google-Smtp-Source: AGHT+IH59qBBDJYZqajM3gXZkrFzpTjDsYhh2UwC+Mu4T262n+h9h/yXectShSlu1o5IM3xVnvhLGg==
X-Received: by 2002:a05:600c:4510:b0:40d:877d:ca9 with SMTP id t16-20020a05600c451000b0040d877d0ca9mr632702wmo.104.1706194217327;
        Thu, 25 Jan 2024 06:50:17 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b0040d91fa270fsm2875875wmo.36.2024.01.25.06.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:50:16 -0800 (PST)
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
Subject: [PATCH v2 08/28] spi: s3c64xx: remove else after return
Date: Thu, 25 Jan 2024 14:49:46 +0000
Message-ID: <20240125145007.748295-9-tudor.ambarus@linaro.org>
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

Else case is not needed after a return, remove it.

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 137faf9f2697..1e44b24f6401 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -407,12 +407,10 @@ static bool s3c64xx_spi_can_dma(struct spi_controller *host,
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
 
 static int s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
-- 
2.43.0.429.g432eaa2c6b-goog


