Return-Path: <linux-kernel+bounces-8110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D4581B244
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D644B288794
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D996219F2;
	Thu, 21 Dec 2023 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cgy2Wvah"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8586B21373
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6d3165ac96bso385037b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 01:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703150597; x=1703755397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kg7QV/oFyp9DuWfL+Kx8o8ppQQ1Ib7IJOm2jNNQfg5c=;
        b=Cgy2Wvah+5b0GcoZ2v0qX1ntTmUstGkQPnAFcNcJ5TCe3tNAoa9OYKOOlgNCNYShu+
         Dnko44siLb9b5XLPaquwZoEA721BKRrhRr0QfhjOOsSiOabCjEck6JCgPEimk1AVpp6j
         PdUIfzNJO31ewQMIBtzG0RE5h3LTSoMSqqRGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703150597; x=1703755397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kg7QV/oFyp9DuWfL+Kx8o8ppQQ1Ib7IJOm2jNNQfg5c=;
        b=NEev7EBSyvZCJ4f63Osf5W4HcA+ZeOaEhgcsmoi4a8nT7eJsQMZTMvkr8LquUbtYUh
         WZc/F3cm9eLnycFCM0w2AB4rZ17NuksIjMygbPp4yjcy1xhlSPEoPZncbyorvYVgr4EN
         H0XddkcFv9+ezNknBJ+RSzZcaQlfzEeDwRimfF0gFLFXV04he3XERsKsvBE+BAk0uaSF
         DEfJn0hUm0XrlV72178VU3Qjuuks6mT65EBpKJDjFJaNJtuLhBqwE1MuykFFPdYHH27/
         r4kPHdJObHkuLxGIedQyddsJVl1gc2U8NVVRgHKdS9G4Y3JfF/zdJ14rGj+geRQ0NKZz
         4h/A==
X-Gm-Message-State: AOJu0Yyyi5eEOiu0CqVzLEx3ZVJmlwtmZpnDinOxxSo0jKHRcltKxkWJ
	YLyYNBCUIpuRB41MUhzN75iP/A==
X-Google-Smtp-Source: AGHT+IFDxUKLBz3VGC2yCoNsiSxvdSiRStRV4vEwYMcZ1GLlryESWkqSr0FR8fSbQq7cz7HdROcAPg==
X-Received: by 2002:a05:6a20:548c:b0:18f:97c:8235 with SMTP id i12-20020a056a20548c00b0018f097c8235mr778237pzk.63.1703150596960;
        Thu, 21 Dec 2023 01:23:16 -0800 (PST)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:5d8a:fab1:933a:9ae9])
        by smtp.gmail.com with ESMTPSA id l6-20020a17090add8600b00274b035246esm1001915pjv.1.2023.12.21.01.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 01:23:16 -0800 (PST)
From: Fei Shao <fshao@chromium.org>
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Fei Shao <fshao@chromium.org>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Tiffany Lin <tiffany.lin@mediatek.com>,
	Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 0/4] Improvement around mtk_vcodec_mem_free() logging and usage
Date: Thu, 21 Dec 2023 17:17:42 +0800
Message-ID: <20231221092226.1395427-1-fshao@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series includes some improvements around mtk_vcodec_mem_free() in
mtk_vcodec_util.c.

I noticed that mtk_vcodec_mem_free() generates a spurious error if the
target DMA buffer has been freed previously:
  mtk_vcodec_mem_free(),69: [MTK_V4L2][ERROR] 18000000.video-codec
  dma_free size=0 failed!

The warning is harmless, but it brings some confusion to our developers
and testing infra, so I sent this series to fix that with some minor
improvement for the driver alongside.

The first two patches are for aesthetic and style improvements, the
third tries to make the error logs more informative, and the last adds
back the missing checks when calling the free function.

Regards,
Fei

v1: https://lore.kernel.org/all/20231113123049.4117280-1-fshao@chromium.org/

Changes in v2:
- rebased on top of next-20231219
- revise commit message for clearer intention and rationale
- update the error messages based on the suggestion

Fei Shao (4):
  media: mediatek: vcodec: Replace dev_name in error string
  media: mediatek: vcodec: Drop unnecessary variable
  media: mediatek: vcodec: Update mtk_vcodec_mem_free() error messages
  media: mediatek: vcodec: Only free buffer VA that is not NULL

 .../mediatek/vcodec/common/mtk_vcodec_util.c  | 23 +++++++++----------
 .../vcodec/decoder/vdec/vdec_av1_req_lat_if.c | 22 ++++++++++++------
 .../vcodec/encoder/venc/venc_h264_if.c        |  5 ++--
 3 files changed, 29 insertions(+), 21 deletions(-)

-- 
2.43.0.472.g3155946c3a-goog


