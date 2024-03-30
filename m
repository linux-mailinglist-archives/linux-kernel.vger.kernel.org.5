Return-Path: <linux-kernel+bounces-125843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D118C892CFA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8319B2816FE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E61482E5;
	Sat, 30 Mar 2024 20:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NBIRUrhr"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E56747F5B
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711830492; cv=none; b=u1+j2OD9JwLa6H2KESb1SENnHm5zImr0bicIJEunAtiS3zXeYdudpg7zrutGFQ6rSLSsO3MXU9z995ZkdsSeRdaXPw8x6KMtO3+aYYQ/px7g9TUt1Gdu663vSPnNIOy4SiIT7jCJ6gNqD9tmJhreYzTd+RmmYMNp5YZbac3Ah4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711830492; c=relaxed/simple;
	bh=0F1QB8XIh89f+/wwsvMkIFMQesykGfs8Jn+3ckwIceQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UdmqDKJFDKXWnNZB9GB9pkzAngHdfNJ/6suY1CLTdxtl66lReLcJk0ITiMofED84hKD+wHiXOLQ5nOmzFnK0OEU+5VjUWXhSw1K4Wdyn3R1IPpr/EKFPXgLpJi+Gs4RnrDfRBd/z2+XUkDdkb/cX9q5N+OXCdsUzZ9djBiOHUfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NBIRUrhr; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34175878e3cso2243877f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711830489; x=1712435289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cb1rJ0C9hI2g+B3ZJcFx/t6UoBBJIXeH0O1CoQprhnI=;
        b=NBIRUrhrAV8X2GD7Oun8YDx8y1Qlq7XzwcBZPFvsD4ppF6kJOeyyuSnm5RTjh3/x3x
         Mv83IwVsh0eqvaJ4CS6VjQ2XQ2clyZKjhE981Fka/d/89il+4to03SmHl/NMzPDHZS+S
         3Y9G6yER4wfOA6yMY15gs/b1M6zl9+KED9GADisIWJWevhml8I4gg3rKlgecnCsYB5E6
         pIxHAWShP/BpqU6QXOuxYMW6v2ydS1GoAl80dqRuYwv27yq+hKp6apNiHNM3KZanBI4s
         BHsBJ96eJztfrwboKEpnPCW3zJBeAD+PgZiN8FEK7zuLJJlK5IMCrYT74zpoetYaWI/l
         sqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711830489; x=1712435289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cb1rJ0C9hI2g+B3ZJcFx/t6UoBBJIXeH0O1CoQprhnI=;
        b=XMw/yqmyHYsYL/H3DkdrJVhDGMNkv8MbKyMJYJzm+Z6h+EZnrKSO1eHlUZS7+wIUaZ
         wR9L/YQjd7oUTzQ7cifYTQxWiu4ccAA4KOA/0jrgBD4AtCWh5pnKZ4R95qOllLS4f7LE
         IwKtN1q17Cy0LIigk4V8Z8gpulVKOsjeRehVkArIm+GRccX/+yKMnag4VgN+M1whSU2X
         Ys2E+nX4M3Yy3GM1U3lsLGZCgcXiQWZi3OQehY1Z8XcCbM0qYKeHP+Xe/9Fe4yuDlOwx
         IIIBI1y7Jss3rwrr+mwNw4EBDW1kr0Ed+qsWhRBXTht8Ja8xGYWgoSXkrH8GQex3/bGb
         JkqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQW/4zdJKhKo2xZI0JsGj0XxU8wghpwnrMUsWos5Wa7G40GdeY9xvsPQJLhFe+nmNna8cO7nCibVF3J0oCFgrgj98mxpoXHGaoHjAT
X-Gm-Message-State: AOJu0YywAe+Tt00xV5GISlyGhtz83N6JGlum9wbT8Fz0Yrk831q8J8S1
	JW/8a59kAPhI9oTsYe91066Sobo0t3aSj8jQ3O9Pla3qK3tYdKTbMUSGLs8sXN8=
X-Google-Smtp-Source: AGHT+IEjYZHqefeHkDLiTxUeDHyCaf2Z/cuKICwGIF/hHCEy9VBp+E0CqbfkFxv/fqV4T+CQdbdFNA==
X-Received: by 2002:adf:ec84:0:b0:33e:d244:9c62 with SMTP id z4-20020adfec84000000b0033ed2449c62mr3082832wrn.68.1711830488802;
        Sat, 30 Mar 2024 13:28:08 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id bk20-20020a0560001d9400b0033fc06f2d84sm7240090wrb.109.2024.03.30.13.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 13:28:08 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] drm/omap: dmm_tiler: drop driver owner assignment
Date: Sat, 30 Mar 2024 21:28:04 +0100
Message-Id: <20240330202804.83936-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in platform_driver_register() already sets the .owner, so driver
does not need to.  Whatever is set here will be anyway overwritten by
main driver calling platform_driver_register().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
index 9753c1e1f994..1aca3060333e 100644
--- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
@@ -1212,7 +1212,6 @@ struct platform_driver omap_dmm_driver = {
 	.probe = omap_dmm_probe,
 	.remove_new = omap_dmm_remove,
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = DMM_DRIVER_NAME,
 		.of_match_table = of_match_ptr(dmm_of_match),
 		.pm = &omap_dmm_pm_ops,
-- 
2.34.1


