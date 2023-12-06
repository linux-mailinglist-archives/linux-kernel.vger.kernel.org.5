Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6560E807532
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379347AbjLFQhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378708AbjLFQhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:37:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84D7D44
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 08:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701880648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NysT7udZ8xwFGddZRwdc9/Qlsmga0cd28a63wrp2AsA=;
        b=Mq2BtzkxG9hdQapps9SMsS9+XnFNuxDs0vQquMqmJRH4ypPIjheOlbCVyWAW4Gg/Gd/NXF
        OJtUk0bVG/T+dhlixANd4eGB0O6/sy9OMpbPDRGn2R3iBo+k8fTwNLqduyfGAINZ6oAfTN
        k7mJjNJpJGEQEI0NX31ElJv/BnsF+X8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-8U8hwTEyN2Cz1TXlS0v0JQ-1; Wed, 06 Dec 2023 11:37:13 -0500
X-MC-Unique: 8U8hwTEyN2Cz1TXlS0v0JQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 418FE85CBA4;
        Wed,  6 Dec 2023 16:35:53 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2666F1C060AF;
        Wed,  6 Dec 2023 16:35:51 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Michael Roth <michael.roth@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Alexander Graf <graf@amazon.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        Dionna Glaze <dionnaglaze@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH RFC] x86/sev: Temporary disable CPU re-onlining for SEV-SNP
Date:   Wed,  6 Dec 2023 17:35:50 +0100
Message-ID: <20231206163550.1454453-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was discovered that an attempt to re-online a CPU in a SEV-SNP enabled
instance in AWS leads to the immediate reboot upon SVM_VMGEXIT_AP_CREATE
VMGEXIT. While support for SEV-SNP in KVM is not yet upstream, it is
unclear whether the problem is guest related or if the hypervisor is not
handling the case correctly. Note, currently Linux doesn't do
SVM_VMGEXIT_AP_DESTROY upon CPU offlining but it is also not entirely clear
from the specification whether this is a must or a nice-to-have
action. When done prior to SVM_VMGEXIT_AP_CREATE on AWS, guest reboot is no
longer observed. Unfortunately, CPU still fails to come up ("CPU1 failed
to report alive state").

Note, SEV-SNP feature on Hyper-V uses a different CPU wakeup
path (see hv_snp_boot_ap() in arch/x86/hyperv/ivm.c) which uses a
hypercall. This one does not seem to have any issues with CPU re-onlining,
at least on publicly available Azure instances.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 RFC: I'm using this silly patch (which makes the problem a bit less severe
 though) to ask if there are plans to make this work, either on the host or
 on the guest side. Thanks!
---
 arch/x86/kernel/sev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 70472eebe719..f7e56cae05c5 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1005,6 +1005,10 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
 
 	cur_vmsa = per_cpu(sev_vmsa, cpu);
 
+	/* Re-onlining CPUs is currently unsupported */
+	if (cur_vmsa)
+		return -EOPNOTSUPP;
+
 	/*
 	 * A new VMSA is created each time because there is no guarantee that
 	 * the current VMSA is the kernels or that the vCPU is not running. If
-- 
2.43.0

