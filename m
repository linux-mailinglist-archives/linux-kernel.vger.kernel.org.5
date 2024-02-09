Return-Path: <linux-kernel+bounces-59652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE0F84F9EA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E282D1C26C05
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FD412C52A;
	Fri,  9 Feb 2024 16:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ZM4Dshbn"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340771292F8
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496883; cv=none; b=VySK345CeTByri63OV8txg+Hd9gytvRe/oH2ZG80PrHl8S1rJzCbs/IZcsKeISv+5v+kvZYpLIRsMJ1rLtZduirL7mV73wk+s+5mW9p6M/f1EkRPU+13m55E4BWLCsd2uacFW17yVJ1xI249b/vp64DPBt9hJyTVicCK3gWrqAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496883; c=relaxed/simple;
	bh=5WoLQ+20FuNzDTgx6dlWdeAOXVkYHDqU6RsL5tdTmfc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VgZG3miU7BwfFu6RHx6Q9TUWxTBR1+zMxc40hvoNbVQL2UHYpPQpaLcITibKriLl/IKkQ+rW6VnGHsY8xsCIr6oaXQ0HpJvr/FVX2nd/KzB7mXQ52Y7w1pHmaCAimZk3hnjFEN2mAl0p/UhaZ2s29bydWDaXSLO7P3HzxGxkjLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ZM4Dshbn; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a383016f428so127946866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707496876; x=1708101676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKk+aGvc2YUoK3OFau8iqg4ZDHFtN8sLbkkpKq6ClNw=;
        b=ZM4Dshbnwb6ldz/uZQgEDTAtjh8P9lOFBXnxms73HCwhThxbaMJkwwYpcbmZM78FmS
         mUTXzAwZ4OWeCMkjz/WduyvQNFZkFqGQy5Y3EaNkKZVayPrmXHzNTRnRHY9v6R0MD8Yp
         7FiAUcY6z2eUb7MbY4Ry54qH2+9/eAcIF0ColR9QVLftcF1s1JeD1rLnLoWsYUcgYm4V
         YiC9VWNyVI8AQUgxRm8mjhMwq/8EDRZ1gwfJp1yu8oYv+uXwe7R9H0zegekREMbgEQ1w
         DPq4hzFfDBzN19lMq+0GGGl2IlbhbHQ0CttpdXJtUD/eFfb6HS9QlgPYe1omazyq46Zl
         1DlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496876; x=1708101676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKk+aGvc2YUoK3OFau8iqg4ZDHFtN8sLbkkpKq6ClNw=;
        b=D9xjamW5SmtwoEycTcM6tpVhyn6R+lhOCfO9gneR5ol1xIRlHVzalWkB/T1Crw15fj
         0uahcAzspEGswplQh8HvHyNIsyqA1BRLXx9+6mRAz7fuvivdLqaqxQSmTnTB63yctGrK
         ++e0sWrYfvo+FpjoCLO2SOsmugMpiEzeIQdJOQC5ansA8v804cFLhxokkrTiMKbxNtCW
         YjIsV89GlxRF/m5Sl0Rbn98JbGUJrVe+GcTPqcmwnqHZQ2LsCeld+2ZXWEsZ07qJ9Nj/
         1LhxtpvnCjS8C01zDMgitHf7ZTrtzb3WK06gkyg2FO3hg/qunovos5C6I0gOvO2p+Oli
         c1Ew==
X-Gm-Message-State: AOJu0YzF+WsB4Q1pkLW6FXuxhVi9it1anvSR7gFMM4zCW2FUE3vyccbw
	pl5sf0CXaCBF0E3kNSp0BEQjmeQSs2DPjeplu9LgoSy1tAEdqq5RuFy0qwXxCpk8F6YLhHR2j9a
	F
