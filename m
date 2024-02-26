Return-Path: <linux-kernel+bounces-80724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6D2866BB8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C0EFB22830
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D5E1CAB5;
	Mon, 26 Feb 2024 08:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mUCw3JOx"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249581CAAA
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708934851; cv=none; b=l9eH84PYmwiHphAkulrWQlE5v6FpRf2czCZq6E038X+bN9mkn+C+2rPch+3NXnRoiD8iqQKKEMAKfbVp/9pPIWrcCoJahT2iWOxd17sf9IZ/F0q5GCz65OhdD4n+9vWbop5lwoCh8h5O9Kw06bqJHkGS+kL4VgfrcXMRzd6tYZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708934851; c=relaxed/simple;
	bh=Y4ODKzD7DJxpkg5gUieFJDFj3mNebdbaYiTeggdrUe8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z4Ax/778QLeQ2QKueP47OAS4184tSQqHSwjtKlyBMtYBdmPuMCm0QUuUIFeRd6z+g66aA3iarFeccVOEtP/ZyXxiSafZzXuG8NBzGdN+yDMisS7J6KCpRzeJBIGABI5jYhx3I7jpVc8Df3lNeyM1wk+d8WR1rhRdB15U/H0pStw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mUCw3JOx; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dc5d0162bcso22798035ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 00:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708934849; x=1709539649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kBcIHteoHnr9Cz5N/WAN5bt6cpSYHYQ7aU0W3fZEze8=;
        b=mUCw3JOxBn1+9bIO0lhdwtd2etxcRQsfgvWpDT9m5/QwTwGuKjQS3eotp7RrBqYW8/
         z1LvhXcUczsun3aA7F3Oadi8vkpjxqeEQlKwbiKjmmUheXiMqjK29KA4o09nb4PZOiZG
         SiByTLYb7CjfHlsQUyKnsZFleCQ97q6Wl1PTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708934849; x=1709539649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kBcIHteoHnr9Cz5N/WAN5bt6cpSYHYQ7aU0W3fZEze8=;
        b=lKCac8EFYtmekdi46be5pBzcR3XTB7LDe3vshqMEnh5NZIPXmh300Xx/mnn0YwOt0H
         O8ZNrHhhp77RiJJ9q669J0tEzjewemR/jQ8v0ndN1CjcKIK7N41yf/7qjBIwPT9Z5Hcf
         OLEQuVor9e/jzUcQhNVcP9di61Eti3MCi1F37mTfIzHBHDQQ4PDIN0xB2q1bH7WQjQCL
         m4FyB1nn/WI1sDbTmQN2U5rXKTQGsKW8bM7l963Qas6Hkjnl3HFggWcLvn9KSlUzaqHZ
         kW04M9Jnfbf7ihDMVOobva9/QXFacf8+jo/pDYOCvz7QfP0TzmLA/DV2abDGLSpOzPq2
         dr5g==
X-Forwarded-Encrypted: i=1; AJvYcCWk5IPDMtlz6dtYwSNJYEKruVMNruydbUiHCcnMXEdIPuKcYnTNZWwVDAcX9T9ZkEjU36ApSndQwIj0UExOLSmdyGgNDL3zYEHpKah3
X-Gm-Message-State: AOJu0YyA97oln6UNOjWIF6TXOgCh4CCh31gVYlw8wexce3xavtTekB8t
	IZaQmOKxSX+Jpk9BVULbAu1FV2VGB8xCuXgBC27KmFWlNGuH/OsgMuLh9mL8YQ==
X-Google-Smtp-Source: AGHT+IExiQnb+rRMNDHWEdTGrSJHafd60Czmd6wFeh8GaiNgF/iSjktfRAWY7nO1Q8GFmSikhhho1g==
X-Received: by 2002:a17:903:548:b0:1db:bd6b:d1fb with SMTP id jo8-20020a170903054800b001dbbd6bd1fbmr5145701plb.63.1708934849429;
        Mon, 26 Feb 2024 00:07:29 -0800 (PST)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:e3f5:67aa:a8f3:8179])
        by smtp.gmail.com with ESMTPSA id le6-20020a170902fb0600b001dc95cded74sm1953660plb.233.2024.02.26.00.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 00:07:29 -0800 (PST)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Fei Shao <fshao@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] drm/mediatek: Support MT8195 OVL compatible in mtk_drm_drv
Date: Mon, 26 Feb 2024 16:06:47 +0800
Message-ID: <20240226080721.3331649-1-fshao@chromium.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Specify the component type for mediatek,mt8195-disp-ovl in the MediaTek
DRM driver on top of commit 76cdcb87d391 ("drm/mediatek: Add MT8195 ovl
driver support").

With this, the compatible can function as an independent fallback for
other display overlays without relying on MT8192.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 14a1e0157cc4..703caba48420 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -739,6 +739,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 	  .data = (void *)MTK_DISP_OVL },
 	{ .compatible = "mediatek,mt8192-disp-ovl",
 	  .data = (void *)MTK_DISP_OVL },
+	{ .compatible = "mediatek,mt8195-disp-ovl",
+	  .data = (void *)MTK_DISP_OVL },
 	{ .compatible = "mediatek,mt8183-disp-ovl-2l",
 	  .data = (void *)MTK_DISP_OVL_2L },
 	{ .compatible = "mediatek,mt8192-disp-ovl-2l",
-- 
2.44.0.rc0.258.g7320e95886-goog


