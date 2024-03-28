Return-Path: <linux-kernel+bounces-123765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8B2890D75
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F7829E24F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91ADE13E6DC;
	Thu, 28 Mar 2024 22:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJjV2iSO"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C3D13E6D4;
	Thu, 28 Mar 2024 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711664017; cv=none; b=jE926ST6TUF85e0+z+CdVhYokIjkPDjnH8Ij1vzP1VsP0ws0Z2a6NU0yvq/FedmfVYgTDu6fXohigKUWm/ICN/jRD6BUBvXHE91wSo1qt5oemudWvEASKBLT7SXotzWmVC1WBwxirvxfOiFv2p+BX86myHT3EC/MuwJL8DtElm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711664017; c=relaxed/simple;
	bh=2lMT6KNPvKzbBMwVwrI0RDmqQ5yOjbh0txjmVUXqLU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bLQLCzHq80BHXipMn6i4+Wsm9mS1lscjHPZSDc+xHLVmCKw5MMlHpnX+jhP9LeCosgpD51QylkbwawrDZgk/fd26yBuBW71FMzPerABZl9yfzQ4ReemTjR1Odjg6SpgQd4Rk8lEg7ihnAwjyFz2hEIvDRkYou9rt2hc0g9ga4YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJjV2iSO; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d4a8bddc21so18433351fa.0;
        Thu, 28 Mar 2024 15:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711664014; x=1712268814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZDt6XPS0X9RrCsopZrtOFphc1SwMJgyr4eQSlHmJ/w=;
        b=YJjV2iSO+rmmmXNCQDupEnIu+EVekdFoaMhN7vD2k9msuhAteuD7jPIdC//jtVRB5c
         4atDpAm0BXEWQnhmm+fIRVuk/snhvGKM67JO4If79iz1KvJXEPrnlzOV5qtI/wEdFMiN
         xWDiBI0LO5ZjlzVO9HRVGZHTb+j3uWuSGC+eWb8pnSS4ceDcW5tN5rJPrCb3oUJg5s6y
         U/D1r9CwxKHQMOiTcOvULfZRgGoXm72BWuuGofqmcs+hifNJe3XyIYISm7Q9UawzRbWe
         xJ9G4AQaC5EHMGtJfx30sMpSS7gwRFPaZC/b8xdzr/tytKXK6hznPhJkZ+i02dP1OqQP
         aYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711664014; x=1712268814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZDt6XPS0X9RrCsopZrtOFphc1SwMJgyr4eQSlHmJ/w=;
        b=RFNMBOQ9aOJke3Om/vUHwbQqZGqAIKO5OtiDJMEC8w6utH3BVwE+lmxNnuGxKIYviJ
         TbLrzdxgSyGikPTADy4Xo2LGlbCvSnnEqEh5PIvqlgNLpkbpkSiOElQYsrPuQi5izKBV
         iLd/JHOrx2RDfYOBJY2O5a6A2ZKJHkK3Jie8hN3NkBevBg9myoTqUNkDSD6BW5YEaIS3
         bN+PyNS1MB9o7Q3x2FqjxDgmdWdLfSb0NDifkXNwCAsRUiatCZ0AWne9KJ/tSjuwJfMv
         rcTh6IWIvX+swa/dzTZKk3yqMglAPYneBGFgivt0N5d/EPB4A7YVty32/V1Wyq3Dq61l
         3/OQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9sTICMr+Wpk4p9FKLvnMshPqKVhJUQ5QhJxPZEj27PGktZcuKDJnGetEcGFLOtDH12srfsDwgrnFlbec+EmvkXi8YOp8P8GJnSX0svSBRZROMKBXSzzt8jpGugWK7mZrHfiNtKcuyJt4=
X-Gm-Message-State: AOJu0YzBEqQ0FQHhCBlEb6Gsk+LWb+y44Sey5JFc9yruaAPENFCRdUlA
	msbT+7VX5iUeppm4JG3EsTgBB+Z6nmeIcr/cMYROQxXmN8iNNc10S5631dbpcNc=