X-Google-Smtp-Source: AGHT+IELBxOziINdJQqpIWiZqVviVxJEL1dud7H96GV0aEdsRv3IEezlG8LZ5nTr+YOOuMIplwfSwQ==
X-Received: by 2002:a17:906:ff4f:b0:a38:252b:ba1b with SMTP id zo15-20020a170906ff4f00b00a38252bba1bmr1590640ejb.51.1707496875807;
        Fri, 09 Feb 2024 08:41:15 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id tl27-20020a170907c31b00b00a3bfe97fe27sm477724ejc.218.2024.02.09.08.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:41:14 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 32/35] linux/kernel.h: move VERIFY_OCTAL_PERMISSIONS() to octal_permissions.h
Date: Fri,  9 Feb 2024 17:40:24 +0100
Message-Id: <20240209164027.2582906-33-max.kellermann@ionos.com>
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
 arch/arc/kernel/perf_event.c             |  1 +
 drivers/edac/thunderx_edac.c             |  1 +
 drivers/hwmon/occ/common.c               |  1 +
 drivers/media/platform/amphion/vpu_dbg.c |  1 +
 drivers/soc/aspeed/aspeed-uart-routing.c |  1 +
 fs/xfs/xfs_error.c                       |  1 +
 include/linux/kernel.h                   | 13 -------------
 include/linux/moduleparam.h              |  2 +-
 include/linux/octal_permissions.h        | 20 ++++++++++++++++++++
 include/linux/sysfs.h                    |  2 +-
 10 files changed, 28 insertions(+), 15 deletions(-)
 create mode 100644 include/linux/octal_permissions.h

diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index 9d43a9988812..dbc24c9351d1 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -9,6 +9,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h> // for upper_32_bits(), lower_32_bits()
 #include <linux/module.h>
+#include <linux/octal_permissions.h>
 #include <linux/of.h>
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index e99ce19e6574..c610d99dceda 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -21,6 +21,7 @@
 #include <linux/atomic.h>
 #include <linux/bitfield.h>
 #include <linux/circ_buf.h>
+#include <linux/octal_permissions.h>
 
 #include <asm/page.h>
 
diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index f7b89b880339..1a4f1a90c2c5 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -11,6 +11,7 @@
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/octal_permissions.h>
 #include <linux/property.h>
 #include <linux/sprintf.h>
 #include <linux/sysfs.h>
diff --git a/drivers/media/platform/amphion/vpu_dbg.c b/drivers/media/platform/amphion/vpu_dbg.c
index bed0ed4fb8a0..ef5658b492cf 100644
--- a/drivers/media/platform/amphion/vpu_dbg.c
+++ b/drivers/media/platform/amphion/vpu_dbg.c
@@ -9,6 +9,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/octal_permissions.h>
 #include <linux/sprintf.h>
 #include <linux/types.h>
 #include <linux/pm_runtime.h>
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
index 8d558f0f1b3b..a225860d272a 100644
--- a/fs/xfs/xfs_error.c
+++ b/fs/xfs/xfs_error.c
@@ -14,6 +14,7 @@
 #include "xfs_error.h"
 #include "xfs_sysfs.h"
 #include "xfs_inode.h"
+#include <linux/octal_permissions.h>
 #include <linux/kstrtox.h>
 #include <linux/sprintf.h>
 #include <linux/sysfs.h>
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 5d088ce30045..ac332f4deed9 100644
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
@@ -308,16 +307,4 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
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
index a285e74ec028..860b0ea1f3b3 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -4,7 +4,7 @@
 /* (C) Copyright 2001, 2002 Rusty Russell IBM Corporation */
 #include <linux/init.h>
 #include <linux/stringify.h>
-#include <linux/kernel.h> // for VERIFY_OCTAL_PERMISSIONS()
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
index 0500b023b5cc..a4b752b24329 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -15,10 +15,10 @@
 
 #include <linux/sysfs_types.h>
 #include <linux/kernfs.h>
-#include <linux/kernel.h> // for VERIFY_OCTAL_PERMISSIONS()
 #include <linux/compiler.h>
 #include <linux/list.h>
 #include <linux/lockdep_types.h>
+#include <linux/octal_permissions.h>
 
 struct kobject;
 struct module;
-- 
2.39.2


