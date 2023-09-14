Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA84D79FD93
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbjINH45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbjINH4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:56:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCFA1FC6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 00:56:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FECC433C8;
        Thu, 14 Sep 2023 07:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694678207;
        bh=9jZHF/WoDrDlTmD+rv+EN7tkrTG84HymGbe+Wx1tQBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V3a1jkgx9h+3UFijQVLP596H5NMlokw0rtDhGLa+6AnN9nFjHRxDbPK3jqxOSBkVe
         pNRkd3kQ8dKOVloME4WOpqPOZtj7QJ2lHRl1klNDehztjRoSsA86BxzBb5pNUWEYRd
         4XagF7Pn5Kiam4qFc32kA40Gio4zdZsHdDXQ9BtrFWba3uIC9uvnyGfrO7vcTSxk5N
         P2mvhgAudOb02jT+O4Ez56iVMQjqXKq92Oe4z4DwrTGQfn7Cs2G79AVyQNs2pYKeMk
         SxlQFp4iOv06AAbeDOPHtHbk5kf7R/GpdFdOW5hBqTqyusOTLW+AHj7m4qQIyIq0RN
         aF1Pg56fqCHug==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] =?UTF-8?q?memblock=20tests:=20fix=20warning=20?= =?UTF-8?q?=E2=80=98struct=20seq=5Ffile=E2=80=99=20declared=20inside=20par?= =?UTF-8?q?ameter=20list?=
Date:   Thu, 14 Sep 2023 10:56:32 +0300
Message-Id: <20230914075632.9515-3-rppt@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230914075632.9515-1-rppt@kernel.org>
References: <20230914075632.9515-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Building memblock tests produces the following warning:

cc -I. -I../../include -Wall -O2 -fsanitize=address -fsanitize=undefined -D CONFIG_PHYS_ADDR_T_64BIT   -c -o main.o main.c
In file included from tests/common.h:9,
                 from tests/basic_api.h:5,
                 from main.c:2:
./linux/memblock.h:601:50: warning: ‘struct seq_file’ declared inside parameter list will not be visible outside of this definition or declaration
  601 | static inline void memtest_report_meminfo(struct seq_file *m) { }
      |                                                  ^~~~~~~~

Add declaration of 'struct seq_file' to tools/include/linux/seq_file.h
to fix it.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 tools/include/linux/seq_file.h           | 2 ++
 tools/testing/memblock/tests/basic_api.c | 2 +-
 tools/testing/memblock/tests/common.h    | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/include/linux/seq_file.h b/tools/include/linux/seq_file.h
index 102fd9217f1f..f6bc226af0c1 100644
--- a/tools/include/linux/seq_file.h
+++ b/tools/include/linux/seq_file.h
@@ -1,4 +1,6 @@
 #ifndef _TOOLS_INCLUDE_LINUX_SEQ_FILE_H
 #define _TOOLS_INCLUDE_LINUX_SEQ_FILE_H
 
+struct seq_file;
+
 #endif /* _TOOLS_INCLUDE_LINUX_SEQ_FILE_H */
diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index 411647094cc3..57bf2688edfd 100644
--- a/tools/testing/memblock/tests/basic_api.c
+++ b/tools/testing/memblock/tests/basic_api.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
+#include "basic_api.h"
 #include <string.h>
 #include <linux/memblock.h>
-#include "basic_api.h"
 
 #define EXPECTED_MEMBLOCK_REGIONS			128
 #define FUNC_ADD					"memblock_add"
diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
index 4f23302ee677..b5ec59aa62d7 100644
--- a/tools/testing/memblock/tests/common.h
+++ b/tools/testing/memblock/tests/common.h
@@ -5,6 +5,7 @@
 #include <stdlib.h>
 #include <assert.h>
 #include <linux/types.h>
+#include <linux/seq_file.h>
 #include <linux/memblock.h>
 #include <linux/sizes.h>
 #include <linux/printk.h>
-- 
2.39.2

