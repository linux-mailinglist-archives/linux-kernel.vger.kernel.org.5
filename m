Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C560789CE6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 12:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjH0KNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 06:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjH0KMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 06:12:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAB4128
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 03:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693131115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iV2wLAfcAl+D7MYwEotIMI/hG+PsohPBamGW1ll7QSU=;
        b=N0fWT95n/idPE3VjgiK7O5ElErLRV1fmPU159EAM7JwO1/IGCDGFvsoJp5xvkIgweYcAxv
        +kW9a7h9DYNl9sJ1H7+JeuynzrFNuGty7sfm0YtUUdc4J1lyfpDsR7WObKc3M7lGBj7N7E
        4ho3wyK/+UMuOv5HvHHx0QWfEZUuQ+g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-dcQi-t8wMe-jYcKP77Qj1Q-1; Sun, 27 Aug 2023 06:11:50 -0400
X-MC-Unique: dcQi-t8wMe-jYcKP77Qj1Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E1C185CBE0;
        Sun, 27 Aug 2023 10:11:50 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2624C2166B25;
        Sun, 27 Aug 2023 10:11:45 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, linux-riscv@lists.infradead.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        thunder.leizhen@huawei.com, dyoung@redhat.com, prudo@redhat.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 3/8] include/linux/kexec.h: move down crash_core.h including
Date:   Sun, 27 Aug 2023 18:11:22 +0800
Message-ID: <20230827101128.70931-4-bhe@redhat.com>
In-Reply-To: <20230827101128.70931-1-bhe@redhat.com>
References: <20230827101128.70931-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Later generic macros related to crash_core will be added into
<linux/crash_core.h>, and the corresponding arch specific macros will be
added to override them if needed. And Kconfig option KEXEC_CORE selects
CRASH_CORE. So move <linux/crash_core.h> including after <asm/kexec.h>.

And also move the crash_res|low_res and crash_notes delcarations after
<linux/crash_core.h> including because they are all defined in
kernel/kexec_core.c, and note_buf_t is definied in crash_core.h.

This is a preparation patch.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/kexec.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 22b5cd24f581..8768fd9e2a66 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -15,25 +15,25 @@
 
 #if !defined(__ASSEMBLY__)
 
-#include <linux/crash_core.h>
 #include <asm/io.h>
 #include <linux/range.h>
 
 #include <uapi/linux/kexec.h>
 #include <linux/verification.h>
 
-/* Location of a reserved region to hold the crash kernel.
- */
-extern struct resource crashk_res;
-extern struct resource crashk_low_res;
-extern note_buf_t __percpu *crash_notes;
-
 #ifdef CONFIG_KEXEC_CORE
 #include <linux/list.h>
 #include <linux/compat.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <asm/kexec.h>
+#include <linux/crash_core.h>
+
+/* Location of a reserved region to hold the crash kernel.
+ */
+extern struct resource crashk_res;
+extern struct resource crashk_low_res;
+extern note_buf_t __percpu *crash_notes;
 
 /* Verify architecture specific macros are defined */
 
-- 
2.41.0

