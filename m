Return-Path: <linux-kernel+bounces-61013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64C7850C4A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53CC628255D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3FC3A8D8;
	Sun, 11 Feb 2024 23:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="MGZFT/gt"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1A837157
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 23:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707693367; cv=none; b=BTOikc9d77dzSBtWHEA7ImCD3u2JGN5RIMJbB2XSKXIM0YoJCBZXrQJJQVw4m47p95N1k9JXdsFNgE98uwJRw6jUEvsjbSnoIOnxz4zBPNga0Q7exGe4ayIolLX/ogto2UsZ/Z9Q96dTLyxuc6qYRbFGpdFwLp/Mt91Fgk6a7QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707693367; c=relaxed/simple;
	bh=vVaFOilpxLPhAvgW98K39yGa6ovKunon69GOcqaDBNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d9s/NS1KTaG3MMteFyaC2WDNUBi4tWJX2tZAWyTJEDYLKdKjzicAObm1MqAchEW9znKNEBmgttS9ZYCMRjUPvIFwOnKkAyoyh5cZx56owaXafP7kslBmqfAXD8gSQ8+IAnymJ3zIBv8rqRhrui38QAj6f3CR5fr5DZBv6XHgljo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=MGZFT/gt; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-560e9c7a094so3434991a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707693362; x=1708298162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RzTfSVvaxCQds+vfCIgTWL90cMKMfve56yUjlfe8no=;
        b=MGZFT/gtQPqRtUyQcqrDeSRn7L29r3DPwjnuWidS3okTxyR3ML0r3DhxdC7SHqrWIz
         MN7nAb56VdNGFEjBkmwvAULJnsbKCDUviHtb91FNf4LCtoKfK52K9GsESjOmeLL5egsG
         X4XKQcYMIgjG16wVwn43jx1FJrUjGfRuiPkIP96xevqrrNiiNAKs06to8MP3CsFs3qAU
         jiuI2XT8pu6Wa4ZBydbjAGFLFDu3cW8wXB0D0M+5FibVSDvJYQdzqU9rY8ANA4sGWM6B
         pPPjEoISJZFTXB9DYjK5a+lyPvX9QzL2nkx6Z0eddXDnj/SwIfFGx9Eka6dC/NLXt6nE
         XzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707693362; x=1708298162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RzTfSVvaxCQds+vfCIgTWL90cMKMfve56yUjlfe8no=;
        b=qNhezO12Y5MX/wCu0oPwg21RZkkPIC5XxSCBZxSn6qtpmf0w0yO5TStOPOL5I8TLep
         V5tCOblP1nr5dGGm00i812UPfzgrKjfnywp1Vu/kgWvYq9tkRF9Vr5RnOXzlAaAWfG82
         uQrKrvyxV3uhEA9tUgN24sWVVBG0ZiHScMk6CObltlD4zevCk1P/Lb8Xao3K57oJoBph
         ttmjFmENAO7XHCi2aG68AvBsvhgg6HZ80XFE2VQHg3S1pG5ba8pyqxIlxoZJYEtL+98P
         LV35UdQPpjXVdzTahdvvH6Hwxtcp+ddq08MICfBB3NbgOcBSBMHsRA9sDSoSXMwVpYm8
         ev5A==
X-Gm-Message-State: AOJu0YxvVbiuvSgE3ULjcR2mZuCzPow9kNupnKaxa86N7zn5jhxkMZBW
	KRloS4beBUVcObYUmnw+HEB5n0uhyZpUiD51C72sseSl9S/lzTgddYnSilVvdVPKovJg97b6kCs
	C
X-Google-Smtp-Source: AGHT+IGBH7mKcU4ytRHjcFIexPOL0NCAPNjq5EQDUsuCyLCkvSwWGvFGoKDKgYBFY5vLQtTgE7DYkA==
X-Received: by 2002:aa7:df8b:0:b0:561:c6e8:ba96 with SMTP id b11-20020aa7df8b000000b00561c6e8ba96mr5284edy.25.1707693362108;
        Sun, 11 Feb 2024 15:16:02 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id et13-20020a056402378d00b0055d19c9daf2sm2170180edb.15.2024.02.11.15.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 15:16:01 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 31/35] linux/kernel.h: move READ and WRITE to direction.h
Date: Mon, 12 Feb 2024 00:15:14 +0100
Message-Id: <20240211231518.349442-32-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240211231518.349442-1-max.kellermann@ionos.com>
References: <20240211231518.349442-1-max.kellermann@ionos.com>
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


