Return-Path: <linux-kernel+bounces-142750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAB98A2FBB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89ADB285D3D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B5684E0C;
	Fri, 12 Apr 2024 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmzdkDDa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE07F84E01
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929458; cv=none; b=GxmkbOhxSG3aD1VMkV/G6fGjmrR4QPx/5SFx+JF79boCBPIlVqnVlOTMH5IXnkVnk6U/hvJZbbmZvr2fPKGPCU57Bz6zf3dc1EhcwVvTJioBr70DLT7Zg73VASLSUBUIQCNW8o53qYxg4jH97l2FisW4wbi2eKrMQQmoeV52bGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929458; c=relaxed/simple;
	bh=gKGUc/1cQbsMy5SwuoHZdZG4ZL+HCcopgsRqDXXZ9hs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eqL+wR82kTTsGNjus9DJcYKuOlDIVn7tzVmjNgkll93hoKE+f+6Of/4AwffihQnalAQyaxKTqCZKV0E0sqbU+BAPssQfN48DvMBlO/qA/twu4ykukj2hbhJzpVLxZDEa/sge3gpHLRONigSBGGX89rgcxiDKhuL4UdU1xa8U4oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmzdkDDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FAAC32781;
	Fri, 12 Apr 2024 13:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712929458;
	bh=gKGUc/1cQbsMy5SwuoHZdZG4ZL+HCcopgsRqDXXZ9hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZmzdkDDascJuxzR8+nPCVHl7jYh25K94DrpS2ELa323WyinpN/GBlZSskLtax//Wk
	 s3ApOWXuhhXGkqtOHgbpOGzG76/jpg99HGyYfTzNUDUez5VUwNNkPJQL9ITjCT4Fb0
	 jwO0sMyoWswWQEuYxKl8MA91tlMKrdMdlhJreZ30OMYFPZkRbsCdv3/mc2Usa5PTgK
	 6QdGoM+KYzLLu18GKoIZUJ8b0kkr9+VbyGosI4HSjCM4nQrqpI48ytJQln2dAsEy9i
	 DbWp9qDQn0yWKa9emz+6CUFnH0YF2PHuMELxp8MQS6ogbFAx/suSVPxzwi8foGTom1
	 M7cqGMUZ/mMjQ==
From: Michael Walle <mwalle@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v1 2/6] mtd: spi-nor: get rid of non-power-of-2 page size handling
Date: Fri, 12 Apr 2024 15:44:01 +0200
Message-Id: <20240412134405.381832-3-mwalle@kernel.org>
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

The Xilinx flashes were the only user of the page sized that were no
power of 2. Support for them were dropped, thus we can also get rid of
the special page size handling for it.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/core.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index cbe5f92eb0af..fb76e0522665 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2098,7 +2098,7 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 	size_t *retlen, const u_char *buf)
 {
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
-	size_t page_offset, page_remain, i;
+	size_t i;
 	ssize_t ret;
 	u32 page_size = nor->params->page_size;
 
@@ -2111,21 +2111,9 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 	for (i = 0; i < len; ) {
 		ssize_t written;
 		loff_t addr = to + i;
-
-		/*
-		 * If page_size is a power of two, the offset can be quickly
-		 * calculated with an AND operation. On the other cases we
-		 * need to do a modulus operation (more expensive).
-		 */
-		if (is_power_of_2(page_size)) {
-			page_offset = addr & (page_size - 1);
-		} else {
-			u64 aux = addr;
-
-			page_offset = do_div(aux, page_size);
-		}
+		size_t page_offset = addr & (page_size - 1);
 		/* the size of data remaining on the first page */
-		page_remain = min_t(size_t, page_size - page_offset, len - i);
+		size_t page_remain = min_t(size_t, page_size - page_offset, len - i);
 
 		addr = spi_nor_convert_addr(nor, addr);
 
@@ -3054,7 +3042,14 @@ static int spi_nor_init_params(struct spi_nor *nor)
 		spi_nor_init_params_deprecated(nor);
 	}
 
-	return spi_nor_late_init_params(nor);
+	ret = spi_nor_late_init_params(nor);
+	if (ret)
+		return ret;
+
+	if (WARN_ON(!is_power_of_2(nor->params->page_size)))
+		return -EINVAL;
+
+	return 0;
 }
 
 /** spi_nor_set_octal_dtr() - enable or disable Octal DTR I/O.
-- 
2.39.2


