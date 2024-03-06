Return-Path: <linux-kernel+bounces-94506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3008740C3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E58201C215FA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A174D140E26;
	Wed,  6 Mar 2024 19:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=klervi.com header.i=@klervi.com header.b="I3VZU8Ca"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B3313E7DB
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709754611; cv=none; b=SasIP/6rd8YQpyRCCQ6myPaIrMte9Fi5fAvrHTmcrkdGMrdJaR26mN6l5gb4X0GEA2ld0TeO12Lf2ZxIUShVxw0t9yQhp4fMebQPFbvQMoFc8bHRQpOBjymHz3l8fpEohRKKXFqpM9jrigVVK4DMiSYijfWkrffN8lKxh1ymLQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709754611; c=relaxed/simple;
	bh=80nZc3rXPRJ+WWBMzS4I/QemTlOkvCsEoLh1p9MezZc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=k+l+m4LGC7rJom9GxU0tWZ9EBBlYPWF4uK+FoH4NEgSQlFCFw1z+GP8ddnn91Wlqoc4EbKOVVm6jjmHuldcoikWs8t2OmGXinTxfMkabKAwVeijyfQ48KtHEDgRlm0G4rtVkKMiiOQDQxwrl5Q9OdiENz7yUiySZtaEA4pdEXPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=klervi.com; spf=pass smtp.mailfrom=klervi.com; dkim=pass (1024-bit key) header.d=klervi.com header.i=@klervi.com header.b=I3VZU8Ca; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=klervi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=klervi.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-412fc5f5099so1106675e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 11:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klervi.com; s=google; t=1709754607; x=1710359407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n04+kjr3Y6YgIJTaMT3u4Uzu8nklWAvbA4VZhXY8Et8=;
        b=I3VZU8CakBvG4a4/NgGuD05GoLhBA3I4JS9gXcPfe1lFyInJpDvCTnDbrn475HJuH6
         A/gASviw0ycrPPgt4ZVaW3WVUWpQZXv5e8fgyo/nUe8hwnIiXam+H/fbYvt7cK008wa8
         04LKU9ZKNuytyKa16OBF+ZowoIKhaH/lfNvLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709754607; x=1710359407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n04+kjr3Y6YgIJTaMT3u4Uzu8nklWAvbA4VZhXY8Et8=;
        b=V3Pm5gJb2o8uuBQf3Pb+i/IC3YrKRPknxWAw/CQ7pAKdu30Bu3rQNJv8orI6cUgDIu
         7Pt3Wkukjzlo8vXUBAszzfbRwNuLYea+TGLY4habyvUEc0jGGXuRZFIVZqTt/gPrUjMS
         2WuAl2fDgW+JQX09gNTR8V2Kqu+OhpGDxfrJx5NfZWFXR40t70Tt5EhLedd098Hb/JpV
         x48vu6h3/JWnkyeq1d/dDJejysCeon3+iocV1QVa6tik5ldXlPF/FzVqvbreq3OXQnnk
         VPYVSjg1zKWwS6vr38XTlT54argVDYitAoygEGJshbq9gTMzWRTwjc3pFXUFXngL2ekw
         uiSg==
X-Forwarded-Encrypted: i=1; AJvYcCW3YUfoJ7SDyawMUL6Yai2z3juY7yfh5pemTTyx4NhU7Owy81xipOZfcEZT8fYA7wDWM2LIuJ53C5y6gc7Z5QzTwGcwg0nOVaAUdTwB
X-Gm-Message-State: AOJu0YwrvCMJ2l3StcAOXpjwqzRDnek/n7FOEbRyN6DfaruGT+yJzXIU
	56MmKRTIsdaOoZ+4jNsAVm4855AqsWvB4ZliJjUGHlekcCCsoZydwUgZ58Yyzi7K3TZfdDWd9VK
	EcoizdcRFqhVwKTh68GBza9ogQIL5LEA8d31go67RwXrxOa0nKcKPbJI1pJObX0W4i5G5smFypk
	IsO2Ad1xgFQ6nDMhQOsrcoMh+oxCS2ieB0WhQRSrDsroAxEmDbEdT3vZT0vRn2jqKoeRSlYFge5
	UCoiEzSJHZGpNLA5P1C9xQ80os=
X-Google-Smtp-Source: AGHT+IF2gkqIB+cBn4Al0GM9/kmbswnuXzHoTEFQtziyTc9Mtd3yLVusDe1v0KZebzI18vt+6lLTlg==
X-Received: by 2002:a05:600c:510f:b0:412:dc42:73f8 with SMTP id o15-20020a05600c510f00b00412dc4273f8mr9417350wms.18.1709754606972;
        Wed, 06 Mar 2024 11:50:06 -0800 (PST)
