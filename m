Return-Path: <linux-kernel+bounces-146554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 615498A671F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E6D1C21704
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1318528F;
	Tue, 16 Apr 2024 09:27:47 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D429B85272;
	Tue, 16 Apr 2024 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713259667; cv=none; b=Z7Lqhx06CAIYPH3v7E6DPE6B5nPCLd57Fwe29SNXLrdFMYJt8umWe4uD4tLvv+bSMqKOh2JCIT/KBEIue4m7vZYCq4T0J5RoFXIp+SV6nPICv4Hk55bxL6vFGRlzp0SZnH47vFAIg7Fi7eRkHWPHWEzFSk0QOSbcpzaC3LEMc/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713259667; c=relaxed/simple;
	bh=rl7/49N7v30krDSKR0so/zjNywMJUo2Pd9g6g4AOMFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHOemicuxIqa+SgqFkj9X92mv18UbTTxDyQGjrNE7cXK8L5zDIm3tEbKdqZXG0SXVPWyehIfMMKvMhI1A1+h+mbwrDBcMx2GuDlooPd6o6ot/C8CQM+GB7asCbhsmxropoD4SVN2HMbO6ha6aL8o9LZ5JQRUnTmjhWm2rwPAUXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 85AC540E024C;
	Tue, 16 Apr 2024 09:27:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UUDF4TFEKb9T; Tue, 16 Apr 2024 09:27:37 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 577B740E0177;
	Tue, 16 Apr 2024 09:27:27 +0000 (UTC)
Date: Tue, 16 Apr 2024 11:27:20 +0200
From: Borislav Petkov <bp@alien8.de>
To: Klara Modin <klarasmodin@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	"Kaplan, David" <David.Kaplan@amd.com>,
	Ingo Molnar <mingo@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"x86@kernel.org" <x86@kernel.org>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH -v2] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20240416092720.GCZh5EeB3bPWVDBMoV@fat_crate.local>
References: <20231024201913.GHZTgmwf6QMkX8BGbo@fat_crate.local>
 <20240103184656.GEZZWroPmHLJuP6y5H@fat_crate.local>
 <20240104131210.GDZZauqoeKoZGpYwDd@fat_crate.local>
 <20240104132446.GEZZaxnrIgIyat0pqf@fat_crate.local>
 <20240104132623.GFZZax/wyf5Y3rMX5G@fat_crate.local>
 <20240207175010.nrr34b2pp3ewe3ga@treble>
 <20240207185328.GEZcPRqPsNInRXyNMj@fat_crate.local>
 <20240207194919.qw4jk2ykadjn5d4e@treble>
 <20240212104348.GCZcn2ZPr445KUyQ7k@fat_crate.local>
 <78e0d19c-b77a-4169-a80f-2eef91f4a1d6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <78e0d19c-b77a-4169-a80f-2eef91f4a1d6@gmail.com>

On Wed, Apr 03, 2024 at 07:10:17PM +0200, Klara Modin wrote:
> With this patch/commit, one of my machines (older P4 Xeon, 32-bit only)
> hangs on boot with CONFIG_RETHUNK=y / CONFIG_MITIGATION_RETHUNK=y.

Ok, this should fix it:

---
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Mon, 15 Apr 2024 18:15:43 +0200
Subject: [PATCH] x86/retpolines: Enable the default thunk warning only on relevant configs

The using-default-thunk warning check makes sense only with
configurations which actually enable the special return thunks.

Otherwise, it fires on unrelated 32-bit configs on which the special
return thunks won't even work (they're 64-bit only) and, what is more,
those configs even go off into the weeds when booting in the
alternatives patching code, leading to a dead machine.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/78e0d19c-b77a-4169-a80f-2eef91f4a1d6@gmail.com
Link: https://lore.kernel.org/r/20240413024956.488d474e@yea
---
 arch/x86/lib/retpoline.S | 7 +++++++
 1 file changed, 7 insertions(+)

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
2.43.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

