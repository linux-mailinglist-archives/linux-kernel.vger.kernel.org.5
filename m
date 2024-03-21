Return-Path: <linux-kernel+bounces-109721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E36881CCB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E601C2115D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE2D51C50;
	Thu, 21 Mar 2024 07:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cgPpJYWJ"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDA34D5B0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 07:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711005321; cv=none; b=Tfglhdp2LBptjUc0wZKeHvecYfd6MTJxv1Z11hhl8Rpo7BvZAxfMd4GCcRxSL1j4dHwhFtW2KLAQwrVTUi0aYknmQmaZSmpcUXt/FRU8WLVwioipHzxXDGvVD7vJF+fohrXFrgD2/q5RlKnZtqiS86wK9MM8t4PYK2bRH0erV/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711005321; c=relaxed/simple;
	bh=uNiHv/0x28H2TbSD8m20i2P9eIK+XRcz2b97ymNsEbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijb9NOYecEYg7HHtdywGI35621qCW+LHkqzZX0+HDQOOJCcKhHUmEQWQYmKgKMRp8AaAK2ioJH9NQcCD4Q+jg+BK5vcxsLS5gyBC8HZSo9ZX4P/qXjLPn/xrvOvzByFdfA0x/Kn/r6N9p+wkDyNqJjnQskS1W15rzso2JlQH8y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cgPpJYWJ; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7cc0b35b75bso20523539f.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 00:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711005319; x=1711610119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ci7BHkTK1iOIEG1KH5AhFPZm3PHh1Xr8+22AEHjA27s=;
        b=cgPpJYWJ6Pmh7tzviwQFjzxK7PxCd1FuT9cZGAijfdxoVvSZ2ENYLSvsgQttAzNKRH
         zYPkBGig/cIaL9QJ9vS4k8ogBb8tn/VmAgzfaLvk0taNFYz5wILL0+5ZJSc73hOVdmvX
         qAEcI0cEdtSwmksmSzM9lMT0DBbasAXPosoHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711005319; x=1711610119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ci7BHkTK1iOIEG1KH5AhFPZm3PHh1Xr8+22AEHjA27s=;
        b=RREmLIh+Viub4KxBnq829h+tX9CaXbOBJhzPp94VTUuNP82jkzE7FalUC5y74VS8By
         m9OUzSRHLklZqZfd/1ZuFpWokZvcmtI2DLeTxKkDlqLVsgeBbesuUlFs7z2mdFSNMeB/
         ftq+co86mEeYcguQRQv0KXlN1GGNKSbB0tRVmy8/R1vbkqwsHgyndVYmUszMCrxJXw1E
         qY748NdeZW82vZr/0/lDPp1IMxvHH99QsJx02lzc8iaRuQIyHnDGRLaOTYUykaLuvYSB
         axzLtgBFhb8cgyLCFoSVMov/O9ztqoWbKeXZsMBn1EuEPamcGNfhUvbNhyH7xfuTDteW
         KeYg==
X-Forwarded-Encrypted: i=1; AJvYcCUm66BWngoPxdQglyi2e/dpixizVsDZ1Sw1nSmwlvzAChGS9H5+hd72sReymPxPqvkq/XbWBM7WrchkObrtHORToi7Vje8gbIgSSfij
X-Gm-Message-State: AOJu0YyaEzwjmKnFTB2oY+BU/ogJvwX8NWd3+KDYZ34PmuLugKi1Uyh7
	HblSTsMCUKdL9LtsPUbMr6K1QlwLByT3CXF9pbAR5GKwqbbu6u0/UE+SUpf85caZOfeloJ3GQIC
	PmA==
X-Google-Smtp-Source: AGHT+IEjYPnHZWGzrzuctWTDZl3/WbtAl14yb32XRq028RUvicCO/g54v3a+VeurCXvyrMfQTJ0ZCw==
X-Received: by 2002:a05:6a20:6716:b0:1a3:6378:1e8f with SMTP id q22-20020a056a20671600b001a363781e8fmr7149948pzh.32.1711004990595;
        Thu, 21 Mar 2024 00:09:50 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:c1ff:a4cf:ac35:8df6])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902d4c100b001dbcfb4766csm8705582plg.226.2024.03.21.00.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 00:09:50 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Fei Shao <fshao@chromium.org>,
	Daniel Kurtz <djkurtz@chromium.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v2 1/2] spi: spi-mt65xx: Fix NULL pointer access in interrupt handler
Date: Thu, 21 Mar 2024 15:08:57 +0800
Message-ID: <20240321070942.1587146-2-fshao@chromium.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
In-Reply-To: <20240321070942.1587146-1-fshao@chromium.org>
References: <20240321070942.1587146-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TX buffer in spi_transfer can be a NULL pointer, so the interrupt
handler may end up writing to the invalid memory and cause crashes.

Add a check to trans->tx_buf before using it.

Fixes: 1ce24864bff4 ("spi: mediatek: Only do dma for 4-byte aligned buffers")
Signed-off-by: Fei Shao <fshao@chromium.org>
---

Changes in v2:
- Restore a missing curly brace being dropped during rebase
- Fix a typo in commit message (trans, not xfer)

 drivers/spi/spi-mt65xx.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 8d4633b353ee..e4cb22fe0075 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -788,17 +788,19 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 		mdata->xfer_len = min(MTK_SPI_MAX_FIFO_SIZE, len);
 		mtk_spi_setup_packet(host);
 
-		cnt = mdata->xfer_len / 4;
-		iowrite32_rep(mdata->base + SPI_TX_DATA_REG,
-				trans->tx_buf + mdata->num_xfered, cnt);
+		if (trans->tx_buf) {
+			cnt = mdata->xfer_len / 4;
+			iowrite32_rep(mdata->base + SPI_TX_DATA_REG,
+					trans->tx_buf + mdata->num_xfered, cnt);
 
-		remainder = mdata->xfer_len % 4;
-		if (remainder > 0) {
-			reg_val = 0;
-			memcpy(&reg_val,
-				trans->tx_buf + (cnt * 4) + mdata->num_xfered,
-				remainder);
-			writel(reg_val, mdata->base + SPI_TX_DATA_REG);
+			remainder = mdata->xfer_len % 4;
+			if (remainder > 0) {
+				reg_val = 0;
+				memcpy(&reg_val,
+					trans->tx_buf + (cnt * 4) + mdata->num_xfered,
+					remainder);
+				writel(reg_val, mdata->base + SPI_TX_DATA_REG);
+			}
 		}
 
 		mtk_spi_enable_transfer(host);
-- 
2.44.0.396.g6e790dbe36-goog


