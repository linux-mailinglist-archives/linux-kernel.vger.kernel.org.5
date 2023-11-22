Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5B97F4632
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344101AbjKVMad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343584AbjKVMaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:30:30 -0500
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B174D92;
        Wed, 22 Nov 2023 04:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
        s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:To:From;
        bh=CPp0Qc6lsksup1D7/LciCKmODvP2NLwil1ZR7D0Jz3s=; b=CQhJKbRt3pgU5rBJ+Vvi7X+I7D
        BhzUIaYVj/Dxf1Nj109ocJ0OWdOTWRTOsQJipQil38bfXXkD1IuL8wEzM5KlLjsZU+tj2yqgK9dfZ
        iU8GayAtIMOpi5M1HdWOnf48fZn9UHxekRKhPFPsWuId7rrvAIawOB3XTO5Ichu1nzuQ=;
Received: from xenbits.xenproject.org ([104.239.192.120])
        by mail.xenproject.org with esmtp (Exim 4.92)
        (envelope-from <paul@xen.org>)
        id 1r5mN0-0005E6-2b; Wed, 22 Nov 2023 12:30:18 +0000
Received: from 54-240-197-231.amazon.com ([54.240.197.231] helo=REM-PW02S00X.ant.amazon.com)
        by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <paul@xen.org>)
        id 1r5mCp-0004y9-EI; Wed, 22 Nov 2023 12:19:47 +0000
From:   Paul Durrant <paul@xen.org>
To:     David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 15/15] KVM: xen: allow vcpu_info content to be 'safely' copied
Date:   Wed, 22 Nov 2023 12:18:22 +0000
Message-Id: <20231122121822.1042-16-paul@xen.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231122121822.1042-1-paul@xen.org>
References: <20231122121822.1042-1-paul@xen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Durrant <pdurrant@amazon.com>

If the guest sets an explicit vcpu_info GPA then, for any of the first 32
vCPUs, the content of the default vcpu_info in the shared_info page must be
copied into the new location. Because this copy may race with event
delivery (which updates the 'evtchn_pending_sel' field in vcpu_info) there
needs to be a way to defer that until the copy is complete.
Happily there is already a shadow of 'evtchn_pending_sel' in kvm_vcpu_xen
that is used in atomic context if the vcpu_info PFN cache has been
invalidated so that the update of vcpu_info can be deferred until the
cache can be refreshed (on vCPU thread's the way back into guest context).

Also use this shadow if the vcpu_info cache has been *deactivated*, so that
the VMM can safely copy the vcpu_info content and then re-activate the
cache with the new GPA. To do this, stop considering an inactive vcpu_info
cache as a hard error in kvm_xen_set_evtchn_fast().

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
---
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org

v8:
 - Update commit comment.

v6:
 - New in this version.
---
 arch/x86/kvm/xen.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index eff405eead1c..cfd5051e0800 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1742,9 +1742,6 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 		WRITE_ONCE(xe->vcpu_idx, vcpu->vcpu_idx);
 	}
 
-	if (!vcpu->arch.xen.vcpu_info_cache.active)
-		return -EINVAL;
-
 	if (xe->port >= max_evtchn_port(kvm))
 		return -EINVAL;
 
-- 
2.39.2

