Return-Path: <linux-kernel+bounces-142754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA2B8A2FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AF47B247E5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7918286128;
	Fri, 12 Apr 2024 13:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzndw7DQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04E685954
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929465; cv=none; b=qVyDX63qHQlGhWsyRVNEeZItefduxxvdiophaPIJyF+3oR9tVVRiH3lXhAK9e/4BMT5jLH8j9visD1hTPOng8tL7X7XT9vmE2KGcURwLZQztYvIld0lnd8mzgN6N4V6L5wfp/tX3i9KcPgsUrzfG0Ip58UBkSb1YSl5e+2boNA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929465; c=relaxed/simple;
	bh=B7/0WXuNeHfB1kb629KPZ4FB30EU6w2b00Yh+4BqI5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K1MfrXTJle3k6D4AGkFl5FLM9DDI1DMa72Pc+zn2RUQzc4TLbe4FCmdrsQIWs04oya5Hk11lfbt7+nJ/WgDCC5a+WjlvkXZaqScTB6j7K1k489Uhp/pBYqBLtIOGqWqnPCQDYAoPbcUuQbH+abbkKILs3njLbSyF5yIl4aRpf8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzndw7DQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0450C2BD11;
	Fri, 12 Apr 2024 13:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712929465;
	bh=B7/0WXuNeHfB1kb629KPZ4FB30EU6w2b00Yh+4BqI5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kzndw7DQL4qgxyf+i/F1X6Ux4uobIQIrrUahDYPKEe/uuUdQiwNY8rkMf8YlVuaKn
	 BJaODhv1AMqazS3IfOT5wTTawOpqvif6YS31LOmMRqD3QKVELrlEWI0Y2W54NvubhU
	 C4+X7gQz9EZhjd+Etq3YVBUUWNAReyN5bl8djIWSsasPto7Cj8/RSdy7K7LmYOh8BL
	 F4aOZiroGwU4dYWR7Ia3chsHv8fsJUJDoDEYHz2Fox/8Dl7e4R1HlttvXeI0nmA2zZ
	 edOMT2eWhJop6owo34F7zDkQir/C3uUzSpYGylF608I8UXURaH0Z9yinJIQHfOH/jO
	 6dz+CbrPEv+hQ==
From: Michael Walle <mwalle@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v1 5/6] mtd: spi-nor: simplify spi_nor_get_flash_info()
Date: Fri, 12 Apr 2024 15:44:04 +0200
Message-Id: <20240412134405.381832-6-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240412134405.381832-1-mwalle@kernel.org>
References: <20240412134405.381832-1-mwalle@kernel.org>
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
---
 drivers/mtd/spi-nor/core.c | 45 ++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index bbfef7b3997f..58d310427d35 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3311,39 +3311,36 @@ static const struct flash_info *spi_nor_match_name(struct spi_nor *nor,
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


