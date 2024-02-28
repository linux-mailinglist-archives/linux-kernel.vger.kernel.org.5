Return-Path: <linux-kernel+bounces-84305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B6A86A4C8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6811028A0D4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB05B23CB;
	Wed, 28 Feb 2024 01:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AWlcWOiT"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3D7111E
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709082699; cv=none; b=NDe/D+CQx93xogIxz9LxJGKBq0UAcf7YE4coZQ67xHauweqkMst00j/WAr93tr8+f3nmigdmAJReXeAxCNikPCT/1m0FpwrsSyu7hn/20jNLKFo0p8Pfbnoa5tFONR9CaGqX9SY61IEa5U8g0HmD7OROsWu90sPMzo9Y1JZldNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709082699; c=relaxed/simple;
	bh=K2+cQMqQu0eaS0de3IxPWO1JWc7t415OLftE4xj9Ahw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eP6XIbbYTFY3MfRW6DwhmBt2PCXt1judtipWLlTlj325k51Nan/DlGAD9p0KOzIb6IIFvmWn1V/AlW0lqmJ30bhu8LnZX76bNGc4lRcFWYpaGQDtHot4naCNCZ0suYNkwSg6F+g256/UPWMzpqwMwiIj8RJ6K4aFyGCAY6mlBEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AWlcWOiT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dcb3e6ff3fso16992845ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709082697; x=1709687497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M5Amh+qBo3n8SZ1SFRORiYxCnsIvquzWzeGyrkguO0Y=;
        b=AWlcWOiTlYX3Gd44zEbVMCnE1g0X/BlV+zxulWGl89WfP8OrSMG+NP30f2XpP7QAXJ
         G4BQ5k1FilmjrF7QcUb+B1iCzjjN8P/I/AIqf/DsEzQSuSYRKjs6qKGaKL/0O8yTTSnB
         Ddu9rX5803O2OQis+tM2L98wJACik9esKZPW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709082697; x=1709687497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M5Amh+qBo3n8SZ1SFRORiYxCnsIvquzWzeGyrkguO0Y=;
        b=gaed4+kcGyjHOBqMFw+ZT+xpM7f5mD0Q6sQp2R9LBFaBoq9/M+VRQHZOSmqsvNAhs/
         4k1GlaBMtTLwu/SvHyiq/sveXPNGeysVdCQeZFnS8l0IaQlEOccU6OxsdBNPbpK/UALx
         At/hMDIlYUBlA7ALIxBAMbTkzWFICMO13ZWetV6a1TghKJrG728hQ8rjQVqRQihr4f9D
         wuOE+m9Ex33CB18ARr7TyFU+225Wxxaqi2Pp//q+drI3gsX/7e3cUm/4jpVJdUIG/4Ya
         +mYsW07hCbd5HfiuCUDEdMp3yCa+vuUG7fxnhtmQXrKuWnTGDSSh3m+S9ifJE24xqzcG
         UYvA==
X-Forwarded-Encrypted: i=1; AJvYcCUVkU+7OTIembt+WbQa9iA5cl1EH6NJfJMAgw0/K+V0LLMTZmz2FP4IRdT8N+/m+vGNlGbreaqBezXteQ3v5l3fjvEjb0t5rJmyW2ds
X-Gm-Message-State: AOJu0Yx9RCQS7hA1UN27QnRmxoBWsTlba7ox0bHu75KZ1hPLQCdffB2/
	ec+vf6BJAB19YJma3OyJDdEITde/VA7Lsj7CFyCF8Xg1JCw1Rhhn1ECcMVhRRg==
X-Google-Smtp-Source: AGHT+IFOFY88+LTSShatdwzqVAAC52XPnhIZWlpmq8/WxiTnE6WOCWIgXgVJWb5hCTv/yF5NF+ZYbw==
X-Received: by 2002:a17:902:c946:b0:1dc:7ca:36de with SMTP id i6-20020a170902c94600b001dc07ca36demr13094236pla.9.1709082697093;
        Tue, 27 Feb 2024 17:11:37 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:87d1:e95d:b670:4783])
        by smtp.gmail.com with ESMTPSA id kl14-20020a170903074e00b001db4b3769f6sm2131529plb.280.2024.02.27.17.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 17:11:36 -0800 (PST)
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
Subject: [PATCH v2 0/3] Match panel with id and name
Date: Tue, 27 Feb 2024 17:05:57 -0800
Message-ID: <20240228011133.1238439-1-hsinyi@chromium.org>
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

v1: https://lore.kernel.org/lkml/20240223223958.3887423-1-hsinyi@chromium.org/T/

Hsin-Yi Wang (3):
  drm_edid: Support getting EDID through ddc without connector
  drm/panel: panel-edp: Match edp_panels with panel name
  drm/panel: panel-edp: Fix AUO 0x405c panel naming and add a variant

 drivers/gpu/drm/drm_edid.c        | 114 ++++++++++++------------------
 drivers/gpu/drm/panel/panel-edp.c |  61 ++++++++++++++--
 include/drm/drm_edid.h            |   3 +-
 3 files changed, 104 insertions(+), 74 deletions(-)

-- 
2.44.0.rc1.240.g4c46232300-goog


