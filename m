Return-Path: <linux-kernel+bounces-125841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D185892CF5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3991C2158A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980D047F78;
	Sat, 30 Mar 2024 20:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o11dxPFi"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A54A26AEC
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711830470; cv=none; b=sI/eaHaSmLSBbFRJE1IONUmEqPw9Zjodnz2IaqVwle2Sce8h3JHV3QGqeE8VgpMxaa6s3cYd4xxs++Agji3SQ42dvxX81nxg6bofQxhEagwDi6ACdHxTW7iMWC3pvX3WO++rBADJ/hLzgtN/5vY84dZE5lSoI35C5cPZ44Yoihk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711830470; c=relaxed/simple;
	bh=H4eGMeTlUK1errM8DuQ86+iOLe8KcI0XbQZW1O+O7Rg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H+vdshSBaHACRlZhaTGsfMHyKYU8bvM9gM6cBdkntK1X7A8LrsIFOGWk0/E5sVhH0NpyaisfzulyzNJf6hiIT7yt1dXAjkTFmp8ZrLdPasWgi2Ty0KvSTZnq9lM1mMJPK9XbfA8zZ0GLsVibM3bq1SLpyUV4ubJA0OKyIncYWAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o11dxPFi; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-415584360c0so4096365e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711830467; x=1712435267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKq1cSJLmBMggJ/k26mH1K2G4dZv2uJutdH8DjECGXE=;
        b=o11dxPFiXt2ynmHLjOmVBRd0cnQ65YlYFuh7H2Cm34ufGL54qrPn24KmefutYJrGOk
         l3H9L0gLqetYIQ8REgFxyUpPo3VPX4XaKpCZiBnrQ1sj7hP98hwtS4SEQI6rITqS1IZm
         /w1/dphSku0Vul197LbqbSUMSvukHLKfif0lR1A3cZpe3M7hTXoRpV/ZVuZyxQhQ5Cvw
         Gdd/YL1I4eqVEjDjc8oDmQCyayaefCAiVE04CAPVCSsSGBAm95lATOsOsGKZ1WidPC5B
         xxBQ26H0WcPvkKAkkq8ShHGnHYvz76u2ekG+sew3+FzKwVWZ+oyh61+9456CEY5vWkFi
         BE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711830467; x=1712435267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKq1cSJLmBMggJ/k26mH1K2G4dZv2uJutdH8DjECGXE=;
        b=trP1XHqmG6UZ4xRXmRo5CoURQNklKlLSZXREpJJkUcXSLYun5YA4KR0iGaDvJpqFoh
         Q3t+an6KR5Zm+j2SGSEeELseoFc9ijpyGIHKu+ZFhNRx9FE2uZibKMRghQq/zqpN7brZ
         /PcVyedqqMJruqKzChepca0qQHGsB+Gygc8K/rtPF1wYErwAhuM9rnYNLPAGs6OPj2Dt
         VqXWUbc543PjSjZwIwHgaPafCYFncKEQCfDfIma/AIEvaCLiLmlgvd+dFvWK/e+bFMiw
         Kl3DqP2tAVwpy1jygdeyQfH5UoBmg0HqAFTWgOVSHdls3VhKGcLilnSFKMzsSWl6Uxoa
         h++A==
X-Forwarded-Encrypted: i=1; AJvYcCU8aWXrvL0y7lowxzFhLI14vTutB5dDXNykvXJkX0nOWAxFH4CfkJ+LZc7AlahI+Mg/XjRQUJR9GSX8CRM4n7kFB4ZoQdYfSJLG8/ft
X-Gm-Message-State: AOJu0YyrPtP/8KUVdi+gSzTLPuBnDThvc3ypUeGMo7Yx0WsqADlfK8ru
	koP0yiTWxi8lPJzitpiilyetzGgUXYX+axtBiOmKcd7LjrLmEw4cczhmLpbMNjU=
X-Google-Smtp-Source: AGHT+IFuJD+q3yYb7HgBA+jgGA0QcBVPVNkVgdIkuGN72/Mz7njw6maSOomeiJziCDBGX+JyPmDdbw==
X-Received: by 2002:a7b:c7d3:0:b0:414:d8f:4399 with SMTP id z19-20020a7bc7d3000000b004140d8f4399mr4105090wmk.18.1711830467366;
        Sat, 30 Mar 2024 13:27:47 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id q17-20020a05600c46d100b0041409db0349sm9505616wmo.48.2024.03.30.13.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 13:27:46 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Jagan Teki <jagan@amarulasolutions.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] drm/bridge: tc358764: drop driver owner assignment
Date: Sat, 30 Mar 2024 21:27:41 +0100
Message-Id: <20240330202741.83867-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240330202741.83867-1-krzysztof.kozlowski@linaro.org>
References: <20240330202741.83867-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in mipi_dsi_driver_register() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/bridge/tc358764.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358764.c b/drivers/gpu/drm/bridge/tc358764.c
index deccb3995022..3d3d135b4348 100644
--- a/drivers/gpu/drm/bridge/tc358764.c
+++ b/drivers/gpu/drm/bridge/tc358764.c
@@ -401,7 +401,6 @@ static struct mipi_dsi_driver tc358764_driver = {
 	.remove = tc358764_remove,
 	.driver = {
 		.name = "tc358764",
-		.owner = THIS_MODULE,
 		.of_match_table = tc358764_of_match,
 	},
 };
-- 
2.34.1


