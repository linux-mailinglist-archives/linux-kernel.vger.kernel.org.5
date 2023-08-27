Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D83789CE7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 12:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjH0KNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 06:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjH0KMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 06:12:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593DA129
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 03:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693131120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ti+FZphx3tTCt2+5tJQ+9yD5S9gf+CV5t2KKqvLpfrs=;
        b=cb2x2OjYqZlCiPYKOfYyEK8tLZvrfcSODKnaYKoRIya5x6ObebXIwLGoll3B09JfFJmQCE
        URKblTlM/8Df+T2OlWCsx8WQl9138CrzwDQ4qAeJ3DZexQXWEc2Nrh7dVzZOlSSU2+ID+T
        8v6s/zOKoBtuoQID7GIo6fcGl4RQ8lA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-h0NDYsL3PUmeR2mCgbvofA-1; Sun, 27 Aug 2023 06:11:55 -0400
X-MC-Unique: h0NDYsL3PUmeR2mCgbvofA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D6C88D40A0;
        Sun, 27 Aug 2023 10:11:55 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F41802166B25;
        Sun, 27 Aug 2023 10:11:50 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, linux-riscv@lists.infradead.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        thunder.leizhen@huawei.com, dyoung@redhat.com, prudo@redhat.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 4/8] crash_core: change parse_crashkernel() to support crashkernel=,high|low parsing
Date:   Sun, 27 Aug 2023 18:11:23 +0800
Message-ID: <20230827101128.70931-5-bhe@redhat.com>
In-Reply-To: <20230827101128.70931-1-bhe@redhat.com>
References: <20230827101128.70931-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 kernel/crash_core.c        | 28 +++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 2e76289699ff..85260bf4a734 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -77,6 +77,12 @@ Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
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
index f6a5c219e2e1..355b0ab5189c 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -276,6 +276,9 @@ static int __init __parse_crashkernel(char *cmdline,
 /*
  * That function is the entry point for command line parsing and should be
  * called from the arch-specific code.
+ *
+ * If crashkernel=,high|low is supported on architecture, non-NULL values
+ * should be passed to parameters 'low_size' and 'high'.
  */
 int __init parse_crashkernel(char *cmdline,
 			     unsigned long long system_ram,
@@ -291,7 +294,30 @@ int __init parse_crashkernel(char *cmdline,
 				crash_base, NULL);
 	if (!high)
 		return ret;
-
+#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+	else if (ret == -ENOENT) {
+		ret = __parse_crashkernel(cmdline, 0, crash_size,
+				crash_base, suffix_tbl[SUFFIX_HIGH]);
+		if (ret || !*crash_size)
+			return -1;
+
+		/*
+		 * crashkernel=Y,low can be specified or not, but invalid value
+		 * is not allowed.
+		 */
+		ret = __parse_crashkernel(cmdline, 0, low_size,
+				crash_base, suffix_tbl[SUFFIX_LOW]);
+		if (ret == -ENOENT)
+			*low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
+		else if (ret)
+			return -1;
+
+		*high = true;
+	} else if (ret || !*crash_size) {
+		/* The specified value is invalid */
+		return -1;
+	}
+#endif
 	return 0;
 }
 
-- 
2.41.0

