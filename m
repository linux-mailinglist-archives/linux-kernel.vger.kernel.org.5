Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA8280735C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442402AbjLFPHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379115AbjLFPHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:07:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62302D46
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 07:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701875267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/JBJQVO5XBoc9lUdPYm1Dkdtmlp9iMHA1ds5P3k5wtk=;
        b=JNeHjo0Zqd9VpCbcepdiHQ/VtVqFsj8d7hTLCtMGjOVyw3IGmXb9keZTr8jGvdbft/XHr+
        V7EsqIt77n6wqBkAL29HMKBqFIC856VV1JYWHY6nzypNsdYW2uM5/XkG9W0qUTZnb+964q
        d2eAR+TaHSiM6fDA5lrd7KZ//SVYNVw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-AU8IRVTjNYqiuh7hhJ6ozg-1; Wed, 06 Dec 2023 10:07:43 -0500
X-MC-Unique: AU8IRVTjNYqiuh7hhJ6ozg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-332e71b8841so800651f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 07:07:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701875258; x=1702480058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/JBJQVO5XBoc9lUdPYm1Dkdtmlp9iMHA1ds5P3k5wtk=;
        b=mzwJnfibU39gaPoOT8TZG3ZbjLjUnCw5cWOHKNnrrLB293/tgnxy5xsizpisti53dP
         ScyczTXzWcGbOtbOEeVsASXqmycoQ4rou6kHDG4gvHVwbNGsa7ulMvRm1mNxtOmfe+Gl
         kr0f7Aq5ZwHRszsBKxGqch0wz/DTkQ/NVnXF2fi2Ge6YCot0mPpZcvC9J9/tu5CTR84n
         ZDZjAAtA/mq0cJyNCNZxpzO017cm+UIqFcbjcP3lPz6CQWUGXmab/BVrwmU6bK30PUl2
         NuKeJLcPoqT4w5pgWVfODeUIjm6dG01LD8m4JUREdgyu4rgK2DuTV13snSrmm76N3glc
         XGgg==
X-Gm-Message-State: AOJu0YzArj3lvFMGD4vgDHS6s/90KJz+pERYru+c+R56AwSorcyrsEHu
        24CJhzmTmMdSsZ3CGHGqfFSGO5i6bfC29yy9v557srR7HcVepBg53My5ZM8Zt47fHHyIH5uRrSU
        4bKlqqNrBioeSrXln2w1kGQo=
X-Received: by 2002:a5d:4009:0:b0:333:5258:68ef with SMTP id n9-20020a5d4009000000b00333525868efmr692840wrp.68.1701875258351;
        Wed, 06 Dec 2023 07:07:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLa1/yFQDJ3QsgPuJIOsVfygTgkEWMxKZQhHwYBT6FHhXNXPic4hIBJCiXWvnVGxjbXDr5Dw==
X-Received: by 2002:a5d:4009:0:b0:333:5258:68ef with SMTP id n9-20020a5d4009000000b00333525868efmr692834wrp.68.1701875257975;
        Wed, 06 Dec 2023 07:07:37 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-30-38.cust.vodafonedsl.it. [2.34.30.38])
        by smtp.gmail.com with ESMTPSA id c1-20020adfa301000000b003333a216682sm11896497wrb.97.2023.12.06.07.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 07:07:37 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Rae Moar <rmoar@google.com>
Cc:     Marco Pagani <marpagan@redhat.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] kunit: run test suites only after module initialization completes
Date:   Wed,  6 Dec 2023 16:07:28 +0100
Message-ID: <20231206150729.54604-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

v3:
- add a comment to clarify why the start address is checked
v2:
- add include <linux/mm.h>

Fixes: 2810c1e99867 ("kunit: Fix wild-memory-access bug in kunit_free_suite_set()")
Tested-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 lib/kunit/test.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 7aceb07a1af9..3263e0d5e0f6 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -16,6 +16,7 @@
 #include <linux/panic.h>
 #include <linux/sched/debug.h>
 #include <linux/sched.h>
+#include <linux/mm.h>
 
 #include "debugfs.h"
 #include "hooks-impl.h"
@@ -775,12 +776,19 @@ static void kunit_module_exit(struct module *mod)
 	};
 	const char *action = kunit_action();
 
+	/*
+	 * Check if the start address is a valid virtual address to detect
+	 * if the module load sequence has failed and the suite set has not
+	 * been initialized and filtered.
+	 */
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
@@ -790,12 +798,12 @@ static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
 
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

base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a
-- 
2.43.0

