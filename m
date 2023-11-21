Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213377F35EC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbjKUSag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjKUSad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:30:33 -0500
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA0E18C;
        Tue, 21 Nov 2023 10:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
        s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:To:From;
        bh=sy3Iq8ck++uRsQC+BbzwlVq1Fqi2MFGRPa2yPUfB5uM=; b=a2VEtKperwchV5z05Oa2/7Clji
        QKelvSs5rAgVcjaAwl7hhfFiuWJZTEgN1kREYGgQs+Rgs4Fqj19YKvpA3K5nsSaUeH04Pw9RZq3IC
        iVHNUSuwGWcTSepvDTRTKe0DajLH09xF1Ys8P+VoHLxy+FRrSzT6HCeTR+iLHrWyXPE0=;
Received: from xenbits.xenproject.org ([104.239.192.120])
        by mail.xenproject.org with esmtp (Exim 4.92)
        (envelope-from <paul@xen.org>)
        id 1r5VVq-0000Bg-0w; Tue, 21 Nov 2023 18:30:18 +0000
Received: from 54-240-197-231.amazon.com ([54.240.197.231] helo=REM-PW02S00X.ant.amazon.com)
        by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <paul@xen.org>)
        id 1r5V5q-0004Z3-Mt; Tue, 21 Nov 2023 18:03:26 +0000
From:   Paul Durrant <paul@xen.org>
To:     David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 13/15] KVM: xen: advertize the KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA capability
Date:   Tue, 21 Nov 2023 18:02:21 +0000
Message-Id: <20231121180223.12484-14-paul@xen.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231121180223.12484-1-paul@xen.org>
References: <20231121180223.12484-1-paul@xen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Durrant <pdurrant@amazon.com>

Now that all relevant kernel changes and selftests are in place, enable the
new capability.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
---
Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: x86@kernel.org

v2:
 - New in this version.
---
 arch/x86/kvm/x86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4afe9e447ba4..270018cf9ce0 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4638,7 +4638,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		    KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL |
 		    KVM_XEN_HVM_CONFIG_SHARED_INFO |
 		    KVM_XEN_HVM_CONFIG_EVTCHN_2LEVEL |
-		    KVM_XEN_HVM_CONFIG_EVTCHN_SEND;
+		    KVM_XEN_HVM_CONFIG_EVTCHN_SEND |
+		    KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA;
 		if (sched_info_on())
 			r |= KVM_XEN_HVM_CONFIG_RUNSTATE |
 			     KVM_XEN_HVM_CONFIG_RUNSTATE_UPDATE_FLAG;
-- 
2.39.2

