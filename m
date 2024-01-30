Return-Path: <linux-kernel+bounces-45445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C57BC8430DD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE3D28605D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C668678B71;
	Tue, 30 Jan 2024 23:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b="IDFVj/lk"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851257EF15
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706656030; cv=none; b=QoSFS4KwgoclnptJhq7ii3SjepqrB+Zvmp6HrvnQrULNtnTLVFXvryiBdv/vGjqgILCGTtpo85ozjqXCA/g3pE+KpooGFdl7GHUJUdT5Wv8aY7cGhtNxyol4VZLoyBkgr/vzWzLrt3BOC+c+tGL+CxvhkhRpt14emgB2vF+4tVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706656030; c=relaxed/simple;
	bh=NQbNim9Kl9w3hMZilkX8mghToO2vPsILhxHQxKtN3Mg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=DVyYi5WJgJHae113akpxiYK9eXcGEkyGbI2KjEJY1T8kg+PRV7cBMn0UAiCsExMZFHRbFXpgiJDFTrpkawlFWT0uh1UaoCtPdOEkp1T7gggzZ4l2O4CNoSH4Uo55uZojr2VgL7GB/6VI150MwG4FX7NQMcW1fxy5YYDlzQDtLM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net; spf=pass smtp.mailfrom=iwanders.net; dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b=IDFVj/lk; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iwanders.net
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5ffdf06e009so44963557b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iwanders.net; s=google; t=1706656027; x=1707260827; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XyHH5Unq92X0kSKpyQantcGDB1tT8ugB/3UImkmNwAE=;
        b=IDFVj/lkAES27SD7y2PE+Akuu1uEcLvjm1pV7PsKvh1mqDPmiEnZqXYUtViiNbR7l6
         VDkXTTkz0Hqx7eTMM9pDE91rV5p8KBew1Od+J0ZCzAfw4YA8HU+I5S/u1Wo3eAdTFrEd
         PEypRiIv+MaBGxLu4FRZv7keu2qR6yQ/Lzbxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706656027; x=1707260827;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XyHH5Unq92X0kSKpyQantcGDB1tT8ugB/3UImkmNwAE=;
        b=Q8utxlLbYfdFVQh/Pw7plazYl1DPA5qjRlcc38gE38uUojLaLL6Kx3ZSS/7Dm3VV7k
         17nQp34O7VhfZ8yteV1pWNE+pLYI00AKJUduzjMJQNobaEyv0KGSgOR970ueEbyhhM1v
         oX685cFby5X6ze1i70aybgRrWocXitbtZ+S6lDD6Itqh/6gWYSi52PHEvC+Z+/9TbJ+H
         BGaypUcvoZdVUCbovphvR+BxgPQeR/Pfoapusl2Uxwp5iiBPZCCveBDA/vAm7BtEZPm+
         Nzo9PHoHoLCXfVxVkHlzkd62/kcEv4uTZRwHkDSrXUk7y7p9MOOLsdKjZbixkrkWDD4m
         CbyA==
X-Gm-Message-State: AOJu0YxKk9OpTdXHaFrlBnqm+K7jkhpuohVTUI8D0mrVMXy/O01//xZf
	h0qzDACWg1gpjxlNxwPkUAfgE3HaoEbL9osRDD+QGcCSgnJveJfunSnavib3SaQ=
X-Google-Smtp-Source: AGHT+IEQXgQHf7sprO3/WcC9qBEGZ9XfRvNABgddgUIxPgQY3kLczs49/FKD+DKLZeQpM6lMZetBhA==
X-Received: by 2002:a81:eb0e:0:b0:5ff:6084:421e with SMTP id n14-20020a81eb0e000000b005ff6084421emr7017803ywm.32.1706656027480;
        Tue, 30 Jan 2024 15:07:07 -0800 (PST)
Received: from eagle.lan (24-246-30-234.cable.teksavvy.com. [24.246.30.234])
        by smtp.gmail.com with ESMTPSA id di8-20020ad458e8000000b0068c47832171sm3081275qvb.65.2024.01.30.15.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 15:07:06 -0800 (PST)
From: Ivor Wanders <ivor@iwanders.net>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Ivor Wanders <ivor@iwanders.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <markgross@kernel.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 1/2] platform/surface: aggregator_registry: add entry for fan speed
Date: Tue, 30 Jan 2024 18:06:53 -0500
Message-Id: <20240130230654.4218-2-ivor@iwanders.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240130230654.4218-1-ivor@iwanders.net>
References: <20240130230654.4218-1-ivor@iwanders.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add an entry for the fan speed function.
Add this new entry to the Surface Pro 9 group.

Signed-off-by: Ivor Wanders <ivor@iwanders.net>
Link: https://github.com/linux-surface/kernel/pull/144
Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
---
Changes in v4:
  - No changes in this patch.
Changes in v3:
  - No changes in this patch.
Changes in v2:
  - No changes in this patch.
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


