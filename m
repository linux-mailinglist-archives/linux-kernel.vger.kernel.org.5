Return-Path: <linux-kernel+bounces-609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAF481437B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49282844CC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0559E18E26;
	Fri, 15 Dec 2023 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OFu3vEQG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC088182B5
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40c41b43e1eso4677325e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 00:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702628508; x=1703233308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TuJawO4SusZv8/FICQYIvQK4zSxUomciGjXfeupkpPM=;
        b=OFu3vEQGw3noi41QwdOnUqkSZ2qQl2fXzpgSdp1zAMqZTciVFG+iB372kFP2cl2syd
         vfG7GgZGLw+LhH523fGGh/zvoaCuWfk9MeNXfhMLuO4U4np/geKJkgaEN6c26vcZL6cv
         7IIFuIE/5Ugs5MxPq5U8P2gyztzq8Ul9NwDTfVOtNm+MkRa9J3YzvfykmQ3vQBtY13oV
         stW/CE9+3j1c21SM8eQJkDgpHuCgvWbkc10vL/IJD0pH/1nh12sPPyFo345JwC4B6YfP
         Y4SIDZvb34Zq9cqdcMiQYS0YpLD+V0hhaKiiennmWm8vPujPCbFs6PNuHtafxOk4FVF/
         lsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702628508; x=1703233308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TuJawO4SusZv8/FICQYIvQK4zSxUomciGjXfeupkpPM=;
        b=wkeg5vo36kzcry/EZ4qUBLB7CgrxFVZOO5odiOqcJQ9eRv78hMN/9QasbgBOa+ahc3
         0ta6bb3++JPqFgjHfQFCwgxqdSqJJQLbd+cqCztJqRglu8HuI3L5nWhZFMze2X7mx+qo
         KzikTL+PEv76DVgRWfXzhdT6viG4Dw4Hvv31C18vh1Zqm0PUFO8LHXGp2KJNuF/IfVWL
         DqKPAVEzWJ10E1iya43cic18dn/G6GGMEeivwRqce+B6KXPPUyWXBUq8XlfsNXkSJh0M
         WXUC5KPMPX9xkUCAi4uhIVn6/TecAfUS7XcU8pXTl4/XBLxPU7tXd/to9uAJSf1oB9EE
         mfpA==
X-Gm-Message-State: AOJu0Yzx1W2a3X/rZPEpZs8uQOLY51qzKDFnH13irkAcR5fU21l1fjVI
	p2PMb5HmmdoiN8zzzaTB3M4aSw==
X-Google-Smtp-Source: AGHT+IEbe2QkPEqCtjPj/fi/n5kO4uAzZ+iTCV7x1AVruE2cmQ2PU5UDSwoezU/9v/C8IO+qTKl4vg==
X-Received: by 2002:a05:600c:292:b0:40c:260e:1bf6 with SMTP id 18-20020a05600c029200b0040c260e1bf6mr4922669wmk.192.1702628508089;
        Fri, 15 Dec 2023 00:21:48 -0800 (PST)
Received: from 1.. ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id p1-20020a05600c1d8100b0040b47c69d08sm30365570wms.18.2023.12.15.00.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 00:21:47 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: pratyush@kernel.org,
	michael@walle.cc,
	miquel.raynal@bootlin.com
Cc: richard@nod.at,
	jaimeliao@mxic.com.tw,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 4/4] mtd: spi-nor: drop superfluous debug prints
Date: Fri, 15 Dec 2023 10:21:38 +0200
Message-Id: <20231215082138.16063-5-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215082138.16063-1-tudor.ambarus@linaro.org>
References: <20231215082138.16063-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1327; i=tudor.ambarus@linaro.org; h=from:subject; bh=g4bufmfMS6w03D11CI2uGLsvxqA3io9spWS2c3zko/k=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBlfAySTlx2lf9cwP4qqsgz/vxDdsVq7T1ap/JJI BpGZZFzFMiJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZXwMkgAKCRBLVU9HpY0U 6Te1B/0RAVmyu2FL3aavzo1rPOrgqcXWHparU1NyB6HBFb6+5q5BQ2Sglzlrm7fsREvIdcQni3f k/SwZgWKcJ8caUR4mZJJnTTwuV9e+Y3hPkLUNlK74SBOzxZ3UuvugVxykGAvUYjT1vhUixxKLnH p17ELt0f8QR9bxPhHZ8rn/S25uX/36CcDFIrtOK/bdvW6Sbv2q3wZPXfnNlMfZzi2e12t+ok4Mj lMkdls5z5E54mrtjOfxS+isLi1qEOaro8jjw9i4RvgZA9fl1AH5/xssRUE4oCrV7uZYivrvG/nu /e7opM8CRO2jk2kLLEp/XqNtuIuWWYgomUXVDUeeWabi/K4T
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit

The mtd data hall be obtained with the mtd ioctls or with new debugs
entries if one cares. Drop the debug prints.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/core.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index ca5bd93d1f17..a708c3448809 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3561,22 +3561,6 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	dev_dbg(dev, "Manufacturer and device ID: %*phN\n",
 		SPI_NOR_MAX_ID_LEN, nor->id);
 
-	dev_dbg(dev,
-		"mtd .name = %s, .size = 0x%llx (%lldMiB), "
-		".erasesize = 0x%.8x (%uKiB) .numeraseregions = %d\n",
-		mtd->name, (long long)mtd->size, (long long)(mtd->size >> 20),
-		mtd->erasesize, mtd->erasesize / 1024, mtd->numeraseregions);
-
-	if (mtd->numeraseregions)
-		for (i = 0; i < mtd->numeraseregions; i++)
-			dev_dbg(dev,
-				"mtd.eraseregions[%d] = { .offset = 0x%llx, "
-				".erasesize = 0x%.8x (%uKiB), "
-				".numblocks = %d }\n",
-				i, (long long)mtd->eraseregions[i].offset,
-				mtd->eraseregions[i].erasesize,
-				mtd->eraseregions[i].erasesize / 1024,
-				mtd->eraseregions[i].numblocks);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(spi_nor_scan);
-- 
2.34.1


