Return-Path: <linux-kernel+bounces-61791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAEA851693
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB3B2865E6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5EB3E481;
	Mon, 12 Feb 2024 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JRE8NM8b"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ABF3E476
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707746637; cv=none; b=eQkr+TEvPENP699SsuuG4q9Zhy6ttDSF/r8nw57oeAsNpQdW6DD4VsLX862B1IY4hBOj/RcUKVc2l0/Oa6iX+J56Qmme1FoNsV58sCzU02aS4W33svswJTW44uHxHVcdBJzjB24PSB2uK41xVHLECh/OpRqqLGNB9K30Yb6zRuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707746637; c=relaxed/simple;
	bh=KjnXCwRxnG+I8/k2U9CBoqUpWqsb3SH0YxbrALUYHXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzYCgskKAfVy8n4jlOWqmKgIqsDErLP1RZuU23kPUnjMobquoffkxOd4Q3d0iLeSJc5eL1ItUxYn+p51IOOVp6deFSbB8RG0/0dDb8aT95R8O6curfprtP9pqZxRJ7r/UAxlx/vPKaytC4zDES8brlqSTRNt0XuVcEriCeoBx9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JRE8NM8b; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41102f140b4so3624505e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 06:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707746634; x=1708351434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwdchoB+O7sv0WsEEn/4CtktSHX1kT968ZrMEmEikx8=;
        b=JRE8NM8bSikEu352isWDDWIsrdKAjJiiEnk0HPsIsGO8JCOwJ7aMg1SD4MV4SAzXa3
         vFpWg2zpVb3IabPjENQL7+wz0N26ZSAPfioAH6D5Ehor3la35z+Y+YAGYzKmUlYlwpdr
         OHEpyw8nouooMVVspXq+aOmTGi4a5KDbljWM483c427ObkmAOvNqPMoHu4C4VzvmNP4b
         jIiVGQzSRWvLFcPzkM2Zbypk4UW5OvlYXiLz+AX7/zVk8ote6JD4b8UEbHgZg9XNkvcp
         g3qZiMgbs3okIpAIF2iS4BOFjytuvVbBYt7PL+dMrPYFSzT3d5YUC60aA1/Zmam9B/9M
         hZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707746634; x=1708351434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwdchoB+O7sv0WsEEn/4CtktSHX1kT968ZrMEmEikx8=;
        b=MBBoT64ZudPPbflQ50tGjmO3OwrWhbrs5UenkOmWhyyfsyfw0YQcEQIdG+u9019Cji
         rqQP0e+GvM3fCIXdSqJ3ZO+ZiXtMZxBYRHpyNfttKiomtZmAcMPhG2ekH4d+xMqOYICc
         +eq3ok7p3JUJfOjiqrRDZYAQcrSxCj2qqcVIXysAYSsiuxbcNjizhaR3QzTK0IZwimN3
         rBRCutRiGmgxIe4LSoW5fH+kqfaigCENy/YyMKZWfeIxsylBtFG7UMqqiV19li8XrFV1
         0x8MhihlQ2TcwitzS2APXOl6Lw/ITmv1ReycTTffuEZJNbVafZSePrs3KB9qzcBcRZRT
         DCsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaKMNmXnQBTK3ZtevLlxF+tv/Zxh7EErTIybOvdhz00ebSd+4mU099p8dmu+gWjUF0kdO2kHIxzCFTOvEzv4pbWxWOPAMUra3/uQAw
X-Gm-Message-State: AOJu0YxIjI9Zy7S/jdI5E9rIH6Xj4NaHeVRRNlQD1utEUp260tSXqtyx
	T67bYXyfYCVQMfU6ToHBd5JcJkB+n+pefzwc+ApxkLhPKjNiN87FNdiYU+Iu4qw=
X-Google-Smtp-Source: AGHT+IHwIfxoiv08pfQ+i4+RbhOsVo0yv8+VlGvPXUawS4yf0N3DLdABRSWs1wE4F5B5L8arnUsAKw==
X-Received: by 2002:adf:f6c7:0:b0:33b:81fa:ed8 with SMTP id y7-20020adff6c7000000b0033b81fa0ed8mr1852749wrp.0.1707746634081;
        Mon, 12 Feb 2024 06:03:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWsi5WaSfqWUOKZuQ8/DidxAGev3Z1GrHFRfy160EH3quKTiQOAjdKKIYPfP8D+yKm9Q1pQQ99vu0HH4Ito4Uzixp02M3marATcsrBiDwwN1D1A34dAB0gNM6X/hFbfhxagI5fk5smjLdVPyf496wYAfEN9QJSS1qLSCxa65Xi2pniuOJuVjGYXCEbb1LQH3E4Fl/kQ3yAP75XPXskXR6YWxlmdnmVV/KvB4C9QX25sun5SChLlO+ISybzk3xTURv0G2iJM3jzHhhwk4pCYvmnfpR+Xhj+HEj7kfKFmhvjyeKtVl/0pNtKOhhIDC1hIsOMupRu9FUf9i9MzlBAtMAjpjEz2P7t8Qnnyf8E0wtRqmYD7wbiJZUctZ4Qtd9f3SQFuZ7cz9sjQxCZXSqaNZkCxEQWu32XrtsVanHERDVPQcAuO26kapN8JKfADKCuhsuxrkJUwVS0l9NEF/3DvuVT5l9nH2+EiXx9Wz9jL9Lz812K3RpJRcYXvY5m2hf0wRVXGD6oEWdWOfAIICVIDINy1yHJZrf4nl9E36TmJv+Yfkbif3LmcADLGZw1qOvElbiFV4ouiBFtv2/BQQep878TKXghEkKopd/rVoe4KE00AEJ/90v0=
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id v9-20020a5d4b09000000b0033b843786e1sm2135356wrq.51.2024.02.12.06.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 06:03:52 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	robh@kernel.org,
	andi.shyti@kernel.org,
	krzysztof.kozlowski@linaro.org,
	semen.protsenko@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	devicetree@vger.kernel.org,
	arnd@arndb.de,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 05/12] spi: s3c64xx: retrieve the FIFO depth from the device tree
Date: Mon, 12 Feb 2024 14:03:24 +0000
Message-ID: <20240212140331.915498-6-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240212140331.915498-1-tudor.ambarus@linaro.org>
References: <20240212140331.915498-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are SoCs that configure different FIFO depths for their instances
of the SPI IP. See the fifo_lvl_mask defined for exynos4_spi_port_config
for example:
        .fifo_lvl_mask  = { 0x1ff, 0x7F, 0x7F },
The first instance of the IP is configured with 256 bytes FIFOs, whereas
the last two are configured with 64 bytes FIFOs.

Instead of mangling with the .fifo_lvl_mask and its dependency of the DT
alias ID, allow such SoCs to determine the FIFO depth via the
``fifo-depth`` DT property.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 72572e23cde5..b1c63f75021d 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1263,7 +1263,9 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 		sdd->port_id = pdev->id;
 	}
 
-	sdd->fifo_depth = FIFO_DEPTH(sdd);
+	if (of_property_read_u32(pdev->dev.of_node, "fifo-depth",
+				 &sdd->fifo_depth))
+		sdd->fifo_depth = FIFO_DEPTH(sdd);
 
 	s3c64xx_spi_set_fifomask(sdd);
 
-- 
2.43.0.687.g38aa6559b0-goog


