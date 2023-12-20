Return-Path: <linux-kernel+bounces-7646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FE981AB32
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671411F2391A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03218487B4;
	Wed, 20 Dec 2023 23:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b="MvZsqubi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091094B5A4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 23:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iwanders.net
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7810c332a2cso10125585a.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iwanders.net; s=google; t=1703115872; x=1703720672; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nrgGbTq/7alvn7tUkOLEl/Ay2Qdm+WISS5BQ99Qmp7o=;
        b=MvZsqubi4NCS0qILkl8aNPYcC1tnIQK4fJPfNE/x/H8ve/b/KUVMB3HATG1lcGDX3T
         A44hrB2c8jD8bNgPHh7RwDOwNL/OPqnp0Kok4XOp6SFTG1nSrce4zZFqr4p2hHqD+8np
         uIiJBvbssesWXnn71hqKqD3pMx3dwjPTA/IBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703115872; x=1703720672;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nrgGbTq/7alvn7tUkOLEl/Ay2Qdm+WISS5BQ99Qmp7o=;
        b=NSxVM2h5weqnFS9BpGTkDIK9v4kbIPVAYAs5X3mTVR7/rmeGYMIs3UCbEsj8SPm4rh
         RR2jLPHw5GLBS4pMm6MFMZ5vj6KtfnvTeOICBPJvnu9Rc8U8VEGhzxx5FtWKNBdgHewU
         RlMUz7FgDA2QgadZcBoIctLup9waegpCqmyXHGR/4HHuh2KTrKdp4H0fjn8PVTzma02O
         ks4mKTOrXOFbNpmbioucoOVUrg0ESJsqRQvjikyzjkGVMY7egnVxwuqgkPQtGQ9OC6Uj
         nUqFiseiVxd8zU4gROeHKsuUVEkNgmq5VPqdIp3+pqW7+VgC6/rkCoE/U3dN7chNlhEO
         ZiGA==
X-Gm-Message-State: AOJu0Yz4+f6mFYSbvEh9j20B743f/cl/0oHwVYNqR5ben8amfmg5lESh
	kxqFEHPwQZ6oO4dr5O9PhmdUDw==
X-Google-Smtp-Source: AGHT+IE3mnbXYY/nAdLtGNS/SfwuPbXr2bUC/Hd+VfVmKU55oZs61zsWcSf7zbWPYNHya8GFXHEk3A==
X-Received: by 2002:a05:620a:2232:b0:77f:40e3:422b with SMTP id n18-20020a05620a223200b0077f40e3422bmr21247778qkh.131.1703115871929;
        Wed, 20 Dec 2023 15:44:31 -0800 (PST)
Received: from eagle.lan (24-246-30-234.cable.teksavvy.com. [24.246.30.234])
        by smtp.gmail.com with ESMTPSA id qj6-20020a05620a880600b0077f1645282csm276742qkn.22.2023.12.20.15.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 15:44:30 -0800 (PST)
From: Ivor Wanders <ivor@iwanders.net>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Ivor Wanders <ivor@iwanders.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <markgross@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 2/2] platform/surface: aggregator_registry: add entry for fan speed
Date: Wed, 20 Dec 2023 18:44:15 -0500
Message-Id: <20231220234415.5219-3-ivor@iwanders.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231220234415.5219-1-ivor@iwanders.net>
References: <20231220234415.5219-1-ivor@iwanders.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add an entry for the fan speed function.
Add this new entry to the Surface Pro 9 group.

Signed-off-by: Ivor Wanders <ivor@iwanders.net>
Link: https://github.com/linux-surface/kernel/pull/144
---
 drivers/platform/surface/surface_aggregator_registry.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 530db4db7..b0db25886 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -74,6 +74,12 @@ static const struct software_node ssam_node_tmp_pprof = {
 	.parent = &ssam_node_root,
 };
 
+/* Fan speed function. */
+static const struct software_node ssam_node_fan_speed = {
+	.name = "ssam:01:05:01:01:01",
+	.parent = &ssam_node_root,
+};
+
 /* Tablet-mode switch via KIP subsystem. */
 static const struct software_node ssam_node_kip_tablet_switch = {
 	.name = "ssam:01:0e:01:00:01",
@@ -319,6 +325,7 @@ static const struct software_node *ssam_node_group_sp9[] = {
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
 	&ssam_node_tmp_pprof,
+	&ssam_node_fan_speed,
 	&ssam_node_pos_tablet_switch,
 	&ssam_node_hid_kip_keyboard,
 	&ssam_node_hid_kip_penstash,
-- 
2.17.1


