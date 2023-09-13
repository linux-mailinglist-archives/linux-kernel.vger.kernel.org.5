Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0A079E6BA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240150AbjIML3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240125AbjIML3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:29:16 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1AEC173E;
        Wed, 13 Sep 2023 04:29:12 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4E111212BE49;
        Wed, 13 Sep 2023 04:29:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4E111212BE49
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1694604552;
        bh=X1hXmesGa1C0q7JmU/DTDthFjHfS3J6LpW/sEYzdfT8=;
        h=From:To:Cc:Subject:Date:From;
        b=kNLzHaD2k3wBpj5CyBUU0Yr7i2kb8O+dpC6iwbNqB6L0xb5jmJkJWEzlGb48C65d6
         2oL/h3Jt7jW5cKXtk9kLv3aofJjUtIMUjdaZ5pTdZlFRsVNryqPgYncD01S1sooz6a
         8aJPcOgGBJTcZ1/4aJ1pByGgLIpKws/8jxz2ZweQ=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com
Cc:     ssengar@microsoft.com
Subject: [PATCH] x86/hyperv: Restrict get_vtl to only VTL platforms
Date:   Wed, 13 Sep 2023 04:28:51 -0700
Message-Id: <1694604531-17128-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For non VTL platforms vtl is always 0, and there is no need of
get_vtl function. For VTL platforms get_vtl should always succeed
and should return the correct VTL.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 783ed339f341..e589c240565a 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -416,8 +416,8 @@ static u8 __init get_vtl(void)
 	if (hv_result_success(ret)) {
 		ret = output->as64.low & HV_X64_VTL_MASK;
 	} else {
-		pr_err("Failed to get VTL(%lld) and set VTL to zero by default.\n", ret);
-		ret = 0;
+		pr_err("Failed to get VTL(error: %lld) exiting...\n", ret);
+		BUG();
 	}
 
 	local_irq_restore(flags);
@@ -604,8 +604,10 @@ void __init hyperv_init(void)
 	hv_query_ext_cap(0);
 
 	/* Find the VTL */
-	if (!ms_hyperv.paravisor_present && hv_isolation_type_snp())
+	if (IS_ENABLED(CONFIG_HYPERV_VTL_MODE))
 		ms_hyperv.vtl = get_vtl();
+	else
+		ms_hyperv.vtl = 0;
 
 	return;
 
-- 
2.34.1

