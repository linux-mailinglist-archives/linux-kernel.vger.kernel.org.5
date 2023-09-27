Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3327B094B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjI0PuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbjI0PuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:50:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D465227D67
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695829723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7eHWlFiucdq0IfNiQ7WXj2KUdARtYTii9zK/Td8/6q0=;
        b=S7Cfm2sdBsCaev/j7AVLMCxU477Ur9oIomoG3oM5+DGHeMTS91XmEYi2ph2/SWxLij3uI3
        5ZzTz9FODXhK276oXRUqxpoR7aKYSq361qCIvczq6P8QJ49jSMuf+6ZmjjlqNNWLS/Zg8n
        NEHUJ0G6UB2dErb1XVPdcjJ/JhnS1ds=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-4UDvRg6ZPD6fO97ItSxtpQ-1; Wed, 27 Sep 2023 11:48:42 -0400
X-MC-Unique: 4UDvRg6ZPD6fO97ItSxtpQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-65b23c40cefso72493156d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695829722; x=1696434522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7eHWlFiucdq0IfNiQ7WXj2KUdARtYTii9zK/Td8/6q0=;
        b=BqI2w3AiYWFhAPycHYxWvPYaRKuIfX5gMh15+VLOwAfUhm5X98x9ADISoBQ/EaUEwv
         5pVi5W2hwltSlhEMW9fdTLA4PDX4bBMbGU6Ec8dCbAVdAGE+n7eUga0uwJjk4m0G56c6
         VoX3a9a/CP6+XIAO4ekiQg6G2lU0jWyhXYpUvIXck7DWWVu+6vp2hOrxRGLP5w7muZ5S
         XZjRTYBgjeCsZIa57LVF0wrsWHvSBpI1H4NBokWQ38W/lJ+ORfwT3iZzlXaUO3D4uwvk
         DgwZvtvFeSXMl98Q2PlX8EAmlhMhrb7J63UZg7ziqA0wl+Vz6kIKBEJmAyEqj5UMO5me
         HjZQ==
X-Gm-Message-State: AOJu0YxjaBb9iaGLtR0lwjAG7o0tldWFAC8CxNJm5gScWEnQbDZYY8h1
        CRLbP59ySsoa1u2SGeucE2oJHkDj2UQN2e+LNo228BkoBLN1j4ZewYfuY2S8qnXOFpXKOs2giKY
        EZLvmeZbDw+Kged9AwpXOkOE=
X-Received: by 2002:a0c:e3c4:0:b0:65b:239f:6779 with SMTP id e4-20020a0ce3c4000000b0065b239f6779mr2411221qvl.38.1695829722172;
        Wed, 27 Sep 2023 08:48:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvXN24Gq7lJ4N2Pd195k1EQvGDijxPrzCysfC8L9ky0JbCss85UWdaXbwHnXlPbMaYyaElaQ==
X-Received: by 2002:a0c:e3c4:0:b0:65b:239f:6779 with SMTP id e4-20020a0ce3c4000000b0065b239f6779mr2411199qvl.38.1695829721936;
        Wed, 27 Sep 2023 08:48:41 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-30-58.cust.vodafonedsl.it. [2.34.30.58])
        by smtp.gmail.com with ESMTPSA id j12-20020a0cf30c000000b0065b0a3ae7c7sm2964022qvl.113.2023.09.27.08.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 08:48:41 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Rae Moar <rmoar@google.com>
Cc:     Marco Pagani <marpagan@redhat.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] kunit: run test suites only after module initialization completes
Date:   Wed, 27 Sep 2023 17:48:27 +0200
Message-ID: <20230927154828.122280-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2810c1e99867 ("kunit: Fix wild-memory-access bug in
kunit_free_suite_set()") causes test suites to run while the test
module is still in MODULE_STATE_COMING. In that state, the module
is not fully initialized, lacking sysfs, module_memory, args, init
function. This behavior can cause all sorts of problems while using
fake devices.

This RFC patch restores the normal execution flow, waiting for module
initialization to complete before running the tests, and uses the
refcount to avoid calling kunit_free_suite_set() if load_module()
fails.

Fixes: 2810c1e99867 ("kunit: Fix wild-memory-access bug in kunit_free_suite_set()")
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 lib/kunit/test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 421f13981412..242f26ad387a 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -784,13 +784,13 @@ static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
 
 	switch (val) {
 	case MODULE_STATE_LIVE:
+		kunit_module_init(mod);
 		break;
 	case MODULE_STATE_GOING:
-		kunit_module_exit(mod);
+		if (module_refcount(mod) == -1)
+			kunit_module_exit(mod);
 		break;
 	case MODULE_STATE_COMING:
-		kunit_module_init(mod);
-		break;
 	case MODULE_STATE_UNFORMED:
 		break;
 	}
-- 
2.41.0

