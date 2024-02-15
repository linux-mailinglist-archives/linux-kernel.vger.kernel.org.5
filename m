Return-Path: <linux-kernel+bounces-66561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D15855E50
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BC791F23DAB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757CA1BDEB;
	Thu, 15 Feb 2024 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="gb5Xu22i"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927841B964
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989826; cv=none; b=H539IscBeNHjHBmZGNlTfBANXlIuvpKyQWfERvAF7SFdhHjD2/rRnFpaO4U7RL8IfdRCJlNzLnlp1Mzatzez8HLypsLJ3+n8S4yLHvjG3r89/WpLtlArog69nCrW0Tydvu5drCPKhKdFC29J8N3ieXn4offCRGFokeeZnw3TZXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989826; c=relaxed/simple;
	bh=HcFHWZ0EaqKsC33i0AWS0HwuM+WXczm8p8HubB1WEWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BQvL1wWLqBUiepctqrY3TsKSj12Gf+baoyER3qV3THCvwgNZeG7rPXpKaewMIDHtRl2gVFiqZYJC+Y2bbTfAfCs55ih+PkFD/D8cyLvi9eA1E7Wz4P2giL1p+ihQRrXh97XnmoARpVeIUBmwU4BHwX1pvruByqYvpFjqpCDUCwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=gb5Xu22i; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5639b00a25cso815670a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 01:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707989822; x=1708594622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WG3uh9svReSzuApEUrRcGc5NvxynYpsbZWpwvFuM0Vg=;
        b=gb5Xu22iJUyr/wF/QQyR8jJKD/jFyZufYw81sV7LsopGs/AW4kw52FV8v3RObMbVy6
         KuEi2znC4FfzBklivhfrO5od81rF5NR89yd0yrz/hiSR12YV2/aLpVzpU2nnuv/cHSO9
         K5qKq+4Z2rPRXZmyXwn5YgoWOefj+Sukr1lqOfEz+HOxzRgvkvAuB4ibMZWCjkzGGKD3
         5Hj0YqWaY9ge/cDXCkPaZKb9R9GcQdLeGM3isKocG+cWry4VKIrbS3GFydkg0eWODAKq
         nF7efj3aoV1nkVCpVRrUKDf9PVh6q2r2NbK4s5whCJSo6jfHzUe5TqoLvafkm3L2VOxy
         vSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707989822; x=1708594622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WG3uh9svReSzuApEUrRcGc5NvxynYpsbZWpwvFuM0Vg=;
        b=DgkhkHl4pEaWiSvzhiwzFsvcSWn/2UlZp7oobAcZH54Uas27LZMEVBfBo0fuWGf/RA
         JaDkJKOHIenutWPANYI86WvrpfANiB8SAobhG68qMHycTcm9qFnuR7mLvEpmvY9A2gUb
         uiAg7lkE9UXcQX4rS8rhYgXItCcugLisVUGK5CF7ovFziO0i/Pjp8gxkQwxtAzejVJt7
         0Jff+G4SHnnnVvxeDmdyC2aBy9OgdmzfKS/1buUloMC2VjHCcrx29EWMITCqCA8LiPiS
         BnomG0J+2g9QqFPdFyphmYvce5S18WGbV3PrnATYdr8FIzhGmf/1oPOeYbuDDJ/3RGM5
         Y4qA==
X-Gm-Message-State: AOJu0YxOoCehpjf/QeHF3pmWFMXe45+izoYtSARjxtp75jFQJNHJH3ip
	qNmwC920R7HWyIcWRgkS8ajShc6Fu8qOUHKErFtz3usgaQJIjlQKk2yq8sBPb95fddkM3myg5RG
	1
X-Google-Smtp-Source: AGHT+IGLycJ/gzVix+qrPLsaBiefLT1tvGk0NgR0j4dqqlu59uThDmg0idASybnBwwTHPukMsTttlg==
X-Received: by 2002:a17:906:3c1b:b0:a3d:87f1:3339 with SMTP id h27-20020a1709063c1b00b00a3d87f13339mr867546ejg.10.1707989822276;
        Thu, 15 Feb 2024 01:37:02 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id rg14-20020a1709076b8e00b00a3d09d09e90sm362059ejc.59.2024.02.15.01.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 01:37:01 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v1 7/8] linux/kernel.h: move VERIFY_OCTAL_PERMISSIONS() to octal_permissions.h
Date: Thu, 15 Feb 2024 10:36:45 +0100
Message-Id: <20240215093646.3265823-8-max.kellermann@ionos.com>
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
 arch/arc/kernel/perf_event.c             |  1 +
 drivers/edac/thunderx_edac.c             |  1 +
 drivers/hwmon/occ/common.c               |  1 +
 drivers/media/platform/amphion/vpu_dbg.c |  1 +
 drivers/soc/aspeed/aspeed-uart-routing.c |  1 +
 fs/xfs/xfs_error.c                       |  1 +
 include/linux/kernel.h                   | 13 -------------
 include/linux/moduleparam.h              |  2 +-
 include/linux/octal_permissions.h        | 20 ++++++++++++++++++++
 include/linux/sysfs.h                    |  1 +
 10 files changed, 28 insertions(+), 14 deletions(-)
 create mode 100644 include/linux/octal_permissions.h

diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index adff957962da..48bc5c25842e 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -8,6 +8,7 @@
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/octal_permissions.h>
 #include <linux/of.h>
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index 90d46e5c4ff0..603f71fcdf44 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -20,6 +20,7 @@
 #include <linux/atomic.h>
 #include <linux/bitfield.h>
 #include <linux/circ_buf.h>
