Return-Path: <linux-kernel+bounces-60760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A545885092E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1EF1F259F8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F8760889;
	Sun, 11 Feb 2024 12:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ceaZ4YG4"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5285C60249
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707654651; cv=none; b=OFzFgaUXeqWKOS6szxyLwKVHvOfZlryMpuWvDwbaLuxMjjcbdqKQ28L8/iJINc85d/l9fdtA2g3wIW1B/FFTO5HX9hVP8F5gWVHaN0GYrhDO5WFBC50/c6peDbZiEN8DWNCAoaFVvsCAwy384lHgD3rmGlfpEyiyY74iES4/Orw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707654651; c=relaxed/simple;
	bh=vVaFOilpxLPhAvgW98K39yGa6ovKunon69GOcqaDBNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gbU4p/MHhVJIJ7I1jSrZvbgbHPW7uytsiH56b8l7l3zT2yvYhjTNGHVykiB9CbkSDi+EZ7zbzxnZSsAxIvVqCmoDPyy/5L1rZLVnkwfb2z2PI9jRD5SkLA3Wm6hhTy9Zf+SbD7GGhzt/OU1JtNSgmGwrrorevCeMwZ+ZbAt4U9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ceaZ4YG4; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56001b47285so3090158a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 04:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707654645; x=1708259445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RzTfSVvaxCQds+vfCIgTWL90cMKMfve56yUjlfe8no=;
        b=ceaZ4YG4UoZBYIsgw+j8smZXzx/mtuHpjAMDqTGp8+K5mCB57m86PyGa/hm4u1+7p8
         JfY8TaQe5iwa1/sfCHeuiiNBBV1FzTb73qpx3faFWWpt81aEUZ1hJtPQHPiYmUCjkxLM
         QH4xp9ubds0IFV+J29xZPyR1LJ9zepY9XX1Y0TahYX9hg72x+rLgnzpvK5+zbadlarXx
         RJeLRzVZDJ8AljqsOOCRR3yCh5Vffp6J8Ef6R2eJvWltuuz6ZDUkax1sY3oZIHsu8xjY
         g4yeLN6JGqFvPsvUyRLKFPN31kNA5g/P6bnk9X81R1OuY1Fs5EsMCIU7Odw52cl4gN+/
         9qag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707654645; x=1708259445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RzTfSVvaxCQds+vfCIgTWL90cMKMfve56yUjlfe8no=;
        b=rYm0GFUeZDjhzuOgIUKzLzmy4r38T/zeZstKl3powC0OZ7LoJFHEmwn26V6Ecb6YEV
         HF5Qk16N0oN95FW3+hveM7rFNtEtt9GXFUYrzds8qWuh4il0Q9aEckpuDcy0tHcCjYTl
         JXqonTH5FxB4RaynGt09FkV9m6P8TolrOzYqwDuoigzOBrg/jZssNzUJF46EiG/M6IAf
         J0ZPMqakSIJkop6gdsC2buAEBlfnA/0mOLBh/jYZ71UOrN4Y+3l2ZyB2J/A8nRgBbQsY
         wHUK+Upr4LRuTAnSiS9sn4f9k8jhBC6f8JiZTYY9ZVqT7mkTPGjHxt3z1Yg0tzS/FpZp
         vtLg==
X-Gm-Message-State: AOJu0Yx8bb1NmVJBzHlUMhQszV7zsjY4YHt+cYQEJHi11tnAACNzo1oN
	zakfYYSFA4asv3S77Gf1MB25AtGAXf7+hfT5Ep8m6w8MN0cRjncuEwbwtQscYN1HWN7fkD7q9WY
	6
X-Google-Smtp-Source: AGHT+IHandP0049CfMYBvHiLGSFYKsEK0XLqIVtHHpQvv/OkpyzgwwkHXzeI/iRkFQCtldAfgS6FYQ==
X-Received: by 2002:aa7:dad0:0:b0:55f:e35e:137c with SMTP id x16-20020aa7dad0000000b0055fe35e137cmr2602352eds.25.1707654645060;
        Sun, 11 Feb 2024 04:30:45 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id fj18-20020a0564022b9200b0056187ca4120sm1024611edb.10.2024.02.11.04.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 04:30:44 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 31/35] linux/kernel.h: move READ and WRITE to direction.h
Date: Sun, 11 Feb 2024 13:29:56 +0100
Message-Id: <20240211123000.3359365-32-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240211123000.3359365-1-max.kellermann@ionos.com>
References: <20240211123000.3359365-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reducing dependencies on the header linux/kernel.h.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 drivers/memstick/core/memstick.c    | 1 +
 drivers/memstick/host/jmb38x_ms.c   | 1 +
 drivers/memstick/host/r592.c        | 1 +
 drivers/memstick/host/rtsx_pci_ms.c | 1 +
 drivers/memstick/host/rtsx_usb_ms.c | 1 +
 drivers/memstick/host/tifm_ms.c     | 1 +
 fs/overlayfs/copy_up.c              | 1 +
 include/linux/direction.h           | 9 +++++++++
 include/linux/kernel.h              | 4 ----
 include/linux/nd.h                  | 1 +
 include/linux/uio.h                 | 2 +-
 11 files changed, 18 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/direction.h

diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index 7afc0132f512..e48ca1bdea66 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -12,6 +12,7 @@
 #include <linux/idr.h>
 #include <linux/fs.h>
 #include <linux/delay.h>
+#include <linux/direction.h>
 #include <linux/slab.h>
 #include <linux/kobject.h>
 #include <linux/module.h>
diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
index 594f55b8cd11..0621121edb95 100644
--- a/drivers/memstick/host/jmb38x_ms.c
+++ b/drivers/memstick/host/jmb38x_ms.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/spinlock.h>
+#include <linux/direction.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
index b941c8d02f7c..76a480de78d2 100644
--- a/drivers/memstick/host/r592.c
+++ b/drivers/memstick/host/r592.c
@@ -12,6 +12,7 @@
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
 #include <linux/delay.h>
+#include <linux/direction.h>
 #include <linux/slab.h>
 #include <linux/kthread.h>
 #include <linux/sched.h>
diff --git a/drivers/memstick/host/rtsx_pci_ms.c b/drivers/memstick/host/rtsx_pci_ms.c
index 15720a4afac2..4bd00d69a9b6 100644
--- a/drivers/memstick/host/rtsx_pci_ms.c
+++ b/drivers/memstick/host/rtsx_pci_ms.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/highmem.h>
 #include <linux/delay.h>
+#include <linux/direction.h>
 #include <linux/platform_device.h>
 #include <linux/memstick.h>
 #include <linux/rtsx_pci.h>
diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/rtsx_usb_ms.c
index 29271ad4728a..eeebdde571e6 100644
--- a/drivers/memstick/host/rtsx_usb_ms.c
+++ b/drivers/memstick/host/rtsx_usb_ms.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/highmem.h>
 #include <linux/delay.h>
+#include <linux/direction.h>
 #include <linux/platform_device.h>
 #include <linux/workqueue.h>
 #include <linux/memstick.h>
diff --git a/drivers/memstick/host/tifm_ms.c b/drivers/memstick/host/tifm_ms.c
index c272453670be..c46b6157aa25 100644
--- a/drivers/memstick/host/tifm_ms.c
+++ b/drivers/memstick/host/tifm_ms.c
@@ -10,6 +10,7 @@
 
 #include <linux/tifm.h>
 #include <linux/memstick.h>
+#include <linux/direction.h>
 #include <linux/highmem.h>
 #include <linux/scatterlist.h>
 #include <linux/log2.h>
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 6a861535ed38..7431a4b20081 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -16,6 +16,7 @@
 #include <linux/uaccess.h>
 #include <linux/sched/signal.h>
 #include <linux/cred.h>
+#include <linux/direction.h>
 #include <linux/namei.h>
 #include <linux/fdtable.h>
 #include <linux/ratelimit.h>
diff --git a/include/linux/direction.h b/include/linux/direction.h
new file mode 100644
index 000000000000..78d70701579d
--- /dev/null
+++ b/include/linux/direction.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_DIRECTION_H
+#define _LINUX_DIRECTION_H
+
+/* generic data direction definitions */
+#define READ			0
+#define WRITE			1
+
+#endif
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 67662bdb17d0..5d088ce30045 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -39,10 +39,6 @@
 
 #define STACK_MAGIC	0xdeadbeef
 
-/* generic data direction definitions */
-#define READ			0
-#define WRITE			1
-
 #define PTR_IF(cond, ptr)	((cond) ? (ptr) : NULL)
 
 #define u64_to_user_ptr(x) (		\
diff --git a/include/linux/nd.h b/include/linux/nd.h
index b9771ba1ef87..eb8e037d92c8 100644
--- a/include/linux/nd.h
+++ b/include/linux/nd.h
@@ -7,6 +7,7 @@
 #include <linux/fs.h>
 #include <linux/ndctl.h>
 #include <linux/device.h>
+#include <linux/direction.h> // for READ, WRITE
 #include <linux/badblocks.h>
 #include <linux/perf_event.h>
 
diff --git a/include/linux/uio.h b/include/linux/uio.h
index bea9c89922d9..306b0fffe2a4 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -5,7 +5,7 @@
 #ifndef __LINUX_UIO_H
 #define __LINUX_UIO_H
 
-#include <linux/kernel.h>
+#include <linux/direction.h> // for READ, WRITE
 #include <linux/thread_info.h>
 #include <linux/mm_types.h>
 #include <uapi/linux/uio.h>
-- 
2.39.2


