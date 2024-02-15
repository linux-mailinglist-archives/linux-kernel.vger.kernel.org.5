Return-Path: <linux-kernel+bounces-66560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D2A855E67
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BABDB2E912
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520B61BDE0;
	Thu, 15 Feb 2024 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="NSzFrQ5u"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5E219BCA
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989826; cv=none; b=JUVS8XTXWGMzW00ndY+t5DmzkymUen7gtY7MOByRoa9/DHPDBxHNyjhdSUXQLfnJUufUEIjylcZ8V+1wEB7rM2BfPOBy0Gvfv8u15hy8kVWImkspa8fZkblnZOsmaB/MCV04riWDLYz3zUf0ib0TQpJJ1i04iSFvluthqVL9qK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989826; c=relaxed/simple;
	bh=qa3ESH7vWTFVNhW4xY+/8wA/zae1Q18vWxlN7dbb6J0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FMp64NpAp9ZeOzvU4rA4xeuhF4Phc+qktEPbC0Dou90irESwlvL49qnEDntvLhfKPAvNCCsbySDqhVH7YUqyArgmNngyQ9pI68NsiUa2n+O14cC9jitgon3M5qjpqcQqcbGnJ649BjwCqX4ufuxbYBMOyScKjYIzUiphM94d9K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=NSzFrQ5u; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3d62da9d25so74449466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 01:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707989821; x=1708594621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+h1IEdtpwE+MgefySz12julwicOiuPFac8ie3+0rpxY=;
        b=NSzFrQ5u5Yt7t+fK0EdOlsh3Ei1hAx0oLDkWkymLfXQuTs+1oZr7kqZo8txNXBL1Pa
         Bwak8aEb6slBPPUA3idYNvHHrBcSrJD8zTb9hqSt4ebYueUORvwodNmuoWdtj7sd7r1j
         +xFRri3nIxlXOWtghW7EdoTlCPsABBMoihyMb9e2jRz+RmRtfHve7NfykCd9YjrEAppb
         X6wv2ffgoYHxopkHICfVRGHG1EuiF9wlGMhFcZ/MsIo55O3I4Wtf0jv/qbviPWSvfVK0
         N32OS7Z4COufhtSj2Cz8LJ7qrtbKLqHjrladGCwSTm9SKjYRIDQBHAc8qfAofAEuesux
         nSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707989821; x=1708594621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+h1IEdtpwE+MgefySz12julwicOiuPFac8ie3+0rpxY=;
        b=DFs/UCN0DFvaISBatHiviSb7WjcLuAOY7lHJUXAaV6k3XzeI2EzSZf2g6I/j7/yGz6
         pCdwblPcaziEVgUX+Req0FxwtILKkPmXZV8PW1tSgwvF6LPOvKv8jHb+Ro5R8BAzbTRN
         vvbxVyUot0eR1U8mQqY4AyttguC7Q1sp+VoG/eNzUOZ0NcA5qp6+cZ2JzRWv/ohlCm/N
         ZN+hP/mCd36/hnVtww6NLexMu4sqb/GlhUBkUU7pdVkR06eVQKJCXHjMV22mECEAbpx8
         T2FdE+RB2AwRkrf5n8Ya0kNwh5mNETLhd46VlOhO0wgMeFH7jutO56FpAxLgJxoSJSFM
         7Nag==
X-Gm-Message-State: AOJu0Yw2hwmCuEnC9ZygIAm/98qx8PmXjKLaoWjWU/ChrAhcP+tFzsf6
	KCbjwO3sdywVSOB3qYoLDdEbRgXJf8QMl6lNOA4cBKkY3gL3JsLM9SgT9ff3eCtcTGIr6COsF+h
	x
X-Google-Smtp-Source: AGHT+IEUQzhbJGuDHy3NZszYofnMmzmppTOLEzLxDW4Z+z34IcFGwZfKaQbb0RuKLXrx148oDnt7RQ==
X-Received: by 2002:a17:906:2c55:b0:a3c:770:1752 with SMTP id f21-20020a1709062c5500b00a3c07701752mr794174ejh.68.1707989820789;
        Thu, 15 Feb 2024 01:37:00 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id rg14-20020a1709076b8e00b00a3d09d09e90sm362059ejc.59.2024.02.15.01.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 01:37:00 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v1 6/8] linux/kernel.h: move READ and WRITE to direction.h
Date: Thu, 15 Feb 2024 10:36:44 +0100
Message-Id: <20240215093646.3265823-7-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215093646.3265823-1-max.kellermann@ionos.com>
References: <20240215093646.3265823-1-max.kellermann@ionos.com>
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
 drivers/input/misc/iqs7222.c        | 1 +
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
 12 files changed, 19 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/direction.h

diff --git a/drivers/input/misc/iqs7222.c b/drivers/input/misc/iqs7222.c
index 36aeeae77611..622cec9bcfe8 100644
--- a/drivers/input/misc/iqs7222.c
+++ b/drivers/input/misc/iqs7222.c
@@ -8,6 +8,7 @@
 #include <linux/bits.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/direction.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index 23fea51ecbdd..fcc28853d588 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -12,6 +12,7 @@
 #include <linux/idr.h>
 #include <linux/fs.h>
 #include <linux/delay.h>
+#include <linux/direction.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
index e77eb8b0eb12..dc8e4f6a01df 100644
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
index 461f5ffd02bc..9ab3a7a15674 100644
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
index 8586e2f5d243..465a7822b5dd 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -15,6 +15,7 @@
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
index f6a978d51c1d..55af40e63b92 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -41,10 +41,6 @@
 
 #define STACK_MAGIC	0xdeadbeef
 
-/* generic data direction definitions */
-#define READ			0
-#define WRITE			1
-
 #define PTR_IF(cond, ptr)	((cond) ? (ptr) : NULL)
 
 #define u64_to_user_ptr(x) (		\
diff --git a/include/linux/nd.h b/include/linux/nd.h
index b9771ba1ef87..ef344119214b 100644
--- a/include/linux/nd.h
+++ b/include/linux/nd.h
@@ -7,6 +7,7 @@
 #include <linux/fs.h>
 #include <linux/ndctl.h>
 #include <linux/device.h>
+#include <linux/direction.h>
 #include <linux/badblocks.h>
 #include <linux/perf_event.h>
 
diff --git a/include/linux/uio.h b/include/linux/uio.h
index bea9c89922d9..77a3e462d8c4 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -5,7 +5,7 @@
 #ifndef __LINUX_UIO_H
 #define __LINUX_UIO_H
 
-#include <linux/kernel.h>
+#include <linux/direction.h>
 #include <linux/thread_info.h>
 #include <linux/mm_types.h>
 #include <uapi/linux/uio.h>
-- 
2.39.2


