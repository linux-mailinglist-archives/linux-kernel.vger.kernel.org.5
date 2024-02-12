Return-Path: <linux-kernel+bounces-61491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B818512D8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11D31C21035
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B1E3E480;
	Mon, 12 Feb 2024 11:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="dBvYcLNS"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2003D0A4
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738949; cv=none; b=lLSXput2TXD4+dxXqox3OKIfDc/1kldnkrKoJ6xS9foMPetKg+D9r3dB9I/emVYzV1D9hGsPk/f8/jqgpDp3LVYhES/xilBRv124SduQ2+Iyobxym11vXId11YispjUBhGZrHDSYfbaAT6Hog0K2aJWHxBCeqD4Ot1ggFK+/mJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738949; c=relaxed/simple;
	bh=vVaFOilpxLPhAvgW98K39yGa6ovKunon69GOcqaDBNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BhkzQOUevjYhVoF7r8tj0hTmqsrL0NJ8nefRa1Y8AkX3OpvqPNdvfYEVSLJK15dZ6WOlhS40sI5Y6ftnAhI631uGpQmOlNVNo3HJmq5udG5qb7UyIVuUGdgZ64ZaHhXqGvV6wrRcBzYW++kEbO8HzBFPYRvyBZwVBI1wXmCXMZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=dBvYcLNS; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3916c1f9b0so414208166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707738944; x=1708343744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RzTfSVvaxCQds+vfCIgTWL90cMKMfve56yUjlfe8no=;
        b=dBvYcLNST9UqtJxbbK+WUZhkJag1KFaYGSB6nK2SJ6VKO4vrhS9XjucVfyqdjhu2t7
         gACBeMiG696XocoOJw4OLFPgKplfzo0JPTbn4ddx4ddc3y4tS7NO1HTdZZ28HD+H0I+M
         z/vjcvDcpLr3q6pii7BYHIk/CpUs8xlHDgWmCmEBiyEybmxtqvK/Lo9cwS9BOg6xcANZ
         9rt5S2evyb8adyIrgDJ8GA1DIMZjTEBAdSX9UvCqDtKy6qotZBL6H2q2atFVBISi4SKF
         ckI/SklhpjYs4yGb8EdkVgpkyx6aeBXqPc4T7Kn1BX3FALOYi8+My+Q44CAD9W8LPRsi
         StGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707738944; x=1708343744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RzTfSVvaxCQds+vfCIgTWL90cMKMfve56yUjlfe8no=;
        b=M60mg8vdOy7be0VZTQl9Bn9uV8jImNaWqRy5mlLZ46Vm4X4M2HkcGX/utguoeOHysW
         G9J36UPxZF7X9MSledp7+v4S5qPYDT46/WS4hpIt2l2WgLyfLCeC99hGugRzpHIlc8w6
         tE+n0Ab7YzQpMv1xdrJJgMYs+xYxruBxJZ1kwjHNclZAlsFPdKh4LRg4F8qOUuvldncc
         W5frSCKMDgd3ja4qSTmfMmaQP325aOJm5QOwnDIi8I3i1wQUJ36gZSd9s+eGRERASunU
         xj1ZWRURP30mv4+Ik1WCc+YOnEdXWg2I7HlKGUFztwSa1d4xjcULdP53p+twDCV5oHze
         issw==
X-Gm-Message-State: AOJu0Yz5dF7H6Lkpjun8uB9/Ex63xe+fk0hSkO9Yj9zKiHaaX5lEbfEA
	n/9vH6SLSjmB8bAjURt+eyZfIQ9FvEAxlPZA4npBqgdAY6B1dkfOoT/s9Haf4SlPlUia7/aL/mD
	M
X-Google-Smtp-Source: AGHT+IGPwyj4ysTHfcN17YrAT2BkrW7RLLWMTCRS2zipAgDOUexGPF8WZsVBWpOG2ln49ugsBH9Kug==
X-Received: by 2002:a17:906:7db:b0:a3c:3411:de61 with SMTP id m27-20020a17090607db00b00a3c3411de61mr3669443ejc.40.1707738943890;
        Mon, 12 Feb 2024 03:55:43 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090607c100b00a36c3e2e52dsm139203ejc.61.2024.02.12.03.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:55:43 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 31/35] linux/kernel.h: move READ and WRITE to direction.h
Date: Mon, 12 Feb 2024 12:54:56 +0100
Message-Id: <20240212115500.2078463-32-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212115500.2078463-1-max.kellermann@ionos.com>
References: <20240212115500.2078463-1-max.kellermann@ionos.com>
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


