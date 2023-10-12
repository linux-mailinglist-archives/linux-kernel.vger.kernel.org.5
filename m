Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325E07C6A65
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343665AbjJLKEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235618AbjJLKEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:04:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F951A9;
        Thu, 12 Oct 2023 03:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697105076; x=1728641076;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MYvAKDdK1BbhX247ponvSXkbWwL0F8DFfz3s+y5S/6A=;
  b=HFpV/+3CBDf04+aVkrABphGBAWZjNx8q25IMzStybLeiNreelx7+n+Gq
   jZR50QQEIM20CpK9+OfTaz6YB/k7zn4u/lsy0/hGI+y4CFD9RFUdPjv5/
   nunh/62XYe/LsxFVSy/TYQzQDOLopsCRF5rEndkql02dOfKKK5y0ouggP
   upXryH1GyKTxIn3K3XqGcBQMYD/M6i3Z+29j5P9/jOqpsgsFX2sJVUJpV
   zntzp93yySzH4eLw8c7lRY3smu/VHTLD5uABXFQG9K2PcBqVMJEKY7qKk
   9SAGin9aKdnAAUppCSC0zbQloq7J5oGKI9+SgmoEzXWNbEoUT0gx6aRTf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="388744141"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="388744141"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 03:04:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="789338995"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="789338995"
Received: from nmalinin-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.58.130])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 03:04:31 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 3466E10A1B1; Thu, 12 Oct 2023 13:04:28 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Fei Yang <fei.yang@intel.com>, stable@vger.kernel.org
Subject: [PATCHv3] x86/alternatives: Disable KASAN in apply_alternatives()
Date:   Thu, 12 Oct 2023 13:04:24 +0300
Message-ID: <20231012100424.1456-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fei has reported that KASAN triggers during apply_alternatives() on
5-level paging machine:

	BUG: KASAN: out-of-bounds in rcu_is_watching
	Read of size 4 at addr ff110003ee6419a0 by task swapper/0/0
	...
	__asan_load4
	rcu_is_watching
	trace_hardirqs_on
	text_poke_early
	apply_alternatives
	...

On machines with 5-level paging, cpu_feature_enabled(X86_FEATURE_LA57)
got patched. It includes KASAN code, where KASAN_SHADOW_START depends on
__VIRTUAL_MASK_SHIFT, which is defined with the cpu_feature_enabled().

KASAN gets confused when apply_alternatives() patches the
KASAN_SHADOW_START users. A test patch that makes KASAN_SHADOW_START
static, by replacing __VIRTUAL_MASK_SHIFT with 56, fixes the issue.

Disable KASAN while kernel patches alternatives.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Fei Yang <fei.yang@intel.com>
Fixes: 6657fca06e3f ("x86/mm: Allow to boot without LA57 if CONFIG_X86_5LEVEL=y")
Cc: stable@vger.kernel.org
---
 v3:
  - Summarize KASAN splat;
  - Update comment in apply_alternatives();

 v2:
  - Move kasan_disable/_enable_current() to cover whole loop, not only
    text_poke_early();
  - Adjust commit message.
---
 arch/x86/kernel/alternative.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 517ee01503be..73be3931e4f0 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -403,6 +403,17 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	u8 insn_buff[MAX_PATCH_LEN];
 
 	DPRINTK(ALT, "alt table %px, -> %px", start, end);
+
+	/*
+	 * In the case CONFIG_X86_5LEVEL=y, KASAN_SHADOW_START is defined using
+	 * cpu_feature_enabled(X86_FEATURE_LA57) and is therefore patched here.
+	 * During the process, KASAN becomes confused seeing partial LA57
+	 * conversion and triggers a false-positive out-of-bound report.
+	 *
+	 * Disable KASAN until the patching is complete.
+	 */
+	kasan_disable_current();
+
 	/*
 	 * The scan order should be from start to end. A later scanned
 	 * alternative code can overwrite previously scanned alternative code.
@@ -452,6 +463,8 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 
 		text_poke_early(instr, insn_buff, insn_buff_sz);
 	}
+
+	kasan_enable_current();
 }
 
 static inline bool is_jcc32(struct insn *insn)
-- 
2.41.0

