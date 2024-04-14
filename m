Return-Path: <linux-kernel+bounces-144064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A3D8A4166
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4677281F9A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17417225D6;
	Sun, 14 Apr 2024 09:06:04 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9CA224F6
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 09:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713085563; cv=none; b=a46VFjF1CMbrwtRoNJd7Jnrs7Sd69Bcj7AJ0ndo3pzZwNve59qFLJcsWGz7qd3MGJTBy9eh1ZC9RAT5PvuFK8owr6cC3Ij6+GMvj0XFw0SC6yteNCOiSQSjMfoWUuAC50KIzWCsbd4PcuMbR7rDQg5G/6oKTzxHPKG+hWPfBkdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713085563; c=relaxed/simple;
	bh=yrAL9GUA/N14hW0WLi3sK266Q0gOYXSQTBR6phPWlLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJexKNuFvAae5W1mRiGB/jo/dZcT1mzghJm/myU6hNeo/ECOAEiGvdvE0gHJPjPeWT+Tm6d4zemTd9EvTxwQmqtd28onY6824gJNGTBOxZaSs8kuwm16r0hr5hv63lwNW2EX3NllnLTRDtrWBkToLFF5vT/TJcELJpvhL2B08jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6BC5140E01C5;
	Sun, 14 Apr 2024 09:05:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Tt5TSdih2YIp; Sun, 14 Apr 2024 09:05:55 +0000 (UTC)
Received: from nazgul.tnic (unknown [212.23.229.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 986A740E0177;
	Sun, 14 Apr 2024 09:05:42 +0000 (UTC)
Date: Sun, 14 Apr 2024 11:08:10 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>,
	Erhard Furtner <erhard_f@mailbox.org>, x86@kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	jpoimboe@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Breno Leitao <leitao@debian.org>
Subject: Re: [bisected] Kernel v6.9-rc3 fails to boot on a Thinkpad T60 with
 MITIGATION_RETHUNK=y (regression from v6.8.5)
Message-ID: <20240414090810.GBZhuc-lN6tyKbF_-M@fat_crate.local>
References: <20240413024956.488d474e@yea>
 <ZhpOIeVq1KQXzjBp@archie.me>
 <68e3503c-5573-4d82-8fb0-5b955c212d67@leemhuis.info>
 <20240414083626.GAZhuViviWKudQ5Apm@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240414083626.GAZhuViviWKudQ5Apm@fat_crate.local>

On Sun, Apr 14, 2024 at 10:36:26AM +0200, Borislav Petkov wrote:
> Am looking at the whole thing. Stay tuned...

Something like this, I guess...

Execution goes off somewhere into the weeds during alternatives patching
of the return thunk while it tries to warn about it in the alternatives
code itself and it all ends up in an endless INT3 exceptions due to our
speculation blockers everywhere...

I could chase it as to why exactly but the warning is there for all
those mitigations which need a special return thunk and 32-bit doesn't
need them (and at least the AMD untraining sequences are 64-bit only
so...).

IOW:

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index e674ccf720b9..391059b2c6fb 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -382,8 +382,15 @@ SYM_FUNC_END(call_depth_return_thunk)
 SYM_CODE_START(__x86_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
+#if defined(CONFIG_MITIGATION_UNRET_ENTRY) || \
+    defined(CONFIG_MITIGATION_SRSO) || \
+    defined(CONFIG_MITIGATION_CALL_DEPTH_TRACKING)
 	ALTERNATIVE __stringify(ANNOTATE_UNRET_SAFE; ret), \
 		   "jmp warn_thunk_thunk", X86_FEATURE_ALWAYS
+#else
+	ANNOTATE_UNRET_SAFE
+	ret
+#endif
 	int3
 SYM_CODE_END(__x86_return_thunk)
 EXPORT_SYMBOL(__x86_return_thunk)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

