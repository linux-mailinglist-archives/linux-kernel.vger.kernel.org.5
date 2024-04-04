Return-Path: <linux-kernel+bounces-131215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBD08984B3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D6E2832CC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B35D74C09;
	Thu,  4 Apr 2024 10:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a8wvQ7vr"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8748F7D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 10:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712225291; cv=none; b=TaYKAnSDdo5ZYLipwbQkXE8KitIbw0P8WFXheUOIQfDeRh9iiTIQtNzIb8nObj8PG7Wee4X+W9WD04HHBu3EDPQSluBoxdyHfNgZhi84C59rwUtAXlFEfrDy2/mPRpCXSwnLQnxDsLHPb0GtYvXoxkJg3iq6A4HDfwdFRcTxau0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712225291; c=relaxed/simple;
	bh=Du46wueKWvwkNxb//bx6Oplm8RijccGjLPvLCDL3hio=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IwN9nGLRCpXOOniffpj2sJZJMOUg1pxYmYO9da+WwqNrJxGwHfh5x80JkZHPwxc54sr6+5WKtFQmJJlrRVFtDtZWhS8+Qck3D28MRFvChH3g5Xrak755gU9I4epgW/3BJe86diFAB64+iHNx3d6EV33fx/s9ztONjd+86vApwuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a8wvQ7vr; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56bf6591865so1135366a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 03:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712225287; x=1712830087; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qmPmdTR9ZwPxhvP2c4bgI17aKaTHU1vV+VtVIiuiDB4=;
        b=a8wvQ7vrpD19l4lBjBddTtRx+2Rh97pYKuZq+OuFi5sHKk4UmyJIPsnTkQKnr7fW5V
         jwhhA69m7pDAaWF2odzTz6nCMwW0ogLJ18zLOzOnkK5bfC38QyRaUbs8oX4wHJc07jhQ
         mzTSR88oPkH3NacYJkS9VBZYtBhCYAuaM0hBFntJpWX0QIeorOrtHDVpU07SHZRnLcKm
         bJFGuRbJBVSLuRSv0ONdWApyCLlgw/vERJ6bZImiP99r32yyKBWRi0Sl7pAHnv9qmiuL
         N31YP7xThQrMk0vRmkLoWHoz662oTYaBWWgYFIms14akch+q4WCA48h6wRhInTDdu+km
         tdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712225288; x=1712830088;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qmPmdTR9ZwPxhvP2c4bgI17aKaTHU1vV+VtVIiuiDB4=;
        b=HaJTxaoNXLZVLDfYnxvhwKSF5PZUPBRLmJluRU+EhCsWMhklEKMi/0xa7i96eVxnuD
         of6xa1AOcO0tB1KbO8f4Byp2MJvNPKWlVvXXaeycjrnoUynXe2vQdYF4KAcnLEgEqTp3
         hAOgXxn3Ejc60JV1EXmQHm9G++saHbIP1384hNsW5a0dlK3cP5i/ASs0FZkZA9z4LFoF
         iL/wnMzTauv0TAXtzom6RarqWg1og/RI3c7w7JXqVo9kqo3YuDDcITpMYMz6KEPxLQS3
         Wgm40Sz0U9+ke+oRAjDKazA9RxOfkwIPg7eyMbN6JfIN9s1MkrgcHNwyg4KWYgoUkc9h
         0ENw==
X-Forwarded-Encrypted: i=1; AJvYcCUqmit1W32dN2V7WK3i8+5XsGSbKEoLpS35VU4Q3839DEyauqW5ppAtR/Z1P4HdOMwUObEPenfFv6C7xav17GnSXbKqofz8BfNIAizW
X-Gm-Message-State: AOJu0Yy4YcltdHcxDL8o7VG7yOIWxYXoongiHsvlHON0ajHcacctPtTN
	aT1jSM84eCoaCRfKVfvihoEdsDXWZbDatW+e8Q/R1A/34wBDM2HmJDNZ72AdT6k=
