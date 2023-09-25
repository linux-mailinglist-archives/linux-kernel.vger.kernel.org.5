Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A157ACE99
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 05:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjIYDIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 23:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjIYDIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 23:08:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36746A3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 20:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695611231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=LibzKZdeb1DOWmi/oEB5Gnb73A+4XGeHqkUmug2NkOM=;
        b=Qb/68mnugye4Ta//yCjKcUAQN+hqu90j4Xf49vF8AUduqxCxiCf66Cn1aGGfub4LHC015Z
        YFsruJf2qrAzMMKGHqtrKnVitzU2/Akv0p/iZEPY72nEuMKXnKeqII6aWnzhJypTqOIt5M
        dEzAidRwg2aeTSkqhsKLz+IVq43rUXg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-uZKBFWG_Pa2dv_Xgk2SIig-1; Sun, 24 Sep 2023 23:07:08 -0400
X-MC-Unique: uZKBFWG_Pa2dv_Xgk2SIig-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C756C85A5A8;
        Mon, 25 Sep 2023 03:07:07 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69B5B2026D68;
        Mon, 25 Sep 2023 03:07:04 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, akpm@linux-foundation.org,
        eric.devolder@oracle.com, vschneid@redhat.com, dyoung@redhat.com,
        sourabhjain@linux.ibm.com, Baoquan He <bhe@redhat.com>
Subject: [PATCH v2] Crash: add lock to serialize crash hotplug handling
Date:   Mon, 25 Sep 2023 11:07:01 +0800
Message-ID: <20230925030701.338672-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
v1->v2:
 - Move mutex lock definition into CONFIG_CRASH_HOTPLUG ifdeffery
   scope in kernel/crash_core.c because the lock is only needed and
   used in that scope. Suggested by Eric.

 kernel/crash_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 03a7932cde0a..5951d6366b72 100644
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
@@ -783,9 +794,11 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 {
 	struct kimage *image;
 
+	crash_hotplug_lock();
 	/* Obtain lock while changing crash information */
 	if (!kexec_trylock()) {
 		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
+		crash_hotplug_unlock();
 		return;
 	}
 
@@ -852,6 +865,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 out:
 	/* Release lock now that update complete */
 	kexec_unlock();
+	crash_hotplug_unlock();
 }
 
 static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
-- 
2.41.0

