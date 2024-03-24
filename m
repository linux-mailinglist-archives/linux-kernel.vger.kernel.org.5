Return-Path: <linux-kernel+bounces-112543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF2F887B58
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 03:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15EC0282311
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 02:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1D81870;
	Sun, 24 Mar 2024 02:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=g.clemson.edu header.i=@g.clemson.edu header.b="VZr0rH21"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665E181E
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 02:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711245930; cv=none; b=CVd2fZnKjNaecUCAh4J1whMA1J7cGgP8sfrsmwssk5v1MeQNLs/P8A0ruk9jckFZeBWeccXo4jwl2Zkp71sF9Xe9Tx7rwT4yEAJ3yK3telV6bC9XO/3siI1VHU+GFabo3uNLbRinQ8JcXNLl+BXjvaHAdFQgAlYvBMBAdqrtqgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711245930; c=relaxed/simple;
	bh=ybTg85mjv+LEvjlcKRegRL+Mb2Zd2etxoHxcXa0N06U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c/XLVPzv1kGnpQwb4qt5/D+rWQj5TYATxcG2X98Y/XBz3wgbA/0iDGY+cFO60dEfrNSmfNofYjD3KrAw4td98Xu3ST8grjBMFbVt+at1yMtk9cHm8gOtxVDjliquoVtj/x1d2ZH/gMowDVcUiKFM2qmzCnOe5iUAqJ9wvhO4tVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=g.clemson.edu; spf=pass smtp.mailfrom=g.clemson.edu; dkim=pass (2048-bit key) header.d=g.clemson.edu header.i=@g.clemson.edu header.b=VZr0rH21; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=g.clemson.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.clemson.edu
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-60a0a54869bso27072407b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 19:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.clemson.edu; s=google; t=1711245927; x=1711850727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/3eJdLTiaJ5WbBvAcx/Ng3C1DgyvhQmSTdGW5VESX1g=;
        b=VZr0rH21K8qRrqm08uveka61blTSB4kFdUB01TdJlPnkiGut4levpDN8oAW26Q3cNR
         ldS3+I2p6WOfm8Ls/1bMcz2fxM0kmXBIXwHEQqwcdEnlj0+/rXFogMYmLjdjbqkOf+ks
         SyQTfQYiXVAtKONQVbCHInA9xE/slPzkGB5jBJBkBB7uDwHlHOqImtgKrqK3J/KrtpJA
         YtXAJTeZCbNvEAg3L3eOEcM12a+11Urzb3snvShaKff0qHX9TU7/v5ffVu8XuHQsNMHb
         Iz30qB4MpxSHWg6PyD8Msr42/MR9RhzIv9IU1stgX3QucKHRhPG8YClCbr9gy7FlB+fY
         oW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711245927; x=1711850727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3eJdLTiaJ5WbBvAcx/Ng3C1DgyvhQmSTdGW5VESX1g=;
        b=kk5fIo7LZwNoS25TW17cSgTs/xvrKXG21LjTn4YASZ2fKVkq9IvOPk5NmR3ovUJQUl
         kZ4NSXUwj7Fcyp7iFTraOElN/DXv06psLuS2KPo26CJR5wLYPn/Urpvi1Q88vBkfL34E
         s07OzYZpfDAMHhksKlYQwYaWFTNLNhFSmE0+y5GWIauReEDP98A4VM6RRyzjyfRU3l0+
         7qjGiKFm0xmJEsH0AB56fjzmGCG6nmftdMTxw33H4G0dLMX4kBTmomjFBLeh8Le4rYWG
         stlFPvJghUyEof376zSxiUJ0fffD9yjK/pubXpJ8dfDNbT+qyvvgVpxuwPHqkPOZSGg1
         YQGg==
X-Forwarded-Encrypted: i=1; AJvYcCVb7go+aZrovi/+x1qXK1C/Y4ae4h7NOAC3ZOwnsxXT3bqUpsUFLDWA0glxQ98UvhEPnJ6PiWGsmckSU4g6G6qbxPp2YPHSsZJyzzKJ
X-Gm-Message-State: AOJu0YyZzk9g1F+Z1K/Bg/WnQ8AUz5Geu3W8ceoOW7IaKwD8CazM+NwX
	U2jHUymZOR52dMZf3iEKLAIr1d1Ryq1leDfs3CCy0BZewnFRyTqYaEGKTRfvky2unEO0a8lBZUE
	nDA==
