Return-Path: <linux-kernel+bounces-59649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 822BD84F9E7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11A951F27C7C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CCE1292C7;
	Fri,  9 Feb 2024 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="IDQ8Q2+4"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCA77BB05
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496881; cv=none; b=erqaSYt1WZHHvcx/5VCC2eJL6cn+uQMFo90AJgDtGgQM3P+EpCPuC5omATRT4klupK0XTIaIo41t8dfW+VJ/cnaRpidUCMv3jsyjYjymsl1ouE6nUAX1zDfNGoNM0DIygZOjXLSe/KnqJ7yh5Jj4VXUjQDTm6OZ/f5QEV5MXAD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496881; c=relaxed/simple;
	bh=vVaFOilpxLPhAvgW98K39yGa6ovKunon69GOcqaDBNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X8rWwEPFLCZ1j8yc2l6vd8xFkxfepMZCHeS9Tz2m/r4BUiZeEoKCebMzHUoywRjj23pqnKrWTJhY1fd6c1iFgqlAoviBukrr6ia4rRPsrRVyHMUMlopua64Evy/0kfJS6Z4CserFWpEJ2Jpd5jfgSdP435ctYhFLy+mzT3Xm3tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=IDQ8Q2+4; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-560c696ccffso3884833a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707496875; x=1708101675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RzTfSVvaxCQds+vfCIgTWL90cMKMfve56yUjlfe8no=;
        b=IDQ8Q2+4owy3M3itQpNSfbzJOPViCOgZCFx7bYnmYQkYHEQueXZn1OlKORby+O0EuL
         L/aq9ir7EYqe3PaXWN5mOulzZ3WrmEXwU6FALCyMBJTb+FZq9X+1fPNo9fDuZ1Fmi6CI
         0t4i/eQf5uFQgbzQaxSOWnpbzGhy2WHALxCtJUsV8bHWqvpzW5MpsLWu5U/qQHElgz0S
         gpky89TZWE9gAwIxn89DqSFMP5Gn9ZvIc2rcrB6RdqPuX9FZdB8fNNTvrPW0KNraCW7B
         RwUjDuRpPJ2UN4ADjcvwCGTaqZaUoi/+/nn/di34yA09m4H/WK4DA3ys9kKZzCwG5cYl
         heGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496875; x=1708101675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RzTfSVvaxCQds+vfCIgTWL90cMKMfve56yUjlfe8no=;
        b=CVqKNaQ22MxByK71TfxwKjLxVO+dIV/XPiUU4fJIK+WRdN3RD9MgfwSwoYgPDzBsxn
         flvyzHVKAF+BVS3dQCAb5JGTkdUZVZ4MlxSl553I63HR71d+0Xe+brgfP+chSYNle9WR
         HKNLktCP5vBwNV+730VWwT9Ak7b9W68IbO4+RhITM3Ywl8IW0OGYAinLRYfhrN4/+e11
         aaS8xRmByjWN8sbwFY7WW+PQvMFqbwQmu6xDt7aGYUFW4+27r804xt3oonGmSh0COoW+
         i79FNwKkelHnlZeZAk3fyQ0Tlo+Q+BYvCP8SlS1EQiw1eaB3Bb0Z962sRWZrX53CPmBu
         4KRg==
X-Gm-Message-State: AOJu0Yx5zCGz/eXIlXUHVaPtkwFvbIVRXvsNvdZXnMod7PD63zW3K5Hu
	/GTJm7eEbjq7cHCJrBImB+XJ+Giunkw4XR1t+0rEd3YKs+lkTShaw8KqjdrhcEXYRkYzwmRmulT
	P
X-Google-Smtp-Source: AGHT+IFHyejJdjiNw7BfnBRES/eTSSoPBF1y3sZWIrJTI29pqN4apVIYblk8jauhofe4WuI6m53otA==
X-Received: by 2002:a17:906:1c4e:b0:a38:4340:60d3 with SMTP id l14-20020a1709061c4e00b00a38434060d3mr1429684ejg.10.1707496874787;
        Fri, 09 Feb 2024 08:41:14 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id tl27-20020a170907c31b00b00a3bfe97fe27sm477724ejc.218.2024.02.09.08.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:41:14 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 31/35] linux/kernel.h: move READ and WRITE to direction.h
Date: Fri,  9 Feb 2024 17:40:23 +0100
Message-Id: <20240209164027.2582906-32-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240209164027.2582906-1-max.kellermann@ionos.com>
References: <20240209164027.2582906-1-max.kellermann@ionos.com>
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


