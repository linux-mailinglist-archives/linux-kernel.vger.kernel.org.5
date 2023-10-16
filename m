Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81937CB4CB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbjJPUhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbjJPUhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:37:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DFD102
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697488563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AodHtY5bOphDx4xnpuhtV1x5N9Vz2Fukampd5mQ9OLw=;
        b=Ko40CfiiFbCp2eLIAatQOeZSDxPk/Ij4ZhLYOzCjUDLWu/ObO24wSWJnuEEUax71opizf5
        PguOI4JSt7e4gbOZWLOt/CYywsigUp+p7BZEl9EQa+jeLLUfHWsSzDO5r2M69SqHIP+b5C
        WQ6b4EKzs9+8xelvt9iMKD9pys2x7PM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-k9SSOJ7gOomBzrm0dS0Y7Q-1; Mon, 16 Oct 2023 16:36:02 -0400
X-MC-Unique: k9SSOJ7gOomBzrm0dS0Y7Q-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-41810af14a4so58644431cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697488562; x=1698093362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AodHtY5bOphDx4xnpuhtV1x5N9Vz2Fukampd5mQ9OLw=;
        b=VKuOyZU9hxlJWT7+c+O3Y/Ol3zlir0tmbgFO7nyhSIS6Vqn3j4uOKHtM/V5HNp6MmS
         iAoV3y5mruwIojhBNSP61KXaXVWp+gxt9ePGO1unY7xnNB9IS8H/UTI1XACRiuGrGt/Z
         JgywMEPCHv/NLQaxFXZskEtSJqbntEYPnNzDxQ93mF9jXBcOSm2SjunPZ47c3VSf0osR
         Bo+PSt9GBErTnTxa7Gf6edHmEom6lrneVuiyXvdgUEUJVTzuxSFUwJosrVSm/HvzpsmA
         kwBRbPmyjoWmTEzcFy6EBbtgNSuO0tqREwKKyJ8LWCUtrvDNjSMge+21Ks3Oo1NBzmDq
         5Qzg==
X-Gm-Message-State: AOJu0YyVS7sonEq6amoDkFi9+RvfdmJ4895DEiR+63We/hW64KVwMu/b
        ryV/k2yG1vgv9RdNFkB+XUKoqopNkQHWUGXeDd7QGYADncEWahxYx8RHSPr7hLsiaovpfy+EGe5
        gCaoQr7ukMm5Vv6hmyM4z50s=
X-Received: by 2002:a05:622a:81:b0:412:3092:feab with SMTP id o1-20020a05622a008100b004123092feabmr454526qtw.50.1697488561995;
        Mon, 16 Oct 2023 13:36:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOo0etpC1oKXc/e9E+LqEy0tb5DelVDWAS0Kjx3OhVnExbU7R5ztEAMLWZ5cuH+MAH2ctw+g==
X-Received: by 2002:a05:622a:81:b0:412:3092:feab with SMTP id o1-20020a05622a008100b004123092feabmr454509qtw.50.1697488561688;
        Mon, 16 Oct 2023 13:36:01 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-31-107.cust.vodafonedsl.it. [2.34.31.107])
        by smtp.gmail.com with ESMTPSA id bp43-20020a05622a1bab00b0041520676966sm40052qtb.47.2023.10.16.13.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 13:36:01 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     Marco Pagani <marpagan@redhat.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kunit: run test suites only after module initialization completes
Date:   Mon, 16 Oct 2023 22:35:47 +0200
Message-ID: <20231016203548.21993-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2810c1e99867 ("kunit: Fix wild-memory-access bug in
kunit_free_suite_set()") is causing all test suites to run (when
built as modules) while still in MODULE_STATE_COMING. In that state,
test modules are not fully initialized and lack sysfs kobjects.
This behavior can cause a crash if the test module tries to register
fake devices.

This patch restores the normal execution flow, waiting for the module
initialization to complete before running the test suites.
The issue reported in the commit mentioned above is addressed using
virt_addr_valid() to detect if the module loading has failed
and mod->kunit_suites has not been allocated using kmalloc_array().

Fixes: 2810c1e99867 ("kunit: Fix wild-memory-access bug in kunit_free_suite_set()")
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 lib/kunit/test.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 421f13981412..1a49569186fc 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -769,12 +769,14 @@ static void kunit_module_exit(struct module *mod)
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
@@ -784,12 +786,12 @@ static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
 
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
-- 
2.41.0

