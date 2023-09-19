Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FC37A616A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjISLgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjISLgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:36:12 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01B44F5;
        Tue, 19 Sep 2023 04:36:06 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 51140212C490;
        Tue, 19 Sep 2023 04:36:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 51140212C490
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1695123365;
        bh=muQr4xAOr9mwPiaEClsJaD04MPYM4/npYfpYCIbVV/4=;
        h=From:To:Cc:Subject:Date:From;
        b=Vo5IdaRnq5uPm3g5LOVczP8sMdoHhIaxAnxToQVRE8qhob+TXMvXXhSppLL8jMehe
         /d0meMoZifn1oReHyJKCxhQCRVEfQmVUetAJrt/sjCrzYQ8RAY/vBpBa16SJolvwmT
         Y6QnCa7SrQym56jOIUZctD7rUxPOlefgT9Mk4qJo=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        vkuznets@redhat.com
Cc:     ssengar@microsoft.com
Subject: [PATCH] x86/hyperv: Add common print prefix "Hyper-V" in hv_init
Date:   Tue, 19 Sep 2023 04:36:01 -0700
Message-Id: <1695123361-8877-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "#define pr_fmt()" in hv_init.c to use "Hyper-V:" as common
print prefix for all pr_*() statements in this file.

Remove the "Hyper-V:" already prefixed in couple of prints.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 953e280c07c3..1c973067f008 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -7,6 +7,8 @@
  * Author : K. Y. Srinivasan <kys@microsoft.com>
  */
 
+#define pr_fmt(fmt)  "Hyper-V: " fmt
+
 #include <linux/efi.h>
 #include <linux/types.h>
 #include <linux/bitfield.h>
@@ -176,7 +178,7 @@ void set_hv_tscchange_cb(void (*cb)(void))
 	struct hv_tsc_emulation_control emu_ctrl = {.enabled = 1};
 
 	if (!hv_reenlightenment_available()) {
-		pr_warn("Hyper-V: reenlightenment support is unavailable\n");
+		pr_warn("reenlightenment support is unavailable\n");
 		return;
 	}
 
@@ -488,7 +490,7 @@ void __init hyperv_init(void)
 	if (cpu_feature_enabled(X86_FEATURE_IBT) &&
 	    *(u32 *)hv_hypercall_pg != gen_endbr()) {
 		setup_clear_cpu_cap(X86_FEATURE_IBT);
-		pr_warn("Hyper-V: Disabling IBT because of Hyper-V bug\n");
+		pr_warn("Disabling IBT because of Hyper-V bug\n");
 	}
 #endif
 
-- 
2.34.1

