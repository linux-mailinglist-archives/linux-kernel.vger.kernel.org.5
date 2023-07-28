Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCE8766243
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 05:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjG1DEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 23:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjG1DEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 23:04:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1950D2688
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 20:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690513387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=w7A8DUBQAAPdvxITFYdrC5cFY9Ke6WrqD74ZBOps/Ko=;
        b=dQIdjmNaXQBjynIT4NDdnRFcwUOMQjbQQ3O82u+XSHyeqT+u2vsBDLkdsmjXEExxCkFroD
        +FTcEafT2oK2H4Vr952hhFxD06MdLbcW09tHDrep+M+DMo0/MGB5fma+yZzY9g7xOo9gbk
        GdELumHIswqYqKu296szoTPUEIXfu7I=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-Y4PCtH-HO6qgImkgM0He2w-1; Thu, 27 Jul 2023 23:03:03 -0400
X-MC-Unique: Y4PCtH-HO6qgImkgM0He2w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08B2C1C0725A;
        Fri, 28 Jul 2023 03:03:03 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E07440C2063;
        Fri, 28 Jul 2023 03:03:00 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org, dennis@kernel.org
Cc:     linux-mm@kvack.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH v2] mm/percpu.c: print error message too if atomic alloc failed
Date:   Fri, 28 Jul 2023 11:02:55 +0800
Message-Id: <20230728030255.8458-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'err' is assgigned to an error message if atomic alloc
failed, while it has no chance to be printed if is_atomic is true.

Here change to print error message too if atomic alloc failed, while
avoid to call dump_stack() if that case.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
v1->v2:
 Fix the code bug in v1 pointed out by Dennis.

 mm/percpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 83fc47206680..bdca8ec33d49 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1890,13 +1890,15 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 fail:
 	trace_percpu_alloc_percpu_fail(reserved, is_atomic, size, align);
 
-	if (!is_atomic && do_warn && warn_limit) {
+	if (do_warn && warn_limit) {
 		pr_warn("allocation failed, size=%zu align=%zu atomic=%d, %s\n",
 			size, align, is_atomic, err);
-		dump_stack();
+		if (!is_atomic)
+			dump_stack();
 		if (!--warn_limit)
 			pr_info("limit reached, disable warning\n");
 	}
+
 	if (is_atomic) {
 		/* see the flag handling in pcpu_balance_workfn() */
 		pcpu_atomic_alloc_failed = true;
-- 
2.34.1

