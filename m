Return-Path: <linux-kernel+bounces-159077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C238B2907
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4EB1C21CDB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A299152181;
	Thu, 25 Apr 2024 19:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Wx6BXBqY"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0E32135A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 19:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714073273; cv=none; b=pnodU0hkMpPfdQ6J74l+V1vjLQQnYK3O39BhgOkNfx0c4abZd0fIyw/rKTIZB4uUeljTCqiINXMLHOjCuWepNzdnAWftRpo/Ht/rW9IruXuSYdPiaCsazBj6iNIDWlJHOd9cUMs9WdIruF244WS8XJwqRhJ/ErQS6D8NRBgIsF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714073273; c=relaxed/simple;
	bh=9zUGvtPYESFL93IQuZWZqwV2EmLmIRwNFPqf2JM2j3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WKnEK+447NDtbbiX8pVO1S0GueV9R9MEMpd9y9yS0V4bidPa1/81C5eEkoiHVbAWEtUp3MYCEfGI1BIqDOVbcs0oBGe7Z4G1oqDI3ITaxoX+Ty7Q90V1wl8mDV6MiDxOsNiLojAdBtn4usSQG9TkzWVEbEfYgocldZ9/rluJq7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Wx6BXBqY; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7eb23f807b5so273819241.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 12:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1714073271; x=1714678071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xRfxLogI9T4CmFpA/Ru6xajlEXu5NliZz/2sLYlz8bo=;
        b=Wx6BXBqYAXL03L5j1u7tuT6AFEwV26Is/tb8riQ7q/8YrnJqPe/jkcmgN80qeMfw2A
         XzMO0nRv+pCjXyXz3T7HPkA8AWcKylGG2o37hkKbiOASBCUyoOI06A1x3hpD1aSrQIVL
         zKFFdyo+kNnOnlYWCavh+9mC2Kp72tPl+QF6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714073271; x=1714678071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRfxLogI9T4CmFpA/Ru6xajlEXu5NliZz/2sLYlz8bo=;
        b=C1ruQ76GDxxaGSEGf7JgHJXsTgOezwX4uHZYBdUeJPeNxRX+FzZ7k49ofXu3/mkVxf
         BlVo381qiK5WJjG9ESwH/bgyBmkKoMEdLTRbDi42i/1boCT/u43wi6S5kexlEq4EeaJG
         IVueOAHq/G94hgjYq2V52RkdIGmHl0rJ22dpdEo+TGq8KmrbnmK4MvCHRkTDkXXaKAqb
         fN7PedNriO/8xjJCBEhm44OJGlqXlNM3ZRASGpinh3kfeqJIaUNmZcrY63D7pGD6uFHl
         Ul7SsrKArS72QRs79tZ69lekDTnCMlreTjLQmqP/YVulH3PEVmeayJ73kZIQTQ/a1DyE
         IWsA==
X-Forwarded-Encrypted: i=1; AJvYcCVOXD5vDBLY3ksIrE6YMtTDtPtPMjO2hrBqlsofTvRVI85T33qXIpWvuqWHXZIPgYALnQglWafaPgEqXICSIpraYWLZTi5CuhI3k9Iv
X-Gm-Message-State: AOJu0YyR5xyXKFviTQ8P2uuGtU/CThqtzF+XjhWZBxao/1QEI/NugHZ/
	LSVtnksl04LIYPRiufSjt8j31kM/jYtsxDvoVXel4SC6Rz7dLWLDUIaZxhIPTQ==
X-Google-Smtp-Source: AGHT+IGiWvcsbM8xXbwuiNnV+4S3QNaR+rkFtqZskbW40nOl8jDdg6Vv+cSiZ7zf6opnHiBk1LVHtA==
X-Received: by 2002:a67:fad2:0:b0:47c:1c1b:59be with SMTP id g18-20020a67fad2000000b0047c1c1b59bemr446547vsq.33.1714073271249;
        Thu, 25 Apr 2024 12:27:51 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id b4-20020a0cf044000000b0069b1e2f3074sm7258689qvl.98.2024.04.25.12.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 12:27:50 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	ian.forbes@broadcom.com,
	martin.krastev@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	zdi-disclosures@trendmicro.com,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: Fix invalid reads in fence signaled events
Date: Thu, 25 Apr 2024 15:27:48 -0400
Message-Id: <20240425192748.1761522-1-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correctly set the length of the drm_event to the size of the structure
that's actually used.

The length of the drm_event was set to the parent structure instead of
to the drm_vmw_event_fence which is supposed to be read. drm_read
uses the length parameter to copy the event to the user space thus
resuling in oob reads.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Fixes: 8b7de6aa8468 ("vmwgfx: Rework fence event action")
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-23566
Cc: David Airlie <airlied@gmail.com>
CC: Daniel Vetter <daniel@ffwll.ch>
Cc: Zack Rusin <zack.rusin@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: <stable@vger.kernel.org> # v3.4+
---
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
index 2a0cda324703..5efc6a766f64 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
@@ -991,7 +991,7 @@ static int vmw_event_fence_action_create(struct drm_file *file_priv,
 	}
 
 	event->event.base.type = DRM_VMW_EVENT_FENCE_SIGNALED;
-	event->event.base.length = sizeof(*event);
+	event->event.base.length = sizeof(event->event);
 	event->event.user_data = user_data;
 
 	ret = drm_event_reserve_init(dev, file_priv, &event->base, &event->event.base);
-- 
2.40.1


