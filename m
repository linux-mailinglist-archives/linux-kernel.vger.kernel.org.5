Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D497679F8F3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 05:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbjINDd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 23:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbjINDd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 23:33:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0ECFF1BE7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 20:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694662355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=84e78RW9ozQMqOd2HZjEsxWYJUdZRFgV+7wAdbe6THU=;
        b=IjE+7tJbluJSh7SW6BUAu3Hdl6ATph4iQiN6k1HCgs4DIcSVjoFR9Td6AAojNtSBE8FsT7
        Sg3QPJsXIXF8NC2ZVgkoyG+qCuLGaUAPkgmxqs1sXGG93fxsH8DcnC+bjCJprks92gTfPl
        KwOXR5uW+L8nABUHfNfJYTTvljyLCQQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-5gDvrYr_NW2QYV57OjzW7A-1; Wed, 13 Sep 2023 23:32:31 -0400
X-MC-Unique: 5gDvrYr_NW2QYV57OjzW7A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43466805B29;
        Thu, 14 Sep 2023 03:32:31 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E58D10085C0;
        Thu, 14 Sep 2023 03:32:27 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, thunder.leizhen@huawei.com,
        catalin.marinas@arm.com, chenjiahao16@huawei.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 9/9] crash_core.c: remove unneeded functions
Date:   Thu, 14 Sep 2023 11:31:42 +0800
Message-ID: <20230914033142.676708-10-bhe@redhat.com>
In-Reply-To: <20230914033142.676708-1-bhe@redhat.com>
References: <20230914033142.676708-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far, nobody calls functions parse_crashkernel_high() and
parse_crashkernel_low(), remove both of them.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 include/linux/crash_core.h |  4 ----
 kernel/crash_core.c        | 18 ------------------
 2 files changed, 22 deletions(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 3c735a7e33fb..3426f6eef60b 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -96,10 +96,6 @@ void final_note(Elf_Word *buf);
 int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base,
 		unsigned long long *low_size, bool *high);
-int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
-		unsigned long long *crash_size, unsigned long long *crash_base);
-int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
-		unsigned long long *crash_size, unsigned long long *crash_base);
 
 #ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
 #ifndef DEFAULT_CRASH_KERNEL_LOW_SIZE
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index ad7dc03f3993..1a77d466eaed 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -350,24 +350,6 @@ int __init parse_crashkernel(char *cmdline,
 	return ret;
 }
 
-int __init parse_crashkernel_high(char *cmdline,
-			     unsigned long long system_ram,
-			     unsigned long long *crash_size,
-			     unsigned long long *crash_base)
-{
-	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
-				suffix_tbl[SUFFIX_HIGH]);
-}
-
-int __init parse_crashkernel_low(char *cmdline,
-			     unsigned long long system_ram,
-			     unsigned long long *crash_size,
-			     unsigned long long *crash_base)
-{
-	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
-				suffix_tbl[SUFFIX_LOW]);
-}
-
 /*
  * Add a dummy early_param handler to mark crashkernel= as a known command line
  * parameter and suppress incorrect warnings in init/main.c.
-- 
2.41.0

