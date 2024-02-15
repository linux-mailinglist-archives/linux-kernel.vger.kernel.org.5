Return-Path: <linux-kernel+bounces-66562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E06855E51
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365961C22646
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B791BF5D;
	Thu, 15 Feb 2024 09:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="FDbUrGDJ"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFCF1BC36
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989827; cv=none; b=L7jdqrnZzV5BvZsnBTe92nVFksn237Awn8HhcwV1a3GyO0GCLJJJzxpIFyD2P98eGTT2z8UQsoY4QmG+Tkuc3gzizbgpFxHItYHIXCRptbnOnBxtjcFiUTN6f+AhAqUSlKPzG8oA9hu//agZ6J7YnT4t429RWCXxmUW5JxqZjDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989827; c=relaxed/simple;
	bh=jY5dj1ThpsIuN7XJJW1uT42jgkmQrscd1nxpX2OhyMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VYXbLjEOJqppCLfCjI42n4s2OnZYKZFx4/SnnoacxDIOsoXAuzBIbTcaQGnnf1ax4orqtVugFOjMkHI8JRwRGoFTFkzmnipgi6ginOpv0pkSY4My3NUSvB30LBdi5J67ynWXMXsc1s6KFgSyF9odbaqU3qAWt3ZNQsFCYOavg2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=FDbUrGDJ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a36126ee41eso81676766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 01:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707989823; x=1708594623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ickuvkgsuryJ7QB6aeyaT4/rf7qDfQYCAiw5coU/dY=;
        b=FDbUrGDJ4vqc1WfAmOgsAuUQ/kTqrzbK8EiPFx623EYwgtkTCn++RogLLV3bUrBh93
         vhdf66mVV9dkn8xk9OqzNv6CgFiZO/oEY0iKoPRIZGh6B1G7q1JEUn1XkxO3IJYXTEka
         phvobhn5dGOBNNyolkMZ4b7JTl6xppe0ke/T+EVbbB84gzkNK20HidyLT665FqkgZXcJ
         6jWZuBD8yDjYoAoILa0ltpFhIrGsE1eVf2a++BefQ7avlkYrP24bKdSt78VaUujNeAQP
         PsvFD9hoou16A3QOBgomznWYqpwsRZknmBhlZJkBkit33l+g58y0JjQll6+HKrfD4Qx3
         CQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707989823; x=1708594623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ickuvkgsuryJ7QB6aeyaT4/rf7qDfQYCAiw5coU/dY=;
        b=QnUYX64VlFSoe9+MVzkzlNn6CIC1PKa7+7d5yz+CLsqoSqwu+eLvjyp6GV5YKsfFrs
         Fli0o3svbAvZ6dAZC9pt18PiOLXcZi0SpLGIES1mJ8/nwwLjZNnXBMh/3SiLrayNFdZS
         MfmZxTtDWQPeFLGcSeJWlbYriGhCil1hY3aaaLkeoxM6gFdkp8J3LiJBpt+9zyGL1swN
         Erp1S+ToAwI3ZGeyQpbKYNtSdTUkCp8fGMxsIP/p1FgNA8XilLJHVEgib6Tf6PsJttvy
         EW0Igomsy7MetCE8G7+xkLsxDGPrPpteuNSQ1iThEDXAK8wEu0kVONMPpiCauWhxAIZH
         cioQ==
X-Gm-Message-State: AOJu0YyFNTc9MjB850chVXZ36d40AuYxrB7wkjtTsRkMLjd/U5CAb/jC
	3MgBfQ0ZOwigPnvqlEg3j32Adk9Thp//dZ/ZwsBlj2b8wa0jmHgySLXfOkug8JeXgk8nJWnkY4Y
	M
X-Google-Smtp-Source: AGHT+IGi6owf0/kjoDqwYB495frezFp8I5t8MQXTn+rnraVsdwBeBAiLgULZnWPXNUb+/5WuZFMXqg==
X-Received: by 2002:a17:906:57d2:b0:a3d:916d:caba with SMTP id u18-20020a17090657d200b00a3d916dcabamr733451ejr.58.1707989823615;
        Thu, 15 Feb 2024 01:37:03 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id rg14-20020a1709076b8e00b00a3d09d09e90sm362059ejc.59.2024.02.15.01.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 01:37:02 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v1 8/8] linux/kernel.h: move PTR_IF() to ptr_util.h
Date: Thu, 15 Feb 2024 10:36:46 +0100
Message-Id: <20240215093646.3265823-9-max.kellermann@ionos.com>
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
 drivers/gpio/gpio-sim.c            | 1 +
 drivers/gpu/drm/i915/i915_driver.c | 1 +
 drivers/pinctrl/pinctrl-ingenic.c  | 1 +
 include/linux/kernel.h             | 2 --
 include/linux/pm.h                 | 1 +
 include/linux/ptr_util.h           | 7 +++++++
 include/rdma/uverbs_ioctl.h        | 1 +
 7 files changed, 12 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/ptr_util.h

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index c4106e37e6db..fdf17cc91b4c 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -29,6 +29,7 @@
 #include <linux/notifier.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/ptr_util.h> // for PTR_IF()
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/string.h>
diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index 9ee902d5b72c..6dd0d8fdd6eb 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -34,6 +34,7 @@
 #include <linux/pci.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
+#include <linux/ptr_util.h> // for PTR_IF()
 #include <linux/slab.h>
 #include <linux/string_helpers.h>
 #include <linux/vga_switcheroo.h>
diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index bc6358a686fc..f88d2d3d217c 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/ptr_util.h> // for PTR_IF()
 #include <linux/regmap.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 01a0cc0a0776..1f1b2ced524f 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -40,8 +40,6 @@
 
 #define STACK_MAGIC	0xdeadbeef
 
-#define PTR_IF(cond, ptr)	((cond) ? (ptr) : NULL)
-
 #define u64_to_user_ptr(x) (		\
 {					\
 	typecheck(u64, (x));		\
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 97b0e23363c8..7e593b5fc5f1 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -9,6 +9,7 @@
 #define _LINUX_PM_H
 
 #include <linux/export.h>
+#include <linux/ptr_util.h> // for PTR_IF()
 #include <linux/list.h>
 #include <linux/workqueue.h>
 #include <linux/spinlock.h>
diff --git a/include/linux/ptr_util.h b/include/linux/ptr_util.h
new file mode 100644
index 000000000000..7469aff978a9
--- /dev/null
+++ b/include/linux/ptr_util.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PTR_UTIL_H
+#define _LINUX_PTR_UTIL_H
+
+#define PTR_IF(cond, ptr)	((cond) ? (ptr) : NULL)
+
+#endif /* _LINUX_PTR_UTIL_H  */
diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index 5ed57a660ead..c94244e7a77d 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -7,6 +7,7 @@
 #define _UVERBS_IOCTL_
 
 #include <rdma/uverbs_types.h>
+#include <linux/ptr_util.h> // for PTR_IF()
 #include <linux/uaccess.h>
 #include <rdma/rdma_user_ioctl.h>
 #include <rdma/ib_user_ioctl_verbs.h>
-- 
2.39.2


