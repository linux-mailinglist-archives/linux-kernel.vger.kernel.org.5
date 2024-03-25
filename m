Return-Path: <linux-kernel+bounces-117288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C852E88A9AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422861F3FA9C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD6D1514D4;
	Mon, 25 Mar 2024 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n8aepkce"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FC413C9D4
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711378227; cv=none; b=mjF+B6i8XiFVt40/1oASAVPJZwVApRqBDbpAJbZh16xOsMVuuF3WWY4N5jXmg3sYkwpAI548j1XHATnEohx0MtYIwi2Nr2S0MViuJZhbUYRv301FeyqYDtk4TV8yGGFPdGtxYKMkjYSaLmA6YQiOO3pG91uKYLkBLTsjrcbWkSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711378227; c=relaxed/simple;
	bh=XuosJhLq9XO2f2Iz8q5BqXyhg3JPBHZ2/G19za/IC+w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ezXjdvwSuQs0KelCEZIjoeiZQf0zEF4r/bRy9ySZof2KzXQZMvdF7412fm0sY2wfjkrLL4vf/sDEjQ0sSG7U1HXGACVR9TtGN8mCZ6Aj4TI0sDlD3I9+jzdJ605nR8YlO4pdNNyZ2vfMlkDizejIim5ZK3F+kYeRNuexTDguBcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n8aepkce; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42e29149883so15019501cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 07:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711378224; x=1711983024; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pH1jT5inC85eoeQR+KEh1jf0eALiBVZ6LM3AeT5cMWA=;
        b=n8aepkceqW67KYGgLdRVr+PxaaD0O7n9RblWiOcUrXfnoYijyxVJSU8tNVXyJiVXfD
         AFEenoGs9fa1Kte9Cbtutcel/3lJe4+Ky65yEBze4iC1yFyOX9x+dZ1EJN2+Soh4l5L2
         4HVS7seYGrOOjrecpRxKTCHMLzKYKFJNI4N9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711378224; x=1711983024;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pH1jT5inC85eoeQR+KEh1jf0eALiBVZ6LM3AeT5cMWA=;
        b=hJL1b9aHvCeH13nphNKe7W2BZD8yadYFraGOZDpwLWx3RiUZiPkcSq00ppvTAnZfal
         By7rkjad3ue+u2dsoMmgwvDLQPOocMsSw6Galo590TlkdSqwmockhjNJ9OA+MdtBcCXV
         GrwW0Ke4GLsyXMAu0rf7oXrs3OiSZbnEZR+9IShSdvSMAeio7riGpRfSlaAujKMdAVeD
         N89QSmO1LM/c2WnrrzWFTeVfxmylenKRGMcQkbmwHqiGVCN9PWmQ2C/Ak47fpfWmEQ8U
         fg9IV8uGRnMThohCcuoMmLxzSuKdb6VkCb3AG26u3JCq6PZDlHwrD0r1CAzS27PSG7s0
         /iQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTL0Gc79bsPeRV7MtsLN+yVV1hm+rW4XfQufKmvhR3js7xfN2PRHWZZU+ovhykbM6KCyc8fwBIoGg400aLhf9vJOS2JxeeU2LLiXK/
X-Gm-Message-State: AOJu0Yy+T9/DndkhYEAyN16yTQr8gqftlvNsWiBSGwDYf/qoVLTvh1Ex
	XDCHIJdki/jnlURt+CEy+TON+w30BjuUQTt/+D7xZFEKatc/Kor27sGTeLsKNw==
X-Google-Smtp-Source: AGHT+IFeN0Nzu5ziAfC1KxHAnbV156Nv0MLZtP9x2YPsCIAtNRoL4Uk2YVOl+IK8Y4idRu/fWLa7ew==
X-Received: by 2002:a05:622a:11cc:b0:431:59e9:4a5a with SMTP id n12-20020a05622a11cc00b0043159e94a5amr2582881qtk.68.1711378224682;
        Mon, 25 Mar 2024 07:50:24 -0700 (PDT)
Received: from denia.c.googlers.com (188.173.86.34.bc.googleusercontent.com. [34.86.173.188])
        by smtp.gmail.com with ESMTPSA id eq17-20020a05622a5e1100b004313f54aaa9sm2491449qtb.5.2024.03.25.07.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 07:50:24 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 0/3] media: Fix gcc warnings
Date: Mon, 25 Mar 2024 14:50:22 +0000
Message-Id: <20240325-gcc-arm-warnings-v3-0-81b8c10dc18a@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAC6PAWYC/33NTQ7CIBCG4asY1mLoAPFn5T2MCzpSOouCGRQ1T
 e8u7coY4/L9knlmFNkz+SwOq1GwL5QpxRp6vRLYuxi8pEttAQqM0qBlQJSOB/lwHCmGLL3BxgC
 21qES9ezKvqPnQp7OtXvKt8Sv5UNp5vUPVhqppGqNRbTQ6b0/Ys9poPuwSRzE7BX4NOwPA6pht
 hY0dhZ36L6MaZrePUlX8vcAAAA=