X-Google-Smtp-Source: AGHT+IEQXyiCKApTwZRRWL08M7GZqI7Ri9/gYPz/35OH0zL1qkQi4HnbVQl7wV1Kcip+ZffOmf4zUg==
X-Received: by 2002:a2e:9d45:0:b0:2d4:707e:623 with SMTP id y5-20020a2e9d45000000b002d4707e0623mr254372ljj.37.1711664014152;
        Thu, 28 Mar 2024 15:13:34 -0700 (PDT)
Received: from lmc-playground.localdomain ([188.25.208.244])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b00414688af147sm6666778wms.20.2024.03.28.15.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 15:13:33 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com,
	peter.ujfalusi@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	daniel.baluta@nxp.com,
	iuliana.prodan@nxp.com,
	linux-sound@vger.kernel.org,
	imx@lists.linux.dev,
	laurentiu.mihalcea@nxp.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ASoC: SOF: imx: remove imx8_*_clocks API
Date: Fri, 29 Mar 2024 00:12:01 +0200
Message-Id: <20240328221201.24722-3-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328221201.24722-1-laurentiumihalcea111@gmail.com>
References: <20240328221201.24722-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Since the i.MX drivers no longer use the imx8_*_clocks API
this can be removed.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/sof/imx/imx-common.c | 24 ------------------------
 sound/soc/sof/imx/imx-common.h |  9 ---------
 2 files changed, 33 deletions(-)

diff --git a/sound/soc/sof/imx/imx-common.c b/sound/soc/sof/imx/imx-common.c
index 36e3d414a18f..2981aea123d9 100644
--- a/sound/soc/sof/imx/imx-common.c
+++ b/sound/soc/sof/imx/imx-common.c
@@ -74,28 +74,4 @@ void imx8_dump(struct snd_sof_dev *sdev, u32 flags)
 }
 EXPORT_SYMBOL(imx8_dump);
 
-int imx8_parse_clocks(struct snd_sof_dev *sdev, struct imx_clocks *clks)
-{
-	int ret;
-
-	ret = devm_clk_bulk_get(sdev->dev, clks->num_dsp_clks, clks->dsp_clks);
-	if (ret)
-		dev_err(sdev->dev, "Failed to request DSP clocks\n");
-
-	return ret;
-}
-EXPORT_SYMBOL(imx8_parse_clocks);
-
-int imx8_enable_clocks(struct snd_sof_dev *sdev, struct imx_clocks *clks)
-{
-	return clk_bulk_prepare_enable(clks->num_dsp_clks, clks->dsp_clks);
-}
-EXPORT_SYMBOL(imx8_enable_clocks);
-
-void imx8_disable_clocks(struct snd_sof_dev *sdev, struct imx_clocks *clks)
-{
-	clk_bulk_disable_unprepare(clks->num_dsp_clks, clks->dsp_clks);
-}
-EXPORT_SYMBOL(imx8_disable_clocks);
-
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/sound/soc/sof/imx/imx-common.h b/sound/soc/sof/imx/imx-common.h
index ec4b3a5c7496..13d7f3ef675e 100644
--- a/sound/soc/sof/imx/imx-common.h
+++ b/sound/soc/sof/imx/imx-common.h
@@ -15,13 +15,4 @@ void imx8_get_registers(struct snd_sof_dev *sdev,
 
 void imx8_dump(struct snd_sof_dev *sdev, u32 flags);
 
-struct imx_clocks {
-	struct clk_bulk_data *dsp_clks;
-	int num_dsp_clks;
-};
-
-int imx8_parse_clocks(struct snd_sof_dev *sdev, struct imx_clocks *clks);
-int imx8_enable_clocks(struct snd_sof_dev *sdev, struct imx_clocks *clks);
-void imx8_disable_clocks(struct snd_sof_dev *sdev, struct imx_clocks *clks);
-
 #endif
-- 
2.34.1


