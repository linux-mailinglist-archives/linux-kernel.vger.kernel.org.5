Return-Path: <linux-kernel+bounces-142755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6A38A2FC2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 691DDB249F0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930CE86267;
	Fri, 12 Apr 2024 13:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3HBauPO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4F986258
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929467; cv=none; b=J2EayGYwQZmYnPRG/sW2huFif1K1zIoSG3FXl/mNV3qa9htCv0ym/7CfmCu9TSuxEqxl52GvvubJHNcapDpPMwYKmfUwbDcs+O2Zoa6kbBIMG2fkfLViIwApo54w1WaCj0GlzAnsdvcVMtfR9JHq5eubdVgdr+eX36518jWsvMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929467; c=relaxed/simple;
	bh=Hetc/oU2jZtMC9jkGVkbwuLoaws05Gs3ek4EybKWEMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WLy8WXjZrUHV/vXVYrqPAWmdD2mskbhwxmdbpFMVKwsm+xNRd/+NY8hZjJFYxZmHOoqHqd4VAKNxi6ka0Ixcr/9RwY+W/zC1oim0uNxOk0TIevbRNqnqTNCg7zcagvoazhg5ySTF8IJgv7yqGY6PH/5mnpwA1fOh+ErkvrSqX70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3HBauPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123BCC2BD10;
	Fri, 12 Apr 2024 13:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712929467;
	bh=Hetc/oU2jZtMC9jkGVkbwuLoaws05Gs3ek4EybKWEMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h3HBauPOR0oPi0tOF6mEj1wDwCkaBlUi0Wq3QWcIVW9hWixJ5AS2Lk0mbuRzp/jlR
	 WR09bQOmjRCBddX2sOdOldFbb5tO8hV48GbfdiFN38I7dFHw3k8+204OdsN8XIRyKF
	 dKt6879LcC3LGSn/1GlzpKlGu7TLiM39ugnpnw6BviHV3Uhjy4JCvQ/Di+CUAV7OOG
	 J4JuW05KVu7JRdIPRi5sI1YcWcfLQOiaeFVqUw4XSAhRt9tiY9wkuExoWEo7J90egI
	 HgzcXod64yKmBDtjZ16XaiMs3vJDDjGm0L0CMB9laMEsOOIkyO4cqH9um7MoHfLYeC
	 M3YPWXWYucP1g==
From: Michael Walle <mwalle@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>
Subject: [RFC PATCH v1 6/6] mtd: spi-nor: introduce support for displaying deprecation message
Date: Fri, 12 Apr 2024 15:44:05 +0200
Message-Id: <20240412134405.381832-7-mwalle@kernel.org>
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

SPI-NOR will automatically detect the attached flash device most of the
time. We cannot easily find out if boards are using a given flash.
Therefore, introduce a (temporary) flag to display a message on boot if
support for a given flash device is scheduled to be removed in the
future.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/core.c | 12 ++++++++++++
 drivers/mtd/spi-nor/core.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 58d310427d35..a294eef2e34a 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3312,6 +3312,7 @@ static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
 						       const char *name)
 {
 	const struct flash_info *jinfo = NULL, *info = NULL;
+	const char *deprecated = NULL;
 
 	if (name)
 		info = spi_nor_match_name(nor, name);
@@ -3326,6 +3327,17 @@ static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
 			return jinfo;
 	}
 
+	if (info && (info->flags & SPI_NOR_DEPRECATED))
+		deprecated = info->name;
+	else if (jinfo && (jinfo->flags & SPI_NOR_DEPRECATED))
+		deprecated = jinfo->name;
+
+	if (deprecated)
+		pr_warn("Your board or device tree is using a SPI NOR flash (%s) with\n"
+			"deprecated driver support. It will be removed in future kernel\n"
+			"version. If you feel this shouldn't be the case, please contact\n"
+			"us at linux-mtd@lists.infradead.org\n", deprecated);
+
 	/*
 	 * If caller has specified name of flash model that can normally be
 	 * detected using JEDEC, let's verify it.
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 8552e31b1b07..0317d8e253f4 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -524,6 +524,7 @@ struct flash_info {
 #define SPI_NOR_NO_ERASE		BIT(6)
 #define SPI_NOR_QUAD_PP			BIT(8)
 #define SPI_NOR_RWW			BIT(9)
+#define SPI_NOR_DEPRECATED		BIT(15)
 
 	u8 no_sfdp_flags;
 #define SPI_NOR_SKIP_SFDP		BIT(0)
-- 
2.39.2


