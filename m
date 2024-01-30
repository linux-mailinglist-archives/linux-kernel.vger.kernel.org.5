Return-Path: <linux-kernel+bounces-44335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DA98420C5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79AFCB31BC9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF3B6DD07;
	Tue, 30 Jan 2024 09:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="arOvOHtO"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725FC67739
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608628; cv=none; b=EW14FoptPLzQlfQhvWYBkfqwt1lcoqeqZJgdyU2z4IOujJakGi+gf06aPXfo5PbzdkqHvwWzCWbgCAbS0TczIrNMk5ExwNEB1/N5nBQL3msBBTYrrUA6AiqZ+u9G4FB8T8NyCSzvjeO8Sdg6a+nH8gZNk/0zxyjwcvmTbhbmiTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608628; c=relaxed/simple;
	bh=PjLNZGOK4cojVlDhXj8cggrO1CsQ4u8l1duSGG978Bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYkA9KfJVpwVp/yVhF6CqEZVlCTmLjwNHQq8Dfc66Ttkx+7grUbhGu7sQONxIBPAA99be8JoFPHJrlyoN5qqzwcYj81Ur3Unyxv48/GB8kOAliHURj9xAND1odag7LFua3w0vfEOpoJRONrQennVzhjSX+wfpAxx0dCjH/6tFyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=arOvOHtO; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2901ceb0d33so3553651a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706608627; x=1707213427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdC3n49f3pUPNsrcBA7Bt2BGENrWBIomL/x/RasR6Lw=;
        b=arOvOHtONb2E51YRGSlT/H6dFpxETt36r1dKYJzVpEyMf5vDtG9InBYf7KAoEE+G1d
         oRVJiFszU5u8kZEu9WATRXzhnt/Xe46soqRWVHUuMHsKf86mR/yhdM75Hr1/xI59Z0Qz
         FKXkTaFT5RwrUYUOqITq01ORHBrNxUhjJphnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706608627; x=1707213427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdC3n49f3pUPNsrcBA7Bt2BGENrWBIomL/x/RasR6Lw=;
        b=pRf6hDstuFnanddHwVTwPrJ6z18oKw8KlHAg6DVBO4AKOpc90VDlEGrSWEsMWB/Zg8
         dx0co58DP5vOkVxG2v0K4PsVQXLkJig9fGwKNvb1dgh7iakKhC6WN/V/xJvg7OFvhrb8
         6ug2M/TPfGm0uCrFqXWAtKHqHT5rtTsQFd6ysrKT6aIGgxMBqKB6Jkz8YrQgHZ/aOIY9
         SSauu/GSfzNF2d7Trg1scRJ5vS9xZfdVqtSIlh2RlmsEIiJsvk9bC4crQy40Hr/VhcLo
         8plv3SMD5iVIxEYiHajtRBufkC1PPinA1kUXSKEWfs3217SZe8XK63XicVGA4GHzkYJ/
         m88Q==
X-Gm-Message-State: AOJu0YxXOPSzOB3YMQjdK6jUWZTPfwu0Da+M8RNIfITXJkeefPB+b3it
	skRkn5ABLod1xlSbmHUtNUidgGRItajnHpaFDcAgCQNVbGrLwROcDo7Rj1fKWw==
X-Google-Smtp-Source: AGHT+IGlxSqsMuF9m2bnctGlj48RdUWW+c4ToCBn1TGjF/x6IAqZ5PbEFfSDJkkT532DsO+oYz2DtQ==
X-Received: by 2002:a17:90b:696:b0:28d:1581:29e6 with SMTP id m22-20020a17090b069600b0028d158129e6mr1136268pjz.13.1706608626736;
        Tue, 30 Jan 2024 01:57:06 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:469:110f:d748:6896])
        by smtp.gmail.com with ESMTPSA id sm5-20020a17090b2e4500b0028ffea988a2sm8069810pjb.37.2024.01.30.01.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 01:57:06 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	William-tw Lin <william-tw.lin@mediatek.com>
Subject: [PATCH 3/3] nvmem: mtk-efuse: Drop NVMEM device name
Date: Tue, 30 Jan 2024 17:56:53 +0800
Message-ID: <20240130095656.3712469-4-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240130095656.3712469-1-wenst@chromium.org>
References: <20240130095656.3712469-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT8183 has not one but two efuse devices. The static name and ID
causes the second efuse device to fail to probe, due to duplicate sysfs
entries.

With the rework of the mtk-socinfo driver, lookup by name is no longer
necessary. The custom name can simply be dropped.

Fixes: 4e6102d60d88 ("nvmem: mtk-efuse: Register MediaTek socinfo driver from efuse")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/nvmem/mtk-efuse.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
index f5bebcecf9bd..9caf04667341 100644
--- a/drivers/nvmem/mtk-efuse.c
+++ b/drivers/nvmem/mtk-efuse.c
@@ -86,7 +86,6 @@ static int mtk_efuse_probe(struct platform_device *pdev)
 	econfig.size = resource_size(res);
 	econfig.priv = priv;
 	econfig.dev = dev;
-	econfig.name = "mtk-efuse";
 	if (pdata->uses_post_processing)
 		econfig.fixup_dt_cell_info = &mtk_efuse_fixup_dt_cell_info;
 	nvmem = devm_nvmem_register(dev, &econfig);
-- 
2.43.0.429.g432eaa2c6b-goog


