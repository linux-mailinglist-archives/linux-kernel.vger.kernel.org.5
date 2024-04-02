Return-Path: <linux-kernel+bounces-127477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF52894C47
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010C71F22F3D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95479383BD;
	Tue,  2 Apr 2024 07:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cg+UdBbC"
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481BC364BE
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 07:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712041882; cv=none; b=DcSgFJCPYQO5omZnai8bktdkakmAGaQX4er3Ln11TPy65y1BVJlkoirRcSbQXvjVNOezbPZqWiU/L1dqp+WkxhZeOyhzpR7VKK6fphK1la2wr+Ulhax2oPLGS/MOlykL9xLsDWmtL8V4zEyh8MCIW9hc35HVkLheVrYC7xjKqik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712041882; c=relaxed/simple;
	bh=MQzXPp+oT/1/PFhqEjpGaOh1QP+W+l+TqjkB8HIEYRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cdaKqjWv+yf8EUUsgHnNAWbK/eMPuEpYSmxmM2SQJ5Hnq+ar7UVvqFahB2U4QDthSXdfS1RXir3KrNTig6+SqiSatjI4zGf0OOPdoHLVCoMOUTUfK9tgZ/zOGy8/vwT9R/oQlvB78rvUkl9j6JakKuO6Xw4Uy9qip+ZYuqQyv2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cg+UdBbC; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-56de953b9a0so114231a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 00:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712041879; x=1712646679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnIWTbeR2GXQXE2WKV9Ap/wvI2y5jKr9SDTIrGO5fgY=;
        b=cg+UdBbC8QEQh/epzJ76f9KKNOW0uMpPRw8EHRKd/WySnlnrzPffjG2IEWAvtnzOLQ
         nH59W7avW6vcJv+JtmUTdFKmFFZ+V2PCrPh0MyYOe3WPSqYWezjtF9T3WVHp/ZXpLomO
         4oOavqDgc6gz2xaEALgq1bj3QJmRqXQjvbci0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712041879; x=1712646679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZnIWTbeR2GXQXE2WKV9Ap/wvI2y5jKr9SDTIrGO5fgY=;
        b=XJ3lkANkNng+QgVLdjUyU3GJ8Jl44UfATSaricVGu26g6pmPHz3BBiiHeVNmOSmsH4
         nDUSqPfRkT3Cl4IvQ58IjV2BbyEbcIuDmtdjq0i+Osb11YQ6LBSmg569UcoUnTZ+qIKl
         TYvw/0ogdQY6kh6SZOQsfCXf5Ru2vlGZQYchz7lG6HeocJkli0OYm0qRU8ZhnO1Attgp
         vybGcZPA4G/0PVNfL1mDugEsRZYfinc4U2tu577NTYEVEH0nFnZkY6paM8TUuBvHEtl9
         G7lUq0Zle3n3CnalfvxOv5auvEiOXWyG4qELXbwvxYW7pnZDOi0afe9l1ppcFj7/Ke3K
         UXoA==
X-Forwarded-Encrypted: i=1; AJvYcCVYq5A5dT+oCXvdxYGJBqAiabywH+wvbmsQNU02mGdiSpGsHd2cedIblbkk2Q+65DwzZWwpMpoXFn1hAu1NwtC5Iwe2VVxCbzwHC7x3
X-Gm-Message-State: AOJu0YzxVVq2zzCGlYZTj+Vqvx6YqsyXRI5BDd92gqjfokQK0Pl4N7T8
	+rrRahqpDOeNC3wgRpr6LBrGMH8YpyguQCmsExnm+RcIvI/Ta8Y8AlfNDTDB3Q==
X-Google-Smtp-Source: AGHT+IGUOjA6NKyVT/+ELVqwwCceZpb+FILLMln0YYk0jw8k+fwEMqxkgdfJr/x+JyjJ3SCGlsnvew==
X-Received: by 2002:a50:f603:0:b0:56d:e947:dd52 with SMTP id c3-20020a50f603000000b0056de947dd52mr471101edn.26.1712041879594;
        Tue, 02 Apr 2024 00:11:19 -0700 (PDT)
Received: from orzel7.c.googlers.com.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id g28-20020a056402321c00b0056c1c2b851esm6395171eda.0.2024.04.02.00.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 00:11:19 -0700 (PDT)
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
Cc: Wojciech Macek <wmacek@chromium.com>
Subject: [PATCH] drm/mediatek/dp: fix mtk_dp_aux_transfer return value
Date: Tue,  2 Apr 2024 07:11:13 +0000
Message-ID: <20240402071113.3135903-1-wmacek@chromium.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wojciech Macek <wmacek@chromium.com>

In case there is no DP device attached to the port the
transfer function should return IO error, similar to what
other drivers do.
In case EAGAIN is returned then any read from /dev/drm_dp_aux
device ends up in an infinite loop as the upper layers
constantly repeats the transfer request.

Signed-off-by: Wojciech Macek <wmacek@chromium.com>
---
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
2.44.0.478.gd926399ef9-goog