+#include <linux/octal_permissions.h>
 
 #include <asm/page.h>
 
diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index dd690f700d49..fc328aa417b2 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -10,6 +10,7 @@
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/octal_permissions.h>
 #include <linux/property.h>
 #include <linux/sysfs.h>
 #include <asm/unaligned.h>
diff --git a/drivers/media/platform/amphion/vpu_dbg.c b/drivers/media/platform/amphion/vpu_dbg.c
index 940e5bda5fa3..0f64dce90f9d 100644
--- a/drivers/media/platform/amphion/vpu_dbg.c
+++ b/drivers/media/platform/amphion/vpu_dbg.c
@@ -9,6 +9,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/octal_permissions.h>
 #include <linux/types.h>
 #include <linux/pm_runtime.h>
 #include <media/v4l2-device.h>
diff --git a/drivers/soc/aspeed/aspeed-uart-routing.c b/drivers/soc/aspeed/aspeed-uart-routing.c
index a2195f062e01..6b091df7775a 100644
--- a/drivers/soc/aspeed/aspeed-uart-routing.c
+++ b/drivers/soc/aspeed/aspeed-uart-routing.c
@@ -5,6 +5,7 @@
  */
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/octal_permissions.h>
 #include <linux/of.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
diff --git a/fs/xfs/xfs_error.c b/fs/xfs/xfs_error.c
index 7ad0e92c6b5b..90075bd7dbe3 100644
--- a/fs/xfs/xfs_error.c
+++ b/fs/xfs/xfs_error.c
@@ -14,6 +14,7 @@
 #include "xfs_error.h"
 #include "xfs_sysfs.h"
 #include "xfs_inode.h"
+#include <linux/octal_permissions.h>
 
 #ifdef DEBUG
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 55af40e63b92..01a0cc0a0776 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -29,7 +29,6 @@
 #include <linux/typecheck.h>
 #include <linux/panic.h>
 #include <linux/printk.h>
-#include <linux/build_bug.h>
 #include <linux/sprintf.h>
 #include <linux/static_call_types.h>
 #include <linux/instruction_pointer.h>
@@ -285,16 +284,4 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
 # define REBUILD_DUE_TO_FTRACE_MCOUNT_RECORD
 #endif
 
-/* Permissions on a sysfs file: you didn't miss the 0 prefix did you? */
-#define VERIFY_OCTAL_PERMISSIONS(perms)						\
-	(BUILD_BUG_ON_ZERO((perms) < 0) +					\
-	 BUILD_BUG_ON_ZERO((perms) > 0777) +					\
-	 /* USER_READABLE >= GROUP_READABLE >= OTHER_READABLE */		\
-	 BUILD_BUG_ON_ZERO((((perms) >> 6) & 4) < (((perms) >> 3) & 4)) +	\
-	 BUILD_BUG_ON_ZERO((((perms) >> 3) & 4) < ((perms) & 4)) +		\
-	 /* USER_WRITABLE >= GROUP_WRITABLE */					\
-	 BUILD_BUG_ON_ZERO((((perms) >> 6) & 2) < (((perms) >> 3) & 2)) +	\
-	 /* OTHER_WRITABLE?  Generally considered a bad idea. */		\
-	 BUILD_BUG_ON_ZERO((perms) & 2) +					\
-	 (perms))
 #endif
diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index bfb85fd13e1f..860b0ea1f3b3 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -4,7 +4,7 @@
 /* (C) Copyright 2001, 2002 Rusty Russell IBM Corporation */
 #include <linux/init.h>
 #include <linux/stringify.h>
-#include <linux/kernel.h>
+#include <linux/octal_permissions.h>
 
 /* You can override this manually, but generally this should match the
    module name. */
diff --git a/include/linux/octal_permissions.h b/include/linux/octal_permissions.h
new file mode 100644
index 000000000000..57d4d6a5b66d
--- /dev/null
+++ b/include/linux/octal_permissions.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_OCTAL_PERMISSIONS_H
+#define _LINUX_OCTAL_PERMISSIONS_H
+
+#include <linux/build_bug.h>
+
+/* Permissions on a sysfs file: you didn't miss the 0 prefix did you? */
+#define VERIFY_OCTAL_PERMISSIONS(perms)						\
+	(BUILD_BUG_ON_ZERO((perms) < 0) +					\
+	 BUILD_BUG_ON_ZERO((perms) > 0777) +					\
+	 /* USER_READABLE >= GROUP_READABLE >= OTHER_READABLE */		\
+	 BUILD_BUG_ON_ZERO((((perms) >> 6) & 4) < (((perms) >> 3) & 4)) +	\
+	 BUILD_BUG_ON_ZERO((((perms) >> 3) & 4) < ((perms) & 4)) +		\
+	 /* USER_WRITABLE >= GROUP_WRITABLE */					\
+	 BUILD_BUG_ON_ZERO((((perms) >> 6) & 2) < (((perms) >> 3) & 2)) +	\
+	 /* OTHER_WRITABLE?  Generally considered a bad idea. */		\
+	 BUILD_BUG_ON_ZERO((perms) & 2) +					\
+	 (perms))
+
+#endif
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index b717a70219f6..d584184db8c2 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -21,6 +21,7 @@
 #include <linux/kobject_ns.h>
 #include <linux/stat.h>
 #include <linux/atomic.h>
+#include <linux/octal_permissions.h>
 
 struct kobject;
 struct module;
-- 
2.39.2


