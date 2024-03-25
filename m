Return-Path: <linux-kernel+bounces-117234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4AA88A8EF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC7521F614BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF8912FB05;
	Mon, 25 Mar 2024 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WuExTdnl"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD2A12F5A8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376398; cv=none; b=QuYpgZECA0FX4j3x7CIjPaXbXJQ/+a1FAdE6+DVvWckILDQLtkOs+uzcV84J0VWOXDS+zGp+p0HNchee5sPZhV5dc4bM6WaQflXFojNO7X9bG07QABDXz3Y7lQgL23J4l/UKjOTGNQRG59Z3U7vt3tUdK/WvRhiGoELkefa9b5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376398; c=relaxed/simple;
	bh=JKbdbNdPOYQQqddMWH6dBM0cjrj/2ap/o5f7isOs8AY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rvdlAiswsiddHpttWjGnBy4RWZt8+8yZLp0AzCRAdLp0K/P3SXFSim0BUGuV9gYhy4DKiwl9UAGwyhd5p9GGAThCl+Uisr2Ydg4jXuwC2Wm1l4VpLJp3l8dVBloyW9TcJKq6Emwo1V0tUCc9dEDzD0Dnq1rmBuP3XZoDDftVJCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WuExTdnl; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e675181ceaso2453474a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 07:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711376395; x=1711981195; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mXrTB7+ol6tbk+bHTpvN5T0GXtoDHNWTCFN/jK6yyrw=;
        b=WuExTdnlaZYpwlr/wNTWHoQszeVR/Ze50unBmjGWBr1Pbf6JTkjx2alDyQ9RGA03YI
         2KDN0qN1h1llPRe7OWC7Wlo58KAxrAakr7bsIAwL25/oKirv7KkwshRKjRJgxfDV9CWY
         TDikOt86I9/1iKezSqRf4/UZT7VaigM8JbE4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711376395; x=1711981195;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXrTB7+ol6tbk+bHTpvN5T0GXtoDHNWTCFN/jK6yyrw=;
        b=wCWkZoeA/8E8pI+MhzvBRn1hap/Zt2Istj3EaoI967pGtN+w9Z+xHJnqLcFxkul8w3
         gXY10oL7ssKvW21bPb0FIT/eAP63VS85jg2cI36lRGZXdEfJEsbAmc1RHLnb1e/IqoQf
         W3rLDyoX5KwhJbzeKJhyxdkV8FwD9AmFV07GbpQ40RFGY9qDzYI4fSviNPH6eTzO5ZlT
         YzR+Swx2yhytvvx+nULTDHOQqhfoHujO8X5pOqiGsLdEKpuBZIvsbWmAwhOzwM5OUJlf
         08X6DtnNEAHsK+F3xoWs/+ICkk7xuqivilw2zx4rN3qtYto5gbcV1zr+Tut24uTQeI7f
         1YxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3xDx/UyJXC9zkLmHouetniwZqU5+M5niZfRBJUy94G/WRR7BLLcRYRcNZAosxSDdo+3hpB2djy1PYA56VuJibUTPMtQlKry0Km1YB
X-Gm-Message-State: AOJu0YzetgyuP+vI9YI/6YB6gqyKkOKBKnoVTjM5z1HIY2Cdfyuj2b6Y
	ZKUsBKVbzoBEWJF6/Hu3jENILgszWdLGvwRvZL9QEW+2HBPlJCYrVdFvO9Xc/g==
X-Google-Smtp-Source: AGHT+IG+csagqpvPTu78ZUHHmPYI/wP0o4on29JF1NkEZT/PFJ0Ha9SsmHe27984oyp+F6/Vtl/r0g==
X-Received: by 2002:a05:6870:d0d1:b0:22a:4345:5731 with SMTP id k17-20020a056870d0d100b0022a43455731mr2324674oaa.29.1711376395371;
        Mon, 25 Mar 2024 07:19:55 -0700 (PDT)
Received: from denia.c.googlers.com (188.173.86.34.bc.googleusercontent.com. [34.86.173.188])
        by smtp.gmail.com with ESMTPSA id br11-20020a05622a1e0b00b00430a9b20a55sm2618759qtb.69.2024.03.25.07.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 07:19:54 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 0/3] media: Fix gcc warnings
Date: Mon, 25 Mar 2024 14:19:52 +0000
Message-Id: <20240325-gcc-arm-warnings-v2-0-47523cf5c8ca@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAiIAWYC/32NMQ7CMAxFr1J5xihN0wEm7oE6pMZNPTRBDhRQl
 bsTegDG96T//gaZVTjDudlAeZUsKVawhwZo9jEwyq0yWGOd6WyHgQi9LvjyGiWGjOyodZbG3pO
 BOrsrT/Lek9eh8iz5kfSzP6ztz/6JrS0aNKPriXo7dSe+0KxpkedyTBpgKKV8AZduLGezAAAA
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


