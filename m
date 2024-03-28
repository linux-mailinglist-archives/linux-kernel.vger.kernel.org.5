Return-Path: <linux-kernel+bounces-123633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CE4890C05
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AFFE1F24B59
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA81313AA5D;
	Thu, 28 Mar 2024 20:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PaSNHWG5"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F9F81219
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711659170; cv=none; b=hIfIME3TZNFf06mmvYbQLc8FaIaRCKzpbc82IVkLqZusmQtwb949O/hWjhaoL2MFi6cr17E5Em92sh6mqjlIG72P59gvhJ7ibAskTiwfmn7kzBcrf9ihKIjOKi8bXu3/f5qd7Nc+Lj69RS6f2PLFYfoc8slPF7avyo/FTXC+thQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711659170; c=relaxed/simple;
	bh=GeMYE1tfKAVoMVZLat41QykjcobP/pX5nbPP5nlFDmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oFWAvXcY98qtpsIvvTMSW7+cItOs+U3IEJvw6quwQbhhjZkBFW/iZ3nkqpPydx/Swbotl0qd+qYI65uSIKIY+EVX4zI3xYBSFLxF+q1HpbqhiXkzihoZQWV07cpiwEtYWPXH1O61QVGSzmiSXpXYmZX5BU2gnEH/5D/Nrmnvz1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PaSNHWG5; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e695b7391dso670213a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 13:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711659167; x=1712263967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02QukKA7rGv689sMEnY5Waa2GxmfCRYMmefB+eiHwtw=;
        b=PaSNHWG5HD6j+WPHD8wLgj5iRrFYweQ8S76xWWlZ9HpMEXUGlrGH1MGOv62UrKFVYW
         e+2gQOcAR7TxKun9CqicBWPPzFB8zSDYPdfl8N4ykmg1t31DUDLjfdhm6pXHXRDqR6nU
         SnDzxl9+t+dgyZHUCGlIIwbyVhPXxVkTKKEFDi3nxa28sBEsDHphnCsTTsQjEMtXHluF
         Q/BVX3Hlzl5Iuhml51uyFojHWZB5NTkmOxd06SsvSeMBGPPbTxcz9N0fgffpmXaFR5O7
         IXec/hpknlPHjva+gmKYt5beOTKQ6x/LIuJll0KaM/jEpFYooxNB7tOFuLsaakZaHrNZ
         rJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711659167; x=1712263967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02QukKA7rGv689sMEnY5Waa2GxmfCRYMmefB+eiHwtw=;
        b=qynBmE9ai9/lSmvwk4gx6eFByoGRQcT36H4kevID8v+x8+I+c+XupB9/QwD+/XsX6f
         LZTMP7lNDUGXFq8YYcmIbKa3kxJ33RLbzg6c9l76XtzLcZfGbTuea+Y4zQglm5/saV6a
         loLiamHff9rc0gV2L8EIp2S4VqQX2udzVTAVOSfnzsL9GSyxfIM5BJuBaYTQBXKesYwN
         yT3RBxhE1zNCCuzdJl5HDBBRpX2dyRV0WjzeSkmUD8S3x6EyfIpFyQ9aR3C8VTd8oUtJ
         Tjq2A47E1xfGZx964GuDogpykmibR0+z01skU8Ukh9DCd6bN6ge/s0MGZCNV0X13O7gB
         02XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVROVUzOD/JzValw0bUvoZBiyPh66je+L3XEHE639nFOgXLPO9u6a2QVwa1TefbjA5GwWVxwgqQnx+ZeUqFZ/znyL+3KPjq73n0lEAG
X-Gm-Message-State: AOJu0YyglwWVbDiIrq/hO+K10Xf85y8GcpWOzv2G/P14Y2qagipmF6CB
	HI8tVMt5DXCRoM4c2B5wu2JeYCdOrDJsM9Eec/GPRJ/yHDOdW1zCK+eVwq+GrFlo6b3/fMUWmmw
	W
