Return-Path: <linux-kernel+bounces-167079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADFD8BA434
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62B11F2499D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFE9158DDB;
	Thu,  2 May 2024 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HyK/o+fv"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E977F20B20
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 23:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714693732; cv=none; b=Ta4rbHYpHE6S+d3sN4kGPgo3fNrI1swppxzmZDbZ2tzCMnv9trL1p7bGmOe2rgsp3N6eQ5RbjHm/10Jiv3+QQmRqAEdweLM9ZoUhJTqXAT1YHta3KTFfTaij1irLMweXcjvcL3rSSI+Kf7rDHTq3f76gndLkrEPTQv6nz4+5nMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714693732; c=relaxed/simple;
	bh=KeLfBLVsYKf0NkAsxvwZ2OpoQ4gim0mwaDiykWZFITg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mt2dW/HKGGo6VrKBIjQTuVIsQbU3Kh0N3DTUfG5YjYNj91lu6vgNYcMdzErm2zwfUeBQZl3/0cDEJHCjY7z49ZDJednCjkztEc5ssrKgLUKMcueT9jUoBMbeCmhf2v3Nt8arW/PQHZk6p6y1d6li3AhSZgLJAFcfviwEBe5fELU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HyK/o+fv; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-22e6b61d652so3081554fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 16:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714693730; x=1715298530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RXJmwjLLfXijbHQ77pXOxLke34rf/p881w66RrP7meg=;
        b=HyK/o+fv8KZoTMKle4Ai4nQzzW7yBkNYdK/edP3QmGnm9J3LOysZAO3BROAzKax455
         NbcAbGZXkv9TgCI6j/u/xLMgp5LHYDYZ0hRhH/rWTpq9Qm/yfsNmw0vjvF+yO5/bxKRk
         NRU8Q7yXfnki4vWod6GO3WuQ8pZABPvSoMbvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714693730; x=1715298530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RXJmwjLLfXijbHQ77pXOxLke34rf/p881w66RrP7meg=;
        b=EFKS8ZIVuNY7P6Ah0ksyfbOc2SjrrWhCQB933LOI5AN1ovv9dtVQMpbTA/VQVU5MHh
         tzyKz/CTpurP81RUunC9BFFgvOdd+98TkyCMinJq3Mq16v8fXlThfkyXI0lQ12+6kKaW
         JF6bGfgSSkWaoK6mY9Fp4jqZeVL44LFmen6RyC5dssmkal3Y+HEfEdX3XJo1ttjRrDR6
         miU/qB0htQN/BVqfsd6S/PJ2PCsWWqi1nUCtBrmAXMzpTvDD23lkuiAsogT2sjD6s6El
         UQFrtf2G+vRJVT6FF4LnLn62PtCZ7BwTVGh2Ks1SkbtjXt4M4e/j5CM+e0z3FIa5rY10
         hOWw==
X-Forwarded-Encrypted: i=1; AJvYcCUS2xuqYAQ9zvnc+dYUHXu4ZBsMkdjTfO7RjgkdtKZGpIewibtD6jgYJZijLtvpZe8NfuV0J/1bpBV0GuUgZLWIUu9+u6XJHdZNHXgW
X-Gm-Message-State: AOJu0YwGjRoRNaKjpHmVzC8LGyG62mnpkcTBcmEEFsixzTsBiaHScGpm
	2dXIPfp4VjeVG2ks+NxPPPN8FLjjV4VzwRileqe+aAVCa4iuAZGO9mksbIe44Q==
X-Google-Smtp-Source: AGHT+IFOZOl17eOR3MtgDxnITFsr+fNeEqGSZ1NUEfGyThSYh+x1eXFaCgEw/AFQ2TIdvCrRkI9+QQ==
X-Received: by 2002:a05:6871:33a9:b0:23d:4124:457b with SMTP id ng41-20020a05687133a900b0023d4124457bmr1507565oac.36.1714693729999;
        Thu, 02 May 2024 16:48:49 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:d58d:52de:fc6:7f45])
        by smtp.gmail.com with ESMTPSA id o18-20020a639a12000000b0061ce6606203sm181355pge.58.2024.05.02.16.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 16:48:49 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: Hsin-Yi Wang <hsinyi@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel-edp: Add ID for KD KD116N09-30NH-A016
Date: Thu,  2 May 2024 16:47:47 -0700
Message-ID: <20240502164746.1.Ia32fc630e5ba41b3fdd3666d9e343568e03c4f3a@changeid>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As evidenced by in-field reports, this panel shipped on pompom but we
never added the ID and thus we're stuck w/ conservative timings. The
panel was part of early patches but somehow got left off in the
end. :( Add it in now.

For future reference, EDID from this panel is:
	00ffffffffffff002c82121200000000
	321e0104951a0e780ae511965e55932c
	19505400000001010101010101010101
	010101010101a41f5686500084302820
	55000090100000180000000000000000
	00000000000000000000000000000000
	000000000000000000000000000000fe
	004b443131364e3039333041313600f6

We use the ASCII string from decoding the EDID ("KD116N0930A16") as
the panel name.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 6db277efcbb7..9cfa05c7d193 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2094,6 +2094,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('K', 'D', 'B', 0x0624, &kingdisplay_kd116n21_30nv_a010.delay, "116N21-30NV-A010"),
 	EDP_PANEL_ENTRY('K', 'D', 'B', 0x1118, &delay_200_500_e50, "KD116N29-30NK-A005"),
 	EDP_PANEL_ENTRY('K', 'D', 'B', 0x1120, &delay_200_500_e80_d50, "116N29-30NK-C007"),
+	EDP_PANEL_ENTRY('K', 'D', 'B', 0x1212, &delay_200_500_e50, "KD116N0930A16"),
 
 	EDP_PANEL_ENTRY('K', 'D', 'C', 0x044f, &delay_200_500_e50, "KD116N9-30NH-F3"),
 	EDP_PANEL_ENTRY('K', 'D', 'C', 0x05f1, &delay_200_500_e80_d50, "KD116N5-30NV-G7"),
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


