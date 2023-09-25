Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257BB7AE1C8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjIYWjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjIYWjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:39:19 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EBB9C;
        Mon, 25 Sep 2023 15:39:11 -0700 (PDT)
X-QQ-mid: bizesmtp62t1695681542tdrh3qq7
Received: from linux-lab-host.localdomain ( [116.30.124.152])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 26 Sep 2023 06:38:56 +0800 (CST)
X-QQ-SSF: 01200000002000E0Y000B00A0000000
X-QQ-FEAT: SFhf6fKhx//PtbsvyVYEL/gCYQ5xMD8J6LwaCKhulpVEfmJppGRkMmjMj3Bxv
        8wdytKPzLVFJlPA82FjC2Ti02tsIHXGhP+Tb7KY7NXZeQX14PHTRUwY1uNtWxj7nVvdw5N8
        ypB+bBYPZTiHwLTOfPVZ2o3kvUQu/slgqaqTTvxwiXKKuRoubwr8vyOsZC+zpBmOn8ghMQm
        AG5bLu8EeQJF77jcZcCDh8tBPzUgxyBcq+ybkOO584JaaHxdkRqP9QMqdLVLQkwKUzkpjRx
        8jfcH0gidHmiUdV76m98gNAlJ0swOV9yXGIUaa85PdpJ4c+AiLAPLqrLnY0hvGmFDffugib
        /YpU8n7ZB5APg72lHoVQhLN1V/LOaRguiP/XLXevf0Z/Nx5UZypKAyBjtff2CMVyBvswmd1
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11640928319628299727
From:   Zhangjin Wu <falcon@tinylab.org>
To:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Cc:     falcon@tinylab.org, palmer@rivosinc.com, paul.walmsley@sifive.com,
        paulburton@kernel.org, paulmck@kernel.org,
        tsbogend@alpha.franken.de, w@1wt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Tim Bird <tim.bird@sony.com>
Subject: [PATCH v1 3/7] DCE/DSE: Add a new scripts/Makefile.syscalls
Date:   Tue, 26 Sep 2023 06:38:56 +0800
Message-Id: <df1ce8c514c3efc1323d5ed69e6ecbdb2542b960.1695679700.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1695679700.git.falcon@tinylab.org>
References: <cover.1695679700.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: Yes, score=6.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_PBL,RCVD_IN_SBL_CSS,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *      [43.154.54.12 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [43.154.54.12 listed in list.dnswl.org]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  1.3 RCVD_IN_VALIDITY_RPBL RBL: Relay in Validity RPBL,
        *      https://senderscore.org/blocklistlookup/
        *      [43.154.54.12 listed in bl.score.senderscore.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_TRIM_UNUSED_SYSCALLS is enabled, get used syscalls from
CONFIG_USED_SYSCALLS. CONFIG_USED_SYSCALLS may be a list of used
syscalls or a file to store such a list.

If CONFIG_USED_SYSCALLS is configured as a list of the used syscalls,
directly record them in a used_syscalls variable, if it is a file to
store the list, record the file name to the used_syscalls_file variable
and put its content to the used_syscalls variable.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 scripts/Makefile.syscalls | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 scripts/Makefile.syscalls

diff --git a/scripts/Makefile.syscalls b/scripts/Makefile.syscalls
new file mode 100644
index 000000000000..5864d3a85996
--- /dev/null
+++ b/scripts/Makefile.syscalls
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0
+
+ifndef SCRIPTS_MAKEFILE_SYSCALLS
+  SCRIPTS_MAKEFILE_SYSCALLS = 1
+
+  ifdef CONFIG_TRIM_UNUSED_SYSCALLS
+    ifneq ($(wildcard $(CONFIG_USED_SYSCALLS)),)
+      used_syscalls_file = $(CONFIG_USED_SYSCALLS)
+      ifeq ($(shell test -s $(used_syscalls_file); echo $$?),0)
+        used_syscalls != cat $(CONFIG_USED_SYSCALLS)
+      endif
+    else
+      ifeq ($(subst /,,$(CONFIG_USED_SYSCALLS)),$(CONFIG_USED_SYSCALLS))
+        used_syscalls = $(CONFIG_USED_SYSCALLS)
+      else
+        $(error No such file: $(CONFIG_USED_SYSCALLS))
+      endif
+    endif
+
+    ifneq ($(used_syscalls),)
+      used_syscalls := $(subst $(space),|,$(strip $(used_syscalls)))
+    endif
+
+    used_syscalls_deps = $(used_syscalls_file) $(objtree)/.config
+
+    export used_syscalls used_syscalls_deps
+  endif # CONFIG_TRIM_UNUSED_SYSCALLS
+
+endif # SCRIPTS_MAKEFILE_SYSCALLS
-- 
2.25.1

