Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D804D7BAFFF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 03:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjJFBNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 21:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjJFBNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 21:13:07 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AEAE4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 18:13:05 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-27731a63481so1493647a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 18:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696554784; x=1697159584; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZAek5umiw6GVVoIEUs57JBTUu1Ih3TpUkA3pAEzjKWY=;
        b=2h2QK6gqw4FLR3yx2bhHeZAYMiLEvjmruIIqwVZlSdfvvo9I7btoOjevefJHNsf+ry
         8TL8XY+XQJu+p5ECY1LHz/3h6b4vuAbskcGklpEEFziskkAMJ9xXW9CoK/MDRHvxIIA5
         /MyIM6zxNNpqCHDOAkOeSC/k/d2f46FxHGGVPKJFd1/Cb2k/tusV7oZiuGXt6copNNx4
         bfrFfstVBM3W1I1n5vuTxaXltfENJKJiMWN1UGGj/ReJGCwzm4aX+dAF+O+Z9/hPW0MX
         s3y/gIDnQ74AmoQi18VuV87hN4nuob1qajHJzUhx/ryALztQzQxjaWUhqOwByAKwZ+7z
         Io/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696554784; x=1697159584;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZAek5umiw6GVVoIEUs57JBTUu1Ih3TpUkA3pAEzjKWY=;
        b=btEGp7az3OqxiAVK0VY/dL+UiITWuVFPt6ykxlxCXRCrmI47mP8JFSMGlDk1sdnvtY
         8PpNseleBES935Vs9UWS2vnje8e5pdQIpCJZntzT9FibfOpZwZRGq7XiaIaEJ1Qz6SCZ
         M4jqb5YQTBKEviaVoo8rQLTsIej+bwXHzZac07YVfCmXgpnuVi7QovfHe33JvXz/Nugg
         8VvWlOOKHZQeQPMZeoxx522ZeN4GXwP8W5z41qm25cxQ5s1X3X+1ZXWEgLU0A/rGCpah
         KyqGFhlrvvuqWUdqwxmwpx8F71gWQ6oR91moDbu8eMBvmEcOohGheK9EHCDnV2SvYU+J
         N+bQ==
X-Gm-Message-State: AOJu0YyumxlwUxAY6s4xk0BjtN6NVQgGp8KE8q5c6/c+YMDZx6J+9wue
        KEHznDqu2ogANbvH/XvrhlNoNv8onJmbgHPV
X-Google-Smtp-Source: AGHT+IFaSFiDN6s7b5QnThCcfsNZu7HKcB00VtLQMm6/AH4Mz1KgT5focdnzVy4yYsrJWHqYTSx+4tkiEfZiNjoi
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:43a4])
 (user=vannapurve job=sendgmr) by 2002:a17:90a:ad4c:b0:276:d039:aec4 with SMTP
 id w12-20020a17090aad4c00b00276d039aec4mr110386pjv.6.1696554784428; Thu, 05
 Oct 2023 18:13:04 -0700 (PDT)
Date:   Fri,  6 Oct 2023 01:12:55 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231006011255.4163884-1-vannapurve@google.com>
Subject: [PATCH] x86/tdx: Override the tsc calibration for TDX VMs
From:   Vishal Annapurve <vannapurve@google.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Sagi Shahar <sagis@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TSC calibration for native execution gets the TSC frequency from CPUID,
but also ends up setting lapic_timer_period. When using oneshot mode
with lapic timer, predefined value of lapic_timer_period causes lapic
timer calibration to be skipped with wrong multipliers set for lapic
timer.

To avoid this issue, override the TSC calibration step for TDX VMs to
just calculate the TSC frequency using cpuid values.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 arch/x86/coco/tdx/tdx.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 1d6b863c42b0..6625594f8c62 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -757,6 +757,33 @@ static bool tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
 	return true;
 }
 
+/**
+ * Determine TSC frequency via CPUID, else return 0.
+ */
+static unsigned long tdx_calibrate_tsc(void)
+{
+	unsigned int eax_denominator = 0, ebx_numerator = 0, ecx_hz = 0, edx = 0;
+	unsigned int crystal_khz;
+
+	/* CPUID 15H TSC/Crystal ratio, plus optionally Crystal Hz */
+	cpuid(0x15, &eax_denominator, &ebx_numerator, &ecx_hz, &edx);
+
+	if (ebx_numerator == 0 || eax_denominator == 0)
+		return 0;
+
+	crystal_khz = ecx_hz / 1000;
+
+	/*
+	 * TSC frequency reported directly by CPUID is a "hardware reported"
+	 * frequency and is the most accurate one so far we have. This
+	 * is considered a known frequency.
+	 */
+	if (crystal_khz != 0)
+		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+
+	return crystal_khz * ebx_numerator / eax_denominator;
+}
+
 void __init tdx_early_init(void)
 {
 	u64 cc_mask;
@@ -808,6 +835,7 @@ void __init tdx_early_init(void)
 
 	x86_platform.guest.enc_cache_flush_required  = tdx_cache_flush_required;
 	x86_platform.guest.enc_tlb_flush_required    = tdx_tlb_flush_required;
+	x86_platform.calibrate_tsc = tdx_calibrate_tsc;
 
 	/*
 	 * TDX intercepts the RDMSR to read the X2APIC ID in the parallel
-- 
2.42.0.609.gbb76f46606-goog

