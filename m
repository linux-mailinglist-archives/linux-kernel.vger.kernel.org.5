Return-Path: <linux-kernel+bounces-91190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FEE870B05
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C5A1C21E85
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D867A125;
	Mon,  4 Mar 2024 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lx4oRblU"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAE31AADE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 19:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709581939; cv=none; b=PP1jgpsKugeJtX68ZXBHF+7tQReLvVwmaFmxNkUAqo61HZLTu9z2moCDeKI9i7x1e8xy5H/UTlaW+/A0n1zuPbweLehE6loZqBLK6uNLsPnJlX7dQVN+ek0jVuA+DzzAhGBHrtCc1QG9c5ujaJvZgGpNFeJqyoCapY8qLaavSOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709581939; c=relaxed/simple;
	bh=N/fu5N7do8ziJJpzwjlkmbsIxfESf0tg0PummNaMWws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RNFUVt7egrOuj3kO5Xhj/jFRNBh/Ot58pElCDoeKhVJmT+0YIFW6o5l3+C6qnXnFsRDDP3KlcQhjXTKW7TeOZL/V1XwrIzzwYEY5pac8wNwKj2FLzoo8FbLxKJi5iqknVRBigulN4wLjvqHpHLmICIZg4DTeMZbUI9AhePRdMZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lx4oRblU; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e55b33ad14so2950035b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 11:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709581938; x=1710186738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L2YF/tllYikOHtree+lJgBUznCn/Cf96YkN5i0u5L7M=;
        b=lx4oRblUW8NVksr8z9C3tFE5y7unRh9RXfLqcvomA7551OMZB/942KNWf2/ou1ELYD
         VoBAdsnDPchK59b8j/ScYzCY9BDwZ1Wa30858WelEDJ1TJFBWAtLQOlqi2/M3PhnxlWZ
         pvwOorln46edDtZ5ylc7fyazeObzPjUDDVRDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709581938; x=1710186738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L2YF/tllYikOHtree+lJgBUznCn/Cf96YkN5i0u5L7M=;
        b=nhP9q3VOgKvOjer6N30B1SxLIQl628qPX4KvHG060aDeWA1IwVJnnC5a2N5L4rEqa5
         DxbbKXV9mtWOf56EEh6UOiJofVJpNypKZycrut6YsKm1p38atQj3+SD6tmovTzW/wnJy
         0RETQH08DddMPva8P1kVV/4dGHqzuW7uqx423vU3b8rCZafVIbVvQ0xew6jnkMfEfKd+
         +Mk/EL1fBOx3IdH6jdzYxiViamlLZOdHS6XV0M02X6zP7RKQqP0tvaoMf3OCdNQdoljf
         +M//i8Zu9zLLLhuN0pshbkHYRAcW6Elr/eBCzjAZuSqWBsGVCCLPPqa+/h50fnCF8Ef9
         buyA==
X-Forwarded-Encrypted: i=1; AJvYcCXfJoAcNvr2kbt+lbcxbQqnpi55n3DIrKA3R4VeTnQc17kji6ttkS1kW10z0HhPwDk7nE+ix8d6FShcKKaUAKXdXCj7bI8tRjsBsSuM
X-Gm-Message-State: AOJu0YwkFWuoUZ8MqWgqjIULsTpU04mOvGVXkduLDOdfyTcn3VGrvBwK
	i/7sm0agayVgigZg3gZ/Ipy+0BY3Lnyazm+VVI0ekFgGFoYeGt2bl5QCQXQUSA==
X-Google-Smtp-Source: AGHT+IFvoBTWPISuhFRebI8OudEATtlEpmelxZSJ1DFYb6YYmUlCcAx8kS6YqeGubnHARR6ayMjlAg==
X-Received: by 2002:a05:6a00:3d56:b0:6e6:3920:7a26 with SMTP id lp22-20020a056a003d5600b006e639207a26mr125447pfb.3.1709581937713;
        Mon, 04 Mar 2024 11:52:17 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:bcf3:25da:25cd:199])
        by smtp.gmail.com with ESMTPSA id r27-20020aa7845b000000b006e04d2be954sm7600820pfn.187.2024.03.04.11.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:52:17 -0800 (PST)
From: Hsin-Yi Wang <hsinyi@chromium.org>
To: Douglas Anderson <dianders@chromium.org>
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
Subject: [PATCH v3 0/4] Match panel with id and name
Date: Mon,  4 Mar 2024 11:44:55 -0800
Message-ID: <20240304195214.14563-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
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

Match the panel for both name and id. If not found, fallback to match id.

v1: https://lore.kernel.org/lkml/20240223223958.3887423-1-hsinyi@chromium.org
v2: https://lore.kernel.org/lkml/20240228011133.1238439-1-hsinyi@chromium.org

Hsin-Yi Wang (4):
  drm_edid: Add a function to get EDID base block
  drm/edid: Add a function to check monitor string
  drm/panel: panel-edp: Match edp_panels with panel name
  drm/panel: panel-edp: Fix AUO 0x405c panel naming and add a variant

 drivers/gpu/drm/drm_edid.c        | 107 +++++++++++++++++++++++-------
 drivers/gpu/drm/panel/panel-edp.c |  42 +++++++++---
 include/drm/drm_edid.h            |   8 ++-
 3 files changed, 123 insertions(+), 34 deletions(-)

-- 
2.44.0.rc1.240.g4c46232300-goog


