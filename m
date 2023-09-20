Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A8B7A8777
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbjITOpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236835AbjITOpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:45:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87840C6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 07:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4hBA0mBFz86EuPBzuRyC6ZCKI5h6ySdd8K4qpgeL0oM=; b=Jsv7w/BZMh+zkv/M4Ojx8yDNnZ
        Z6rZzuzcqV9vBeGcpupMFe4Yg7c34Dvkk9NY7HugdGXloG8jpgcsxjBj449PLlFWWfqFIDxpw5F8d
        DGU7GgKsk5pEwwGXqIevo+moJCeGwFLsfHPaOSf1atcOjN6+YRWg9NWvqBA1gvMM2K/WAvPzglpt2
        w34nqJi9OBXzG1MbMlFiCc6XV+6OiBOaWQR0asifD9ycEhqxAlQP6JAj/lmaXwMWo8D0xSiSoIeNc
        +rjoRppbtLbusWfeA/M5HHtyJg0ODokI8yGkWERlBZ3BxIIVIpe/BujHHPph75zZABA4/bS+qpf6x
        re1627Dw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qiyRK-00EfRD-2z;
        Wed, 20 Sep 2023 14:44:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 09E03300513; Wed, 20 Sep 2023 16:44:32 +0200 (CEST)
Date:   Wed, 20 Sep 2023 16:44:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH 2/3] x86/alternative: add indirect call patching
Message-ID: <20230920144431.GA6687@noisy.programming.kicks-ass.net>
References: <20230608140333.4083-1-jgross@suse.com>
 <20230608140333.4083-3-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608140333.4083-3-jgross@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 04:03:32PM +0200, Juergen Gross wrote:
> In order to prepare replacing of paravirt patching with alternative
> patching, add the capability to replace an indirect call with a direct
> one to alternative patching.
> 
> This is done via a new flag ALT_FLAG_CALL as the target of the call
> instruction needs to be evaluated using the value of the location
> addressed by the indirect call. For convenience add a macro for a
> default call instruction. In case it is being used without the new
> flag being set, it will result in a BUG() when being executed. As in
> most cases the feature used will be X86_FEATURE_ALWAYS add another
> macro ALT_CALL_ALWAYS usable for the flags parameter of the ALTERNATIVE
> macros.
> 
> For a complete replacement handle the special cases of calling a nop
> function and an indirect call of NULL the same way as paravirt does.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Since I wrecked all that with 270a69c4485d ("x86/alternative: Support
relocations in alternatives") I wrote you a replacement :-)

---
Index: linux-2.6/arch/x86/include/asm/alternative.h
===================================================================
--- linux-2.6.orig/arch/x86/include/asm/alternative.h
+++ linux-2.6/arch/x86/include/asm/alternative.h
@@ -10,6 +10,9 @@
 
 #define ALT_FLAG_NOT		(1 << 0)
 #define ALT_NOT(feature)	((ALT_FLAG_NOT << ALT_FLAGS_SHIFT) | (feature))
+#define ALT_FLAG_CALL		(1 << 1)
+#define ALT_CALL(feature)	((ALT_FLAG_CALL << ALT_FLAGS_SHIFT) | (feature))
+#define ALT_CALL_ALWAYS		ALT_CALL(X86_FEATURE_ALWAYS)
 
 #ifndef __ASSEMBLY__
 
@@ -150,6 +153,8 @@ static inline int alternatives_text_rese
 }
 #endif	/* CONFIG_SMP */
 
+#define ALT_CALL_INSTR		"call x86_BUG"
+
 #define b_replacement(num)	"664"#num
 #define e_replacement(num)	"665"#num
 
Index: linux-2.6/arch/x86/kernel/alternative.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/alternative.c
+++ linux-2.6/arch/x86/kernel/alternative.c
@@ -396,6 +396,40 @@ noinstr void x86_BUG(void)
 EXPORT_SYMBOL_GPL(x86_BUG);
 
 /*
+ * Rewrite the "call x86_BUG" replacement to point to the target of the
+ * indirect pv_ops call "call *disp(%ip)".
+ */
+static int alt_replace_call(u8 *instr, u8 *insn_buff, struct alt_instr *a)
+{
+	void *target, *bug = &x86_BUG;
+
+	if (a->replacementlen != 5 || insn_buff[0] != CALL_INSN_OPCODE) {
+		pr_err("Alternative: ALT_FLAG_CALL set for a non-call replacement instruction\n");
+		pr_err("  Ignoring the flag for the instruction at %pS (%px)\n", instr, instr);
+		return 5;
+	}
+
+	if (a->instrlen != 6 || instr[0] != 0xff || instr[1] != 0x15) {
+		pr_err("Alternative: ALT_FLAG_CALL set for unrecognized indirect call\n");
+		pr_err("  Not replacing the instruction at %pS (%px)\n", instr, instr);
+		return -1;
+	}
+
+	/* ff 15 00 00 00 00   call   *0x0(%rip) */
+	target = *(void **)(instr + a->instrlen + *(s32 *)(instr + 2));
+	if (!target)
+		target = bug;
+
+	/* (x86_BUG - .) + (target - x86_BUG) := target - . */
+	*(s32 *)(insn_buff + 1) += target - bug;
+
+	if (target == &x86_nop)
+		return 0;
+
+	return 5;
+}
+
+/*
  * Replace instructions with better alternatives for this CPU type. This runs
  * before SMP is initialized to avoid SMP problems with self modifying code.
  * This implies that asymmetric systems where APs have less capabilities than
@@ -451,6 +485,12 @@ void __init_or_module noinline apply_alt
 		memcpy(insn_buff, replacement, a->replacementlen);
 		insn_buff_sz = a->replacementlen;
 
+		if (a->flags & ALT_FLAG_CALL) {
+			insn_buff_sz = alt_replace_call(instr, insn_buff, a);
+			if (insn_buff_sz < 0)
+				continue;
+		}
+
 		for (; insn_buff_sz < a->instrlen; insn_buff_sz++)
 			insn_buff[insn_buff_sz] = 0x90;
 
