Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA0C786983
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240448AbjHXIGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240464AbjHXIGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:06:21 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51741BD6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:05:35 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bda9207132so51602655ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692864308; x=1693469108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhPhAEYXOjd7Sn6E5mFHIsVfVenAXGYibiKvIzNeJhI=;
        b=G+ioXOlMhzzSsFeOo98ApC0O6Bz+xTN7o7NvHt6zUSzMtMjnoOCwssUrtpM3Ea/f4q
         QzZWnac70CX9Tsu8jkszmzYyq03LndVS91OTCpw8PH2TyoJt/jfWUy1VBPEHCSH5NHQI
         lVh4ksRnv/2AHsWJlta0CGXZwJ81ZZyP1PIsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692864308; x=1693469108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhPhAEYXOjd7Sn6E5mFHIsVfVenAXGYibiKvIzNeJhI=;
        b=F+6taLKPKNOYX3C9bK3wAOKQW0xuCI/ZHRgI9eT6l5d9NC1+3/6Dvx0bIqhzktiuBS
         SHQKE1nQ1c7UiONt3xZ5XLpIiMziaj/dM9AgqM/6NAKhPfxOSEjdoCqcbiKkrDkAs5Q/
         v1P+PHttfX4tAImgldhgKXfsfw9PT9+pEZFxCJGHMb5kTMuFHvrg5h8TS88oMEEvU6P0
         S/4bD+WmoRLLwsoUXX3vtOpD9DskkrMKeEMrMrqimofMr0ANnmsVBxx9YWbS+naN8a3B
         N8MD+XhRcO2G7BsPdHBOcEk82yQdhoZHFI0qatEc7gsaZqvvcCJPyLbzRVRVrjnAQVPF
         Y19g==
X-Gm-Message-State: AOJu0YyjJWV5taybtMHs2ZRNgbg099Az9RSOmM4TlEOUws4nvBR3v14e
        okXDFxOC/L0CXvdb8hSYHYxnIA==
X-Google-Smtp-Source: AGHT+IFkCGH2GwA3ilX5jB05HUrrf1vUBIbmMJaFJx2swg78OUGHa276ImTXLpzo2mY30kNcsT6wbw==
X-Received: by 2002:a17:902:c947:b0:1c0:7bac:13d4 with SMTP id i7-20020a170902c94700b001c07bac13d4mr10820347pla.65.1692864308600;
        Thu, 24 Aug 2023 01:05:08 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:515:8b2a:90c3:b79e])
        by smtp.gmail.com with UTF8SMTPSA id q6-20020a170902a3c600b001bf095dfb76sm12370611plb.237.2023.08.24.01.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 01:05:08 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Xu <peterx@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH v8 4/8] KVM: x86/mmu: Migrate to __kvm_follow_pfn
Date:   Thu, 24 Aug 2023 17:04:04 +0900
Message-ID: <20230824080408.2933205-5-stevensd@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824080408.2933205-1-stevensd@google.com>
References: <20230824080408.2933205-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

Migrate from __gfn_to_pfn_memslot to __kvm_follow_pfn. Most arguments
directly map to the new API. The largest change is replacing the async
in/out parameter with FOLL_NOWAIT parameter and the KVM_PFN_ERR_NEEDS_IO
return value.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 arch/x86/kvm/mmu/mmu.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index ec169f5c7dce..dabae67f198b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4296,7 +4296,12 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
 static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 {
 	struct kvm_memory_slot *slot = fault->slot;
-	bool async;
+	struct kvm_follow_pfn foll = {
+		.slot = slot,
+		.gfn = fault->gfn,
+		.flags = FOLL_GET | (fault->write ? FOLL_WRITE : 0),
+		.try_map_writable = true,
+	};
 
 	/*
 	 * Retry the page fault if the gfn hit a memslot that is being deleted
@@ -4325,12 +4330,20 @@ static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 			return RET_PF_EMULATE;
 	}
 
-	async = false;
-	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, false, false, &async,
-					  fault->write, &fault->map_writable,
-					  &fault->hva);
-	if (!async)
-		return RET_PF_CONTINUE; /* *pfn has correct page already */
+	foll.flags |= FOLL_NOWAIT;
+	fault->pfn = __kvm_follow_pfn(&foll);
+
+	if (!is_error_noslot_pfn(fault->pfn))
+		goto success;
+
+	/*
+	 * If __kvm_follow_pfn() failed because I/O is needed to fault in the
+	 * page, then either set up an asynchronous #PF to do the I/O, or if
+	 * doing an async #PF isn't possible, retry __kvm_follow_pfn() with
+	 * I/O allowed. All other failures are fatal, i.e. retrying won't help.
+	 */
+	if (fault->pfn != KVM_PFN_ERR_NEEDS_IO)
+		return RET_PF_CONTINUE;
 
 	if (!fault->prefetch && kvm_can_do_async_pf(vcpu)) {
 		trace_kvm_try_async_get_page(fault->addr, fault->gfn);
@@ -4348,9 +4361,17 @@ static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	 * to wait for IO.  Note, gup always bails if it is unable to quickly
 	 * get a page and a fatal signal, i.e. SIGKILL, is pending.
 	 */
-	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, false, true, NULL,
-					  fault->write, &fault->map_writable,
-					  &fault->hva);
+	foll.flags |= FOLL_INTERRUPTIBLE;
+	foll.flags &= ~FOLL_NOWAIT;
+	fault->pfn = __kvm_follow_pfn(&foll);
+
+	if (!is_error_noslot_pfn(fault->pfn))
+		goto success;
+
+	return RET_PF_CONTINUE;
+success:
+	fault->hva = foll.hva;
+	fault->map_writable = foll.writable;
 	return RET_PF_CONTINUE;
 }
 
-- 
2.42.0.rc1.204.g551eb34607-goog

