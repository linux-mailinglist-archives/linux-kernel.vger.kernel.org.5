Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF7F7F4DB5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343845AbjKVRBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjKVRBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:01:50 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9ABB29F;
        Wed, 22 Nov 2023 09:01:46 -0800 (PST)
Received: from localhost.localdomain (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3567820B74C2;
        Wed, 22 Nov 2023 09:01:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3567820B74C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1700672506;
        bh=9wgjWP/62NvaWRr+CGCSQIegQce2mbkL4aNWuVLLmPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cQ5qDyv2Rah3MoXsEFMlU8EIn49kbZ5NPUGql50qiS7Za5mSWv8lv9Vss99FM6i+h
         BvCUBCqrAoBSX8/lWTVA/wcDN6HGodpQUlCgVH79GAT+bnyrcQhs4ZjDiLXbodRKlb
         FItHxXC4nnexkyPpElSU/phmqHSIgFxyBu6LjFRg=
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michael Kelley <mhkelley58@gmail.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        Dexuan Cui <decui@microsoft.com>
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, stefan.bader@canonical.com,
        tim.gardner@canonical.com, roxana.nicolescu@canonical.com,
        cascardo@canonical.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, sashal@kernel.org, stable@vger.kernel.org
Subject: [PATCH v1 3/3] x86/tdx: Provide stub tdx_accept_memory() for non-TDX configs
Date:   Wed, 22 Nov 2023 18:01:06 +0100
Message-Id: <20231122170106.270266-3-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_INTEL_TDX_GUEST is not defined but CONFIG_UNACCEPTED_MEMORY=y is,
the kernel fails to link with an undefined reference to tdx_accept_memory from
arch_accept_memory. Provide a stub for tdx_accept_memory to fix the build for
that configuration.

CONFIG_UNACCEPTED_MEMORY is also selected by CONFIG_AMD_MEM_ENCRYPT, and there
are stubs for snp_accept_memory for when it is not defined. Previously this did
not result in an error when CONFIG_INTEL_TDX_GUEST was not defined because the
branch that references tdx_accept_memory() was being discarded due to
DISABLE_TDX_GUEST being set.

Cc: <stable@vger.kernel.org> # v6.5+
Fixes: 75d090fd167a ("x86/tdx: Add unaccepted memory support")
Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
---
 arch/x86/include/asm/shared/tdx.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 7513b3bb69b7..58cdbaac3d5b 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -91,7 +91,11 @@ struct tdx_module_output {
 u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
 		      struct tdx_module_output *out);
 
+#ifdef CONFIG_INTEL_TDX_GUEST
 bool tdx_accept_memory(phys_addr_t start, phys_addr_t end);
+#else
+static inline bool tdx_accept_memory(phys_addr_t start, phys_addr_t end) { return false; }
+#endif
 
 /*
  * The TDG.VP.VMCALL-Instruction-execution sub-functions are defined
-- 
2.39.2

