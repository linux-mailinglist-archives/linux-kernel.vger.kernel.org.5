Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A2D801DD0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 17:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbjLBQjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 11:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBQjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 11:39:00 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FFF115
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 08:39:04 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 23B2240E025A;
        Sat,  2 Dec 2023 16:39:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tPNwvTI0rU2V; Sat,  2 Dec 2023 16:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701535140; bh=nQmbrfM4qRQXMTfkFquYPysOK9TVsixwOkQpPGJQb7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HubyHDX5eyo5Q5Icf9JREFefBsVmnCQSUFfqX2L+cKaTPyR3RDANPNRv6LfQcmw2g
         Lyeg5/6mXNOrVDQxG9lLjxDZYLnk/qjAANYLqCyRsQqouDZwJ1HcoyIuckN/5kMFzr
         NU50DulKq70pNw1Qavg/XftYyI6yFDEpClhK+3Nb4eO/1is92pbWky/qJirEeWCCE9
         7lNT30RFErY8XUykrH6RtGtBmNsuRatlrX8vXN0cV/qrvdhVDLeTF653IH3YLTkYQN
         o9x0Wjs2NXMi1JSFf253Wi7jOqVxKKJgcWspwgGUy5OphSUvqjvYC53e+1D7uzYacX
         dWwYT0fcqNt7ES16H3DLQeoEnaBLkXqgrYQWhcF7HJZGjggVPBZsM5jHEPGqPwOLT2
         GOVAgKgbu68MhVEHjBi58z0dFiktyGgKYVpB+bb6NghGwGjjoWpNviXyCVzFiOQ51t
         4pNVfPj8GWpihQjJoC3qAhU9He+MigAhyAfP/2g0GHhyhl6qy13RmIjGqOREsXJGCc
         cflLes0ep5UAnZmeSGc90IKUFoDrqkBSLh0984e19V4y5SAH64kyf9yeqG5AFuKURQ
         Th7IsvLC43at4s6GtUDF6qVI6cYtaY5tXBPvecPe630orUccj3UcpzkSeRgKAnRz0h
         ifH+J4R16luI/9eDhUAMz4YI=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EB2A240E0030;
        Sat,  2 Dec 2023 16:38:55 +0000 (UTC)
Date:   Sat, 2 Dec 2023 17:38:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] x86/microcode: Rework early revisions reporting
Message-ID: <20231202163850.GCZWtdmrMoJqyAiycZ@fat_crate.local>
References: <20231115210212.9981-1-bp@alien8.de>
 <20231115210212.9981-3-bp@alien8.de>
 <ZWjVt5dNRjbcvlzR@a4bf019067fa.jf.intel.com>
 <20231201163928.GCZWoMQNAAQSA9U12D@fat_crate.local>
 <ZWpDHgNjhQKLodF6@a4bf019067fa.jf.intel.com>
 <20231201204146.GGZWpFCqodLUPS27tJ@fat_crate.local>
 <ZWpQ9Wbb7u4ss0mt@a4bf019067fa.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZWpQ9Wbb7u4ss0mt@a4bf019067fa.jf.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 01:32:37PM -0800, Ashok Raj wrote:
> dmesg for the microcode part here below:
> 
> https://paste.debian.net/hidden/e911dffc/

Thanks, it is all clear now.

This should fix it:

---
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Fri, 1 Dec 2023 14:35:06 +0100
Subject: [PATCH] x86/microcode/intel: Set new revision only after a successful update

This was meant to be done only when early microcode got updated
successfully. Move it into the if-branch.

Also, make sure the current revision is read unconditionally and only
once.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/microcode/intel.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 070426b9895f..334972c097d9 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -370,14 +370,14 @@ static __init struct microcode_intel *get_microcode_blob(struct ucode_cpu_info *
 {
 	struct cpio_data cp;
 
+	intel_collect_cpu_info(&uci->cpu_sig);
+
 	if (!load_builtin_intel_microcode(&cp))
 		cp = find_microcode_in_initrd(ucode_path);
 
 	if (!(cp.data && cp.size))
 		return NULL;
 
-	intel_collect_cpu_info(&uci->cpu_sig);
-
 	return scan_microcode(cp.data, cp.size, uci, save);
 }
 
@@ -410,13 +410,13 @@ void __init load_ucode_intel_bsp(struct early_load_data *ed)
 {
 	struct ucode_cpu_info uci;
 
-	ed->old_rev = intel_get_microcode_revision();
-
 	uci.mc = get_microcode_blob(&uci, false);
-	if (uci.mc && apply_microcode_early(&uci) == UCODE_UPDATED)
-		ucode_patch_va = UCODE_BSP_LOADED;
+	ed->old_rev = uci.cpu_sig.rev;
 
-	ed->new_rev = uci.cpu_sig.rev;
+	if (uci.mc && apply_microcode_early(&uci) == UCODE_UPDATED) {
+		ucode_patch_va = UCODE_BSP_LOADED;
+		ed->new_rev = uci.cpu_sig.rev;
+	}
 }
 
 void load_ucode_intel_ap(void)
-- 
2.42.0.rc0.25.ga82fb66fed25

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
