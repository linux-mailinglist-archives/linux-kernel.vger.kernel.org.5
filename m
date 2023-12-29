Return-Path: <linux-kernel+bounces-13039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B2081FEBB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 10:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD4F1C22370
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 09:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E090210A1B;
	Fri, 29 Dec 2023 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OSVJ0Ppg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0620910A00
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8B19340E00CB;
	Fri, 29 Dec 2023 09:39:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id a6tiNQdeLUCW; Fri, 29 Dec 2023 09:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1703842797; bh=Qk0q6nX2Cs4vSXvdmDOIyxNTDDZXTbe3ccra2vUYMFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OSVJ0PpgLIeyh/2zUwfpZ7psmp8LMBltWzdfZhA4+/hoe27U/5lTrp119CH1ucDwJ
	 VEOkLfHbzBRRFpBvwaYR+nFvS0wmGrRPP2kDae3OVCY54YV+eRnu0xiemHgSAjk2f/
	 xOEH1EIlVJ4hdk+ISI78WDKlIIIm4aLda0nbOQDgTHLpCpaKj1rl6GNrTfGbkJnbdX
	 tyWJQvIUjZOAY3vidYY0k7FQTKZzBEapKnQ83sErNty+EJtF3xhTZ07qv+exFx+4xl
	 nugJ4xcGGEXCNJ3RF5eD45ji1cPCpp23KmZKSY5hHYC/TTvg5j+cCluuT/cCnF642S
	 WniSODD9q5ajlWrsGN5T8yADqAIB4yXI1Mho0RfbmEMWtSMWrxBHQjihiY+9YTWUVK
	 L4isCE4jStJDHZWd49ozsAcFLe82XctVgArQ/9aT+hPTGr8v+87SYJRs4IsSsGliQp
	 Nih+GDC8dYHAM1zIWf2gPaQIf0XZgsTFg5kPwWLJH2f8CM3efEQ7PfKpH09Z7mXFGs
	 Qj8v2cKSzTm/pFMrXwUyMpXn3CeE3LFELp5lG6UImaOoO1KWmI7hMLrrZX09ZS5tSD
	 TfvHJ4rjYXdIdyODyU6accS0bphrGkPoFVw/LAsUSCMUhwVtJVr6A3lz1S4kzwDsnE
	 6PviDYYi46IeQ+dsVcG9NRN0=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 414D440E00C9;
	Fri, 29 Dec 2023 09:39:48 +0000 (UTC)
Date: Fri, 29 Dec 2023 10:39:42 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tanzir Hasan <tanzirh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Nick Desaulniers <nnn@google.com>
Subject: Re: [PATCH] x86/vdso: shrink vdso/extable.i via IWYU
Message-ID: <20231229093942.GBZY6T3knaGKpeRA9a@fat_crate.local>
References: <20231228-extable-v1-1-32a18c66b440@google.com>
 <20231228212511.GCZY3nt3gKI+aDvSF1@fat_crate.local>
 <CAE-cH4rEWU-+ovwo8_-i3b2F8pK17kORJ3gV5tnjnUpRJA+B0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE-cH4rEWU-+ovwo8_-i3b2F8pK17kORJ3gV5tnjnUpRJA+B0Q@mail.gmail.com>

On Thu, Dec 28, 2023 at 02:01:20PM -0800, Tanzir Hasan wrote:
> The intention with these changes is to add up the impact of these small changes
> over time to improve build time and also use more direct inclusions where
> possible.

The problem I see with such "changes" is that it'll be a never-ending
stream of them because over time, headers get reworked, moved, changed,
split, etc and one would have to do such reorganization again.

And I'd understand it if the benefits were higher than what you're
seeing. But right now it looks like unnecessary churn.

Dunno, perhaps one could do those in one single patch for, say,
on arch/x86/ or so, and show a before and after wrt numbers. And then do it
again in a couple of releases, when it becomes necessary again.

Or one could run that tool on patches which haven't been applied yet,
patches on lkml.

Patches which touch headers or add #include directives and then reply
with an automatic report to them, saying something along the lines of

"your patch has a suboptimal include - if you include this and that,
it'll improve build time by this and that"

and then people would incorporate those changes and right then and
there.

But let's see what the others think first.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

