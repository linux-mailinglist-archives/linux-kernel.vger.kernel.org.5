Return-Path: <linux-kernel+bounces-54017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E2584A946
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018F11F2740A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C685A1AB7E0;
	Mon,  5 Feb 2024 22:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZ01epSG"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7331AB7E7
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 22:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707171975; cv=none; b=sl2wxbKiYCn3RjexoJH24RX2TIjRk1HMzPqAGUVU9SHdziVhq+qUq2c8tpw4LfWZJJdXj9egE4369uNe68TEvKaUzGfaSHU/vziRRd6w53jLt+JTwBvIjQynDJhbXcoMsotMDlJSlnnflFM0IaYvjYXdaXeiXF/2DI0nLRVzVlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707171975; c=relaxed/simple;
	bh=r4t+x7jJOA5L4WJ872y/4vHQsmSNBzv1hPgvnAix4es=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WYM3CpDDfQLNPhywk0KBTfkDay5UBNKgide+ex7wcCUHLoLUD28hqKSnII93wy1TXtFzqMkSXm4Q2cNIlooAFWW1qkzTiRfv7zuw+xrIOCe/0j4U+Yf1lPEwtLMKgkPzI8DYCXDJdFQw4+Xjaomh9n82tgA8pj5GzKAGHNYFLoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZ01epSG; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a35e65df2d8so661019866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 14:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707171971; x=1707776771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jMW5wdmb5flI6vLFVtqD4Jumk1xc51o3V0jyjgs8wnk=;
        b=CZ01epSGuqppWQRrXM82e2ZnZC2WVsPtHcE+m26pnfr0QWW/r06HWuLB/H6iT9gxgG
         CI97Mnls00roRZL/4V9c8qlW+DS93/mQZATdLBMgaXpljcAsaVpn0l44TIGjAG2s2s1l
         C4nnv8Xv2zKrgIBVzDNOM9MHj7TpSRCeynPwqW4z8yxCsE4TcBrn5r+tsrKSLUHbwdp0
         vJ//RGYjT4Qjr0rOMKTh4tJH8tam+dVkIGWdT3h9JgIT5m4PT+hHK5+DOxstN6E6YGc3
         KVAlFBU8k0KSsBcCUad45kjpEZ+Qs5GRyEsYNGJ+jYyK7p33HNUaGIxu5qcyaBX7+qdT
         Rheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707171971; x=1707776771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jMW5wdmb5flI6vLFVtqD4Jumk1xc51o3V0jyjgs8wnk=;
        b=TzikC460mq5t4aa1xoWrUSjgpFA2PEQo1lWuNDyjwE0Au0t2x8YtiuV7PXqVpBPXZw
         DsKUMLhksQvlNnKtjINFIBqTUkAJPHILQzbi/W184J2dBvU06tvZhX7YJHORXXuWPtgd
         TxEZaiHhETwGA3qJ1HEOMnXHMnk+HIOZVysjpv58g5xay3+HYrb9hV9eZKTqwICcoI3Y
         q9IB3+eu7Rsug0vfUhCjCHreyu3/m2WA8DO2phIwNuLVH1TQX3MYyrqdEZuG5Q7SR/yP
         /BmfjncGYsnub31Dz494Z+C4vcJ2hSu8jtfl0keuA8URw+UExRuWnExJPZwhoOSMJgr5
         fYyw==
X-Gm-Message-State: AOJu0Yx7GRSJxNSu3FHPDAfZffIG4zkqOizM19D8i2iNzh2gMNacYeED
	ORCUUXUvV2QpTHhxe6WwkVOJ7f/7h0+gu8470iALdB85t0TKGSZo
X-Google-Smtp-Source: AGHT+IE/FqKYit9aohk8It1ZTAaSm0WfL91R5trg6gCGqjVzKZedXq10IDnGZY0XorSUy746CCXy8A==
X-Received: by 2002:a17:906:41:b0:a37:1e9a:c549 with SMTP id 1-20020a170906004100b00a371e9ac549mr416602ejg.49.1707171970972;
        Mon, 05 Feb 2024 14:26:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWX1EJyOYmTktMLnOdtloZGXokcxAyu3WHr/pSCnNXGDP+u+5T+eARTd8bTkDCc+RgrBa7kMgodQb1VQsYp0eTIxpGDCk5XhlWCba98EHKTr9HwOnXCbCx/Y1bIqWQWlSqBFHnIuULyU5sFbWF/h0Ao8yiT6n7DDwr75M88OSIaZkZz0HpmjycbUU5xsIAVKcFEzn8X9qKfx1NkKzSJxsnJyh7Kmu44hdz5MgACwWplMEN8u77SsWd0e3I=
Received: from localhost ([2001:470:5139::819])
        by smtp.gmail.com with ESMTPSA id x12-20020a1709065acc00b00a3793959b4asm325169ejs.134.2024.02.05.14.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 14:26:10 -0800 (PST)
From: cubic2k@gmail.com
X-Google-Original-From: tjakobi@math.uni-bielefeld.de
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm: panel-orientation-quirks: Add quirk for Aya Neo KUN
Date: Mon,  5 Feb 2024 23:25:56 +0100
Message-ID: <20240205222556.299481-1-tjakobi@math.uni-bielefeld.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>

Similar to the other Aya Neo devices this one features
again a portrait screen, here with a native resolution
of 1600x2560.

Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index d5c15292ae93..03224f8860ce 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -196,6 +196,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_BOARD_NAME, "NEXT"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* AYA NEO KUN */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+		  DMI_MATCH(DMI_BOARD_NAME, "KUN"),
+		},
+		.driver_data = (void *)&lcd1600x2560_rightside_up,
 	}, {	/* Chuwi HiBook (CWI514) */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
-- 
2.43.0


