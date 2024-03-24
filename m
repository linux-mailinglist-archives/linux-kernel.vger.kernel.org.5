Return-Path: <linux-kernel+bounces-112669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA57887CC2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78847281805
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 12:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E2C17BB7;
	Sun, 24 Mar 2024 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="myamaYhu"
Received: from msa.smtpout.orange.fr (smtp-82.smtpout.orange.fr [80.12.242.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317B61A38EA;
	Sun, 24 Mar 2024 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711283793; cv=none; b=ffa3Xz3l8IAGpO63zvE8c3MqbMsncmlLcfrH8e+QdfkzfhosLwqOb6dOPA7vGMC18EBzTcP/I0DZqfpiHA45ICSyDICBpnEMMMk2qopnJEM2xOiLT1qwdxzddWP/H1WJIL9M3ePyBlPkzZ08VnRhWss+vwf022k7O0rmOpED1FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711283793; c=relaxed/simple;
	bh=lWwQT6POGscHInaUBXSVs3Bvzl6JJjKrLFC4q7X2oXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fe2DVSBBiu18uYpdLijxhOjgKETL7b8UAadu+esrL6Ey+WP45toXAhzlDGSb7D6hTeRm8ybSNCxb1w+g95tp1t/AFxQOpPh0eAgYBIX1vRtnFWL8Ib1Dn9wrHjXwMydW+e8HmcsQK8T83e7eTIFRt15ivJ23uuetN8KVGld6xmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=myamaYhu; arc=none smtp.client-ip=80.12.242.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id oN5IrIYha6CS1oN5JrDlnb; Sun, 24 Mar 2024 13:36:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1711283782;
	bh=AAKPnCD08n1Ivbegax1tBgxYyf6ck38NkApHtw35RgI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=myamaYhuvINo6+J4tEXYZmXa/jZmdPUzjt8agUOV9bfclSuBufCperDAgb/I8v6hj
	 AL4OtzwgO0Q0e5OMWvbWWiUfHEuZacREINBto9K+29h7xWRsCwv+SHxLU6yIX7lsmC
	 prg3rXml3JE57XWT8AwaNIiAqNfDbwyffONYdWaKsL3yJJE+i1RA4VD9FZuV7gxJEe
	 vPDgHSSGUuBacl5iJGkYpmfVbIX6pcQ1t+kVpHjgq18z956sBDzuXwtDdMdN0Ytr96
	 oWn/UVvJOiJ1TGgpgv5NyCDE/3RlzgFtvI0eYUMXCGcYGthx30VvqYnJZVw9VwjwDX
	 ylXwaHWTw6ewA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 24 Mar 2024 13:36:22 +0100
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: pressure: hsc030pa: Use spi_read()
Date: Sun, 24 Mar 2024 13:36:16 +0100
Message-ID: <8327ac591d244ac85aa83c01e559076159c7ba12.1711283728.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use spi_read() instead of hand-writing it.
It is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile test only
---
 drivers/iio/pressure/hsc030pa_spi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/iio/pressure/hsc030pa_spi.c b/drivers/iio/pressure/hsc030pa_spi.c
index 818fa6303454..337eecc577d2 100644
--- a/drivers/iio/pressure/hsc030pa_spi.c
+++ b/drivers/iio/pressure/hsc030pa_spi.c
@@ -23,14 +23,9 @@
 static int hsc_spi_recv(struct hsc_data *data)
 {
 	struct spi_device *spi = to_spi_device(data->dev);
-	struct spi_transfer xfer = {
-		.tx_buf = NULL,
-		.rx_buf = data->buffer,
-		.len = HSC_REG_MEASUREMENT_RD_SIZE,
-	};
 
 	msleep_interruptible(HSC_RESP_TIME_MS);
-	return spi_sync_transfer(spi, &xfer, 1);
+	return spi_read(spi, data->buffer, HSC_REG_MEASUREMENT_RD_SIZE);
 }
 
 static int hsc_spi_probe(struct spi_device *spi)
-- 
2.44.0


