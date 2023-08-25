Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D21878807B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242767AbjHYHCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241362AbjHYHCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:02:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC271199E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:02:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41C186404D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:02:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A777C433C7;
        Fri, 25 Aug 2023 07:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692946924;
        bh=rP86MMvPG+dPyCsGymZiEpaBrzyflZRcfpq/e1xxDGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fUUxSqj8+im2BF0zGrFhKs+Ot5aK2AT501tpHBA45dLJN/se28FTTIRBJzyofXCEe
         /7XWe3i+bXm+Y26wCx99PQgiPLzeuloJRRXjyniureJzqE5hAqEVHnz9NDu/mj5egc
         cKf1Frj2xYl41MtvEuKInbtXyhLlD0dIFrdAPUQl/WSkHSAjBZuBSmGJRSOJ+7weh1
         yqiouRnM66vDScQRvfJQpbIjBwRr7+Pc0AoGF1hZFVAetDtt9CRV4vvwml/fClCZlE
         r/38jsC7OqqP7p9hHho6Eg816M3Z6SFSEswwcpkElFNKI7vIFv6RnkygYuZ9Q/D4Co
         NpmUBiGNgu6+w==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 04/23] KVM: x86: Add IBPB_BRTYPE support
Date:   Fri, 25 Aug 2023 00:01:35 -0700
Message-ID: <79d5f5914fb42c2c62418ffbcd78f138645ded21.1692919072.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692919072.git.jpoimboe@kernel.org>
References: <cover.1692919072.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the IBPB_BRTYPE CPUID flag, which indicates that IBPB
includes branch type prediction flushing.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kvm/cpuid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index d3432687c9e6..c65f3ff1c79d 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -729,8 +729,8 @@ void kvm_set_cpu_caps(void)
 		F(NULL_SEL_CLR_BASE) | F(AUTOIBRS) | 0 /* PrefetchCtlMsr */
 	);
 
-	if (cpu_feature_enabled(X86_FEATURE_SRSO_NO))
-		kvm_cpu_cap_set(X86_FEATURE_SRSO_NO);
+	kvm_cpu_cap_check_and_set(X86_FEATURE_IBPB_BRTYPE);
+	kvm_cpu_cap_check_and_set(X86_FEATURE_SRSO_NO);
 
 	kvm_cpu_cap_init_kvm_defined(CPUID_8000_0022_EAX,
 		F(PERFMON_V2)
-- 
2.41.0