X-Google-Smtp-Source: AGHT+IH7bshBEpXrBz6f2reJsiz2RhBfp0ItfogGGdyRW9iUolZWkHGVZWa0gAFa4N3dG6Moby7prA==
X-Received: by 2002:a05:690c:6c07:b0:610:d7a7:43cc with SMTP id ir7-20020a05690c6c0700b00610d7a743ccmr1641236ywb.19.1711245927372;
        Sat, 23 Mar 2024 19:05:27 -0700 (PDT)
Received: from mephi-laptop.localnet (130-127-40-81.lever.resnet.clemson.edu. [130.127.40.81])
        by smtp.gmail.com with ESMTPSA id g2-20020a815202000000b0060a08edc81dsm518716ywb.4.2024.03.23.19.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 19:05:27 -0700 (PDT)
From: Emilio Mendoza Reyes <emendoz@g.clemson.edu>
To: neil.armstrong@linaro.org, dianders@chromium.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject:
 [PATCH 2/2] drm/panel: Promote warn_dev to WARN for invalid calls in
 drm_panel.c
Date: Sat, 23 Mar 2024 22:04:47 -0400
Message-ID: <2388112.ElGaqSPkdT@mephi-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

From: Emilio Mendoza Reyes <emendoz@clemson.edu>

This patch is the second of a set of two.

In the kernel docs there is a todo:
Link: https://www.kernel.org/doc/html/v6.8/gpu/todo.html#clean-up-checks-for-already-prepared-enabled-in-panels

The first patch addresses removing the duplicated code. This second
patch addresses promoting instances of dev_warn to WARN as it is an
error in other code for these functions to be called in the invalid
state that triggers the checks.

Signed-off-by: Emilio Mendoza Reyes <emendoz@clemson.edu>
- ---
 drivers/gpu/drm/drm_panel.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index cfbe020de54e..0b7602c8b387 100644
- --- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -114,7 +114,9 @@ int drm_panel_prepare(struct drm_panel *panel)
 		return -EINVAL;
 
 	if (panel->prepared) {
- -		dev_warn(panel->dev, "Skipping prepare of already prepared panel\n");
+		const char *name = dev_name(panel->dev);
+
+		WARN(1, "Unexpected attempt to prepare an already prepared panel by %s\n", name);
 		return 0;
 	}
 
@@ -162,7 +164,9 @@ int drm_panel_unprepare(struct drm_panel *panel)
 		return -EINVAL;
 
 	if (!panel->prepared) {
- -		dev_warn(panel->dev, "Skipping unprepare of already unprepared panel\n");
+		const char *name = dev_name(panel->dev);
+
+		WARN(1, "Unexpected attempt to unprepare an already unprepared panel by %s\n", name);
 		return 0;
 	}
 
@@ -208,7 +212,9 @@ int drm_panel_enable(struct drm_panel *panel)
 		return -EINVAL;
 
 	if (panel->enabled) {
- -		dev_warn(panel->dev, "Skipping enable of already enabled panel\n");
+		const char *name = dev_name(panel->dev);
+
+		WARN(1, "Unexpected attempt to enable an already enabled panel by %s\n", name);
 		return 0;
 	}
 
@@ -246,7 +252,9 @@ int drm_panel_disable(struct drm_panel *panel)
 		return -EINVAL;
 
 	if (!panel->enabled) {
- -		dev_warn(panel->dev, "Skipping disable of already disabled panel\n");
+		const char *name = dev_name(panel->dev);
+
+		WARN(1, "Unexpected attempt to disable an already disabled panel by %s\n", name);
 		return 0;
 	}
 
- -- 
2.44.0

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQTcaZbABwnECYA0cZI0LAN3EqikFgUCZf+KPwAKCRA0LAN3Eqik
FgImAQCqtDgta8+cyU8aAaWN2QTflyiHrNWqB1YmPkVggV1xSwEAx6Ge9YOH7vNL
hmew94ipW21OuQzIeHtSjLpqJ5Creww=
=aLEl
-----END PGP SIGNATURE-----




