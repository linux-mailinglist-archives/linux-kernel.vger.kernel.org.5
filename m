Return-Path: <linux-kernel+bounces-110325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2611885D38
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 800EF281D44
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFE112C551;
	Thu, 21 Mar 2024 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="vUMoiJEn"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E70B12C52D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037830; cv=none; b=N9V+RqJkdLxlf/0JrWKAqvF5P+aioksassEFSexqf7cfUcEoFcCDfuIeJcl0F9WkG2JYLFg4ISoXLXMtypyETK7Ksp8+hUERhnsyvxWxyH/SpJNvRAfKWXGUAS6GwtQqg0Wq9G6S92qs/PbwW5LyUibbT92cFFf0/n8SMEEXQp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037830; c=relaxed/simple;
	bh=iCvxqjV8nvENU9QhU5KtACphTO4DgKMFcObGcyiE06A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W2bgMzfJEtAQz1iU6BM4Srlu0b7Jj6hxzx9aQ5fBaiUf6DV7wiPKapTovh6QudHt8JSpzqgba94aneYEWKBL9E3i0v1RQe5nZnnjxBepLGSo14EzpkKD6bNTic1kYhXb7sFZkHXum71fkQfq6cP9cyYGOWpyy6pZgMlgbh2GEf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=vUMoiJEn; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42a9c21f9ecso6185941cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 09:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711037827; x=1711642627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GblkM0rXkobGOvAznWFXNMB8PHw+JhTurN6nTmP6yek=;
        b=vUMoiJEnC/mouzRlDN62P1GJ42N5P7VgELwelDb5GEIedHAPzJqjNrN7953cuqx51y
         pXuU+SV7+Vt3h34mJcH1gORmVu/a49WJHZByQP1zRBJSoBJF/mjNSPjFzXpnWh0n3Cta
         cCkycKUPa+PRMs5eSuAAv2rTcWMECD4zoUM95FZOUAkf4v09IUuMyg3y7pim3/VdBs+P
         x/y0zjhZcrL9yJSHgs5Aeo4AdBZQ6wDtN+COZSW8sNE/hhPeLJayDZwdZaSCRY4jOTxK
         5ygSrl3dt7KgX8tKE7HQzXSK+wrFAtmt9NB3gZfI6gKGmujXn66rHeyaEAg+jEZrQhd/
         Qx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711037827; x=1711642627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GblkM0rXkobGOvAznWFXNMB8PHw+JhTurN6nTmP6yek=;
        b=W2lnIlZwj3XSXYI0TR109WUPYy8ARS5IA7PF4gBPhCcGoq8j510E+2H0m4myTmA+21
         LYVZ1uX0ObkE5bsjNmcRs8Yqvl/fjiJ2FCnR6oA/HZaiMHtEyKJbIhgLwREkaRSFgDhR
         DtrKNhni3J/AQynxullLW37psyu2rMwFMDwOoY/eCgMcbKcerIBzNfNBHgY2GQk9zdWP
         0GDjIwX/KCvXN3+K8Y7uADFge1aJoUNt4zlBsC/jSxX4WxnSTIEPzyUWnqZYW0bwfcu/
         LtXO/78l0N5KmLsoQ33w3dtTGSPd7eYdT+JYq5rJpYuuGdCHyehA2M8te6ko6CcEyzR5
         BbIg==
X-Forwarded-Encrypted: i=1; AJvYcCVzniYtajnevUvbSG4/ttHPYsr9F78eufxujG2grofgkujpo5BG/GSjjAw5d0Fi+zg78EUHzDd1EGe722g0BuuT9lNUWbNzKV8MVysf
X-Gm-Message-State: AOJu0Yxem7BFSbq0HFLUQqccxZ1R6n3xsmQGeVz7BtFfG1yR40Nors8H
	on5yRdFoR7KDpLanm36SSCbhr2jk2ijBCitPEMX+sCaAYkhX3Fo9S1Olg2i2LHo=
X-Google-Smtp-Source: AGHT+IEkMIUX5FBkoVAsY/o5aRSeEBHHMCbQRrZJMyq82UZg8ZQv8JQaK8mGhWFKdcA1ZdOtiV9Z3w==
X-Received: by 2002:a05:622a:106:b0:431:1def:c7c5 with SMTP id u6-20020a05622a010600b004311defc7c5mr3547484qtw.43.1711037826656;
        Thu, 21 Mar 2024 09:17:06 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id e8-20020ac85988000000b0042c61b99f42sm15309qte.46.2024.03.21.09.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 09:17:05 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Takashi Iwai <tiwai@suse.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: control: fix memory leak in snd_ctl_elem_read_user()
Date: Thu, 21 Mar 2024 12:17:00 -0400
Message-ID: <20240321161700.2926-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With 6.9, I noticed kmalloc-2k blowing up to tens of gigabytes over
several days. Kmemleak shows a long string of these:

unreferenced object 0xffff8f1bddbce800 (size 2048):
  comm "wireplumber", pid 1058, jiffies 4294690193
  hex dump (first 32 bytes):
    14 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
    4d 61 73 74 65 72 20 50 6c 61 79 62 61 63 6b 20  Master Playback
  backtrace (crc bd965d91):
    [<ffffffff85ac328b>] __kmalloc_node_track_caller+0x25b/0x370
    [<ffffffff85a79375>] memdup_user+0x25/0x80
    [<ffffffff85fa5d63>] snd_ctl_ioctl+0x753/0x880
    [<ffffffff85b18119>] __x64_sys_ioctl+0x89/0xb0
    [<ffffffff861ee190>] do_syscall_64+0x80/0x170
    [<ffffffff862000ab>] entry_SYSCALL_64_after_hwframe+0x46/0x4e

When 1052d9882269 ("ALSA: control: Use automatic cleanup of kfree()")
converted a few sites to automatic freeing, it removed the kfree from
snd_ctl_elem_read_user() but forgot to add the __free hook.

Fixes: 1052d9882269 ("ALSA: control: Use automatic cleanup of kfree()")
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 sound/core/control.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 8367fd485371..7da0d6afb766 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1275,7 +1275,7 @@ static int snd_ctl_elem_read(struct snd_card *card,
 static int snd_ctl_elem_read_user(struct snd_card *card,
 				  struct snd_ctl_elem_value __user *_control)
 {
-	struct snd_ctl_elem_value *control;
+	struct snd_ctl_elem_value *control __free(kfree) = NULL;
 	int result;
 
 	control = memdup_user(_control, sizeof(*control));
-- 
2.44.0


