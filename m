Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33492765BA0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjG0SsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjG0Sr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:47:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DCE30ED
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690483582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hgcVQqDmL6DGm3gA3jePiRRXjc2Eh2fCViWl8QhUEvg=;
        b=Y4JSd47Xegv6a1ISXruZJHB2sj7hoX9QuNgmxYMIM79hsCpnSlvmq09xjBZj5FCP8NSnZF
        zDrRpeDw8ZnEXg+wQNe7NsyvhU5L6dEWJC3HO/RHjcnLcqNhIIy+0gfXuiucEA8m58OdqC
        n8m2B+/3KsO2BIYEp/QpTNbE8ccwAKg=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-132-6W-bzWr5NiSbdIJR7bTk_Q-1; Thu, 27 Jul 2023 14:46:21 -0400
X-MC-Unique: 6W-bzWr5NiSbdIJR7bTk_Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C83183828890;
        Thu, 27 Jul 2023 18:46:18 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB4A8C57964;
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
Subject: [PATCH v6 3/4] intel_idle: Use __update_spec_ctrl() in intel_idle_ibrs()
Date:   Thu, 27 Jul 2023 14:45:59 -0400
Message-Id: <20230727184600.26768-4-longman@redhat.com>
In-Reply-To: <20230727184600.26768-1-longman@redhat.com>
References: <20230727184600.26768-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When intel_idle_ibrs() is called, it modifies the SPEC_CTRL MSR to 0
in order disable IBRS. However, the new MSR value isn't reflected in
x86_spec_ctrl_current which is at odd with the other code that keep track
of its state in that percpu variable.  Use the new __update_spec_ctrl()
to have the x86_spec_ctrl_current percpu value properly updated.

Since spec-ctrl.h includes both msr.h and nospec-branch.h, we can remove
those from the include file list.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 256c2d42e350..d286f31a5b96 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -53,9 +53,8 @@
 #include <linux/moduleparam.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
-#include <asm/nospec-branch.h>
 #include <asm/mwait.h>
-#include <asm/msr.h>
+#include <asm/spec-ctrl.h>
 #include <asm/fpu/api.h>
 
 #define INTEL_IDLE_VERSION "0.5.1"
@@ -182,12 +181,12 @@ static __cpuidle int intel_idle_ibrs(struct cpuidle_device *dev,
 	int ret;
 
 	if (smt_active)
-		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+		__update_spec_ctrl(0);
 
 	ret = __intel_idle(dev, drv, index);
 
 	if (smt_active)
-		native_wrmsrl(MSR_IA32_SPEC_CTRL, spec_ctrl);
+		__update_spec_ctrl(spec_ctrl);
 
 	return ret;
 }
-- 
2.31.1

