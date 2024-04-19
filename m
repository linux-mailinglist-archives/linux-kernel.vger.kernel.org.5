Return-Path: <linux-kernel+bounces-151564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF498AB07E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59550285542
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B08412F5BB;
	Fri, 19 Apr 2024 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPzfyqZD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15A712F5A1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713536058; cv=none; b=XX1B5VATSbFU2L6u2ACDrw7lU1OscQh0giP8QI5EHr4I2w2fDWzROSn2Ec5+SCQ4UePMWnW1Yy7RTBdjlakZ1a0Pc+SdP1MQaDO4cpwyr1t0WzaT9e7Uen7LPhABxyeoa7PqByMp2gAG78hJmBd6vq+FMcDQ1muuz7KgKKL7jhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713536058; c=relaxed/simple;
	bh=DcpeOrGfxSWHHh5NWmUVMOKN4dI/mFp5Fo+st0c8Sy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IhreWKPUecwaGI2qgiMVvLI6O0KsrYHj7xRAjTJyBm7rAe6ELFP+dvLo6SWcMyDCs9b+GAELbwDh0MunehdEIcwIXiR3Q15aJfPw1QbgQj4EHBj0gSs44tNkPZVjy1QvC6hVTOWO44M3x822Qc9jZbqQ0MxN+zw11hty6pRorck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPzfyqZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC9AC32781;
	Fri, 19 Apr 2024 14:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713536058;
	bh=DcpeOrGfxSWHHh5NWmUVMOKN4dI/mFp5Fo+st0c8Sy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MPzfyqZDTSlEOuYwta3lRloXs0YAlULAlSge2d5/w+h0p9F1rCwkCaU190HAsPf+C
	 1bH9QgzNb5p1UuLAU0OcQBe+loA2WqYp0w8xC0PZz0sHNHTHD7HPgrjctiWJSo9QRE
	 q3Kg5AWBb2Yz9x1lHjsgBe0HHDtImeGhLN8uDxP9dS5UgR4Jzd+vyWlaS1WXuGEOM2
	 T96DNEIJPb/mIk0fXd9u8ij9sH/wEVbkRJzo+LZuKm1uvn/UlRc4FzelePYoSkQ1Qn
	 QLiJZg/NzE1Kii8Zoq+cRjuyAGzxdtEeJsWKH8NS+sTtLCWe2ESwfn8PUnDXiktuAF
	 qRTUxxFd6VS7A==
From: Michael Walle <mwalle@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Ricardo Ribalda <ribalda@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v2 5/6] mtd: spi-nor: simplify spi_nor_get_flash_info()
Date: Fri, 19 Apr 2024 16:12:48 +0200
Message-Id: <20240419141249.609534-6-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419141249.609534-1-mwalle@kernel.org>
References: <20240419141249.609534-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rework spi_nor_get_flash_info() to make it look more straight forward
and esp. don't return early. The latter is a preparation to check for
deprecated flashes.

Signed-off-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 drivers/mtd/spi-nor/core.c | 45 ++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 4e2ae6642d4c..8e4ae1317870 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3294,39 +3294,36 @@ static const struct flash_info *spi_nor_match_name(struct spi_nor *nor,
 static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
 						       const char *name)
 {
-	const struct flash_info *info = NULL;
+	const struct flash_info *jinfo = NULL, *info = NULL;
 
 	if (name)
 		info = spi_nor_match_name(nor, name);
-	/* Try to auto-detect if chip name wasn't specified or not found */
-	if (!info)
-		return spi_nor_detect(nor);
-
 	/*
-	 * If caller has specified name of flash model that can normally be
-	 * detected using JEDEC, let's verify it.
+	 * Auto-detect if chip name wasn't specified or not found, or the chip
+	 * has an ID. If the chip supposedly has an ID, we also do an
+	 * auto-detection to compare it later.
 	 */
-	if (name && info->id) {
-		const struct flash_info *jinfo;
-
+	if (!info || info->id) {
 		jinfo = spi_nor_detect(nor);
-		if (IS_ERR(jinfo)) {
+		if (IS_ERR(jinfo))
 			return jinfo;
-		} else if (jinfo != info) {
-			/*
-			 * JEDEC knows better, so overwrite platform ID. We
-			 * can't trust partitions any longer, but we'll let
-			 * mtd apply them anyway, since some partitions may be
-			 * marked read-only, and we don't want to loose that
-			 * information, even if it's not 100% accurate.
-			 */
-			dev_warn(nor->dev, "found %s, expected %s\n",
-				 jinfo->name, info->name);
-			info = jinfo;
-		}
 	}
 
-	return info;
+	/*
+	 * If caller has specified name of flash model that can normally be
+	 * detected using JEDEC, let's verify it.
+	 */
+	if (info && jinfo && jinfo != info)
+		dev_warn(nor->dev, "found %s, expected %s\n",
+			 jinfo->name, info->name);
+
+	/*
+	 * JEDEC knows better, so overwrite platform ID. We can't trust
+	 * partitions any longer, but we'll let mtd apply them anyway, since
+	 * some partitions may be marked read-only, and we don't want to loose
+	 * that information, even if it's not 100% accurate.
+	 */
+	return jinfo ?: info;
 }
 
 static u32
-- 
2.39.2


