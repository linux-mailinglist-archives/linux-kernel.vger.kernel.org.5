Return-Path: <linux-kernel+bounces-4885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9F581834D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DD0AB23675
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65CF11725;
	Tue, 19 Dec 2023 08:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CzdXGrjQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C875813FE9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 08:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3ba0dfc9001so1464456b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 00:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702974461; x=1703579261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d9mjWg+9jf9K26duFvN0uz9/tUf2ZAojSB2YpAHDwss=;
        b=CzdXGrjQx6F3XNhX/hDSAzQS0jExVqdRjZcnD3z3uFj74gTpAiq6wIPlniLZ+wgXh8
         /GhIrem+FCyEHkluU4keYQ6iukBQZgp+BrrfLA3Ft9CLAWzILURybM7p1IIDa05F0F/O
         sKIC6OFkpt3POSdBZhOMphSK/RGin8zl4UTZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702974461; x=1703579261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9mjWg+9jf9K26duFvN0uz9/tUf2ZAojSB2YpAHDwss=;
        b=VhoOD64m2UnfHBU3adENDMCqXDPkuJzywgmae/mN4Ud884phtL+GjKm76WGVPQVPUf
         WyOQi57wQC8lyMc3y+04OoTclbn5IvqaSdn347805TvICa4Lcj2AEKYHLxa+IYq3pmbM
         FaoHhjtmAAkkrsZ7krldLPH46Bc0W0MYrBuNVBYKcDj0szfpIL8tKKt/KolpWY90/eDs
         1rrnhxiPVeeCJLRS3f5YmkUa/iFamjSqjUGQPCQ6h7x9LagQltWhynp9gdR6IBIJ4KrD
         aZJFC1rgDSlxieRVTDS+u0K8ZDNSwbUiQ0OgWftJSFa38Mc0O84Wd8QHVHM9hWvjd8+g
         TIcA==
X-Gm-Message-State: AOJu0Yy4JfvqYYJ9cIeLCPWIHOi1JGdkkKadS1b8EosiMlOoejqHQnRJ
	ygLj9zPjBRYIWmRvCzXL1KImBA==
X-Google-Smtp-Source: AGHT+IE/rlWaZhIZsk9W2/LEBbaDvPfz7GUTydXmHDziltIOSmDwM7Hz0QYY4u8OBHGRZO0I5Yl0Ng==
X-Received: by 2002:a05:6808:bcf:b0:3b8:b52b:5b65 with SMTP id o15-20020a0568080bcf00b003b8b52b5b65mr13762331oik.59.1702974460935;
        Tue, 19 Dec 2023 00:27:40 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:a1d9:66f1:da29:6b6b])
        by smtp.gmail.com with ESMTPSA id e8-20020aa78c48000000b006d7e67d2e74sm2930644pfd.32.2023.12.19.00.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 00:27:40 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal/core: Correctly free tz->tzp in thermal zone registration error path
Date: Tue, 19 Dec 2023 16:27:24 +0800
Message-ID: <20231219082726.844508-1-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal
zone parameters structure"), the core now copies the thermal zone
parameters structure, and frees it if an error happens during thermal
zone device registration, or upon unregistration of the device.

In the error path, if device_register() was called, then `tz` disappears
before kfree(tz->tzp) happens, causing a NULL pointer deference crash.

In my case, the error path was entered from the sbs power supply driver,
which through the power supply core registers a thermal zone *without
trip points* for the battery temperature sensor. This combined with
setting the default thermal governor to "power allocator", which
*requires* trip_max, causes the thermal zone registration to error out.

The error path should handle the two cases, one where device_register
has not happened and the kobj hasn't been reference counted, and vice
versa where it has. The original commit tried to cover the first case,
but fails for the second. Fix this by adding kfree(tz->tzp) before
put_device() to cover the second case, and check if `tz` is still valid
before calling kfree(tz->tzp) to avoid crashing in the second case.

Fixes: 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone parameters structure")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
This includes the minimal changes to fix the crash. I suppose some other
things in the thermal core could be reworked:
- Don't use "power allocator" for thermal zones without trip points
- Move some of the thermal zone cleanup code into the release function

 drivers/thermal/thermal_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 2415dc50c31d..e47826d82062 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1392,12 +1392,16 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 unregister:
 	device_del(&tz->device);
 release_device:
+	/* Free tz->tzp before tz goes away. */
+	kfree(tz->tzp);
 	put_device(&tz->device);
 	tz = NULL;
 remove_id:
 	ida_free(&thermal_tz_ida, id);
 free_tzp:
-	kfree(tz->tzp);
+	/* If we arrived here before device_register() was called. */
+	if (tz)
+		kfree(tz->tzp);
 free_tz:
 	kfree(tz);
 	return ERR_PTR(result);
-- 
2.43.0.472.g3155946c3a-goog


