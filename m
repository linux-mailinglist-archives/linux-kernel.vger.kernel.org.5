Return-Path: <linux-kernel+bounces-61014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D9F850C4C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2A21C20F88
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B333217550;
	Sun, 11 Feb 2024 23:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="CV21k42S"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5942F37710
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 23:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707693368; cv=none; b=lfTAqvgD933qOiQ8BD4YmBi6P1o4j981N3z7QfhA41KozHIU8dwC3GIEJlgWmH0GcAP7AAIT9KCRB3Fo8aQHE2WIGEbcy0u3YSYwhb4S67oVQ8chfJb7ZVwvcIkYZiHE2l6nteWdGLpdkGoVNJH+iyKCLvOXuPHzfefSwuz/Up4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707693368; c=relaxed/simple;
	bh=5WoLQ+20FuNzDTgx6dlWdeAOXVkYHDqU6RsL5tdTmfc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ahowo7W1VoPfnf5ACLx41/8d8GWIGLqVdSyapJf7RVj2AHFmIeOl7I4M7ysikytyGCXb0pcYUxZ3L4uXfJ+jx7FSoswPLZ2X9DV9hZAK1zkc9MD4tNNT3QtaxfnyYoq0qclvHisTrby0Gx0J3prqIPFi7yYp3hO3MchY7/RAmN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=CV21k42S; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56001d49cc5so3259180a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707693363; x=1708298163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKk+aGvc2YUoK3OFau8iqg4ZDHFtN8sLbkkpKq6ClNw=;
        b=CV21k42S6wgX/WcXy2QCKLtzNQX1m779FgTQRWlBKqlC4rjSnO0P9qf+yiWkFEfZdd
         UPtFO7shfCb5u7fxHL56OL/qNA5HrULabb3AIcjjkFWYRlGlr1DMs+WKwJv5cbXmRKqA
         KXBNadG7Pc9LsClJZhiwa1N0oLwIYVfQGzlAtjxoV1EQQhKrs5jNaqEra5zDxSWfuEao
         qwojpu40GzhCYhNTngnrLlIq+0gpkxVfZuHIH/oIefE9rH2PSW2c1DOgy+bax1uYFI7s
         tWlg6/arDm+Sy1DsxMWX2WrwmfNXikUC6d21DJ/FaRQw0t0v7yqbx5x47JfDR6AJ4D42
         7eow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707693363; x=1708298163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKk+aGvc2YUoK3OFau8iqg4ZDHFtN8sLbkkpKq6ClNw=;
        b=XK4bXUoT3hzHtNTIKEXVpgEaXoy+2dleQJlPAsa2H5EDkx1FOOENetMWidSTbngTsM
         uBOMgfstBmkqArYaCcueQklSSuaPX+Q1ZTUwWUIDLCG0MMctWhQkfG6B5cSYJuXJ4K/4
         wpdOESs6rXFB/UOWBy+ctOOWurIVx7UaY5OST6aZ0PxUPtuXLeW+iRhpw1HcdRG1g1Nc
         xNthNmM5Jh3H8AnSdFqLUs3e5tB5TlTVxN3UCePvJXnQf61ZfrKluUNPQlojS0cJ6a22
         3Mc1XSFQ7HQ6Ts2jPLlZcpV5IZNE4oxU30HOteT39qs+JNa6u0N+o+0NnQZe+KT65Qgy
         YBOA==
X-Gm-Message-State: AOJu0YyCBPB9s2l6plx/9HltFcrrvhAFTNP1RtXCK+sH15WpXW8Rrv/K
	7Q2Iyo+4CZ3VcC+dlxukXLwjUTsyJzX2EuxOdUJA1n31W05XCOoP8x0sYx1/i2Tp455MJ6ZZWAB
	2
X-Google-Smtp-Source: AGHT+IFLteGysqjfJheqz7uLh/iMraWoqyAbCOL3/fRisgTe4+4KM080przeNV1tkDQZY5v7f1+dFQ==
X-Received: by 2002:aa7:d8ce:0:b0:55f:a309:172f with SMTP id k14-20020aa7d8ce000000b0055fa309172fmr4271070eds.15.1707693363055;
        Sun, 11 Feb 2024 15:16:03 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id et13-20020a056402378d00b0055d19c9daf2sm2170180edb.15.2024.02.11.15.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 15:16:02 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 32/35] linux/kernel.h: move VERIFY_OCTAL_PERMISSIONS() to octal_permissions.h
Date: Mon, 12 Feb 2024 00:15:15 +0100
Message-Id: <20240211231518.349442-33-max.kellermann@ionos.com>
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


