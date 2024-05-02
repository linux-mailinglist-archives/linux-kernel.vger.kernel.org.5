Return-Path: <linux-kernel+bounces-167000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDE38BA32F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEC141C20C10
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EE214285;
	Thu,  2 May 2024 22:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fQrdNKX/"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C45F57C9B
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 22:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714689189; cv=none; b=Jc71U7DyvKN8b1GubeAC4LPRSnF4MYT1CttVBa0LHBS1rLxffnbmvTuetzPx/RVap9OkBV/frNMgqKA64qAkPjXR1yGirUoS/uQjV9Km9Qakr+JWpKBUnPZaIKlUBVDKabBkZjyh1WncdowSq/BCAKeCjLxzqAdBZZjIOgf6oKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714689189; c=relaxed/simple;
	bh=dO9d9GO+9ZhaX/+//8IAsuH1HU7eGJvU8Bz2RrU68Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YiOgZQWiNBom7nESI+YS/Oe8D3zSc+6ozX/wjIynvlpw8euM7zm83pRaqLTyGKcRxv9JaDaXtp4IVJu6G7DWzN+AfYxShxh/Rmd8UOV3iNIzl+eaJ6LrGRmFCH4DiW016HEl295KCbF8TtA/td70V6UQohtWtDgnpcS0NsmxjmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fQrdNKX/; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-618a51c8c29so972510a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 15:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714689188; x=1715293988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o0jTh2QfVXv25MHjtTxDv2qpxtdDgCoD64Zip10hlxA=;
        b=fQrdNKX/zEISmlN//8eO6b6k8HUbaOPregNTxYipQQ2yFkvO58znVNWG3QlspkNcjI
         H57su+gX0FAqAwO94C5z33SmXjHPOTipExaUu2HbY3/p2mb+u5p2ewJ6cmDFl+CD9pJg
         6NeCW0gCeijt8hUWZ6JJ0uuKsOSLIR4PXdXrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714689188; x=1715293988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o0jTh2QfVXv25MHjtTxDv2qpxtdDgCoD64Zip10hlxA=;
        b=weiuCv+6Kd/1rgjeW0nYmGKdje4jLsNCyJ+K81btpLnnejvy5lorPvA3asxWYio67n
         y6BiX1KXUxP+cE5G5lKnH6juLHkvGHB3k7WjpfL6W86c8hfwRGZnb2lMs2CdFFd6kM1x
         /YdWQePJsMrRqtFGaKz4JqDwv0kPz8+VuJwAclGgJ8mV18VlkNugG4ixOh2nS4fOfJIH
         MRsr4hobeMyO1gZgIR2xTLLwWWBEoSeo8522NqrFYvRKyjwes4Gw2zDFd+IP9e+NX8c1
         m7HwKFezYlokhQD9zBU+g+ypY33kyiPDvqSQPuPx/y8+V1o9zZStxhb/6lhdJ+AqJQLy
         1vQA==
X-Forwarded-Encrypted: i=1; AJvYcCVsAudxsEpW0BgGuhiIN0FGixpomcDTDN6bx+Z+DQHTUk8GpruYlyqirkcICaX4YikiITO34P6MNc19Zs+H6He5NBmOF9LCCwOIBrNi
X-Gm-Message-State: AOJu0Yw1EIslVWKWZTjFAOHEQsC/L3GhsrPKzGCuUjoeFDaLdXUXbPWE
	nWFuXvGqmeQ1K7e3tuDxsriIGG6I+roFDhMlBP+MM36hhLmZ73wiC8V56ILrHg==
X-Google-Smtp-Source: AGHT+IHaVWuOpzr0DJi9lnd6PZ+qLFMY6hMD14bFNnPzTY4pfzLIiVSi7AZDi3pqydphJYYIjNr6GA==
X-Received: by 2002:a17:90b:a42:b0:2a2:9e5d:9bf9 with SMTP id gw2-20020a17090b0a4200b002a29e5d9bf9mr5810940pjb.8.1714689187899;
        Thu, 02 May 2024 15:33:07 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:d58d:52de:fc6:7f45])
        by smtp.gmail.com with ESMTPSA id sx7-20020a17090b2cc700b002a4b2933a7asm3787730pjb.1.2024.05.02.15.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 15:33:07 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: Rob Clark <robdclark@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Pekka Paalanen <pekka.paalanen@collabora.com>,
	Simon Ser <contact@emersion.fr>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/connector: Add \n to message about demoting connector force-probes
Date: Thu,  2 May 2024 15:32:35 -0700
Message-ID: <20240502153234.1.I2052f01c8d209d9ae9c300b87c6e4f60bd3cc99e@changeid>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The debug print clearly lacks a \n at the end. Add it.

Fixes: 8f86c82aba8b ("drm/connector: demote connector force-probes for non-master clients")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/drm_connector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index b0516505f7ae..4d2df7f64dc5 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2940,7 +2940,7 @@ int drm_mode_getconnector(struct drm_device *dev, void *data,
 						     dev->mode_config.max_width,
 						     dev->mode_config.max_height);
 		else
-			drm_dbg_kms(dev, "User-space requested a forced probe on [CONNECTOR:%d:%s] but is not the DRM master, demoting to read-only probe",
+			drm_dbg_kms(dev, "User-space requested a forced probe on [CONNECTOR:%d:%s] but is not the DRM master, demoting to read-only probe\n",
 				    connector->base.id, connector->name);
 	}
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


