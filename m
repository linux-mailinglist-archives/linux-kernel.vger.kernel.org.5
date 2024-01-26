Return-Path: <linux-kernel+bounces-40405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F9383DFA4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE43B1F2217C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CA6208C0;
	Fri, 26 Jan 2024 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j69YWkrT"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B68A1F619
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289354; cv=none; b=WO/PHtzVQENmc7+76pESd48ifWwnvbdOUTVjwyH3oVYUCUNDXVAT7rLpnIiI00YSHP2uIq56QPcSlpUT8FbL2ilUJP3vEdf2GUIDvPBvm6IvrjBzU1F/ZspkxRSdzm78GKA6z4yOgm7SjR9ns70NU1bJi0wG/hQ0l/ySdeKeNq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289354; c=relaxed/simple;
	bh=/bUj8RLEZjYthKdQPh+B31SkdTcIYenu7ITI+3MnkQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sH1qDYZGcbgJrQ6xPG8PlSBCON+jyeDoeM8Omhb2pDBX3anagjcovbXtK+2NS2qB9Ae0Lwn6fTKz4mbGtjBYkkS/NPjAjUxolB+vGA84dvJFGPXtOTrFm3iTs6H+2TjKSWy4iEs/dkO02RyUTjVf77Mkw/HCa+MZzStWmIfnEH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j69YWkrT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e7e2e04f0so10063325e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706289352; x=1706894152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qV8ITwl1O57QlGGOA7a30fekUIiUXq0J9XlHzcfvV8M=;
        b=j69YWkrTdXJh3Sc3GxAPdndbbSVV3eHyHsLn7hnXdDGFmAHH4bttsILKKx72ht9qUv
         QN0ktjRpWHjoT9STE+Nsgq5DsIKaMtI4sZ728lO9GmwCbkPX1bZG/n0/WD7dPOEwulC0
         ig8RHeGa88NbXzIv6ai11WDZKPu3v/R7pmZkETPiY5qTA6nhtTgbE1w9CbF7NCRansUU
         nvM1+XlpiuHMBZ9oW1pF66jMU0bhaDAG+hY+HWtls7ODggFg++v5Asz/NdjBxyiQzg+e
         3YV+4/CCSVk4SIkmU3+ROp2iFyO4L7XjPUPYaRmFWYn0MQeAFEzAxNkwAs6iTfvSRWix
         OZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289352; x=1706894152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qV8ITwl1O57QlGGOA7a30fekUIiUXq0J9XlHzcfvV8M=;
        b=LPPFVK5uPeC9XJVFv0vfQNahN1lOklTREPEH9+8M3vtnPweZuw9GpvU8/tYi6wwOAC
         sYP4FJPHECGtO/dkipVXW7hc9U6sWo/6uM0KBUbJConNCM0rO6y/OwhlAOiVry9e2rBP
         QcJls8WF7nT4Ct3bEXhGxql/VwP7gKWYEpVPJzbK6HNhO5ZEAOTCmp8iXbxwg185jZXn
         CGUjcw5fcb2LFZEfzGVcnIT0JMWhLLihUFqpr14K+Zn890Z1QDR4X7pkexC+w2yxkZ2s
         zXosHw6nRWM1ANsV3K06bm4CfxLzhFwmgHG3aadTD4eqB6uFJinVUi/gnFLORgvd0Kca
         Kc6Q==
X-Gm-Message-State: AOJu0YwMbOykizObmy77cKqU4omKe+ZEqoiRYr9aiazoNeM6vvk4XDiu
	G1xUzHXHy8rmb6MuY8CAEIo8Dk3blf/CBQ3FkjJCmiai7Css4Bl/rCXJ1KdT42M=
X-Google-Smtp-Source: AGHT+IEvNW5DbdU8iWYCHzL7THeKzP8fEDzX/ESRePAImO9XzqkTKIuqDrCsNewY4d6xeB03PZgS4Q==
X-Received: by 2002:a05:600c:378b:b0:40e:8bb2:6bcf with SMTP id o11-20020a05600c378b00b0040e8bb26bcfmr75031wmr.151.1706289351730;
        Fri, 26 Jan 2024 09:15:51 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id k10-20020a05600c1c8a00b0040e451fd602sm6287286wms.33.2024.01.26.09.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 09:15:50 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	jassi.brar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 03/17] spi: s3c64xx: avoid possible negative array index
Date: Fri, 26 Jan 2024 17:15:31 +0000
Message-ID: <20240126171546.1233172-4-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
References: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The platform id is used as an index into the fifo_lvl_mask array.
Platforms can come with a negative device ID, PLATFORM_DEVID_NONE (-1),
thus we risked a negative array index. Catch such cases and fail to
probe.

Fixes: 2b90807549e5 ("spi: s3c64xx: add device tree support")
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 2b5bb7604526..c3176a510643 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1189,6 +1189,9 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 					     "Failed to get alias id\n");
 		sdd->port_id = ret;
 	} else {
+		if (pdev->id < 0)
+			return dev_err_probe(&pdev->dev, -EINVAL,
+					     "Negative platform ID is not allowed\n");
 		sdd->port_id = pdev->id;
 	}
 
-- 
2.43.0.429.g432eaa2c6b-goog