X-Google-Smtp-Source: AGHT+IGxxiP+qq0jVjWIwgc+9slYwS5wp9XffdmBw/yeJyXyzaCNvqDCbJlkHDpqDAINcXYxMa9pFA==
X-Received: by 2002:a05:6870:96a4:b0:229:f2a0:5f4d with SMTP id o36-20020a05687096a400b00229f2a05f4dmr378247oaq.1.1711659167493;
        Thu, 28 Mar 2024 13:52:47 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id g16-20020a9d6c50000000b006e7011fea78sm293335otq.41.2024.03.28.13.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 13:52:46 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] spi: au1550: t->{tx,rx}_dma checks
Date: Thu, 28 Mar 2024 15:51:45 -0500
Message-ID: <20240328-spi-more-tx-rx-buf-cleanup-v1-1-9ec1ceedf08c@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240328-spi-more-tx-rx-buf-cleanup-v1-0-9ec1ceedf08c@baylibre.com>
References: <20240328-spi-more-tx-rx-buf-cleanup-v1-0-9ec1ceedf08c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

There are no more peripheral drivers that set t->tx_dma or t->rx_dma so
these will always == 0. Therefore, we can remove these checks since
they are always true.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-au1550.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-au1550.c b/drivers/spi/spi-au1550.c
index 825d2f1cdff8..16f200bb3d17 100644
--- a/drivers/spi/spi-au1550.c
+++ b/drivers/spi/spi-au1550.c
@@ -314,11 +314,8 @@ static int au1550_spi_dma_txrxb(struct spi_device *spi, struct spi_transfer *t)
 
 	hw->tx = t->tx_buf;
 	hw->rx = t->rx_buf;
-	dma_tx_addr = t->tx_dma;
-	dma_rx_addr = t->rx_dma;
 
 	/*
-	 * check if buffers are already dma mapped, map them otherwise:
 	 * - first map the TX buffer, so cache data gets written to memory
 	 * - then map the RX buffer, so that cache entries (with
 	 *   soon-to-be-stale data) get removed
@@ -326,23 +323,17 @@ static int au1550_spi_dma_txrxb(struct spi_device *spi, struct spi_transfer *t)
 	 * use temp rx buffer (preallocated or realloc to fit) for rx dma
 	 */
 	if (t->tx_buf) {
-		if (t->tx_dma == 0) {	/* if DMA_ADDR_INVALID, map it */
-			dma_tx_addr = dma_map_single(hw->dev,
-					(void *)t->tx_buf,
-					t->len, DMA_TO_DEVICE);
-			if (dma_mapping_error(hw->dev, dma_tx_addr))
-				dev_err(hw->dev, "tx dma map error\n");
-		}
+		dma_tx_addr = dma_map_single(hw->dev, (void *)t->tx_buf,
+					     t->len, DMA_TO_DEVICE);
+		if (dma_mapping_error(hw->dev, dma_tx_addr))
+			dev_err(hw->dev, "tx dma map error\n");
 	}
 
 	if (t->rx_buf) {
-		if (t->rx_dma == 0) {	/* if DMA_ADDR_INVALID, map it */
-			dma_rx_addr = dma_map_single(hw->dev,
-					(void *)t->rx_buf,
-					t->len, DMA_FROM_DEVICE);
-			if (dma_mapping_error(hw->dev, dma_rx_addr))
-				dev_err(hw->dev, "rx dma map error\n");
-		}
+		dma_rx_addr = dma_map_single(hw->dev, (void *)t->rx_buf,
+					     t->len, DMA_FROM_DEVICE);
+		if (dma_mapping_error(hw->dev, dma_rx_addr))
+			dev_err(hw->dev, "rx dma map error\n");
 	} else {
 		if (t->len > hw->dma_rx_tmpbuf_size) {
 			int ret;
@@ -398,10 +389,10 @@ static int au1550_spi_dma_txrxb(struct spi_device *spi, struct spi_transfer *t)
 			DMA_FROM_DEVICE);
 	}
 	/* unmap buffers if mapped above */
-	if (t->rx_buf && t->rx_dma == 0)
+	if (t->rx_buf)
 		dma_unmap_single(hw->dev, dma_rx_addr, t->len,
 			DMA_FROM_DEVICE);
-	if (t->tx_buf && t->tx_dma == 0)
+	if (t->tx_buf)
 		dma_unmap_single(hw->dev, dma_tx_addr, t->len,
 			DMA_TO_DEVICE);
 

-- 
2.43.2


