Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507747679B5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbjG2Ahf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236072AbjG2AhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:37:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F019F44AE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 17:36:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d1ef70d6a02so2490132276.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 17:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690591017; x=1691195817;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=yrzuMhAa5ZwKSNV65AbGOyhxR2CbeFJJoK4NwSTk8zA=;
        b=dN9YT0VxVpTnTjGk/rv/FxwHOjp1VRvYhtyRfTVCAOoulkUZDNhTZRIAQk8NOYfzZZ
         GWEnyWCXZ+uS6SH++isxPQAlqFS/lA6695c9u+iCiY2gzPBkcDkFB1xdiizMtZDxh38s
         JhdAaexpefMPKDWwwntmojHOAbSw2wFqTgQFuSAyMXENyvM48ivs3AXaTMZ82Kx5J4jW
         1kfdHVfh4dZh8FWhvcm03R9vowpN+JAwtXDm6Wy6OKafqBDFo6Zl0dqWCqKvEmo3qZ+L
         Tw0U7sTciY5PsfKaJJzXUgwKlmw8zZcjJQZ7mmloZZWEM4wOySbaCh0bwzOyHfTy2Dw+
         qQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591017; x=1691195817;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yrzuMhAa5ZwKSNV65AbGOyhxR2CbeFJJoK4NwSTk8zA=;
        b=ZMtoaZB3DRgoZoQ0umdKGtxFp0MIi0jpcTMEaB6H5vALN5vxgfEixXMRmLfvNw3opy
         WOkdrfbjau1swMfPQZisye+L9WVZCAPfr3EZuUtyDxtKVw+wpGB/48fbwSV7531JeV/3
         gehEfVombBDmq4BzzLPtq9nFJYFQGkRLhc8U8Lcm4Y5U2DIOGFCWh+KbGIjEinDQcrgE
         X68LNWtgO0hVw57zvMXVX65kslHzNOSGCro3dclJ7qKHmrfH2vfEcN5EilD0pvEZormz
         OV6e+K+NX1N+l0ihMLP8RBGyAc6xL7LLrbkX+1U/hNZAn8UX4177pRJTKWXgEMd2/coV
         JTJw==
X-Gm-Message-State: ABy/qLY8OsveLvMxNjLLrVlCw8LgNh729zgHcrwYza658vxEtYSP47Nz
        AgZF4lobgQkZNXpPoGeTwFtWq0yWR/c=
X-Google-Smtp-Source: APBJJlEZT09RPLsuDS5f8Sg2OFhpONKGw2AX4nW13KrfxH17cPvEic/pdQPcg0HACBrHFD9tkqER2tbLXyU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ccd1:0:b0:d1c:5506:9761 with SMTP id
 l200-20020a25ccd1000000b00d1c55069761mr23062ybf.1.1690591017810; Fri, 28 Jul
 2023 17:36:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 28 Jul 2023 17:36:15 -0700
In-Reply-To: <20230729003643.1053367-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230729003643.1053367-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230729003643.1053367-7-seanjc@google.com>
Subject: [PATCH v4 06/34] KVM: selftests: Add additional pages to the guest to
 accommodate ucall
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Thomas Huth <thuth@redhat.com>,
        "=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=" <philmd@linaro.org>,
        Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Lewis <aaronlewis@google.com>

Add additional pages to the guest to account for the number of pages
the ucall headers need.  The only reason things worked before is the
ucall headers are fairly small.  If they were ever to increase in
size the guest could run out of memory.

This is done in preparation for adding string formatting options to
the guest through the ucall framework which increases the size of
the ucall headers.

Fixes: 426729b2cf2e ("KVM: selftests: Add ucall pool based implementation")
Signed-off-by: Aaron Lewis <aaronlewis@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/ucall_common.h | 1 +
 tools/testing/selftests/kvm/lib/kvm_util.c         | 4 ++++
 tools/testing/selftests/kvm/lib/ucall_common.c     | 5 +++++
 3 files changed, 10 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/ucall_common.h b/tools/testing/selftests/kvm/include/ucall_common.h
index 1a6aaef5ccae..bcbb362aa77f 100644
--- a/tools/testing/selftests/kvm/include/ucall_common.h
+++ b/tools/testing/selftests/kvm/include/ucall_common.h
@@ -34,6 +34,7 @@ void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu);
 void ucall(uint64_t cmd, int nargs, ...);
 uint64_t get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc);
 void ucall_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa);
+int ucall_nr_pages_required(uint64_t page_size);
 
 /*
  * Perform userspace call without any associated data.  This bare call avoids
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 3170d7a4520b..7a8af1821f5d 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -312,6 +312,7 @@ static uint64_t vm_nr_pages_required(enum vm_guest_mode mode,
 				     uint32_t nr_runnable_vcpus,
 				     uint64_t extra_mem_pages)
 {
+	uint64_t page_size = vm_guest_mode_params[mode].page_size;
 	uint64_t nr_pages;
 
 	TEST_ASSERT(nr_runnable_vcpus,
@@ -340,6 +341,9 @@ static uint64_t vm_nr_pages_required(enum vm_guest_mode mode,
 	 */
 	nr_pages += (nr_pages + extra_mem_pages) / PTES_PER_MIN_PAGE * 2;
 
+	/* Account for the number of pages needed by ucall. */
+	nr_pages += ucall_nr_pages_required(page_size);
+
 	return vm_adjust_num_guest_pages(mode, nr_pages);
 }
 
diff --git a/tools/testing/selftests/kvm/lib/ucall_common.c b/tools/testing/selftests/kvm/lib/ucall_common.c
index 2f0e2ea941cc..77ada362273d 100644
--- a/tools/testing/selftests/kvm/lib/ucall_common.c
+++ b/tools/testing/selftests/kvm/lib/ucall_common.c
@@ -11,6 +11,11 @@ struct ucall_header {
 	struct ucall ucalls[KVM_MAX_VCPUS];
 };
 
+int ucall_nr_pages_required(uint64_t page_size)
+{
+	return align_up(sizeof(struct ucall_header), page_size) / page_size;
+}
+
 /*
  * ucall_pool holds per-VM values (global data is duplicated by each VM), it
  * must not be accessed from host code.
-- 
2.41.0.487.g6d72f3e995-goog

