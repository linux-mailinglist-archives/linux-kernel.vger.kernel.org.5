Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC4E782F07
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 19:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbjHURFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 13:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236637AbjHURFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:05:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE3FEC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 10:05:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D108663FB5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 17:05:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9948C433C8;
        Mon, 21 Aug 2023 17:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692637522;
        bh=yOqCdpIyIpUzG50zxebnqqgGyhgFh6oKPQzqFCIqFb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JXF2axUBUoj9oFZfO8AGKu2k37vvALXBqb4hmGWRchnqVNCH9KcCagWiNktmOlJ5Y
         4aaXysyIZ8tFCppYy29OvBOTTKUoiULGFTbBhrXECEK0l1YB0EFHXfRzzFg9ylYYFy
         r9sL2gaNsG8hbCSf2LYe/kl8wDuRW9i8uyOskfPNlgkzwIgi1RlkiRS9WtneJkZh5s
         jXxSx4tk5Blmo1g8maUudftLDjkWz4X1AunO35A12VK4QJRcOZ9HzrX7TaxmPHXw+o
         1NmTe02ek48aINrXi4nRSLyrf17N33qwb8a2P1o0IlFtSnErBX7ObCHi7d0le61Bzq
         7gZX79a6/SD9Q==
Date:   Mon, 21 Aug 2023 10:05:20 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>, David.Kaplan@amd.com,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 03/22] KVM: x86: Support IBPB_BRTYPE and SBPB
Message-ID: <20230821170520.dcovzudamnoqp7jc@treble>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <a4d62162bcb501e50b0bb19b748702aa12260615.1692580085.git.jpoimboe@kernel.org>
 <45ef7bcc-d52e-3759-403b-e4b5a79a4a4f@citrix.com>
 <20230821162337.imzjf3golstkrrgd@treble>
 <ZOOSXc9NE1rMHDZ1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZOOSXc9NE1rMHDZ1@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 04:35:41PM +0000, Sean Christopherson wrote:
> There are more wrinkles though.  KVM passes through MSR_IA32_PRED_CMD based on
> IBPB.  If hardware supports both IBPB and SBPB, but userspace does NOT exposes
> SBPB to the guest, then KVM will create a virtualization hole where the guest can
> write SBPB against userspace's wishes.  I haven't read up on SBPB enought o know
> whether or not that's problematic.
> 
> And conversely, if userspace expoes SBPB but not IBPB, then KVM will intercept
> writes to MSR_IA32_PRED_CMD and probably tank guest performance.  Again, I haven't
> paid attention enough to know if this is a reasonable configuration, i.e. whether
> or not it's worth caring about in KVM.
> 
> If the virtualization holes are deemed safe, then the easiest thing would be to
> treat MSR_IA32_PRED_CMD as existing if either IBPB or SBPB exists.  E.g.

I can't think of a reason why the holes wouldn't be safe, i.e. AFAICT
there's no harm in letting the guest do whatever type of barrier it
wants even if it's not technically supported by their configuration.

Question: if we're just always passing PRED_CMD through, what's the
point of having any PRED_CMD code in kvm_set_msr_common at all?

Also, since you're clearly more qualified to write this patch than me,
can I nominate you to do so? :-)

FWIW, the below is my qemu patch which worked for me in testing:

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 97ad229d8b..4b17f0152b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1054,8 +1054,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, "sbpb",
+            "ibpb-brtype", "srso-no", NULL, NULL,
         },
         .cpuid = { .eax = 0x80000021, .reg = R_EAX, },
         .tcg_features = 0,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e0771a1043..ff3c714214 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -969,6 +969,12 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE    (1U << 6)
 /* Automatic IBRS */
 #define CPUID_8000_0021_EAX_AUTO_IBRS   (1U << 8)
+/* Selective Branch Prediction Barrier */
+#define CPUID_8000_0021_EAX_SBPB        (1U << 27)
+/* MSR_PRED_CMD[IBPB] flushes all branch type predictions */
+#define CPUID_8000_0021_EAX_IBPB_BRTYPE (1U << 28)
+/* CPU is not affected by SRSO */
+#define CPUID_8000_0021_EAX_SRSO_NO     (1U << 29)
 
 #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
 #define CPUID_XSAVE_XSAVEC     (1U << 1)
