Return-Path: <linux-kernel+bounces-45555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC98843258
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C73AB21699
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2389D20EE;
	Wed, 31 Jan 2024 00:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b="Jo8YtHRH"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C577E7FA
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706662745; cv=none; b=cwyM7m4MbhGDOZkLqWG4McRbPlfM6Mcjc90YO01JHB5YHEyry7HNvdLUsozPY4lTt4/MWz8jr0m196+Yvil1TNOBpogz3Pjg9tuVbKTfvbnOSRyCjnGXIAiSPxVI13nI7VpYJn9Ju6c5imjhlye36GQ67SWXXRrlQXkxxkYhkBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706662745; c=relaxed/simple;
	bh=NyWQpZvyfXiQ1pPODvzBA3Cchx9hEFuF35X+qnan0xU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=GRPp5YxWRIFrbWnWoUoi+ZbqzjtHb+JfexXCEyC3Jp+c/xBavVdE/hJbYlfqttr5YRaVkcIPN+KaJzorz/oPHMJbWrBI06uXVHuKpiPHBUWNTGrUZ3VlRKFjw9TWsHuiNAcTUxyLhncareIRDVvVZ6bz4xM/HNYbeeUg6n8MTRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net; spf=pass smtp.mailfrom=iwanders.net; dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b=Jo8YtHRH; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iwanders.net
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78538f94d00so11450085a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iwanders.net; s=google; t=1706662742; x=1707267542; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BGbVVWmzCS/qQW3OOIkbvYCslK4QZ0cY8oAxDb26lic=;
        b=Jo8YtHRHhNxNI4pom7MaF6nQYJcgjwqwyjhylKjLvNnweaQSVdK8U5eIrvCq7CIpXD
         zvVwrkNAgRfrkZmcPFrFioxwGh74LHm/skF388PFcX4MKVJ5VAsKHuiMY7qiCP4N44N5
         wN4AfrwXLQaWo2fEzB6azimVTO0TP0kUtAWxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706662742; x=1707267542;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGbVVWmzCS/qQW3OOIkbvYCslK4QZ0cY8oAxDb26lic=;
        b=mjdpdw/n+QiuAt5bMX9XiELbGLGStG6akw/SReuIp+xC4pOPeHSuFrojI75b64yf6x
         AwMa51fp5nBpWAZTFI/eEi3qW6i5rHIB2FKBs0riSA1x853CpuBNoEHlgDooCLbPCFDh
         2K9LGGyFfwUUwIWR5PD5lXGOiVzz889116G54NbhytbmKPLkjA5O9aEqo/AtEG/vUH/W
         NPsQaWspLFR5xsGWa2vBU0QTPuNMTjEoEeW+V8CFH7c2Rhn74dje+ZWH/d5PhpaI9Koo
         YEHcYksivWZkaFhyPafr0rXDJHWOY5F0rmR4FcJQFxDGWC3AnJExULRfKjN0jU6R7ilv
         //uA==
X-Gm-Message-State: AOJu0Yyl5zOAAPGusns5Zf9OiBJAb+Ew/pFSJaW9EXvJES/U4ga7XwY+
	nflMTnJilwI2n/SXjBncHRPDln9H2jNALvotMMzXqXDk5zB4dKtHrZZ3o4g7yBU=
X-Google-Smtp-Source: AGHT+IFTwSrfJqR+7Jmkta8hOZECRvc6kWaFJAi00qGGfQmJ5ZyhKGPk8OaRHjxJ5EoI5ngLZw9LYg==
X-Received: by 2002:a05:6214:20c1:b0:68c:5e0d:6a23 with SMTP id 1-20020a05621420c100b0068c5e0d6a23mr237795qve.34.1706662742669;
        Tue, 30 Jan 2024 16:59:02 -0800 (PST)
Received: from eagle.lan (24-246-30-234.cable.teksavvy.com. [24.246.30.234])
        by smtp.gmail.com with ESMTPSA id ld27-20020a056214419b00b006869e0eed00sm4969090qvb.26.2024.01.30.16.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 16:59:02 -0800 (PST)
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
Subject: [PATCH v5 2/2] platform/surface: aggregator_registry: add entry for fan speed
Date: Tue, 30 Jan 2024 19:58:56 -0500
Message-Id: <20240131005856.10180-3-ivor@iwanders.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240131005856.10180-1-ivor@iwanders.net>
References: <20240131005856.10180-1-ivor@iwanders.net>
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
Changes in v5:
  - No changes in this patch.
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
index aeb3feae4..035d6b410 100644
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
@@ -305,6 +311,7 @@ static const struct software_node *ssam_node_group_sp9[] = {
 	&ssam_node_bat_ac,
 	&ssam_node_bat_main,
 	&ssam_node_tmp_pprof,
+	&ssam_node_fan_speed,
 	&ssam_node_pos_tablet_switch,
 	&ssam_node_hid_kip_keyboard,
 	&ssam_node_hid_kip_penstash,
-- 
2.17.1


