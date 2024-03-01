Return-Path: <linux-kernel+bounces-88581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E9086E3AE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C301C22BD9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9EC6F06B;
	Fri,  1 Mar 2024 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pZkNualV"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943EF6E2BD;
	Fri,  1 Mar 2024 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709304300; cv=none; b=MmSkZsWn3lv5NjIM053aXJTdbHTxd0QVqCDrKeSdgD4WAoqYmxai7LgjjgrZ1PIMpidBTm03YE0lRktwfxmMez0VI9PjVR4zMoXS1reZqzJu17HClkXEPX9YLmSTUnF/MeJfGD7lvPAIWHbGYLS+62skm9jPnEsUNgWA4XF7AZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709304300; c=relaxed/simple;
	bh=+HDNwzccRkcc9hkZwYDAOt4M5Q55mu65xiChlYxn1dQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WJNqQEXHa2QsUIJd/Dw49NYFmBhrkT9mueREE4Nc3+0i3soV4IQmKqh/Wu/fQIWtQ/J2zt8klO0hFU9Lo+2k6XqQCeTdwypv7xN7PzgVHbYiyZ4jnTuh+8OMpL1R6wER6JXJWtfWsSd81FJL3aUH1Ll4mEEymMCO4W/xSh4XVPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pZkNualV; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709304297;
	bh=+HDNwzccRkcc9hkZwYDAOt4M5Q55mu65xiChlYxn1dQ=;
	h=From:To:Cc:Subject:Date:From;
	b=pZkNualVekd3oqnVTbyHho7X9a0TfTXMrnaziDRaJuNjpVhtH/ldHxYvBFfjVKGs8
	 nRTXZokimaEUyf8L/HDeFwqHyiNNDD9SIny/tWWzrFRWqi0eCd/z4kTHb5LZLovYv/
	 la1r0v6NgLzIg89PPK8lXJi1Qx/K6rfOnIeB5Dp/REZmZ/rbTHybVUX7/cGS6Mn+DR
	 t8AZo93TmYzPzeYWEfeqslFe+xWaf0d2DVURdIUGlY1eMAGAsCWbbYstJ6/RNW42uQ
	 5XiSJwzhVx4YxHieVKiny3fIds9b51FFRHQnNrAwIdpBlATEOXNCNUYJJTJnU7n6Gr
	 0PSx8sSrce0XA==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EA57137803EE;
	Fri,  1 Mar 2024 14:44:53 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	kernel-janitors@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: core: correct type of i to be signed
Date: Fri,  1 Mar 2024 19:45:16 +0500
Message-Id: <20240301144517.2811370-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i should be signed to find out the end of the loop. Otherwise,
i >= 0 is always true and loop becomes infinite.

Fixes: 6a9eda34418f ("mtd: spi-nor: core: set mtd->eraseregions for non-uniform erase map")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/mtd/spi-nor/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 65b32ea59afc6..46bc45b80883f 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3373,7 +3373,7 @@ static u32
 spi_nor_get_region_erasesize(const struct spi_nor_erase_region *region,
 			     const struct spi_nor_erase_type *erase_type)
 {
-	u8 i;
+	s8 i;
 
 	if (region->overlaid)
 		return region->size;
-- 
2.39.2


