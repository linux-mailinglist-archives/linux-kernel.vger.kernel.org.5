Return-Path: <linux-kernel+bounces-70085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D258592E4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 22:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B8F28467F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B4280044;
	Sat, 17 Feb 2024 21:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwkBlgzJ"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B71657BE
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 21:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708204421; cv=none; b=fYU03k38Bt98aAXedwXT6aY99AtJyLLrAEi3Lgfjo+A4UL410B0TWLcxSwjSK2os791ipAkUcobk7wpnKLmby02FUAPKcunjdYgePJkcLQYQwOxBOrlh26EqymyPWiEClLhigOOZVX7INtFo/QR4mbmmIdz627jTWTOb78WueEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708204421; c=relaxed/simple;
	bh=nx+tftz1nBVA1JDthW839KRrG90SMOUclvTtsVrk+RY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KeWMI6udAUip6/dXKArVLSBI68fvOs0NaYV/QZA2hZ3+GW5QBOMECUF79o76dmKjHkC9GfMi9IJiZzUN0HmAOc7+U0FGIZQyoEXbXap7VH2oWuwOo0o3wzcxVYwKZxySQtlHyUcxIrR+SLWI7XS9zLWBgAPEcRGv+cyfZL0i2M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwkBlgzJ; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d1080cb9easo43022791fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 13:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708204418; x=1708809218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80aNxi3/T+LbaRRg/6R2N0khZ/zy5It3WYtSjVAdo14=;
        b=MwkBlgzJR0jNvqgf2rPna3qliDdbr30qojIw1tK+ugawPaaEzD0sRjWUeaGaSafdBq
         SWApM2Kw+VnsV1M1H1XkgJz4TmXMqHAPJ8JbdFMY69gtvCYxj+hvy65uv7omQGRYHSaR
         CkdSMIyvv2Y3ObG6WWrBME9d3hhU3s8X1GzbQ1AWHUza+rr4cyb2NVwajflfc0e1m206
         9kQ0vUJewS90HzHcQVnAxeTYsXEykDg7kxPyG5b7tvDFpWNTua9eOwCXo6jR47ALIBSj
         iWLGZsBWfZBUfiSMT/lNuinuJIQJHnvXnKjx1CrwuKEUJi5eQR5k8bSWrJJd01p09fgX
         +xEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708204418; x=1708809218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80aNxi3/T+LbaRRg/6R2N0khZ/zy5It3WYtSjVAdo14=;
        b=XCqp9rzst/U3QQxtWyCT167JlELUt6w5PettivBY5WmcMHhUFRhonx0JuNKtbh2F+e
         H/ZrF3s3mBf6ran1Hw8u+geoB4Vh9WtJU0rX2xquNtCcteYrGzQBaxCTZYNIZWnZoE03
         DX1Xx/wxrxUkbp3q1VsYPNYbGB2T+LgvElMXRlLS7fwlwc00MHBlJ0UAQZSZGnNcQ3b/
         9JdalGlJePPtUvsFqPMvh0h4umdQgUVKlwK6mi8/LtvxH8Aj3VGv/Dtr60MX0n/tQOUv
         HSCTMewFo9E/R830gqAg2gjoea0y/LE3Cr1AET1nq6A/Sewv5+S9I/ORweiB6fkJ7Mpy
         JPEA==
X-Forwarded-Encrypted: i=1; AJvYcCVVQlf9hbGOkVJTf6fAxFqO8oZZmyXGONPoynvUGjUo0MG2NOdH1lh0mJSoJ3BA2AJ3p+kd4eFrnZVgaluFcLTt8ilUkwPExfbbQ27k
X-Gm-Message-State: AOJu0Yy7A/lCR2MV1O26icW9mPihgipfiZGI9wSdfeIAWrszE8OCGHbc
	W2MEacxG5KKM8spk/z+Lp/Xc+HGaQbqHOdQOmdgG82JmRAoKv/ITDCEfm9dp
X-Google-Smtp-Source: AGHT+IHMnVyJmhAK4CsTjqVXERP3BRF1TlMELlJXzXhuJXBLjenNCJb4Q6haf5FOo9elDWVjDhXl0A==
X-Received: by 2002:a2e:a543:0:b0:2d2:ccc:ac2c with SMTP id e3-20020a2ea543000000b002d20cccac2cmr6041608ljn.4.1708204417902;
        Sat, 17 Feb 2024 13:13:37 -0800 (PST)
Received: from pinguine.lan (ip-176-198-146-182.um43.pools.vodafone-ip.de. [176.198.146.182])
        by smtp.gmail.com with ESMTPSA id n3-20020a05640206c300b005644eca3befsm132087edy.85.2024.02.17.13.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 13:13:37 -0800 (PST)
From: "Moritz C. Weber" <mo.c.weber@gmail.com>
To: florian.fainelli@broadcom.com
Cc: linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Moritz C. Weber" <mo.c.weber@gmail.com>
Subject: [PATCH v2 3/8] Staging: vc04_services: bcm2835-camera: fix brace code style check
Date: Sat, 17 Feb 2024 22:12:41 +0100
Message-Id: <20240217211246.28882-4-mo.c.weber@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240217211246.28882-1-mo.c.weber@gmail.com>
References: <20240217211246.28882-1-mo.c.weber@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reformat function parameters to fix checkpatch check:
Increase readability and consistency

Signed-off-by: Moritz C. Weber <mo.c.weber@gmail.com>
---
 .../vc04_services/bcm2835-camera/bcm2835-camera.c        | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index 1fa868163..dfa9e7670 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -418,11 +418,10 @@ static int enable_camera(struct bcm2835_mmal_dev *dev)
 	int ret;
 
 	if (!dev->camera_use_count) {
-		ret = vchiq_mmal_port_parameter_set(
-			dev->instance,
-			&dev->component[COMP_CAMERA]->control,
-			MMAL_PARAMETER_CAMERA_NUM, &dev->camera_num,
-			sizeof(dev->camera_num));
+		ret = vchiq_mmal_port_parameter_set(dev->instance,
+						    &dev->component[COMP_CAMERA]->control,
+						    MMAL_PARAMETER_CAMERA_NUM, &dev->camera_num,
+						    sizeof(dev->camera_num));
 		if (ret < 0) {
 			v4l2_err(&dev->v4l2_dev,
 				 "Failed setting camera num, ret %d\n", ret);
-- 
2.30.2


