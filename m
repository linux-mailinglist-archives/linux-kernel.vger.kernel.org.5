Return-Path: <linux-kernel+bounces-60761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7394E85092F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97B971C209F0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5530E608FD;
	Sun, 11 Feb 2024 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="iUo95rqh"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DEA60273
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707654651; cv=none; b=UXK+RHTBhgtusANmIjL22NUW1P2bPhAIONkvqDffWwEXVXVUZNWG+veVeaLpQeA7rBZUhiKeIJn+RSyiw6wRohm4hPkIXw+BpXRBNmfr8LoMCU1IdJKM72XyhFPwjNWBvKJvgCGcfWSmtbgxROAHOMeImv+tBY4jJ6EW5+hDJAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707654651; c=relaxed/simple;
	bh=5WoLQ+20FuNzDTgx6dlWdeAOXVkYHDqU6RsL5tdTmfc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zl5Gk0u8edhNJyAkvBd7ZGYzog7CXFHBlheEesy3VwmyblofQ0uJYc3NMck8iDQAHf/aSXNnQ2qkkDq3Q/Dt4MK/9bTtx2lJcAmtuieZP502q3pIS/wDeggMVSNbx1AQsvUy5RzP3ewDmvw3IBH6zPaDWPqVUilH8jK3lbWdF2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=iUo95rqh; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so3114520a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 04:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707654646; x=1708259446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKk+aGvc2YUoK3OFau8iqg4ZDHFtN8sLbkkpKq6ClNw=;
        b=iUo95rqhmDIs3bDNuL+jP2SWYPBOky/7fbQ9BS37psz11e9Q5aLbpEscjpYqvcukPl
         VVfN8ljTyzkh39OfRixwfF58c8x4D7ju1WGDzX3J/8mOOFX8ZgYY6ZTeAoLYr0GvCgzU
         irGVfrHGLWWB0vjD2VGFyQPSI2bNtIwQ1Apw3/QVBXuUwUAlZoHvkc5zZnAuMSKBjsc2
         bjWbZxEiT3RNDmG9m9SBD+UIeZ7ebvYO7lSlV/OPKdHtMz9bi9+lx+eF77CkvmDOs87+
         mtef6cOCPrDE0H8i6WYHOhRqpUrITW74xGg3uDnK4G9fwXEA85+DTW9+8b+IF3bAOB9A
         0FBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707654646; x=1708259446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKk+aGvc2YUoK3OFau8iqg4ZDHFtN8sLbkkpKq6ClNw=;
        b=wtzNJvsZttBjQtjJC3vVBFT/WjGQj/3JbP7/tPlJiYdJQUMiF29gtVatyty6epl0b6
         9+nVWVAtqYrXqGrQbzFZAKIbyB3ZUJKRZUw0KtdWtbhWHcHHynsBoTIKXAwTGwI1SWOg
         pH9xfaJI4R9vR72xwqieW4SCeCcwUZv6CcO7HFWBQ5vXCB9mRkNPWr/1KNOfxWwBnoah
         RtwqrcGSNJuW6Om1qUdeoJG9AUbSGd7FQJP7eSW5JZDJ7VopjgaN9FB/++HT2chNzA+V
         64jcf0/6348OjnWPo0kcXzo9vOsdxlx5VJtlnPEv7o5UiXXNHyuIsp6xFup7H96ajLSU
         bAzQ==
X-Gm-Message-State: AOJu0YzH3baLX428kqQZC7pxqnKF0m12181Ahrt8cpcHl3g4gTTs7fH+
	3Qy6ecvAIPJx4SMkOeo/9TVtD5PtVDXI0zluBYWvhOf5649EB/E8m0hDJnLOm84XkDad9aZRBin
	D
X-Google-Smtp-Source: AGHT+IGZ+5R/3d4QKJq+dDeWTvA6qltpY0UNOBTVJwuOiYzYcuzMt1HQVUUzjFavdEZemkrS8p4S9g==
X-Received: by 2002:a05:6402:1295:b0:55f:f2ae:20ed with SMTP id w21-20020a056402129500b0055ff2ae20edmr2455830edv.16.1707654646588;
        Sun, 11 Feb 2024 04:30:46 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id fj18-20020a0564022b9200b0056187ca4120sm1024611edb.10.2024.02.11.04.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 04:30:45 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 32/35] linux/kernel.h: move VERIFY_OCTAL_PERMISSIONS() to octal_permissions.h
Date: Sun, 11 Feb 2024 13:29:57 +0100
Message-Id: <20240211123000.3359365-33-max.kellermann@ionos.com>
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


