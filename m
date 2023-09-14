Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE7879F8EA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 05:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbjINDcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 23:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbjINDct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 23:32:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7893D1BDC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 20:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694662319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TjqOcwWBrkh/CdUM/5gfUPqEhH0IYqtSZbAnP+4qzQo=;
        b=ii1FH1uO+Km49c2/02wj6FEQ3n1wQ8C/1dFliDtNXmmPyTJKZcYR1myfKuDxTS+Bd+Y/Ig
        kmrn+6ozGEaRPnWtZZK6UXHptWaEWJY7DPn5t0+kL7/jmJaThGvQ2dE12H9i0NlNab2GLQ
        7gnsjvjDJ0N2n1l4occifrilp/a6ZIg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-8r3y9f3cN0Sw9nZr-XdCgw-1; Wed, 13 Sep 2023 23:31:55 -0400
X-MC-Unique: 8r3y9f3cN0Sw9nZr-XdCgw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8724B802D38;
        Thu, 14 Sep 2023 03:31:54 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 773611054FC0;
        Thu, 14 Sep 2023 03:31:50 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, thunder.leizhen@huawei.com,
        catalin.marinas@arm.com, chenjiahao16@huawei.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 1/9] crash_core.c: remove unnecessary parameter of function
Date:   Thu, 14 Sep 2023 11:31:34 +0800
Message-ID: <20230914033142.676708-2-bhe@redhat.com>
In-Reply-To: <20230914033142.676708-1-bhe@redhat.com>
References: <20230914033142.676708-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In all call sites of __parse_crashkernel(), the parameter 'name' is
hardcoded as "crashkernel=". So remove the unnecessary parameter 'name',
add local varibale 'name' inside __parse_crashkernel() instead.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/crash_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 03a7932cde0a..c9695204715d 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -248,11 +248,11 @@ static int __init __parse_crashkernel(char *cmdline,
 			     unsigned long long system_ram,
 			     unsigned long long *crash_size,
 			     unsigned long long *crash_base,
-			     const char *name,
 			     const char *suffix)
 {
 	char	*first_colon, *first_space;
 	char	*ck_cmdline;
+	char	*name = "crashkernel=";
 
 	BUG_ON(!crash_size || !crash_base);
 	*crash_size = 0;
@@ -290,7 +290,7 @@ int __init parse_crashkernel(char *cmdline,
 			     unsigned long long *crash_base)
 {
 	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
-					"crashkernel=", NULL);
+				NULL);
 }
 
 int __init parse_crashkernel_high(char *cmdline,
@@ -299,7 +299,7 @@ int __init parse_crashkernel_high(char *cmdline,
 			     unsigned long long *crash_base)
 {
 	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
-				"crashkernel=", suffix_tbl[SUFFIX_HIGH]);
+				suffix_tbl[SUFFIX_HIGH]);
 }
 
 int __init parse_crashkernel_low(char *cmdline,
@@ -308,7 +308,7 @@ int __init parse_crashkernel_low(char *cmdline,
 			     unsigned long long *crash_base)
 {
 	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
-				"crashkernel=", suffix_tbl[SUFFIX_LOW]);
+				suffix_tbl[SUFFIX_LOW]);
 }
 
 /*
-- 
2.41.0

