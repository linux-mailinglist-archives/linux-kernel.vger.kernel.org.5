Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE42B8009D7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378514AbjLALXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378493AbjLALXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:23:53 -0500
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEEBC4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 03:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1701429839; x=1732965839;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J3xfNFjwOnnvs/ybxP9Rb0J+EPlPSUez1/yCDgbTH+o=;
  b=fWD80V3AYJ/X8LWEjVNAHvu6nm2S0Zo5VYLbJXhk966G4ja19od4zLNZ
   C6Tcu+0QMVky0VmfukEOD6o50b5UL1X/wh9G7vfd7YWPP0NO1f37GconE
   DmkvY/fmdf7oBeZBeciZOt9GAimgNf4Q125SKW4RD2IEQ644kmgoc92H5
   o=;
X-IronPort-AV: E=Sophos;i="6.04,241,1695686400"; 
   d="scan'208";a="373605387"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 11:23:56 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
        by email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com (Postfix) with ESMTPS id 12C33800AE;
        Fri,  1 Dec 2023 11:23:48 +0000 (UTC)
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:37595]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.2.215:2525] with esmtp (Farcaster)
 id f5743f46-4d13-4c19-b142-be6e820b1e92; Fri, 1 Dec 2023 11:23:46 +0000 (UTC)
X-Farcaster-Flow-ID: f5743f46-4d13-4c19-b142-be6e820b1e92
Received: from EX19D002EUA002.ant.amazon.com (10.252.50.7) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 1 Dec 2023 11:23:42 +0000
Received: from dev-dsk-sironi-1a-c39c3a30.eu-west-1.amazon.com (172.19.97.49)
 by EX19D002EUA002.ant.amazon.com (10.252.50.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 1 Dec 2023 11:23:39 +0000
From:   Filippo Sironi <sironi@amazon.de>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-edac@vkeg.kernel.org>
CC:     <sironi@amazon.de>, <tony.luck@intel.com>, <bp@alien8.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>
Subject: [PATCH] x86/MCE: Get microcode revision from cpu_data instead of boot_cpu_data
Date:   Fri, 1 Dec 2023 11:23:27 +0000
Message-ID: <20231201112327.42319-1-sironi@amazon.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Originating-IP: [172.19.97.49]
X-ClientProxiedBy: EX19D032UWA003.ant.amazon.com (10.13.139.37) To
 EX19D002EUA002.ant.amazon.com (10.252.50.7)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fa94d0c6e0f3 ("x86/MCE: Save microcode revision in machine check
records") extended MCE entries to report the microcode revision taken
from boot_cpu_data. Unfortunately, boot_cpu_data isn't updated on late
microcode loading, thus making MCE entries slightly incorrect.  Use
cpu_data instead, which is updated on late microcode loading. This also
fixes the corner case in which the microcode revision isn't coherent
across CPUs (which may happen on late microcode loading failure).

Signed-off-by: Filippo Sironi <sironi@amazon.de>
---
 arch/x86/kernel/cpu/mce/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7b397370b4d6..e1b033298db0 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -127,7 +127,7 @@ void mce_setup(struct mce *m)
 	m->apicid = cpu_data(m->extcpu).topo.initial_apicid;
 	m->mcgcap = __rdmsr(MSR_IA32_MCG_CAP);
 	m->ppin = cpu_data(m->extcpu).ppin;
-	m->microcode = boot_cpu_data.microcode;
+	m->microcode = cpu_data(m->extcpu).microcode;
 }
 
 DEFINE_PER_CPU(struct mce, injectm);
-- 
2.33.0




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



