Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA0E7E0DC1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 05:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjKDEUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 00:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjKDEUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 00:20:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11140D44;
        Fri,  3 Nov 2023 21:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=4xGq+RomEZH3DZvdz2VHIN1h6fcnWJicNhvkTuIdRC8=; b=Nl4ZYr0LZCWCk5uL/pzbkcuRh8
        vMVseyrI1XyoINQzkJo80DKS3TEeoIEftWLfbc/zbDibdcTNz4SoLTS8jUDkWw6lF7TtzjUzXrWG2
        BnRqey/L3ADb6SAuOEEmP603GRQQqqcRTffawia+Zl8uG4Adz1G/yFkTtA77nT5qb7w59dJV6wRvh
        X43i3PqvVGuBD4VJNBhdvUcKVTvFF/w9odc47tMlmpsVKZk6lICUmJLrAQD4a9Z/R8IQaCkeVSrzy
        f+jwRaGr8TDod+ZW7Ni/UrELu4h/bGx4tvmtzZJBdP+YSnORlBZmgNNH48MQCcyTcf5BSvpf7lU3M
        /a6tlwwQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qz89N-00Cbnr-1I;
        Sat, 04 Nov 2023 04:20:47 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org
Subject: [PATCH] lib/test_kmod: fix kernel-doc warnings
Date:   Fri,  3 Nov 2023 21:20:44 -0700
Message-ID: <20231104042044.17807-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix all kernel-doc warnings in test_kmod.c:
- Mark some enum values as private so that kernel-doc is not needed
  for them
- s/thread_mutex/thread_lock/ in a struct's kernel-doc comments
- add kernel-doc info for @task_sync

test_kmod.c:67: warning: Enum value '__TEST_KMOD_INVALID' not described in enum 'kmod_test_case'
test_kmod.c:67: warning: Enum value '__TEST_KMOD_MAX' not described in enum 'kmod_test_case'
test_kmod.c:100: warning: Function parameter or member 'task_sync' not described in 'kmod_test_device_info'
test_kmod.c:134: warning: Function parameter or member 'thread_mutex' not described in 'kmod_test_device'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
---
 lib/test_kmod.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff -- a/lib/test_kmod.c b/lib/test_kmod.c
--- a/lib/test_kmod.c
+++ b/lib/test_kmod.c
@@ -58,11 +58,14 @@ static int num_test_devs;
  * @need_mod_put for your tests case.
  */
 enum kmod_test_case {
+	/* private: */
 	__TEST_KMOD_INVALID = 0,
+	/* public: */
 
 	TEST_KMOD_DRIVER,
 	TEST_KMOD_FS_TYPE,
 
+	/* private: */
 	__TEST_KMOD_MAX,
 };
 
@@ -82,6 +85,7 @@ struct kmod_test_device;
  * @ret_sync: return value if request_module() is used, sync request for
  * 	@TEST_KMOD_DRIVER
  * @fs_sync: return value of get_fs_type() for @TEST_KMOD_FS_TYPE
+ * @task_sync: kthread's task_struct or %NULL if not running
  * @thread_idx: thread ID
  * @test_dev: test device test is being performed under
  * @need_mod_put: Some tests (get_fs_type() is one) requires putting the module
@@ -108,7 +112,7 @@ struct kmod_test_device_info {
  * @dev: pointer to misc_dev's own struct device
  * @config_mutex: protects configuration of test
  * @trigger_mutex: the test trigger can only be fired once at a time
- * @thread_lock: protects @done count, and the @info per each thread
+ * @thread_mutex: protects @done count, and the @info per each thread
  * @done: number of threads which have completed or failed
  * @test_is_oom: when we run out of memory, use this to halt moving forward
  * @kthreads_done: completion used to signal when all work is done
