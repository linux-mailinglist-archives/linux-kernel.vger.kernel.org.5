Return-Path: <linux-kernel+bounces-93174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0C7872BD7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C111F221EF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E7D63AC;
	Wed,  6 Mar 2024 00:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kDyZfX05"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6896FAD
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 00:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709685832; cv=none; b=WoczSC8Zmi1UQ1Gjv4IWtmsAydZvQvdf/ArWV5E+njZXGwpLCu78mN4VSj2DcDzltdy6V3VhUKhLR3Psatny3D6lh+MRT2eH/R0iox+4g8V5vGsGwwehLjSKtjBX8uTvHlHV2Ub0OYZBjuSQ6TKf2epNejvhZ2rt+cr1/e3rOro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709685832; c=relaxed/simple;
	bh=QvW7Akk+lx7kxu4GgZ0ymuJET/HhhBdn4Nuw2/iRSZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YSqRB8EbcZ5XWWYX6/jzdRCYpMAFFJdk/CgT0l4gxzSbhtaIxHZENR4zuNro4RWbRC4S+VvBywAlwTLv4gNIWJwmlsZDK6+3+fZ+fHmFlYAohbQ0sN5Qodb3sfIrhFi3cS8cmWFJQuArrhAScMuZFUn59Ovkyb9WG5PmyoHDJM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kDyZfX05; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c1ea59cf81so1598011b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 16:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709685830; x=1710290630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=skL9kwoINY2e2BLPcnAl1r5cKivgr2bgQKAAVl8VlEI=;
        b=kDyZfX05a/4SRV1io5hcctI0DotKADiIHmqE6npm7kxfBiltbVHGE/1iYIfH6j2/EI
         rLMmYZwjHBXtj7bCWvyiRhsnkFBfpvVXLjU7vc9Lazhz5Q9Fy8v0ArSCNAZ7oQbNrdje
         UALabhxzus1n7vAl+S+L43bOvRJDzu9dODinQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709685830; x=1710290630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=skL9kwoINY2e2BLPcnAl1r5cKivgr2bgQKAAVl8VlEI=;
        b=u1XJH3+0X0lEG+ztJAGHp8xD/dXjhfiwHSX+LAxouy1AIFbkJ+bll4k9vI64Hz9Mrl
         YXHaVptZ1wPco4g7QzW43FcjcqCuKwmsBCkZHwRYBUKwsLe1Qn6T8WsGKkTBMMHyH1q7
         w9/aqUMx8/FjZ+3GePJwIAXV9j5y5KEA4wTPaYzVTt95sao6hr2My+jqBTu4EpEDhGCb
         eJXXJrk91OHgJvTLg6lM6gJEwhb8meab9eo/UCN6t8AfroK/40ZJfhA0XXNFYRJxW20Q
         v/ZzasG8WH8lNm/eSi3x0amQtQg/itx3ChwJPRXrMuEzeByoXxFEtGVDaBeh65m3L+Es
         5aow==
X-Forwarded-Encrypted: i=1; AJvYcCXPhFcVgXTQhM0Iowrl7LyGgEKop1AAkRWQfl6lJAmVC8Y59TpcnTUIbbeugQjPNwzV4EamLrg7D/tg2sgHf4ntlKbO48MJdzkE/Zju
X-Gm-Message-State: AOJu0Yw4F0hQJwkXHUeDrbx3+pjtgUMDn25c5tLb9GSj4T5iMhvR0Prt
	iDGxqLNpGXrJKsID9HETVqdYyIQVCiphCXGmEPw3Q0wBvNdsgqZ9a1Ssn+9x1A==
X-Google-Smtp-Source: AGHT+IH0rkwG83EfUqaVo2L5B6vkJMYLTrBhh7MNxEN86PPrBbsKd0w3xq4KX0LNtK9mic7XGS+vbQ==
X-Received: by 2002:aca:2209:0:b0:3c1:d24e:80d2 with SMTP id b9-20020aca2209000000b003c1d24e80d2mr3600263oic.1.1709685830579;
        Tue, 05 Mar 2024 16:43:50 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:29bc:b3d:1ba8:cf52])
        by smtp.gmail.com with ESMTPSA id x37-20020a631725000000b005dc48e56191sm8512885pgl.11.2024.03.05.16.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 16:43:50 -0800 (PST)
From: Hsin-Yi Wang <hsinyi@chromium.org>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] Match panel with identity
Date: Tue,  5 Mar 2024 16:34:00 -0800
Message-ID: <20240306004347.974304-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is a follow up for 1a5e81de180e ("Revert "drm/panel-edp: Add
auo_b116xa3_mode""). It's found that 2 different AUO panels use the same
product id. One of them requires an overridden mode, while the other should
use the mode directly from edid.

Match the panel for identity (id and name). If not found, fallback to match
id.

v1: https://lore.kernel.org/lkml/20240223223958.3887423-1-hsinyi@chromium.org
v2: https://lore.kernel.org/lkml/20240228011133.1238439-1-hsinyi@chromium.org
v3: https://lore.kernel.org/lkml/20240304195214.14563-1-hsinyi@chromium.org

Hsin-Yi Wang (5):
  drm_edid: Add a function to get EDID base block
  drm/edid: Add a function to match EDID with identity
  drm/edid: match edid quirks with identity
  drm/panel-edp: Match edp_panels with panel identity
  drm/panel-edp: Fix AUO 0x405c panel naming and add a variant

 drivers/gpu/drm/drm_edid.c        | 152 ++++++++++++++++++++++++------
 drivers/gpu/drm/panel/panel-edp.c |  68 ++++++++-----
 include/drm/drm_edid.h            |  11 ++-
 3 files changed, 177 insertions(+), 54 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


