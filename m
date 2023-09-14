Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350A879F8EC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 05:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbjINDdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 23:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbjINDc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 23:32:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A421E1BE1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 20:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694662325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LO8iddQy5SUYo0oFdFE0+QnNUGHrkEvy5Cyf9fh/McM=;
        b=YIMvQZEVFHPzz8pQZyPQlm8m+1hCY0GFCU6FU3qEGFaqo2SY3j8ngzEQOa5VGLJ99nIuAm
        5txJERGKA4/WLy6ful36hLyavAuKDVIqbZQmuJMjIDUgs0/4qLChYPodoVmrNoZmWV3KAJ
        W6eAmNEeryLoRgzaA9dUslRedNRmSgk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-EMldp75JNTm8H3vUthNEkA-1; Wed, 13 Sep 2023 23:32:04 -0400
X-MC-Unique: EMldp75JNTm8H3vUthNEkA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A7FF185A790;
        Thu, 14 Sep 2023 03:32:03 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B36BA10F1BE7;
        Thu, 14 Sep 2023 03:31:59 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, thunder.leizhen@huawei.com,
        catalin.marinas@arm.com, chenjiahao16@huawei.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 3/9] crash_core: change parse_crashkernel() to support crashkernel=,high|low parsing
Date:   Thu, 14 Sep 2023 11:31:36 +0800
Message-ID: <20230914033142.676708-4-bhe@redhat.com>
In-Reply-To: <20230914033142.676708-1-bhe@redhat.com>
References: <20230914033142.676708-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now parse_crashkernel() is a real entry point for all kinds of
crahskernel parsing on any architecture.

And wrap the crahskernel=,high|low handling inside
CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION ifdeffery scope.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/crash_core.h |  6 ++++++
 kernel/crash_core.c        | 36 +++++++++++++++++++++++++++++++++---
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 6156355ef831..d8050a7eab01 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -79,6 +79,12 @@ Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len);
 void final_note(Elf_Word *buf);
 
+#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+#ifndef DEFAULT_CRASH_KERNEL_LOW_SIZE
+#define DEFAULT_CRASH_KERNEL_LOW_SIZE  (128UL << 20)
+#endif
+#endif
+
 int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base,
 		unsigned long long *low_size, bool *high);
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index cca1d76e8255..dce2f5874fea 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -283,6 +283,9 @@ static int __init __parse_crashkernel(char *cmdline,
 /*
  * That function is the entry point for command line parsing and should be
  * called from the arch-specific code.
+ *
+ * If crashkernel=,high|low is supported on architecture, non-NULL values
+ * should be passed to parameters 'low_size' and 'high'.
  */
 int __init parse_crashkernel(char *cmdline,
 			     unsigned long long system_ram,
@@ -296,10 +299,37 @@ int __init parse_crashkernel(char *cmdline,
 	/* crashkernel=X[@offset] */
 	ret = __parse_crashkernel(cmdline, system_ram, crash_size,
 				crash_base, NULL);
-	if (!high)
-		return ret;
+#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+	/*
+	 * If non-NULL 'high' passed in and no normal crashkernel
+	 * setting detected, try parsing crashkernel=,high|low.
+	 */
+	if (high && ret == -ENOENT) {
+		ret = __parse_crashkernel(cmdline, 0, crash_size,
+				crash_base, suffix_tbl[SUFFIX_HIGH]);
+		if (ret || !*crash_size)
+			return -EINVAL;
 
-	return 0;
+		/*
+		 * crashkernel=Y,low can be specified or not, but invalid value
+		 * is not allowed.
+		 */
+		ret = __parse_crashkernel(cmdline, 0, low_size,
+				crash_base, suffix_tbl[SUFFIX_LOW]);
+		if (ret == -ENOENT) {
+			*low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
+			ret = 0;
+		} else if (ret) {
+			return ret;
+		}
+
+		*high = true;
+	}
+#endif
+	if (!*crash_size)
+		ret = -EINVAL;
+
+	return ret;
 }
 
 int __init parse_crashkernel_high(char *cmdline,
-- 
2.41.0

