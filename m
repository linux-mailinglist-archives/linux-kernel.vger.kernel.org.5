Return-Path: <linux-kernel+bounces-72150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D3485B00D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B028B210EE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 00:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E5E4A26;
	Tue, 20 Feb 2024 00:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cy+7QID1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06364185B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 00:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708389286; cv=none; b=rzDvPg/DDtYf6l9rN/mtAJR2AVO29jTZUlK+KmmCbHYSxOkUN+Uy+NFMp27xAzkhILiXRLpPk9OJv5h+Kv3bGB02c+L8h2ZIZaoRs3QP5d1/YwRJ74J9xb99vM98JNmJ83lqJaXf0lbNkfeSwVh7QPKqlZwofmcMnzFCQtFKEeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708389286; c=relaxed/simple;
	bh=twysEfuQ4T/0w/2qh6F2Tm91ScgbJMClrcyBk8mU50U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Veac6j5rpPzd8/0SW5HlXYMvzxuStaFAH3J+G+SUgv0qZKA1BsfjJ1Pe8uBlPbNiWHNN60FSqV1dTEwAPSAeeKIIEFtF/iw8MRuykxoEGXb/llH9yYRr7TDdIEf57LhHyAbgM2YMx8T1Qu/nbmFy+15ZeyGYyhjmj/FmEApKyI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cy+7QID1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708389283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uJszGoDmcJ/e3cfaUrhP/NITyUlid6+ei0fLVW+ftlI=;
	b=Cy+7QID1hKJgbw06GAFxHFEsANhHN4lh2u2ziDe7GLxeLc3QC6eW23/4JFhNkYlSlJPMSc
	M6lylbR3VvJIK2GhWB0lFV4Ec939KI96tfIcBFlp1b5GaL++u3+d+gIej6ZfERIIcjKKXw
	7biA+r2Adt4Si/rODxw8SUuzM09Gi0E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-dn5L_tJ4MfybouTfh8BNvA-1; Mon, 19 Feb 2024 19:34:42 -0500
X-MC-Unique: dn5L_tJ4MfybouTfh8BNvA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-410e83001cbso27064605e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:34:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708389280; x=1708994080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJszGoDmcJ/e3cfaUrhP/NITyUlid6+ei0fLVW+ftlI=;
        b=n3ISU2I6Z20NVNtZI438hVCRhka7xaMFBTTW/Xno59lL62u2c7NJkVKNZ0IYjBUnrw
         yZ1i/0qcYo0tw0T+0J0BFBegWWPwv5kwtAQBNK8swlMnFSyYgxgTwn+tWEkfMou3Lobu
         ic84ehn4hCiV/mPv0GuQ3l2VAu5dnj2J7nB+4D4/+x6pvztUN4DlwgNPo2+wOyv4JL/8
         I/Yc+UuT7D+AUG8zI4dekXIik2uaRqloboN9Fd2QGCrQ6C4ZRkCdq0ikR5mU7g476xKE
         puN79zXK3bq1mC14zLwlCZCE59b3ZbTpef2WA5MOS2/3LtT3y1c8iZDu1KXzscIf2/oz
         YBKQ==
X-Gm-Message-State: AOJu0Yy/0oEFCrRtU9PQyjiO2v+lMEBMSRwmtx0+JxOppI1EhVMiwYcs
	J40Wy+/FWJqP8dGh3HA30gN2xkETKBNWuUJXN7g/opgUAGwt4nWM3fB527yKe5EoWD9VqxdVpVc
	zjLxUDInfgIj66upRJJ5nDenXxq4jBZTOha+rVY0kVq51oG1sZwoJHX0A+KXbjpPgAHiFLPYaDv
	QxXFNhDe11dtGBdJjo1Vvt+8brNXNrEDJfya69xCGxRLE7
X-Received: by 2002:a05:600c:198f:b0:412:6d41:920d with SMTP id t15-20020a05600c198f00b004126d41920dmr434597wmq.38.1708389280354;
        Mon, 19 Feb 2024 16:34:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGscKC/h+165pWPIQGiFVK1k+j+cPntLp690DOup1A66feMphWpMObuy7g/A9wibrQFwsUJhA==
X-Received: by 2002:a05:600c:198f:b0:412:6d41:920d with SMTP id t15-20020a05600c198f00b004126d41920dmr434581wmq.38.1708389279984;
        Mon, 19 Feb 2024 16:34:39 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l12-20020a05600c4f0c00b004122b7a680dsm12803198wmq.21.2024.02.19.16.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 16:34:39 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>,
	oe-kbuild-all@lists.linux.dev,
	Javier Martinez Canillas <javierm@redhat.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	sparclinux@vger.kernel.org
Subject: [PATCH] sparc: Fix undefined reference to fb_is_primary_device
Date: Tue, 20 Feb 2024 01:34:30 +0100
Message-ID: <20240220003433.3316148-1-javierm@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 55bffc8170bb ("fbdev: Split frame buffer support in FB and FB_CORE
symbols") added a new FB_CORE Kconfig symbol, that can be enabled to only
have fbcon/VT and DRM fbdev emulation, but without support for any legacy
fbdev driver.

Unfortunately, it missed to change a CONFIG_FB in arch/sparc/Makefile and
that leads to the following linking error in some sparc64 configurations:

   sparc64-linux-ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_fb_registered':
>> fbcon.c:(.text+0x4f60): undefined reference to `fb_is_primary_device'

Fixes: 55bffc8170bb ("fbdev: Split frame buffer support in FB and FB_CORE symbols")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202401290306.IV8rhJ02-lkp@intel.com/
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

I don't have a sparc64 toolchain to test this patch, but I'm pretty sure
that this is the correct fix for the linking error reported by the robot.

 arch/sparc/video/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/video/Makefile b/arch/sparc/video/Makefile
index 6baddbd58e4d..d4d83f1702c6 100644
--- a/arch/sparc/video/Makefile
+++ b/arch/sparc/video/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-$(CONFIG_FB) += fbdev.o
+obj-$(CONFIG_FB_CORE) += fbdev.o
-- 
2.43.0