X-Google-Smtp-Source: AGHT+IGH9QuL6NMx64raNLiACxvVKWuZIeX2HIIWXh2fepAfblZYgtSLhQDB19KMz0mESLgiFnB8Hg==
X-Received: by 2002:a50:9b1c:0:b0:56d:ece8:a5e8 with SMTP id o28-20020a509b1c000000b0056dece8a5e8mr1463406edi.14.1712225287519;
        Thu, 04 Apr 2024 03:08:07 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id ig10-20020a056402458a00b0056c0a668316sm1984219edb.3.2024.04.04.03.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 03:08:07 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/6] drm/panel: small fixes for visionox and novatek panel
 drivers
Date: Thu, 04 Apr 2024 13:07:58 +0300
Message-Id: <20240404-drop-panel-unregister-v1-0-9f56953c5fb9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP57DmYC/x2MQQqAIBAAvxJ7bqFCivpKdBBdayFU1opA/HsSc
 5rDTIZEwpRgaTIIPZw4+Cp924A5tN8J2VaHoRtUV0ErIWLUnk68vdDO6SLBSSk9O6t6Y0aobRR
 y/P7fdSvlAyplgMhnAAAA
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Matthias Kaehlcke <mka@chromium.org>, 
 Harigovindan P <harigovi@codeaurora.org>, 
 Ritesh Kumar <quic_riteshk@quicinc.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1356;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Du46wueKWvwkNxb//bx6Oplm8RijccGjLPvLCDL3hio=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmDnwFB4ymGew9A+j+lPaxjOF+3+3RraubF85ot
 OjFFlmnjvmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZg58BQAKCRCLPIo+Aiko
 1T43B/99SNedkXIzKq81LkZB/eLv5u0TTihQz/8l+QHHCWt0oOkMNGJ1OiuTLDr+ToE8FUWE6MR
 GuVpa19gteiQWaMoOMLaUlGG+yLtiytO3n9DtqRDSEdkeWshqiEW+YdN1Ur8opJZEYUlmnfPYcb
 uSQWI9uSHpch7sZk7im8Xu6b456C+r3slCqiLotvjlaHZ26ghhwV9M05njsLLcxzq1lwRlYMI3y
 XO9wtiu8lczQFupCgCRVuVAHl90JotvyLoC3RV5Vq8qdCEn/L5Cqy/GGdyzttgNeJkZ9PO78HVz
 nze2WXDRUaOPJYEP92kgYo/dSUBocbb3MZ93en0qQFGV7oXr
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

While taking a glance at the novatek-nt36672e driver I stumbled upon a
call to unregister the DSI device for the panel, although it was not the
panel driver that registered the device.

Remove this call and a similar call from the visionox-rm69299 driver.
While we are at it, also optimize regulator API calls in these two
drivers and in the novatek-nt36672a driver.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (6):
      drm/panel: visionox-rm69299: don't unregister DSI device
      drm/panel: novatek-nt36682e: don't unregister DSI device
      drm/panel: novatek-nt36672e: stop setting register load before disable
      drm/panel: novatek-nt36672e: stop calling regulator_set_load manually
      drm/panel: novatek-nt36672a: stop calling regulator_set_load manually
      drm/panel: visionox-rm69299: stop calling regulator_set_load manually

 drivers/gpu/drm/panel/panel-novatek-nt36672a.c | 11 +++-----
 drivers/gpu/drm/panel/panel-novatek-nt36672e.c | 35 +++-----------------------
 drivers/gpu/drm/panel/panel-visionox-rm69299.c | 18 ++-----------
 3 files changed, 9 insertions(+), 55 deletions(-)
---
base-commit: a6bd6c9333397f5a0e2667d4d82fef8c970108f2
change-id: 20240404-drop-panel-unregister-744a9fd41cc6

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


