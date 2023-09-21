Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AC87AA106
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjIUU4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjIUU4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:56:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208A41F3A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 13:33:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d81c02bf2beso1792556276.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 13:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695328432; x=1695933232; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=e5f7fcNoXL+epp7GM6J6bVKjQgaoLneVTY2X9JXuWRg=;
        b=GmDzyG/T9FWlGLQM/yDebSC/pppt1SFf7DlQnd4YxYIs07qbm4BTIZ639qV8gbbs7m
         lvzy1Im+3ZCMr0BYirajSwh0nz1LQsDB+qBczOshuKJJTrW8v+m5dqWH6ydd6J4IsUBy
         op4+RPEpviqCWD7wI8xCeErcmwwXFqsXWw82wRucspQNalR9y6bXfZtfOqKq0He2I9W9
         tkM3wU02+d859sXtpBPWNCQL8tMAPwoebZsdiepkA3c2K+5RptmQ01vQZ/7AJblzIs2G
         BgCUMbOSvDmNMUaSExgE1x/nVOG5u7IhPgaDLCy7Ha7iVDEfv+9eeIB0VRps/qwAnfmQ
         Pf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695328432; x=1695933232;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e5f7fcNoXL+epp7GM6J6bVKjQgaoLneVTY2X9JXuWRg=;
        b=Kun9QdzOMIhfV9Gh+iW7lKR52OsxPC/E69vhBUnaspRJIbPPV1DQvoVs/VYwJYn/wB
         unt09PiJloidaus/96SJUgK4Yc0UmaVwLlBEtdnW/ywMSTYg0x84zrGHHhBfX82SFYEZ
         YYx1/o9AkNU1RJzE6JMzu8CSeSoD3Oy8fFUYpCqN8gCXcZTgS2KR6nRGFLqFTFGaDa6p
         FMV1SZ1RTvRhacmLqLzaDc5C8q+/zDuh+0DlZAD/2l7PN6hBoEMTUpk943NT6HnfMwYS
         muWeZt1eJ9qkvUiTMtWxcTcbnxu4SBCAwJ/uoWkAg/Vuq5RDjF435Dxs5dNSDzEIVDBj
         tNqg==
X-Gm-Message-State: AOJu0Ywri3nDNcJ1zgobSiinhqUnrDnK5VQj8n8kkW3QtyOk+BvMOT1E
        5VP2Qf3GgN/N/ffkZzlPC0X9WNYAyVc=
X-Google-Smtp-Source: AGHT+IE3ligRVXMNx7Ai6SVYOMLzKH9iL3vgDfzERbbEOnY3rAREZhYCuKUZj1rP+ggkOD4exEVe8RniJ6M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ce8b:0:b0:d81:503e:2824 with SMTP id
 x133-20020a25ce8b000000b00d81503e2824mr82196ybe.10.1695328432076; Thu, 21 Sep
 2023 13:33:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 21 Sep 2023 13:33:27 -0700
In-Reply-To: <20230921203331.3746712-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230921203331.3746712-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230921203331.3746712-11-seanjc@google.com>
Subject: [PATCH 10/13] KVM: x86/mmu: Drop repeated add() of to-be-invalidated range
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Roth <michael.roth@amd.com>,
        Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvm_unmap_gfn_range() instead of kvm_mmu_unmap_gfn_range() when
handling memory attribute ranges now that common KVM adds the target range
to the invalidation set, i.e. calls kvm_mmu_invalidate_range_add() before
invoking the arch callback.

Fixes: dcde045383f3 ("KVM: x86/mmu: Handle page fault for private memory")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index aa67d9d6fcf8..bcb812a7f563 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7272,7 +7272,7 @@ bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
 	if (WARN_ON_ONCE(!kvm_arch_has_private_mem(kvm)))
 		return false;
 
-	return kvm_mmu_unmap_gfn_range(kvm, range);
+	return kvm_unmap_gfn_range(kvm, range);
 }
 
 static bool hugepage_test_mixed(struct kvm_memory_slot *slot, gfn_t gfn,
-- 
2.42.0.515.g380fc7ccd1-goog

