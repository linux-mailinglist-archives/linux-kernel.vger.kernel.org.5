Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C687FB6F8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344120AbjK1KQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbjK1KQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:16:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5C110E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701166600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2mlv9LGhIVFVkJH7cobh6u5ej8q8EOjabrk7WGvxaI4=;
        b=CGx8oBC6JJpEXvrVDoGi/Es5T4FJNSe9NkmFtj9B9vYtUGvfNFHn6IpRrQtQTceD+DflUl
        LzZ1d74IY0en4F/qtMwYzk3Jbmu4Rsyfbebs0yErmgHWYfnBAN3pqMQ9d2W8cIYLxWcrD2
        AuBAbgoxDRaSQL0g/IYYjvWyvNe+61M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-QpEHxa1CP8WMFtg5Y5LTVg-1; Tue, 28 Nov 2023 05:16:38 -0500
X-MC-Unique: QpEHxa1CP8WMFtg5Y5LTVg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40b4e24adc7so2247885e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:16:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701166597; x=1701771397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2mlv9LGhIVFVkJH7cobh6u5ej8q8EOjabrk7WGvxaI4=;
        b=QExp5jM6B8lhnEZ+GyXRe4+0E7rmTZLPar6/POqCAlroELZe9kUSNfSyVvI0NsQ4t7
         oMj5FIq6wf0W5xvUZJ1bwv/MVp5gUeLa39ZfJELhKq1hPBm2pvGuZU3ACipoeM1L4AIx
         hiMxGZYrnBPYD9mA/ccv07t4AD6xapBXaYaGi7aL4kRq7hmM7ioNogDJAvL+djmieE3L
         m0bVeDY8i14qyhb1+G7rzBisftE/ATK+PURbScHVca5dsdfN5wVctGeyOkmvWSFXWqdS
         dOKvH3lHgWlCopn2mGEayMtokI6KtSFlFVpA7oAB/tOzF96yOwCcdaPo+ZTNnI5qgtwv
         hsaA==
X-Gm-Message-State: AOJu0YwuPQB9KyWMjHd4a8KXSW8WG1w33fHdpGrdGTb7EZLlzbTe6nVX
        6dZhLe7IDFArjaS9yIiblNrLTGW8yhpYS2LTTMiU41Gz9DhKYHQxA0avZOuKZIww2wBSyprCzfQ
        w9/gq+tkIE0eC58TvLQ7fPzw=
X-Received: by 2002:a05:600c:3550:b0:40b:415e:c044 with SMTP id i16-20020a05600c355000b0040b415ec044mr7207124wmq.37.1701166597207;
        Tue, 28 Nov 2023 02:16:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEILSD8tbDrDa+Fc2ASqSInMsptxAUayy6eFXUNFydDRl5MiOIb/oAt4B2WgrYpNGeoBPQZlA==
X-Received: by 2002:a05:600c:3550:b0:40b:415e:c044 with SMTP id i16-20020a05600c355000b0040b415ec044mr7207105wmq.37.1701166596883;
        Tue, 28 Nov 2023 02:16:36 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-24-178.cust.vodafonedsl.it. [2.34.24.178])
        by smtp.gmail.com with ESMTPSA id z15-20020a05600c220f00b003fe1fe56202sm16584252wml.33.2023.11.28.02.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 02:16:36 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Marco Pagani <marpagan@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] kunit: run test suites only after module initialization completes
Date:   Tue, 28 Nov 2023 11:16:27 +0100
Message-ID: <20231128101627.65399-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2810c1e99867 ("kunit: Fix wild-memory-access bug in
kunit_free_suite_set()") fixed a wild-memory-access bug that could have
happened during the loading phase of test suites built and executed as
loadable modules. However, it also introduced a problematic side effect
that causes test suites modules to crash when they attempt to register
fake devices.

When a module is loaded, it traverses the MODULE_STATE_UNFORMED and
MODULE_STATE_COMING states before reaching the normal operating state
MODULE_STATE_LIVE. Finally, when the module is removed, it moves to
MODULE_STATE_GOING before being released. However, if the loading
function load_module() fails between complete_formation() and
do_init_module(), the module goes directly from MODULE_STATE_COMING to
MODULE_STATE_GOING without passing through MODULE_STATE_LIVE.

This behavior was causing kunit_module_exit() to be called without
having first executed kunit_module_init(). Since kunit_module_exit() is
responsible for freeing the memory allocated by kunit_module_init()
through kunit_filter_suites(), this behavior was resulting in a
wild-memory-access bug.

Commit 2810c1e99867 ("kunit: Fix wild-memory-access bug in
kunit_free_suite_set()") fixed this issue by running the tests when the
module is still in MODULE_STATE_COMING. However, modules in that state
are not fully initialized, lacking sysfs kobjects. Therefore, if a test
module attempts to register a fake device, it will inevitably crash.

This patch proposes a different approach to fix the original
wild-memory-access bug while restoring the normal module execution flow
by making kunit_module_exit() able to detect if kunit_module_init() has
previously initialized the tests suite set. In this way, test modules
can once again register fake devices without crashing.

This behavior is achieved by checking whether mod->kunit_suites is a
virtual or direct mapping address. If it is a virtual address, then
kunit_module_init() has allocated the suite_set in kunit_filter_suites()
using kmalloc_array(). On the contrary, if mod->kunit_suites is still
pointing to the original address that was set when looking up the
.kunit_test_suites section of the module, then the loading phase has
failed and there's no memory to be freed.

v2:
- add include <linux/mm.h>

Fixes: 2810c1e99867 ("kunit: Fix wild-memory-access bug in kunit_free_suite_set()")
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 lib/kunit/test.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index f2eb71f1a66c..0e829b9f8ce5 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -16,6 +16,7 @@
 #include <linux/panic.h>
 #include <linux/sched/debug.h>
 #include <linux/sched.h>
+#include <linux/mm.h>
 
 #include "debugfs.h"
 #include "hooks-impl.h"
@@ -737,12 +738,14 @@ static void kunit_module_exit(struct module *mod)
 	};
 	const char *action = kunit_action();
 
+	if (!suite_set.start || !virt_addr_valid(suite_set.start))
+		return;
+
 	if (!action)
 		__kunit_test_suites_exit(mod->kunit_suites,
 					 mod->num_kunit_suites);
 
-	if (suite_set.start)
-		kunit_free_suite_set(suite_set);
+	kunit_free_suite_set(suite_set);
 }
 
 static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
@@ -752,12 +755,12 @@ static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
 
 	switch (val) {
 	case MODULE_STATE_LIVE:
+		kunit_module_init(mod);
 		break;
 	case MODULE_STATE_GOING:
 		kunit_module_exit(mod);
 		break;
 	case MODULE_STATE_COMING:
-		kunit_module_init(mod);
 		break;
 	case MODULE_STATE_UNFORMED:
 		break;

base-commit: 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
-- 
2.42.0

