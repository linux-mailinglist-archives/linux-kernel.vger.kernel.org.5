Return-Path: <linux-kernel+bounces-72753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B92385B855
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07752285FA3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C07A60BBD;
	Tue, 20 Feb 2024 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JTQerJQF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23355FDA2
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422880; cv=none; b=oWGDSYcnQjr4jGwqp6ZI9+LU8bcapLFHxHGxPyHjdp/02SsKGWpCLvCQc9XYvjkTVfPsatOoLv9aynEV80G+//XB0Tg0sXYlU/1xQWCA8WqZPdbCh1xvJcJYqEf/P4Spmjl7D2qGRr2AYCvztpz4jqSqNIeeQUHYyT4PI32PJK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422880; c=relaxed/simple;
	bh=peQw3BQe60+8GuD9nJijD6XR4JghW7VvoUyslLSQVK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I1r0k4pcY/rexk/p07+5zXMz6SL2MQi09PvtPb9TCtgodpvmJbrrZVMfedgD+DdLiwtW9SUp+R5bJ2SthtEHdAbA5EvE/VUBrJH2PDKUztuiqkP8/rR397ApW6MmR1QJVcgS3dm5pkr23RdCGwb4v63JxC3uw7i2A4TJxn23/U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JTQerJQF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708422877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EYsCgQEb9/Kdo66E4LvnbORIVEe0BX1Dio1aMiZdh0w=;
	b=JTQerJQFGDtWI3mqtUin0IZ9cr5ERwgshaupc6TZ79hTPsIjicH17SqXc5nqxP18lSXp7c
	/KAN8Iu7UDYA2xTFWqraOZIku/mto1/20wzpj37zIMUTIEWOpqnz0g89u3+snctIVJLz4R
	F0EMZGfYv2vRnpfXK4JKUiFHasLVkWg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-XRJElkKuNBC4wFyI3TZ0QQ-1; Tue, 20 Feb 2024 04:54:35 -0500
X-MC-Unique: XRJElkKuNBC4wFyI3TZ0QQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5113b77ff80so3652476e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 01:54:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708422871; x=1709027671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EYsCgQEb9/Kdo66E4LvnbORIVEe0BX1Dio1aMiZdh0w=;
        b=Y8lmDttfWOy4dYMk939ZDviWy1I/yhzmEEoHMJOSRVrzow2MVfo1nVLa4hki0D0TI8
         AhwSg9jzOlwyBI1p9L81A/sCZjPoVjPDt2O+erTxnUTPFetRLCSvNle2ZRRE80ZKWV9e
         Gda7ARryh16ID5+qwOLlwo2zRhET+gjvcd4gavC6UdMXAJPkxILv/QUQRzaG27ExU8wj
         jBDzGblsuzpevapa9414SIM5BsIzZ+bVSXDgqyS93QChZHZhmcp79PUmqmoPVk529v1f
         AsVxVGqDnaoFUxw9WboFHnFx2OhlJlKKCCaL5UxajqpYbKdRlozFEP0U1Ysjov/I+cz1
         AGyw==
X-Gm-Message-State: AOJu0Yy/o5yyMKfIxZQ4M9EJpLswJ0gwfqbbJoX1Uho7XuKPOMpxdtb7
	2kSPVMcE4EtH4e/yud3ThATP0MWGVsonZqi0F5g1YTnBmbwT1ou1zIQ4g1zO6hhmJeMOcaImS5T
	GW0aUPzTJNusKXgvkHlx0+QGQLABkbAYRcLnAQiOYQHbZyY63VsR+64D+WD+5lChEIQbQh9Ew7+
	LZ/VoK+lK/tbqS0r3NV8kE/1PsMI41qAvH7qHKNmTFDlSk
X-Received: by 2002:a05:6512:5d2:b0:511:a819:2c5d with SMTP id o18-20020a05651205d200b00511a8192c5dmr8362476lfo.28.1708422871400;
        Tue, 20 Feb 2024 01:54:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8fRzgqIWa5YVdSnomCIS6IrRbiiN2cG7VrVXeWQpTvBhTw4p6B+zLzNoWj2miSn7fcrbEVg==
X-Received: by 2002:a05:6512:5d2:b0:511:a819:2c5d with SMTP id o18-20020a05651205d200b00511a8192c5dmr8362454lfo.28.1708422871002;
        Tue, 20 Feb 2024 01:54:31 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h7-20020a05600c314700b004126170a23csm8120499wmo.7.2024.02.20.01.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:54:30 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>,
	oe-kbuild-all@lists.linux.dev,
	Javier Martinez Canillas <javierm@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>,
	Helge Deller <deller@gmx.de>,
	sparclinux@vger.kernel.org
Subject: [PATCH v2] sparc: Fix undefined reference to fb_is_primary_device
Date: Tue, 20 Feb 2024 10:54:12 +0100
Message-ID: <20240220095428.3341195-1-javierm@redhat.com>
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

Unfortunately, it missed to change the CONFIG_FB in arch/sparc makefiles,
which leads to the following linking error in some sparc64 configurations:

   sparc64-linux-ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_fb_registered':
>> fbcon.c:(.text+0x4f60): undefined reference to `fb_is_primary_device'

Fixes: 55bffc8170bb ("fbdev: Split frame buffer support in FB and FB_CORE symbols")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202401290306.IV8rhJ02-lkp@intel.com/
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---

I don't have a sparc64 toolchain to test this patch, but I'm pretty sure
that this is the correct fix for the linking error reported by the robot.

Changes in v2:
- Add collected tags.
- Also fix arch/sparc/Makefile (Thomas Zimmermann).

 arch/sparc/Makefile       | 2 +-
 arch/sparc/video/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index 5f6035936131..2a03daa68f28 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -60,7 +60,7 @@ libs-y                 += arch/sparc/prom/
 libs-y                 += arch/sparc/lib/
 
 drivers-$(CONFIG_PM) += arch/sparc/power/
-drivers-$(CONFIG_FB) += arch/sparc/video/
+drivers-$(CONFIG_FB_CORE) += arch/sparc/video/
 
 boot := arch/sparc/boot
 
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


