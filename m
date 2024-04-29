Return-Path: <linux-kernel+bounces-162212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9308B579E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF91DB255C1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8BD537E3;
	Mon, 29 Apr 2024 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ckc5k5lO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AD852F6D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392681; cv=none; b=AKT7hbCeLl7KagjbfwepdqXXQiEXj8xb3Nma7YLcuD+PV+gHzObwYeXdI1N5+Nkwr98RN2U7q4UA0hfVqUTXijsayhbZ/0P3G1ZwCMcXDAniALZUnMaL5ausmcRm3PbqMMXkM9ex144irycV7K98JJNzAj0QUw2CImfqGdlypZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392681; c=relaxed/simple;
	bh=X1Qvu63kkY3/b6fxxe2AVsLJHeAHq2bhdDS7GrXYg8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p/I1VkpVNnCbYmrTi+33C7ouumWwnaTWTIgzXmUYAHMQwzvUVPXfdQMKz0/TrjMJ8ukshzTg580YxgYJWDDApebRCvW2o3ugOvEBa0RA6QRscFOEFKH90i7c6vcQfHIWiwSWFR0B18ibkLpWXuQw+SP3rpqJSOJYeMP7i290BZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ckc5k5lO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020DFC113CD;
	Mon, 29 Apr 2024 12:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714392680;
	bh=X1Qvu63kkY3/b6fxxe2AVsLJHeAHq2bhdDS7GrXYg8Q=;
	h=From:To:Cc:Subject:Date:From;
	b=Ckc5k5lO0SoC2waH5Mm3uRE9/G6jrfXw9PNzLBHvSRMyV341Vm+RlthYwYgCipJIH
	 0E3j9rgXWKj2scNo1w2qh1TrvnXJLSmpRRpI0viX4y2eCYyCJRJf5QWbc4Isd2Rw9d
	 Zi82egH2foL7xEEQJx12SiBOcSAbgTND1blxsrk6/U14zb1Z4TTPl99bxlWtrYlP/I
	 DcSH0u5vWZrdGTZ7x28mtnOaJ9WvfVL9PZyiFI8wsJFCFxTFBpn9O0ufS1vK1jkTbk
	 ctvnCu+dyyE6/MTXmGIFIc/qYZI7TEa60LaSrFrEihxBDd7ubL6E6NMl4WnxxWzHVF
	 dFfkqnELShCUw==
From: Michael Walle <mwalle@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: replace unnecessary div64_u64() with div_u64()
Date: Mon, 29 Apr 2024 14:11:13 +0200
Message-Id: <20240429121113.803703-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both occurences of div64_u64() just have a u8 or u32 divisor. Use
div_u64() instead.

Reported-by : Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/9ba7f4e6-2b8b-44a3-9cac-9ed6e50f1700@moroto.mountain/
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 3e1f1913536b..028514c6996f 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2893,7 +2893,7 @@ static int spi_nor_late_init_params(struct spi_nor *nor)
 		spi_nor_init_default_locking_ops(nor);
 
 	if (params->n_banks > 1)
-		params->bank_size = div64_u64(params->size, params->n_banks);
+		params->bank_size = div_u64(params->size, params->n_banks);
 
 	return 0;
 }
@@ -3406,7 +3406,7 @@ static int spi_nor_set_mtd_eraseregions(struct spi_nor *nor)
 			return -EINVAL;
 
 		mtd_region[i].erasesize = erasesize;
-		mtd_region[i].numblocks = div64_ul(region[i].size, erasesize);
+		mtd_region[i].numblocks = div_u64(region[i].size, erasesize);
 		mtd_region[i].offset = region[i].offset;
 	}
 
-- 
2.39.2


