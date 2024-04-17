Return-Path: <linux-kernel+bounces-148335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4358A8117
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D29A1F218C5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2346313C3FB;
	Wed, 17 Apr 2024 10:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W0uqOtlR"
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D1C4685
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 10:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713350313; cv=none; b=Krv0fiWqUhFn/D68+lDPYju3zgn7ljWU0zzpsuydvj9zOEHlQa4tAdijM94MQp3FUwhQ9SsSEuBefnHQn2c+gfLAFr80smhQ0Y1Syf0SFPr6mIuDzYeZ6JOMl2B1dRtOWDwFa1tMr8DN1omCRqghoYRXn21kM3vEJtR204pyiKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713350313; c=relaxed/simple;
	bh=HLEm82Qikg0GgPMP8b3IoYOKgePa6VSQprOKe1d1g1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SrMWPPtrXTy671kFGbRPiZBtoesDUdBaciu/42ejKfTnB8oQTWYlUwAJjezjZAYkGd4N+f+MCZ3Uu8X42TtKobsLL47bgLHurilNsqAPFChswY+kxG2tZ2iFSc9sxQ/Fm8qLlTBG0DnFQJEQbyzKcgmrO4MshND6eCNuVBCCEfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W0uqOtlR; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-a44f2d894b7so606063666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 03:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713350309; x=1713955109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wGPAZakFv3tW+couZM/Hz58bGfETU82f69mf8+8G4OQ=;
        b=W0uqOtlRTkSSx0hun5Cgz1ToG2z8O6psQ0Xe44+xZ4NKi71e94TbRvouLTt/KbIYky
         b/srf/XKtEynszQwveeg97SHbHceTN+w5kBJkg/dNt5DaCgsdVuKw72yt2zsHBdOmtSI
         hU87ytPWK7PdxndjaSqdq2XMEZY+rC9JaBFqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713350309; x=1713955109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wGPAZakFv3tW+couZM/Hz58bGfETU82f69mf8+8G4OQ=;
        b=RFPijvFOnyZcSZP7VfCvQFAiNi6J68TueCp1aV/VdoG36AV8aYDCnOTwf7oelvXFf4
         tqqgBLyMoLTHZacklYhtGLouziKCH2iTWaxwbqIi1s1VLp98xovHLXP+kbdIj/lJ7u3i
         1RUR6KzM71XZKJVNAfS3f8H3Rt0SOdL1xuyNQQ4q8rnzn73nkb7+1fbD4dwdtdgduTuk
         CIEXCjOJUY5EK7QVo1u/iPuwd4fNiIV3zgj/UskUdNYJnALUMgmggQzk6QEX7LcbvTtr
         SrVNwpfyIUP1jbxsAIgQAFui0Vd3efX1elMSiWZdKQEDqnPGOguSimwJJbo/yh6in28l
         0XNw==
X-Forwarded-Encrypted: i=1; AJvYcCW7C7mZvU1S9PMiqybmfj3Xy1ternJQMj/FsSnwJZhGRjSJoAbjcqIPD6tgwvEVcfuJa6qOVITscSRrd4iwG63jEON8m0n91ziTRzaW
X-Gm-Message-State: AOJu0YxGsOuF71z6pgA/yiJiVnMVfBnWxso1lyec+WuFDwgUqmv3UFmY
	FfjSFjvhp+VJ/9sppCX7KzzxvyUynaczbWz4oEsu3skvPfXjFmZgBYdiAUKRYw==
X-Google-Smtp-Source: AGHT+IFVcPG0J5A4OYw4wVn0Z7fkAtpovNHvVRNRPx9roE8nRmfmY11gcOt1EWpA8oZzc73jAWSbAg==
X-Received: by 2002:a17:907:928b:b0:a52:54d5:7915 with SMTP id bw11-20020a170907928b00b00a5254d57915mr9533946ejc.74.1713350309663;
        Wed, 17 Apr 2024 03:38:29 -0700 (PDT)
Received: from orzel7.c.googlers.com.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id gf14-20020a170906e20e00b00a51e6222200sm7989488ejb.156.2024.04.17.03.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 03:38:29 -0700 (PDT)
From: Wojciech Macek <wmacek@chromium.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev
Cc: Wojciech Macek <wmacek@chromium.org>
Subject: [PATCH v2] drm/mediatek/dp: fix mtk_dp_aux_transfer return value
Date: Wed, 17 Apr 2024 10:38:19 +0000
Message-ID: <20240417103819.990512-1-wmacek@chromium.org>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case there is no DP device attached to the port the
transfer function should return IO error, similar to what
other drivers do.
In case EAGAIN is returned then any read from /dev/drm_dp_aux
device ends up in an infinite loop as the upper layers
constantly repeats the transfer request.

Fixes: f70ac097a2cf ("drm/mediatek: Add MT8195 Embedded DisplayPort driver")
Signed-off-by: Wojciech Macek <wmacek@chromium.org>
---
Changelog v2-v1:
 - added "Fixes" tag
 - corrected e-mail address

V1: https://patchwork.kernel.org/project/linux-mediatek/patch/20240402071113.3135903-1-wmacek@chromium.org/
 drivers/gpu/drm/mediatek/mtk_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 0ba72102636a..536366956447 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -2104,7 +2104,7 @@ static ssize_t mtk_dp_aux_transfer(struct drm_dp_aux *mtk_aux,
 
 	if (mtk_dp->bridge.type != DRM_MODE_CONNECTOR_eDP &&
 	    !mtk_dp->train_info.cable_plugged_in) {
-		ret = -EAGAIN;
+		ret = -EIO;
 		goto err;
 	}
 
-- 
2.44.0.683.g7961c838ac-goog


