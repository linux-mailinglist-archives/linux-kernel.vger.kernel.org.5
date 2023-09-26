Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698B37AEC2D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbjIZMKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjIZMKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:10:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED19120
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 05:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695730157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jimOcMvQCcdItEjwgV6HXjLHWStYRcQsZMjaE32LDyE=;
        b=e2YN7FhzhG9Uk06AOc7G3spKkNhhOyi/9fq1aAS10QfG2Ga2oe6RrUBVzVwrH8OrukMssf
        QscCTWVbFVLQr90tb1KriSwQMl8NbJ5SfDYhlP8kevhcmYfC9enReXdQFuQ+VLeHvcuKvP
        DnptCk9u2DS/9brvgwn3OIXNVYZppoI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-ilM1DyNsNf--dzhCtfc2KA-1; Tue, 26 Sep 2023 08:09:12 -0400
X-MC-Unique: ilM1DyNsNf--dzhCtfc2KA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52ACA1C0CCAD;
        Tue, 26 Sep 2023 12:09:12 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3EA09140E950;
        Tue, 26 Sep 2023 12:09:07 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, akpm@linux-foundation.org,
        eric.devolder@oracle.com, vschneid@redhat.com,
        sourabhjain@linux.ibm.com, Baoquan He <bhe@redhat.com>
Subject: [PATCH v3] Crash: add lock to serialize crash hotplug handling
Date:   Tue, 26 Sep 2023 20:09:05 +0800
Message-ID: <20230926120905.392903-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric reported that handling corresponding crash hotplug event can be
failed easily when many memory hotplug event are notified in a short
period. They failed because failing to take __kexec_lock.

=======
[   78.714569] Fallback order for Node 0: 0
[   78.714575] Built 1 zonelists, mobility grouping on.  Total pages: 1817886
[   78.717133] Policy zone: Normal
[   78.724423] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
[   78.727207] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
[   80.056643] PEFILE: Unsigned PE binary
=======

The memory hotplug events are notified very quickly and very many,
while the handling of crash hotplug is much slower relatively. So the
atomic variable __kexec_lock and kexec_trylock() can't guarantee the
serialization of crash hotplug handling.

Here, add a new mutex lock __crash_hotplug_lock to serialize crash
hotplug handling specifically. This doesn't impact the usage of
__kexec_lock.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
v2->v3:
 - crash_check_update_elfcorehdr() need take __crash_hotplug_lock
   too because there's tiny racing window when kexec_load interface
   is taken. Eric pointed out this.
v1->v2:
 - Move mutex lock definition into CONFIG_CRASH_HOTPLUG ifdeffery
   scope in kernel/crash_core.c because the lock is only needed and
   used in that scope. Suggested by Eric.
 kernel/crash_core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 03a7932cde0a..2f675ef045d4 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -739,6 +739,17 @@ subsys_initcall(crash_notes_memory_init);
 #undef pr_fmt
 #define pr_fmt(fmt) "crash hp: " fmt
 
+/*
+ * Different than kexec/kdump loading/unloading/jumping/shrinking which
+ * usually rarely happen, there will be many crash hotplug events notified
+ * during one short period, e.g one memory board is hot added and memory
+ * regions are online. So mutex lock  __crash_hotplug_lock is used to
+ * serialize the crash hotplug handling specifically.
+ */
+DEFINE_MUTEX(__crash_hotplug_lock);
+#define crash_hotplug_lock() mutex_lock(&__crash_hotplug_lock)
+#define crash_hotplug_unlock() mutex_unlock(&__crash_hotplug_lock)
+
 /*
  * This routine utilized when the crash_hotplug sysfs node is read.
  * It reflects the kernel's ability/permission to update the crash
@@ -748,9 +759,11 @@ int crash_check_update_elfcorehdr(void)
 {
 	int rc = 0;
 
+	crash_hotplug_lock();
 	/* Obtain lock while reading crash information */
 	if (!kexec_trylock()) {
 		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
+		crash_hotplug_unlock();
 		return 0;
 	}
 	if (kexec_crash_image) {
@@ -761,6 +774,7 @@ int crash_check_update_elfcorehdr(void)
 	}
 	/* Release lock now that update complete */
 	kexec_unlock();
+	crash_hotplug_unlock();
 
 	return rc;
 }
@@ -783,9 +797,11 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 {
 	struct kimage *image;
 
+	crash_hotplug_lock();
 	/* Obtain lock while changing crash information */
 	if (!kexec_trylock()) {
 		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
+		crash_hotplug_unlock();
 		return;
 	}
 
@@ -852,6 +868,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 out:
 	/* Release lock now that update complete */
 	kexec_unlock();
+	crash_hotplug_unlock();
 }
 
 static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
-- 
2.41.0