To: Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

drivers/staging/media/tegra-video/tegra20.c: In function ‘tegra20_vip_start_streaming’:
    drivers/staging/media/tegra-video/tegra20.c:624:72: warning: ‘yuv_input_format’ may be used uninitialized [-Wmaybe-uninitialized]
      624 |                          VI_INPUT_VIP_INPUT_ENABLE | main_input_format | yuv_input_format);
    drivers/staging/media/tegra-video/tegra20.c:617:22: note: ‘yuv_input_format’ was declared here
      617 |         unsigned int yuv_input_format;
          |                      ^~~~~~~~~~~~~~~~
    drivers/media/radio/radio-shark2.c: In function ‘usb_shark_probe’:
    drivers/media/radio/radio-shark2.c:191:17: warning: ‘%s’ directive output may be truncated writing up to 35 bytes into a region of size 32 [-Wformat-truncation=]
      191 |                 .name           = "%s:blue:",
          |                 ^
    In function ‘shark_register_leds’,
        inlined from ‘usb_shark_probe’ at drivers/media/radio/radio-shark2.c:306:11:
    drivers/media/radio/radio-shark2.c:212:17: note: ‘snprintf’ output between 7 and 42 bytes into a destination of size 32
      212 |                 snprintf(shark->led_names[i], sizeof(shark->led_names[0]),
          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      213 |                          shark->leds[i].name, shark->v4l2_dev.name);
          |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    drivers/media/radio/radio-shark2.c: In function ‘usb_shark_probe’:
    drivers/media/radio/radio-shark2.c:197:17: warning: ‘%s’ directive output may be truncated writing up to 35 bytes into a region of size 32 [-Wformat-truncation=]
      197 |                 .name           = "%s:red:",
          |                 ^
    In function ‘shark_register_leds’,
        inlined from ‘usb_shark_probe’ at drivers/media/radio/radio-shark2.c:306:11:
    drivers/media/radio/radio-shark2.c:212:17: note: ‘snprintf’ output between 6 and 41 bytes into a destination of size 32
      212 |                 snprintf(shark->led_names[i], sizeof(shark->led_names[0]),
          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      213 |                          shark->leds[i].name, shark->v4l2_dev.name);
          |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      AR      drivers/staging/media/tegra-video/built-in.a
      AR      drivers/staging/media/built-in.a
    In file included from ./include/asm-generic/preempt.h:5,
                     from ./arch/arm/include/generated/asm/preempt.h:1,
                     from ./include/linux/preempt.h:79,
                     from ./include/linux/spinlock.h:56,
                     from ./include/linux/mmzone.h:8,
                     from ./include/linux/gfp.h:7,
                     from ./include/linux/umh.h:4,
                     from ./include/linux/kmod.h:9,
                     from ./include/linux/module.h:17,
                     from drivers/media/dvb-core/dvbdev.c:15:
    In function ‘check_object_size’,
        inlined from ‘check_copy_size’ at ./include/linux/thread_info.h:251:2,
        inlined from ‘copy_from_user’ at ./include/linux/uaccess.h:182:6,
        inlined from ‘dvb_usercopy’ at drivers/media/dvb-core/dvbdev.c:987:7:
    ./include/linux/thread_info.h:215:17: warning: ‘sbuf’ may be used uninitialized [-Wmaybe-uninitialized]
      215 |                 __check_object_size(ptr, n, to_user);
          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ./include/linux/thread_info.h: In function ‘dvb_usercopy’:
    ./include/linux/thread_info.h:208:13: note: by argument 1 of type ‘const void *’ to ‘__check_object_size’ declared here
      208 | extern void __check_object_size(const void *ptr, unsigned long n,
          |             ^~~~~~~~~~~~~~~~~~~
    drivers/media/dvb-core/dvbdev.c:959:17: note: ‘sbuf’ declared here
      959 |         char    sbuf[128];
          |                 ^~~~
      AR      drivers/media/radio/built-in.a

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v3: Thanks Luca
- Fix error while rebasing the change from Thierry. (sorry :S)
- Link to v2: https://lore.kernel.org/r/20240325-gcc-arm-warnings-v2-0-47523cf5c8ca@chromium.org

Changes in v2: Thanks Thierry
- Make tegra20_vi_get_output_formats() and tegra20_vi_get_inut_formats,
  consistent.
- Link to v1: https://lore.kernel.org/r/20240323-gcc-arm-warnings-v1-0-0b45cc52f39e@chromium.org

---
Ricardo Ribalda (3):
      staging: media: tegra-video: Fix -Wmaybe-unitialized warn in gcc
      media: radio-shark2: Avoid led_names truncations
      media: dvbdev: Initialize sbuf

 drivers/media/dvb-core/dvbdev.c             | 2 +-
 drivers/media/radio/radio-shark2.c          | 2 +-
 drivers/staging/media/tegra-video/tegra20.c | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)
---
base-commit: b14257abe7057def6127f6fb2f14f9adc8acabdb
change-id: 20240323-gcc-arm-warnings-e4c142cb5ac0

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


