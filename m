Return-Path: <linux-kernel+bounces-132068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26764898F51
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8201F25200
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B621350C8;
	Thu,  4 Apr 2024 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="eN17ffd8"
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C615712EBD0;
	Thu,  4 Apr 2024 20:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712260843; cv=none; b=RS8Xj6NPuDkuPUTaWkGsYUSVDqVF3ojbLxAiQtE4ygmvU39BMsNSUMwqchXR1Sjd0iztog9Tf1pMy23k6/vxG1k2M3KP+88epjXW0qm4qlbo/fDO025ANLUvWDoJxKnj8Lo0di8Ou7ulXkck2lscTG/JKV/0lPqa6Zc2ZAhyU/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712260843; c=relaxed/simple;
	bh=NnWpO5HSnw8uUargsGVv4mU1Z9TXWs7lg2IgQ98VYFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ABAXOmMmVGudV6xcOnFKCr0IQLvrmfZscgtvor5NWHunkr9hil5HLMvCdPq4KvJAZ2U0FjvgMmZel5GEhHpZKsTSW2lf7sUOc793uY+fLsxeUexVxkybbqsFEIu5Y5SjMFCWstmJ9iKrpIUBcTztpuymxENX6uawF7hsWZzhMpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=eN17ffd8; arc=none smtp.client-ip=80.12.242.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id sSi1r5Z4Z41mCsSi1r063b; Thu, 04 Apr 2024 21:25:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1712258714;
	bh=7mPh8LUlfoCDmFbSl6D0jWurWX3Eg+JC2SqBtIhoOGc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=eN17ffd8bTSnvh9tMtkbSJ3lfQle/tBrCTt37P67ieDX7vpHxeMzKFRFAzjtZwPvG
	 ygdlvCBR6YX/y9FEF+mBsaVnqtwzNdIx1mQmlY2lpD/x2BZRsJSesa/niuwD3EI3iR
	 EQl5zFf64ZRLLr76OWYlIEOK0kavjRjJi4iWJAreJm1TcmCeQNl638EY8gjjcOoDT/
	 L3Y41daNle69s1Zgbubqms+Zw1i+6zfMyJ5IFzCeJUdUFoqU+kNUV0yZiK/uSX/B00
	 t1k1sP0O9AY2RpEvNneM14sDxo7zJIxMSirrUgdQtJWQUtSjOq5lO12hm9WZHNIaGn
	 kOB+uhcUOtBvQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 04 Apr 2024 21:25:14 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Colin Foster <colin.foster@in-advantage.com>,
	Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] mfd: ocelot-spi: Use spi_sync_transfer()
Date: Thu,  4 Apr 2024 21:25:09 +0200
Message-ID: <7af920eb686b719cb7eb39c832e3ad414e0e1e1a.1712258667.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use spi_sync_transfer() instead of hand-writing it.
It is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/mfd/ocelot-spi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mfd/ocelot-spi.c b/drivers/mfd/ocelot-spi.c
index 94f82677675b..b015c8683f1b 100644
--- a/drivers/mfd/ocelot-spi.c
+++ b/drivers/mfd/ocelot-spi.c
@@ -145,7 +145,6 @@ static int ocelot_spi_regmap_bus_read(void *context, const void *reg, size_t reg
 	struct device *dev = context;
 	struct ocelot_ddata *ddata;
 	struct spi_device *spi;
-	struct spi_message msg;
 	unsigned int index = 0;
 
 	ddata = dev_get_drvdata(dev);
@@ -166,9 +165,7 @@ static int ocelot_spi_regmap_bus_read(void *context, const void *reg, size_t reg
 	xfers[index].len = val_size;
 	index++;
 
-	spi_message_init_with_transfers(&msg, xfers, index);
-
-	return spi_sync(spi, &msg);
+	return spi_sync_transfer(spi, xfers, index);
 }
 
 static int ocelot_spi_regmap_bus_write(void *context, const void *data, size_t count)
-- 
2.44.0


