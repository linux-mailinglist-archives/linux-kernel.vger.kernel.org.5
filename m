Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9270D806D5C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377943AbjLFLG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377967AbjLFLGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:06:52 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE8210C8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:06:56 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2205C40E00C9;
        Wed,  6 Dec 2023 11:06:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mXNI4ZqTJxqJ; Wed,  6 Dec 2023 11:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701860811; bh=avZmmojFb5Au74EZMhQdVYNLK9roiJ15+g0jrwBoiSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LwoQz6sZF7v3TIC5zxH5InKXTcjQDBRcbUN7pQ7ss/ZL0eBpAu4Z4SamjFSYBxS5+
         abK0dyyzfMXMUz0kIW9hiNrubH+YAZOC5qBpPgRNRYKg6eMrAMYxcc7xruNOKtcOsQ
         /kIoJKCmdFotUQ7Hfs8PLkiEjUXTRcfW5cEXJUuvN0WdguT5UbpHqL6UD5Wa0GyeFg
         TSq9IDg4zT6teOGDv0wyEFNnTezLZhCD4UPwJEhEKDzcdS7Ap0x5wwLIt1yiWHlojv
         y3Vuvxclum0pkUY7xF1wGgg+G/T72lFY7t7XJG76FFewcDnjfZt21ykcUqwwBkoDhC
         TRUTglDGVMgmD45uK73fRaZTLnAb3Di6wMTrhRlZi9QevkcurVYom43/SaBqsuXUoL
         SbBFoKcnptSp5Fw+rMRLsF2irYgD6dBWULMUY2GkyLsZaQ98vICrWiT5530dnQteJ+
         FERC9Bm9602cnvaSDPJB/c1sk3Uqmat8qqw62p/5Wfmg52dZet5sQ5AIk8T7xJoISz
         9eueOzgWq6fhnJiF6UQKb2d7iQ+JE5l1G7PnuUma09mgObuQYBcMjiDa8t8XEsUX6l
         V1E42Q4+yF/s8Rw8cynzfEWIrLet72IV1jRKkYR6i0kgkkusuVyPq08f1eAfMphwFn
         MmTgw9uV0uOV6GYam0iyQhq0=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 09C4440E00A9;
        Wed,  6 Dec 2023 11:06:42 +0000 (UTC)
Date:   Wed, 6 Dec 2023 12:06:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 3/5] x86/alternative: add indirect call patching
Message-ID: <20231206110636.GBZXBVvCWj2IDjVk4c@fat_crate.local>
References: <20231129133332.31043-1-jgross@suse.com>
 <20231129133332.31043-4-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129133332.31043-4-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 02:33:30PM +0100, Juergen Gross wrote:
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
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

That SOB chain basically says that you're PeterZ and you're sending this
patch. :)

Are you trying to say that he co-developed it or suggested it or
Originally-by?

Documentation/process/submitting-patches.rst has it all.

Also, what I did ontop of this is below as we must dump the full flags
now with the debug output since you're adding more flags than ALT_NOT.

Also, the naked magic numbers need explanation.

Please include into your next submission.

Thx.

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index e7e53b9e801b..888205234f15 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -395,6 +395,9 @@ noinstr void BUG_func(void)
 }
 EXPORT_SYMBOL_GPL(BUG_func);
 
+#define CALL_RIP_REL_PREFIX	0xff
+#define CALL_RIP_REL_MODRM	0x15
+
 /*
  * Rewrite the "call BUG_func" replacement to point to the target of the
  * indirect pv_ops call "call *disp(%ip)".
@@ -409,11 +412,14 @@ static int alt_replace_call(u8 *instr, u8 *insn_buff, struct alt_instr *a)
 		BUG();
 	}
 
-	if (a->instrlen != 6 || instr[0] != 0xff || instr[1] != 0x15) {
+	if (a->instrlen != 6 ||
+	    instr[0] != CALL_RIP_REL_PREFIX ||
+	    instr[1] != CALL_RIP_REL_MODRM) {
 		pr_err("ALT_FLAG_DIRECT_CALL set for unrecognized indirect call\n");
 		BUG();
 	}
 
+	/* Skip CALL_RIP_REL_PREFIX and CALL_RIP_REL_MODRM */
 	disp = *(s32 *)(instr + 2);
 #ifdef CONFIG_X86_64
 	/* ff 15 00 00 00 00   call   *0x0(%rip) */
@@ -493,12 +499,11 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 			continue;
 		}
 
-		DPRINTK(ALT, "feat: %s%d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d)",
-			(a->flags & ALT_FLAG_NOT) ? "!" : "",
+		DPRINTK(ALT, "feat: %d32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d) flags: 0x%x",
 			a->cpuid >> 5,
 			a->cpuid & 0x1f,
 			instr, instr, a->instrlen,
-			replacement, a->replacementlen);
+			replacement, a->replacementlen, a->flags);
 
 		memcpy(insn_buff, replacement, a->replacementlen);
 		insn_buff_sz = a->replacementlen;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
