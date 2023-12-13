Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A983F80FBF2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377710AbjLMAI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377851AbjLMAIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:08:15 -0500
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70463D4D;
        Tue, 12 Dec 2023 16:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702426083; x=1733962083;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8E5gYeBn7LzFXeE9t3+WWJhfPWwonViYFj973oiYUIk=;
  b=a1vPSAn4RN5MYIpsd3DyyRCkJuBHnCOBZooVN6/fJapR6P9VnnkYiZDS
   1vd8AU/P7+v6f0O8Dzt4xCJuMNWr6H27HNgYhSjG9x5NzAiItEAdByflx
   5JxfSMdqz0mSchn+8natHOk8lS7fixALyrIXy89rim6IuNE5YAMbj/jnk
   0=;
X-IronPort-AV: E=Sophos;i="6.04,271,1695686400"; 
   d="scan'208";a="621371857"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-bbc6e425.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 00:08:01 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
        by email-inbound-relay-iad-1a-m6i4x-bbc6e425.us-east-1.amazon.com (Postfix) with ESMTPS id EF61380632;
        Wed, 13 Dec 2023 00:07:52 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:16104]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.236:2525] with esmtp (Farcaster)
 id 3bda4ab2-5ec6-4d32-90c9-2880fbf14c72; Wed, 13 Dec 2023 00:07:51 +0000 (UTC)
X-Farcaster-Flow-ID: 3bda4ab2-5ec6-4d32-90c9-2880fbf14c72
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:07:44 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:07:40 +0000
From:   Alexander Graf <graf@amazon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-trace-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <x86@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        James Gowans <jgowans@amazon.com>,
        Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
        <arnd@arndb.de>, <pbonzini@redhat.com>,
        <madvenka@linux.microsoft.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Usama Arif <usama.arif@bytedance.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 15/15] tracing: Add config option for kexec handover
Date:   Wed, 13 Dec 2023 00:04:52 +0000
Message-ID: <20231213000452.88295-16-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231213000452.88295-1-graf@amazon.com>
References: <20231213000452.88295-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D033UWA001.ant.amazon.com (10.13.139.103) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all bits are in place to allow ftrace to pass its trace data
into the next kernel on kexec, let's give users a kconfig option to
enable the functionality.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 kernel/trace/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 61c541c36596..af83ee755b9e 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -1169,6 +1169,19 @@ config HIST_TRIGGERS_DEBUG
 
           If unsure, say N.
 
+config FTRACE_KHO
+	bool "Ftrace Kexec handover support"
+	depends on KEXEC_KHO
+	help
+          Enable support for ftrace to pass metadata across kexec so the new
+	  kernel continues to use the previous kernel's trace buffers.
+
+	  This can be useful when debugging kexec performance or correctness
+	  issues: The new kernel can dump the old kernel's trace buffer which
+	  contains all events until reboot.
+
+	  If unsure, say N.
+
 source "kernel/trace/rv/Kconfig"
 
 endif # FTRACE
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



