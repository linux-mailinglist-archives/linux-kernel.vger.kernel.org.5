Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3224A7F2060
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjKTW3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKTW3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:29:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C89A2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700519382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sLnO8asijaZzMbkZtLITBAUSz4awB/mJCNxRwi1gKfo=;
        b=PuXQAQSHOuPfsUnEG1hVzminytUYdsV6j79BsWV/DQspROjLrZYRsL9FssUorWX5aaf/dl
        E0qr43SStwItE5szDFC+2Af2A+IW9GullP5zJlDsOhZEZj2WhuhnI+HjBhBRAyf8viK2MQ
        a0t4eqXwOuCoKC2xxiZiOctBZ4GMMTA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-KPLK3Vn-PRmzq_G3jfoP0Q-1; Mon, 20 Nov 2023 17:29:40 -0500
X-MC-Unique: KPLK3Vn-PRmzq_G3jfoP0Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CFCC85A58C;
        Mon, 20 Nov 2023 22:29:40 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.22.17.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A429F492BE0;
        Mon, 20 Nov 2023 22:29:39 +0000 (UTC)
From:   Nico Pache <npache@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org
Cc:     shuah@kernel.org, akpm@linux-foundation.org, jsavitz@redhat.com
Subject: [PATCH] selftests/mm: prevent duplicate runs caused by TEST_GEN_PROGS
Date:   Mon, 20 Nov 2023 15:29:08 -0700
Message-ID: <20231120222908.28559-1-npache@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 05f1edac8009 ("selftests/mm: run all tests from run_vmtests.sh")
fixed the inconsistancy caused by tests being defined as TEST_GEN_PROGS.
This issue was leading to tests not being executed via run_vmtests.sh and
furthermore some tests running twice due to the kselftests wrapper also
executing them.

Fix the definition of two tests (soft-dirty and pagemap_ioctl)
that are still incorrectly defined.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 tools/testing/selftests/mm/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 78dfec8bc676..dede0bcf97a3 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -60,7 +60,7 @@ TEST_GEN_FILES += mrelease_test
 TEST_GEN_FILES += mremap_dontunmap
 TEST_GEN_FILES += mremap_test
 TEST_GEN_FILES += on-fault-limit
-TEST_GEN_PROGS += pagemap_ioctl
+TEST_GEN_FILES += pagemap_ioctl
 TEST_GEN_FILES += thuge-gen
 TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += uffd-stress
@@ -72,7 +72,7 @@ TEST_GEN_FILES += mdwe_test
 TEST_GEN_FILES += hugetlb_fault_after_madv
 
 ifneq ($(ARCH),arm64)
-TEST_GEN_PROGS += soft-dirty
+TEST_GEN_FILES += soft-dirty
 endif
 
 ifeq ($(ARCH),x86_64)
-- 
2.41.0

