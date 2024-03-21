Return-Path: <linux-kernel+bounces-109707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0901881C9E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 801201F21761
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E95B4D5B0;
	Thu, 21 Mar 2024 06:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X6aA+Rda"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F18C3A1DE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 06:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711003878; cv=none; b=NiTpV8Mh4QZb2EaQNLZkW3YE09mYX66KT6dmyTxUuv+1VR452wyFcgasmQj4ADATvtO8ibrElIFUD75hJNP1PX/uk4eAe0JLSPgkJEpj0qORPN0JMtoGexJr6Y8o2f9eRZgzul9+1J5YQsadzR/NQXPWrWrDreC7kJSeLKc0OO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711003878; c=relaxed/simple;
	bh=oRcLB9dQPwGzVPKTKr0KY9BPsfc919ssadAASAAgBzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0TGI4GwwBB2WEnPUw66UoUdielZjn/dzWqONl4A+AQZFr1+IzHwAIfW4nxx6bZr3jeqg+1Yi0t9BeEY5JpfkklMDcRaYAi1Og5kGS3gghq9054/phubAoSDIqb0VSuuQ13fs4Xz8P7UXkIdEH4Hruse09SWnIJpfrFO580zp+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X6aA+Rda; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-610e3f906acso6916707b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711003876; x=1711608676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBiGSHa0oimyE1MM5zUN6LTK3eAVLs8v7Z76nGxN0a8=;
        b=X6aA+RdaS8IYpJgopFovy8fVPdHXOOR4OKeCow6u0ujZp+mptwNKJzrSmvZ4vuc0/t
         r1/cY25yn+YZ4D5D+UvH+eVeqLGIBHCDK2WFx548jpfs8leAjsCesT2MzZM5E0Ph5hS1
         uDzaqMeGj26OFatLOqQ38xnV4uYMf0+eO0e1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711003876; x=1711608676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBiGSHa0oimyE1MM5zUN6LTK3eAVLs8v7Z76nGxN0a8=;
        b=CphhoLEspRdzI6gPNPyYrUr+3jpnfDyfmzO0rv20unTQW+nmLv5th5uHjBm+mgUvg2
         h/tvWPrzt3MEq3wxI63hbnNwUX0orXIJvg1kdNERj0qp24jWlqlN1pk99gPXYwt00dxB
         3sd0WILDvah/MLnY/piJy0Def+a1108laJbzhYEUxTF9YBENcXZbKb+eD7qJa3/s3yMC
         0SIA+39GMttIvumUE2A5rrUFhf8l8Da5Iee/1uP5ZThqEdgnPwDqfrAjrft8cvj794lR
         KmLgjNGUyI03/T9j8dNamY2B1VmW06DGGgozaBrTGHsOENFMpyk0C1RgnyzfN8sVNH7z
         VAnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJAf/rhqKEPw/NuF0ktJ6UBdIkUC3b96kXmTXvi1vGb4yaDSkr9iTGCgXvBI3bI3+VofYU0f/nHGUC0rplZkNEzzaPZHLB5jz2ShiW
X-Gm-Message-State: AOJu0YxFlN3gB2BM5C+Rb6txlikVvHcNW0zsI0NpBIAL7U6TgNU1HGEV
	XWdpzcw/p3aIFcLK+vfcJAM5XDzTru2xkE5/SHALhXuly7F1xSszf28wJFzIgBMJb3ICZt38GwM
	=
X-Google-Smtp-Source: AGHT+IEEEIHKCYtjOYJVfRhVwN68KX9lfipwtZ2TMyYDdaLt1ht07nRcowYnTodrhLwxJsrplM2RyQ==
X-Received: by 2002:a05:6a21:a586:b0:1a3:6a4c:80a9 with SMTP id gd6-20020a056a21a58600b001a36a4c80a9mr11624698pzc.1.1711003409539;
        Wed, 20 Mar 2024 23:43:29 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:c1ff:a4cf:ac35:8df6])
        by smtp.gmail.com with ESMTPSA id lb3-20020a056a004f0300b006e664031f10sm12874938pfb.51.2024.03.20.23.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 23:43:29 -0700 (PDT)
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
Subject: [PATCH 1/2] spi: spi-mt65xx: Fix NULL pointer access in interrupt handler
Date: Thu, 21 Mar 2024 14:41:01 +0800
Message-ID: <20240321064313.1385316-2-fshao@chromium.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
In-Reply-To: <20240321064313.1385316-1-fshao@chromium.org>
References: <20240321064313.1385316-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TX buffer in spi_transfer can be a NULL pointer, so the interrupt
handler may end up writing to the invalid memory and cause crashes.

Add a check to xfer->tx_buf before using it.

Fixes: 1ce24864bff4 ("spi: mediatek: Only do dma for 4-byte aligned buffers")
Signed-off-by: Fei Shao <fshao@chromium.org>
---

 drivers/spi/spi-mt65xx.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 8d4633b353ee..86ea822c942b 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -788,17 +788,18 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
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
 		}
 
 		mtk_spi_enable_transfer(host);
-- 
2.44.0.396.g6e790dbe36-goog


