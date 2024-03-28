Return-Path: <linux-kernel+bounces-123246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFC8890516
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3987B25ED0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D83A12FB3B;
	Thu, 28 Mar 2024 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L9KqrkNy"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BB37F48D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642997; cv=none; b=HTVUI6tK2YBJNUqepII07mVeX9nvcCmWmnt6d1hRYZx7tcpUYM7kW5QEnr1xS+qSHdMr5z+l4M2NDSb9siQT71cCPJmEPzG9BI9iy143vH/UfEsRn7QrJ4G3dUt4eKJZUGBO2//zbv8rIuH8oIcJZ8i5RePsXG0mW9JhDuuXBYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642997; c=relaxed/simple;
	bh=zzT1fUQFspLhSnPrsRLMaxU0gLulfH4Gy+IzuvB2rv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uSqf2ylkWy/hUO9NoEH2CyLWfrUT3JTzqktymjS5wPJlcVKWKChuWxWfoOmzVMGH8SptSKbkwlwvJOjis+OoeZa1Esf6Nr9HB47di64Pef2pufYhXlcb6CRKDbhotIrxPDX2vrY5NfOnl8ONr4ACz65kOeGGtJ4RPb/Y6sqBTlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L9KqrkNy; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e6a9fafacdso964278b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711642995; x=1712247795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=58X8x1UNsNMmiiyq8gcFRSe6N+Bhf8n97M2Kk8Wg5hs=;
        b=L9KqrkNyHR6WCoWV5gO2XH17i3pCnDe46UuJMCRyaZk4wUjRsikDXJ3TXVcjP6kKUm
         dMk1cXUogpfZwVYitp2xpl7YS0ETtyuR9wRETAabXfzr2ezZ1yTG5dXXK+H23lTQ4hu7
         juu9nr/QtxjFxT93n1aGgsXLBbVr6xVuYn26o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711642995; x=1712247795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=58X8x1UNsNMmiiyq8gcFRSe6N+Bhf8n97M2Kk8Wg5hs=;
        b=O21hjcqsWKQHn3V3kMB5IMkfYawwwGNrNhWeDD0jCUVh0da0h1t0aCOCRvuJVdqVdA
         s/RknlPgJdRjhJNpuH+VOic/O17Ev/T+l/BtejSZoVebrmIMxRP0XIcHVhWSi+DEpMra
         q6knh9BI1RaWqTKkf9M57sRYS6q95aD7mQ3qgmhrQF5NnwjikfDYg3JiWunoGHjay4IS
         QjePgI3Km9GaNW+9A8RlnSu/Y4a5bG3K6jEHIWjqgH11yWbL1uddh5xbpGMXsg+hUhyx
         frOAIIQfQYic0BO8Ddx0nAFceifglzGkT3/fCOv7oe20OApIyaOJWC4OptQz3jUkYOsX
         aG5A==
X-Forwarded-Encrypted: i=1; AJvYcCX29UuteMD0E7jN9QeDz48hqCuEsZzM+ZzzG0SERpsze7m2yrc8Dcy3We8Vu1Ia8WFuROSj7G8sLU19cfptRRhSaV/w3wQSuW4ZQKQx
X-Gm-Message-State: AOJu0Ywsb/4ar2PlIeaRPqTjIBlItp+TxzE5oE3AyFvQQhDDrugiw1MY
	tlYAuRASX/WGGBJ9n78aCRdZ4uSVOIACcn0+c0KqNgJz0Fm978gUYjBcvDDFMA==
X-Google-Smtp-Source: AGHT+IH8m4FOpmulMPR4PXwB9kS9sRqEde1d3TfpdPojRq6SCIUP5y0CcdDEYJswVgJiQU/Ul74A2A==
X-Received: by 2002:aa7:8892:0:b0:6e6:f9b8:38eb with SMTP id z18-20020aa78892000000b006e6f9b838ebmr3422184pfe.21.1711642995035;
        Thu, 28 Mar 2024 09:23:15 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:8167:f222:93f:3779])
        by smtp.gmail.com with ESMTPSA id o1-20020a056a001b4100b006e6233563cesm1548793pfv.218.2024.03.28.09.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 09:23:14 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Douglas Anderson <dianders@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	CK Hu <ck.hu@mediatek.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	"Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Nathan Lu <nathan.lu@mediatek.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] drm/mediatek: Init `ddp_comp` with devm_kcalloc()
Date: Thu, 28 Mar 2024 09:22:49 -0700
Message-ID: <20240328092248.1.I2e73c38c0f264ee2fa4a09cdd83994e37ba9f541@changeid>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the case where `conn_routes` is true we allocate an extra slot in
the `ddp_comp` array but mtk_drm_crtc_create() never seemed to
initialize it in the test case I ran. For me, this caused a later
crash when we looped through the array in mtk_drm_crtc_mode_valid().
This showed up for me when I booted with `slub_debug=FZPUA` which
poisons the memory initially. Without `slub_debug` I couldn't
reproduce, presumably because the later code handles the value being
NULL and in most cases (not guaranteed in all cases) the memory the
allocator returned started out as 0.

It really doesn't hurt to initialize the array with devm_kcalloc()
since the array is small and the overhead of initting a handful of
elements to 0 is small. In general initting memory to zero is a safer
practice and usually it's suggested to only use the non-initting alloc
functions if you really need to.

Let's switch the function to use an allocation function that zeros the
memory. For me, this avoids the crash.

Fixes: 01389b324c97 ("drm/mediatek: Add connector dynamic selection capability")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I don't have a ton of experience with this driver to know if the fact
that the array item was still uninitialized when
mtk_drm_crtc_mode_valid() ran is the sign of a bug that should be
fixed. However, even if it is a bug and that bug is fixed then zeroing
memory when we allocate is still safer. If it's a bug that this memory
wasn't initialized then please consider this patch a bug report. ;-)

I'll also note that I reproduced this on a downstream 6.1-based
kernel. It appears that only mt8188 uses `conn_routes` and, as far as
I can tell, mt8188 isn't supported upstream yet.

 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index a04499c4f9ca..29207b2756c1 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -1009,10 +1009,10 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 
 	mtk_crtc->mmsys_dev = priv->mmsys_dev;
 	mtk_crtc->ddp_comp_nr = path_len;
-	mtk_crtc->ddp_comp = devm_kmalloc_array(dev,
-						mtk_crtc->ddp_comp_nr + (conn_routes ? 1 : 0),
-						sizeof(*mtk_crtc->ddp_comp),
-						GFP_KERNEL);
+	mtk_crtc->ddp_comp = devm_kcalloc(dev,
+					  mtk_crtc->ddp_comp_nr + (conn_routes ? 1 : 0),
+					  sizeof(*mtk_crtc->ddp_comp),
+					  GFP_KERNEL);
 	if (!mtk_crtc->ddp_comp)
 		return -ENOMEM;
 
-- 
2.44.0.396.g6e790dbe36-goog


