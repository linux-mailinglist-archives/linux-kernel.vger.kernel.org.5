Return-Path: <linux-kernel+bounces-94067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B0787395A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C85286AA1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F65113473B;
	Wed,  6 Mar 2024 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oC+eSq2f"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15481133993
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 14:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709735903; cv=none; b=SjfEbSozwiWHuV+l8JRBTYuDvutqXLTSezrtCtYe5QD3QdJgDKWvAx8m3YaiSNCAyjfOa+YErXIYpc4YC+914PZs9bJvP/1u5uOjMGxXarUPa2xnR/UvRrWfkwTg6szaIyzZoVpqzEmpJtINCP3XSNDMsTASKSxdGb4i/YIceIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709735903; c=relaxed/simple;
	bh=NoMdI+P3ezDczKim8qhxeNDYdobYgb/tcnA+4xYseTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LVOykd21p6atW6/MpR443sMIu+uIcCHHtZhUT5HpxjUlqpUroQ1iKtmq55YKsJQdlGb1NPFGNXhJmmobvDzDTg0XG8/HNP3k4xQEcZFQLSMbN1EgGiWQvZ+EGRwcTXxpoRPL22GKQR3tmjbwQ4GSqfTVkuNhEwFXgROWsvhWddk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oC+eSq2f; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dba177c596so6515795ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 06:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709735901; x=1710340701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pLyuD/CIq7Kcq2J+mXAcpPtUiY8V5eDIIqZPqq8Wh04=;
        b=oC+eSq2f52991kigKwibLRWjJMsDjuGw/CFx+zyUoyC0Wx9rIoHukwC3Xocz9zirqU
         qznOIvOucFVVm+1dw2E/6KyTcxsoOSQx39BkPc+r7deQVSNrLao6SO8t+xnukfPw1pdi
         7YRFOBTtWCPw/aUog6e48z/nWOE6p66js6IJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709735901; x=1710340701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLyuD/CIq7Kcq2J+mXAcpPtUiY8V5eDIIqZPqq8Wh04=;
        b=n/g5XlKN5HBBoUN4JR7PVxB3HbDxKKqA1VitRpSNgz8pC2eaADA06mFcxbOcuMwsUj
         fb/CtTlyQzISaQvVZDryl/0lBLNqWJs8IX4/QmEeNovDrhEmTpZBr5K5I2hNkW46LDxx
         oDm61UVA/0lCciNv+rRzwa7eIF3EiK1Eh/+n/5PmZ6ATCKXJudHPK+s1miUz7cFRp4R6
         HyOKuGD/gSmloGJzu2StyyZ0ccyMKIo4E6oEYNRg033JsIeSTYIlf5DC0fEOlwP5W/6i
         UQFOZf0EqgHzM900WSazEJuU6WpEBJWtOV8u843jInwcKdOO3BONJ95BANqZYe1GJUxa
         43hg==
X-Forwarded-Encrypted: i=1; AJvYcCWX0xXzzdpqMHE8bfL0xJuyABJDZP/IsPrWjNXWCPnfykuZHcwQZRgglhCH9co6e4//DhvmXpY1VyQu6uOG/EC9VmoqL3aHqzKXZ967
X-Gm-Message-State: AOJu0YwO0t45BDMj9GwizOaVCNX9bZRYx/NolRek5wk7xtwEcMRK3GrB
	Ml/vWBM59vqCBJiTDkWksWKzzPJEyUXOJl4Nc3hzdsMlywh90mECZPWcV1bLjA==
X-Google-Smtp-Source: AGHT+IHZhsekI2nK6sFkLJTOQ3qMI60iZPbvn0ydMSpr9wbA4qAouFyjXAj8VD/Xwrbaf9QKuboxEQ==
X-Received: by 2002:a17:902:f7cc:b0:1dc:a605:53fd with SMTP id h12-20020a170902f7cc00b001dca60553fdmr252901plw.10.1709735901343;
        Wed, 06 Mar 2024 06:38:21 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:bc24:1849:151f:5509])
        by smtp.gmail.com with ESMTPSA id e7-20020a17090301c700b001db9e12cd62sm12667178plh.10.2024.03.06.06.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 06:38:20 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sean Paul <sean@poorly.run>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "drm/udl: Add ARGB8888 as a format"
Date: Wed,  6 Mar 2024 06:37:22 -0800
Message-ID: <20240306063721.1.I4a32475190334e1fa4eef4700ecd2787a43c94b5@changeid>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 95bf25bb9ed5dedb7fb39f76489f7d6843ab0475.

Apparently there was a previous discussion about emulation of formats
and it was decided XRGB8888 was the only format to support for legacy
userspace [1]. Remove ARGB8888. Userspace needs to be fixed to accept
XRGB8888.

[1] https://lore.kernel.org/r/60dc7697-d7a0-4bf4-a22e-32f1bbb792c2@suse.de

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/udl/udl_modeset.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index 0f8d3678770e..7702359c90c2 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -253,7 +253,6 @@ static int udl_handle_damage(struct drm_framebuffer *fb,
 static const uint32_t udl_primary_plane_formats[] = {
 	DRM_FORMAT_RGB565,
 	DRM_FORMAT_XRGB8888,
-	DRM_FORMAT_ARGB8888,
 };
 
 static const uint64_t udl_primary_plane_fmtmods[] = {
-- 
2.44.0.278.ge034bb2e1d-goog


