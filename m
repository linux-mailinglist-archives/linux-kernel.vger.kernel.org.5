Return-Path: <linux-kernel+bounces-153782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C00328AD30B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 698DDB25C64
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEC0153BC9;
	Mon, 22 Apr 2024 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PevJ4Nul"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F85153514
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805517; cv=none; b=Pybw+NJb1Q56CO0WUlRGStIYv1c6obs738KgKPJSHCftzCA9cBSKbnp1LWjDPQK4j9wzvvsI/RjSeJ8v3NAd0TAvPiba1yIUePDO57F/NJcHdrrfQk93klZ9RK7fCHcaXLnAOktjK48XHqpGnl2jQwyNsL6Z4MzevzP5+Dqd0+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805517; c=relaxed/simple;
	bh=AHu9d6uPryR7QNpvwYORlSRuVIiALc6iKXvSYf0HmQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QVcvNRhbsyqpnH7UE6z/yjSCT3PTAmfz7QUYQMz8LWGklWARzPnjXEcqwoftRU5XPZJwvvykhWWVR/Nijo6/9al73FIbjFndgMcsp8nA/gMrYJFCL9jaJbF02tCIGxYx7KCZ5PvFVjDBiz9ydzvcdA9sL5KvTv07/e1gOk8l2Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PevJ4Nul; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6eddff25e4eso3934549b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713805514; x=1714410314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tSkyOzxUcdbMqzp03KnrhjrfOdlW3TL2PUxe3CYy+uU=;
        b=PevJ4NulAiOYVbA8mciWxEHev11PduHd/oYest7x9tK2CVHr6/B7olAHtulLtr8epI
         04OFtpL3lbl3Fh7ZoIN4grRWoFEAVj05sXGWIapK5oFVTAZjhx4V4QJG44ThmLGpg5sm
         4mCQbmQ6Ra1wVfu4OaUA4puUk0w13NswduPik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713805514; x=1714410314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tSkyOzxUcdbMqzp03KnrhjrfOdlW3TL2PUxe3CYy+uU=;
        b=rqSsPCwNU9LWNbqNPXecZC8vgmFnYRNtMXI7sojcrolYFCB+VIJZWeF7awe3/MJ+Mk
         ovcRX4ldHjxxVr9fHro6v8S+sBRRuqQ79g75q/PHE+S59Ry3Y1nY0uSSnpw2r8n7zCTI
         586MNPy6TBVRzjlqTiws4dCKX9wap1facWbgdJFwt+7VWmRDcXbLCu62zRmck2ZPD0Ya
         O9j9VIdifX956KUHHzgwEN1Dc1K1a5hakG5t3BQtI9iEnhYkoCBVSPL9+Jc1lcyFVEdm
         WpC0abymDN2TOhglL3roW4WVt77rH9ccZFga4hiAabmcAe8mX55Tnt+YoJTJBYC8x3gF
         /Oqg==
X-Forwarded-Encrypted: i=1; AJvYcCU92meZIiFaHYitXTfNcemJzNxlyn5QxZdYAr8EF+aH8thVNE/RdWKss0A6NyhK5uJcz8qJWXjIWPlNRY0bDmemKrCfudEcchgah0vB
X-Gm-Message-State: AOJu0Yy/nN0CJQQWg/3cBwMcQB7P33Q3n70Nij9TGCd2EXpJhEUgiOw+
	w7pj15oT3uIkZconyQQkJKDXdqh+aWkOIpJbhKZDy6byMAzQPdsfmcPwOI7IZw==
X-Google-Smtp-Source: AGHT+IFxJFeMPcL8ytCxc2u5zPDcX0TiDfN/BOFVsXaXujFuR9MAhpYnZXK32l63JffeuOssUsOYXw==
X-Received: by 2002:a05:6a00:1407:b0:6ed:2f2:a8e with SMTP id l7-20020a056a00140700b006ed02f20a8emr11839710pfu.30.1713805514163;
        Mon, 22 Apr 2024 10:05:14 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:843d:b423:30f9:2b2])
        by smtp.gmail.com with ESMTPSA id fa34-20020a056a002d2200b006e5571be110sm7997617pfb.214.2024.04.22.10.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 10:05:13 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Tiffany Lin <tiffany.lin@mediatek.com>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Wei-Shun Chang <weishunc@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] media: mediatek: vcodec: Alloc DMA memory with DMA_ATTR_ALLOC_SINGLE_PAGES
Date: Mon, 22 Apr 2024 10:03:59 -0700
Message-ID: <20240422100354.1.I58b4456c014a4d678455a4ec09b908b1c71c3017@changeid>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As talked about in commit 14d3ae2efeed ("ARM: 8507/1: dma-mapping: Use
DMA_ATTR_ALLOC_SINGLE_PAGES hint to optimize alloc"), it doesn't
really make sense to try to allocate contiguous chunks of memory for
video encoding/decoding. Let's switch the Mediatek vcodec driver to
pass DMA_ATTR_ALLOC_SINGLE_PAGES and take some of the stress off the
memory subsystem.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
NOTE: I haven't personally done massive amounts of testing with this
change, but I originally added the DMA_ATTR_ALLOC_SINGLE_PAGES flag
specifically for the video encoding / decoding cases and I know it
helped avoid memory problems in the past on other systems. Colleagues
of mine have told me that with this change memory problems are harder
to reproduce, so it seems like we should consider doing it.

 .../media/platform/mediatek/vcodec/common/mtk_vcodec_util.c    | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c
index 9ce34a3b5ee6..3fb1d48c3e15 100644
--- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c
+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c
@@ -64,7 +64,8 @@ int mtk_vcodec_mem_alloc(void *priv, struct mtk_vcodec_mem *mem)
 		id = dec_ctx->id;
 	}
 
-	mem->va = dma_alloc_coherent(&plat_dev->dev, size, &mem->dma_addr, GFP_KERNEL);
+	mem->va = dma_alloc_attrs(&plat_dev->dev, size, &mem->dma_addr,
+				  GFP_KERNEL, DMA_ATTR_ALLOC_SINGLE_PAGES);
 	if (!mem->va) {
 		mtk_v4l2_err(plat_dev, "%s dma_alloc size=%ld failed!",
 			     dev_name(&plat_dev->dev), size);
-- 
2.44.0.769.g3c40516874-goog