Received: from cadmium.klervi.com ([2a01:e0a:33b:ae30:d1d4:c3ea:40e3:789f])
        by smtp.gmail.com with ESMTPSA id l14-20020a7bc44e000000b00412f6c695d1sm235193wmi.43.2024.03.06.11.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 11:50:06 -0800 (PST)
From: Pierre-Louis Dourneau <pl.dourneau@klervi.com>
To: Sam Ravnborg <sam@ravnborg.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: Pierre-Louis Dourneau <pl.dourneau@klervi.com>,
	=?UTF-8?q?Beno=C3=AEt=20Alcaina?= <b.alcaina@klervi.com>,
	Arnaud Lahache <a.lahache@klervi.com>,
	Nicolas Georges <n.georges@klervi.com>
Subject: [PATCH] drm/atmel-hlcdc: Release CRTC commit when destroying plane state
Date: Wed,  6 Mar 2024 20:49:35 +0100
Message-Id: <20240306194935.11871-1-pl.dourneau@klervi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaud Lahache <a.lahache@klervi.com>

Fixes a memory leak occurring on each modeset update.

Running a program such as libdrm's modetest[0] with this driver exhausts
all available memory after a few minutes. Enabling kmemleak yields a series
of such leak reports:

unreferenced object 0xc21acf40 (size 64):
  comm "modetest", pid 210, jiffies 4294942460 (age 331.240s)
  hex dump (first 32 bytes):
    00 a0 a1 c1 01 00 00 00 ff ff ff ff 4c cf 1a c2  ............L...
    4c cf 1a c2 ff ff ff ff 58 cf 1a c2 58 cf 1a c2  L.......X...X...
  backtrace:
    [<d68b3e09>] kmalloc_trace+0x18/0x24
    [<f858a020>] drm_atomic_helper_setup_commit+0x1e0/0x7e0
    [<26e8ab04>] drm_atomic_helper_commit+0x40/0x160
    [<49708b0c>] drm_atomic_commit+0xa8/0xf0
    [<e58c2942>] drm_mode_obj_set_property_ioctl+0x154/0x3d8
    [<5e97e57d>] drm_ioctl+0x200/0x3c4
    [<ed514ba1>] sys_ioctl+0x240/0xb48
    [<26aab344>] ret_fast_syscall+0x0/0x44

drm_atomic_helper_setup_commit() acquires a reference to a drm_crtc_commit
for each CRTC and associated connectors and planes involved in a modeset.
64-byte leaks map well to the size of a drm_crtc_commit on 32-bit
architectures, and the second 4-byte chunk in the hex dump above awfully
looks like a reference count.

We tracked this missing reference decrement down to the driver's
atmel_hlcdc_plane_atomic_destroy_state() callback. Its CRTC counterpart,
atmel_hlcdc_crtc_destroy_state(), calls into the drm_atomic helpers and
properly releases its references to the commit. Planes didn't. Using the
default helper for that purpose, __drm_atomic_helper_plane_destroy_state(),
fixes the leak and avoids reimplementing the same logic in the driver.

[0]: https://gitlab.freedesktop.org/mesa/drm/-/tree/main/tests/modetest
     Invoke with `modetest -M atmel-hlcdc -s 32:#0 -v`, assuming 32 is the
     ID of a connector.

Signed-off-by: Arnaud Lahache <a.lahache@klervi.com>
Co-developed-by: Pierre-Louis Dourneau <pl.dourneau@klervi.com>
Signed-off-by: Pierre-Louis Dourneau <pl.dourneau@klervi.com>
Co-developed-by: Benoît Alcaina <b.alcaina@klervi.com>
Signed-off-by: Benoît Alcaina <b.alcaina@klervi.com>
---
As far as our testing goes, we've been running 6 of our production units
with this patch for more than 2 weeks as per the date this patch is sent
out. We can report stable memory usage.

Admittedly, our usage of the DRM uAPI is rather simple: create 2 dumb
buffers, do an initial MODE_SETCRTC, and then MODE_PAGE_FLIP between the
two dumb buffers at the rate of once per second on average. We haven't
evaluated more complex workloads.

 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index daa508504f47..390c4fc62af7 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -934,8 +934,7 @@ static void atmel_hlcdc_plane_atomic_destroy_state(struct drm_plane *p,
 			      state->dscrs[i]->self);
 	}
 
-	if (s->fb)
-		drm_framebuffer_put(s->fb);
+	__drm_atomic_helper_plane_destroy_state(s);
 
 	kfree(state);
 }

base-commit: 9dfc46c87cdc8f5a42a71de247a744a6b8188980
-- 
2.34.1


