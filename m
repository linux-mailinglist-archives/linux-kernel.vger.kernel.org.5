Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D2978C419
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbjH2MSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235322AbjH2MRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:17:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E25CEE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693311407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qjf2vgpZvAbuO/fyNcy9/C3Rx0kevn2I1wz9DuGab2c=;
        b=bzsJ9lQesBefbfLRn7sPuU9vVoJUq/2h6xfOjEO29mZQmRfjVJf2qGMSrMkC30GD0EoTaD
        dNUGO2peI1zdRn+qHB9tX9qvuSg4o+nuzdJLDjrHNlRu1y+vyfUIX7zOF8kyyDYAo+CMIj
        jGQqAv6P14tvGTkoM5KSjPpewlC8TiM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-wvbW7TOFNgO-DwvFv2n-kQ-1; Tue, 29 Aug 2023 08:16:44 -0400
X-MC-Unique: wvbW7TOFNgO-DwvFv2n-kQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 496DE384F3C2;
        Tue, 29 Aug 2023 12:16:43 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C21896B2AD;
        Tue, 29 Aug 2023 12:16:38 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        thunder.leizhen@huawei.com, dyoung@redhat.com, prudo@redhat.com,
        samuel.holland@sifive.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 5/8] crash_core.h: include <asm/crash_core.h> if generic reservation is needed
Date:   Tue, 29 Aug 2023 20:16:07 +0800
Message-ID: <20230829121610.138107-6-bhe@redhat.com>
In-Reply-To: <20230829121610.138107-1-bhe@redhat.com>
References: <20230829121610.138107-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In asm/crash_core.h, ARCH can provide its own macro definitions to
override DEFAULT_CRASH_KERNEL_LOW_SIZE, CRASH_ALIGN, CRASH_ADDR_LOW_MAX,
CRASH_ADDR_HIGH_MAX in <linux/crash_core.h> if needed.

Later, x86 and arm64 wil support the generic reservaton, so wrap the
including into CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION ifdeffery
scope to avoid compiling error in other ARCH-es which doesn't take the
generic reservation.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/crash_core.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 2f732493e922..86e22e6a039f 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -5,6 +5,9 @@
 #include <linux/linkage.h>
 #include <linux/elfcore.h>
 #include <linux/elf.h>
+#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+#include <asm/crash_core.h>
+#endif
 
 #define CRASH_CORE_NOTE_NAME	   "CORE"
 #define CRASH_CORE_NOTE_HEAD_BYTES ALIGN(sizeof(struct elf_note), 4)
-- 
2.41.0

