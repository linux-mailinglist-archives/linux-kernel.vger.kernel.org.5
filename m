Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D946765B98
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjG0SrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjG0SrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:47:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D984930E4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690483582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p0Bv8RV/6VKQUXDLbsWN97ne3VW3ZcB7lEFXae7aK9U=;
        b=eLZt9X2NsG4bodWipo9HB5pdQxYTRZngVG4l+EjDKLiJYKZiay7yN/9erIx/2/osFDLTyk
        OpYQ8v9HmuKx2PR/rrv9j+GNjC8fxQ3H7uZ62t2sIpN05jnUzMFiigQol4PJd9ODNplfG/
        9d3QAlYdTzsYy1gKEM0JZ7le/vUUdsY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-501-8ItcYOwWMwCWW9Ry2Q2B5g-1; Thu, 27 Jul 2023 14:46:18 -0400
X-MC-Unique: 8ItcYOwWMwCWW9Ry2Q2B5g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCEDA88D4E2;
        Thu, 27 Jul 2023 18:46:17 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15228C57964;
        Thu, 27 Jul 2023 18:46:17 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v6 2/4] x86/idle: Disable IBRS when cpu is offline
Date:   Thu, 27 Jul 2023 14:45:58 -0400
Message-Id: <20230727184600.26768-3-longman@redhat.com>
In-Reply-To: <20230727184600.26768-1-longman@redhat.com>
References: <20230727184600.26768-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit bf5835bcdb96 ("intel_idle: Disable IBRS during long idle")
disables IBRS when the CPU enters long idle. However, when a CPU
becomes offline, the IBRS bit is still set when X86_FEATURE_KERNEL_IBRS
is enabled. That will impact the performance of a sibling CPU. Mitigate
this performance impact by clearing all the mitigation bits in SPEC_CTRL
MSR when offline. When the CPU is online again, it will be re-initialized
and so restoring the SPEC_CTRL value isn't needed.

Add a comment to say that native_play_dead() is a __noreturn function,
but it can't be marked as such to avoid confusion about the missing
MSR restoration code.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/kernel/smpboot.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index e1aa2cd7734b..16f420d49a13 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -87,6 +87,7 @@
 #include <asm/hw_irq.h>
 #include <asm/stackprotector.h>
 #include <asm/sev.h>
+#include <asm/spec-ctrl.h>
 
 /* representing HT siblings of each logical CPU */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
@@ -1743,8 +1744,15 @@ void __noreturn hlt_play_dead(void)
 		native_halt();
 }
 
+/*
+ * native_play_dead() is essentially a __noreturn function, but it can't
+ * be marked as such as the compiler may complain about it.
+ */
 void native_play_dead(void)
 {
+	if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS))
+		__update_spec_ctrl(0);
+
 	play_dead_common();
 	tboot_shutdown(TB_SHUTDOWN_WFS);
 
-- 
2.31.1

