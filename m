Return-Path: <linux-kernel+bounces-90263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C34D586FC99
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E9D1281B70
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E77E1B59B;
	Mon,  4 Mar 2024 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CFN/4qSk"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F27199B9;
	Mon,  4 Mar 2024 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709542847; cv=none; b=R8F96DA3DurYOJe6OzRGGECxBnA75qtvNAAzK8mJmFW8lZZynNyvEZOgd/Irrjwg68uqVE2/zs+k5BLocndeFnO8WUM1Wc4np+H8G4f+G1D9oncrqBOcRDs7tS8JKH+CBTrcGXPmuAcYlTri7L/CH13ajiKlfSasB3+pk3mEWfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709542847; c=relaxed/simple;
	bh=bAB5F4vNP6IVN7+dQqmn759QyLQ7N1UG2FLkohO65P8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mPnU2L+Z/vEmgMsomkUw1RClRtCBYMiJNbkMe89udz2w5Cus5N0bhxA5/zft5FdDkTEJHEqSHqzuMU1eqjCbKPTHd+SpHQUd58EveWJ1jHji2gAxPOa5FxY4dH926bL5h3KABByP6ezZwuaLKNi2V3UUmNUvBg7P/GD+tCmwtyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CFN/4qSk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709542844;
	bh=bAB5F4vNP6IVN7+dQqmn759QyLQ7N1UG2FLkohO65P8=;
	h=From:To:Cc:Subject:Date:From;
	b=CFN/4qSkWBc9srp/cqJivW54+P7ZwVqVbVST0wpPuMjw9RIgz/SLskeWyjaIvuQil
	 18X5kSm0FG1hFvv/vCUz2mMeIX6SjaJwNZ05GEPpy5wtRk52rfWWclC0EBq0IK1Jyd
	 KBgyp419NNL7VdiV8tzw1zA90IdPNgwN16k05ChE4tKD3vPEGz4dpKvmZ7wFpSbuqR
	 J0i57OXQ2J/mRtLteKNq4fAJ7iavX1dT/KxzWQNDpSX5pXH7PYffTMepvrrFjUDEWi
	 PXe2A1AgTR/CQP+SpzE5Z+Wn892rOedK2eH+SSGJoCW/nWausLiwhQS14AV59zHPT6
	 UMwjMPdN2Feaw==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AC13F3781FE9;
	Mon,  4 Mar 2024 09:00:41 +0000 (UTC)
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
Subject: [PATCH v2] mtd: spi-nor: core: correct type of i
Date: Mon,  4 Mar 2024 14:01:03 +0500
Message-Id: <20240304090103.818092-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i should be signed to find out the end of the loop. Otherwise,
i >= 0 is always true and loop becomes infinite. Make its type to be
int.

Fixes: 6a9eda34418f ("mtd: spi-nor: core: set mtd->eraseregions for non-uniform erase map")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v1:
- Make i int instead of u8
---
 drivers/mtd/spi-nor/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 65b32ea59afc6..3e1f1913536bf 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3373,7 +3373,7 @@ static u32
 spi_nor_get_region_erasesize(const struct spi_nor_erase_region *region,
 			     const struct spi_nor_erase_type *erase_type)
 {
-	u8 i;
+	int i;
 
 	if (region->overlaid)
 		return region->size;
-- 
2.39.2


