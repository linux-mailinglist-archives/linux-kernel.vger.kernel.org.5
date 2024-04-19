Return-Path: <linux-kernel+bounces-151565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C2F8AB07F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E211C21173
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AD512FB36;
	Fri, 19 Apr 2024 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJVVUFV0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446E412FB24
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713536061; cv=none; b=rNh1VQeofkffRzEVF+7Ph9ZeNEJSTcd7aXlRpcJO8tdrDszfpTb5AJZOzweOzp0Te3Td9SdXv1nIK6fN7vR0/ZmlyLqHNBcquE3q1bqFSuDYlHYXmROXjpeETsfIMO6rqyr1l3A/eUY7S74Y+vxBPV3rW1mLEDZ3ypaJ61LdSFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713536061; c=relaxed/simple;
	bh=p/3JPIvR/iX1VY60SIuTHKNJqMHHtyy/NyXLubcttms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CqgqbmvDRE5+f8mOq4Vld1vYOSm5rOp1AIK3omBdr37U3GYifIKnCOMMq+m08G7M76LkZzlBXHZWTTQLVqo094N4O+E6whJ6oRfdomwUG1zIygRVADXStG2FLhlLlYLNZ9KyZ6GEybE8ygMaRkvW5PZe2URuK61C7+hKTvLM2Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJVVUFV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E07C3277B;
	Fri, 19 Apr 2024 14:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713536060;
	bh=p/3JPIvR/iX1VY60SIuTHKNJqMHHtyy/NyXLubcttms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bJVVUFV02+KHL3buUmmT6Sw5mV7TaTRqwi/xOTm6e/qPBQK/6S5Qlx4wXwoWL1fzz
	 FQvNPvlQ2aVg3S3LnsuwQ5E6bHxfRg5eszKSVQ9GPpPMuA05ouaGbJ3CDiRHMPje1G
	 a3cvjuMayNDtGnQfBP3LIkplmXPKrhXjtePh8vd9FBGGfM9gtqZEFvrUre3v9+IyeN
	 duB8CzM2Z4GePy/DWd7Eq1FjsJsfM7eGN+Qv7eH1L7s8h6NyhnD+vR56qBZ/Nxb9n9
	 pZTh1IT/0liGLNoCDFN1KMaVeMn3U/yhRWIoq7kcgvT6suf/3+b+l/Xzos18P+87q5
	 XjSZ/0xYRt6VQ==
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
Subject: [PATCH v2 6/6] mtd: spi-nor: introduce support for displaying deprecation message
Date: Fri, 19 Apr 2024 16:12:49 +0200
Message-Id: <20240419141249.609534-7-mwalle@kernel.org>
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

SPI-NOR will automatically detect the attached flash device most of the
time. We cannot easily find out if boards are using a given flash.
Therefore, add a .deprecation_version to the flash_info struct which
indicates the kernel version after which the driver support will be
removed.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/core.c | 11 ++++++++++-
 drivers/mtd/spi-nor/core.h |  3 +++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 8e4ae1317870..bed5209b94de 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3323,7 +3323,16 @@ static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
 	 * some partitions may be marked read-only, and we don't want to loose
 	 * that information, even if it's not 100% accurate.
 	 */
-	return jinfo ?: info;
+	if (jinfo)
+		info = jinfo;
+
+	if (info && info->deprecation_version)
+		pr_warn("Your board is using a SPI NOR flash (%s) with deprecated driver\n"
+			"support. It will be removed after kernel version %s.\n"
+			"If you feel this shouldn't be the case, please contact us at\n"
+			"linux-mtd@lists.infradead.org\n",
+			info->name, info->deprecation_version);
+	return info;
 }
 
 static u32
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 1516b6d0dc37..984155d10fd8 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -447,6 +447,8 @@ struct spi_nor_id {
  * @id:   pointer to struct spi_nor_id or NULL, which means "no ID" (mostly
  *        older chips).
  * @name: (obsolete) the name of the flash. Do not set it for new additions.
+ * @deprecation_version:      the kernel version after which the support for
+ *	                      this flash will be removed.
  * @size:           the size of the flash in bytes.
  * @sector_size:    (optional) the size listed here is what works with
  *                  SPINOR_OP_SE, which isn't necessarily called a "sector" by
@@ -504,6 +506,7 @@ struct spi_nor_id {
 struct flash_info {
 	char *name;
 	const struct spi_nor_id *id;
+	const char *deprecation_version;
 	size_t size;
 	unsigned sector_size;
 	u16 page_size;
-- 
2.39.2


