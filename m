Return-Path: <linux-kernel+bounces-96346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3515E875AD6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9E1BB2268B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BE03D55B;
	Thu,  7 Mar 2024 23:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c2RSerpp"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFF02E648
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 23:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709852819; cv=none; b=jqWGW+/qdEn8LKO6fNTiEM/xqklMQW8hUOyvE7X3uDZOGJJQrTeM6PwW6xXLt6g7ciAe7UABA4Atfjq9Kkapz08w2r43R3FZ9CEpzPkcXoNA1JLE41MbNV4HJu0QpHkZh16AxxpPmnD0NY9gIgpR2WY7A4wYK5yuPnSHhiDZ9KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709852819; c=relaxed/simple;
	bh=k0SS8SAKBWSm6ZjaeUI808O7pfDqgFVG9Q0f0R2Yypo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g08Sm6ikNMWoylQaB3BDUeAqK1GpM80VDGyaQjIgXaiYUn2IMJ+rvTnHw2Q1Y6IcB+serja3dtti30ziqmG8XLMktPh7pAIdkwddPtW9qVjcPCM1Ats3uwRRJqQgNmjDs9wNX3YM2iNNvwrQv1b1/GHX7TmY3fM8vuLK9v4Qnlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c2RSerpp; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dc09556599so13276885ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 15:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709852817; x=1710457617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7iHe5Q0jS1HzmXGXJsFnZi6ylveqC0jY0B2sEgUj6Vc=;
        b=c2RSerpp0v8RV9LP11fTVkqzzm+zOhjJYdFiIlbkgO1caXQ7dTnBdAo54cpkRYxlnq
         aJbqYi4bMec+LVerWe8lXiwWDS7wuNU9T9JQc+JwNuIL4aemBz/sqz1RxHlG6BFW1EFA
         PkGiKkmMlziYccNHHicV4oJBzWoQT7/LCVQ7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709852817; x=1710457617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7iHe5Q0jS1HzmXGXJsFnZi6ylveqC0jY0B2sEgUj6Vc=;
        b=eS890yosn6CAyJs3izhx3eywix3Lyjhqwh20RvYZ0o8y4lRXtX8V5DkmNu6R+RaKWV
         1WVEVR0kGRQGOJenYyxcGil9/NKWfzFnT1aFztlDkrdUQ0ZZtOV2CiV7esH5H22Xmyn7
         I8x9VDVOVyR8qkLl2EiyeVM9UKrjp70XzzGv0ida7jfXydvGPQkKuNakTcbDJYRAa3ba
         OzU+PeRVxwc7C/z7WErrokNsdW6hx5UWll1B/AxvzaIe8T/d1CODtehDodvSQS/ntv0Q
         Zaj+ZSQbXHyqyvaeC31FoFXQM4H0VREGzbC+1SKnIpJd6TUeCJn6wAlQunIHHvZcz/nJ
         cMVA==
X-Forwarded-Encrypted: i=1; AJvYcCVUL94NXZpRlUjoxR+bQj/gXSb+4YClE30JZ/8bvfq/TmXS/+zxaeYaISdAxIWtPKkMeCosBuANy62eXgTNEGFh6wCgXmQN3mZOmKYf
X-Gm-Message-State: AOJu0Ywqwkn3vYfhkllzEh/37b6fCPOFz4fF43oJz9t7roA7oxo17bnu
	uG06ypHYJtYIukZAqP9cVezE0jZBEIAIySuuG7X7ssMEdsCNG8XroOSPnC+pnA==
X-Google-Smtp-Source: AGHT+IGDyEFraCKG0HdJyNaPA3O24bCFqx7qZGkZjD64OyRYiu2ACBiTCOFte2RAn/zwJXOBBrJa4A==
X-Received: by 2002:a17:902:e74d:b0:1dc:26a1:d1da with SMTP id p13-20020a170902e74d00b001dc26a1d1damr13203385plf.13.1709852817467;
        Thu, 07 Mar 2024 15:06:57 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:bf8f:10d4:f877:bee3])
        by smtp.gmail.com with ESMTPSA id h19-20020a170902f2d300b001db63cfe07dsm15196654plc.283.2024.03.07.15.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 15:06:57 -0800 (PST)
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
Subject: [PATCH v6 0/5] Match panel with identity
Date: Thu,  7 Mar 2024 14:57:40 -0800
Message-ID: <20240307230653.1807557-1-hsinyi@chromium.org>
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
v4: https://lore.kernel.org/lkml/20240306004347.974304-1-hsinyi@chromium.org/
v5: https://lore.kernel.org/lkml/20240306200353.1436198-1-hsinyi@chromium.org/

Hsin-Yi Wang (5):
  drm_edid: Add a function to get EDID base block
  drm/edid: Add a function to match EDID with identity
  drm/edid: Match edid quirks with identity
  drm/panel-edp: Match edp_panels with panel identity
  drm/panel-edp: Fix AUO 0x405c panel naming and add a variant

 drivers/gpu/drm/drm_edid.c        | 147 +++++++++++++++++++++++-------
 drivers/gpu/drm/panel/panel-edp.c |  73 ++++++++++-----
 include/drm/drm_edid.h            |  12 ++-
 3 files changed, 177 insertions(+), 55 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


