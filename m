Return-Path: <linux-kernel+bounces-28383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D54782FDD0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 00:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6811F27CAC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40B967C64;
	Tue, 16 Jan 2024 23:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AJAYltvX"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECE61D68E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 23:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705448663; cv=none; b=S3X3BN4aK4RIK/RwWAKtOWgErSCfeDs7c2VbzivXPd/iqjytA6jeVPHXgkMa2bGeYEbLfDhjW99DQ+it9ayLLiY/wE2H9l/BRA2FvgSK74vQMcpM+lDkjxYyS3nFfAwhXQgsZihSKKC2wV72TAhpTypW+GreeoAoVLJZuFTdd+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705448663; c=relaxed/simple;
	bh=9DmDWifX5Z6JOjtDY3idRRSQYZv+kZmuFZPwB+mkrwo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=qc5Kca5kVRAkazTRZviCWuboFh5ojCItl9rHaR8c6CGtqNCAHGlfhnTQN7WpWC0FrgJ46RVTA5wAn5wA9rrmd3pZx3vjrNAR9tucDMCmVL+6N/R5PuXNmgOTPixGEacRyXifWOF8utz5YR4p0CzxMR/NPkauF1QqW0aDpqXcwmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AJAYltvX; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7ce9defc4c2so1640824241.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 15:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705448660; x=1706053460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdQ6eiAEP5p2d80q3UGVJcNCex+HtcKgUxVE8iUlFVM=;
        b=AJAYltvXPxB0Mw62kj+WY02TMbs+O+Fln+QtkndPtC495RWMkB79nor4WPmarn4nDy
         y7FcRdUyca+meEbbCw00jG2zMywQeB+algt4gCW6PYyw8xTzglsU6CWouvh0jH6MJsAD
         hAp/vi8r97pZhQccxJSUopeUeKSYaXQFLaNFnZXtgAjlXLz2mNj289/ZBnCICyikB7YD
         LhNBcFSgRvtpRW/k+s5ZwOmhG0NeZCsxjBWDosTHlqgAzRdy5t+qy1GpTKtmkTLUxVlO
         8B78wBeUus0hFdlVoLMFWAulSEPI0AklIlAJtPNTqIDFAbjS2BwYNK2VdoJ3wwi/GlYQ
         4tTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705448660; x=1706053460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdQ6eiAEP5p2d80q3UGVJcNCex+HtcKgUxVE8iUlFVM=;
        b=YXr8UafedQsMc/ceGVkIn38bxUtR/vT47au8YhM0BHvxTSqhKkrFMkWJGckWqExw1A
         2X3mbkcCEQ1i3uEASnBYqnMD2AMf7PEgLfmqkIw7ayyEFG9YXfncDNgAhgeMfZmhIwHL
         ZUwC4kmeFPAuFhILznlvdrQcCB2Y+w7+DNhhT8Kh6WO+weHWEt1+00VpDf1YnGxmzr9+
         W105QqYzpLlfai/1LMJtf702Cjh/2stUllsgUZhRIRbKLxd8Ez63fb+eHMVMJnktr4Gu
         W/qBE+Ti2hcV6MuCZ2uoIsqNWrnB+7BezIqiq+ASngOBDYcT2rOiqTq7GXjRjbTQUJq7
         30SQ==
X-Gm-Message-State: AOJu0Ywpst6RHQPIwp6Xx6y4rUXA1ir47om3mBy1hwIZJnlHT0won416
	rnXlXjE0k7Z2LiLsdkXP+N/2p/QJY0YjQOhGFcq8HkmG1F91
X-Google-Smtp-Source: AGHT+IHyTwjhU9khtcKJv8NUtOGmEIX06trwG04+ik2FnF1wYm8lVJ6tIZBYJhmYaBLWiR0vQf/XBsl+DQARU6XGzSI=
X-Received: by 2002:a05:6122:3691:b0:4b2:dd80:4db0 with SMTP id
 ec17-20020a056122369100b004b2dd804db0mr3234536vkb.32.1705448660484; Tue, 16
 Jan 2024 15:44:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZ7YuEexYSaZYmLK@tassilo> <20240111223650.3502633-1-kevinloughlin@google.com>
 <7144c0d5-8fb4-8d83-a854-ed597296c68f@amd.com>
In-Reply-To: <7144c0d5-8fb4-8d83-a854-ed597296c68f@amd.com>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Tue, 16 Jan 2024 15:44:09 -0800
Message-ID: <CAGdbjmJih4G=JG_6rLJnSAF8j3bhtLeREqDzuzFp-C7XWOqCCg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/sev: enforce RIP-relative accesses in early
 SEV/SME code
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Michael Kelley <mikelley@microsoft.com>, Pankaj Gupta <pankaj.gupta@amd.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, 
	Steve Rutherford <srutherford@google.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Yuntao Wang <ytcoode@gmail.com>, 
	Wang Jinchao <wangjinchao@xfusion.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Brian Gerst <brgerst@gmail.com>, Hugh Dickins <hughd@google.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Joerg Roedel <jroedel@suse.de>, Randy Dunlap <rdunlap@infradead.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-coco@lists.linux.dev, 
	Ashish Kalra <ashish.kalra@amd.com>, Andi Kleen <ak@linux.intel.com>, 
	Adam Dunlap <acdunlap@google.com>, Peter Gonda <pgonda@google.com>, Jacob Xu <jacobhxu@google.com>, 
	Sidharth Telang <sidtelang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 7:53=E2=80=AFAM Tom Lendacky <thomas.lendacky@amd.c=
om> wrote:
>
> On 1/11/24 16:36, Kevin Loughlin wrote:
> >
> > @@ -61,33 +66,34 @@ static __maybe_unused __always_inline bool amd_cc_p=
latform_vtom(enum cc_attr att
> >   static bool noinstr amd_cc_platform_has(enum cc_attr attr)
> >   {
> >   #ifdef CONFIG_AMD_MEM_ENCRYPT
> > +     const u64 sev_status_fixed_up =3D sev_get_status_fixup();
>
> Why not also have a variable for sme_me_mask?

`sme_get_me_mask_fixup()` is only used on certain conditional paths in
the calculation of the return value (therefore, a max of 1 times per
invocation of `amd_cc_platform_has()`). As such, calling
`sme_get_me_mask()` unconditionally at the beginning of the function
would be unnecessary for some invocations of `amd_cc_platform_has()`.
In contrast, the sev_status is needed on every invocation of
`amd_cc_platform_has()`. Additionally, the `sev_get_status_fixup()`
result is potentially used multiple times in the same invocation of
`amd_cc_platform_has()`, motivating the use of a local variable.

> > @@ -130,6 +130,7 @@ static unsigned long __head sme_postprocess_startup=
(struct boot_params *bp, pmdv
> >   {
> >       unsigned long vaddr, vaddr_end;
> >       int i;
> > +     const u64 sme_me_mask_fixed_up =3D sme_get_me_mask_fixup();
>
> Should be the first variable listed given the length of the line.

I will incorporate this and all other stylistic changes that you
mentioned in v3.

> > @@ -110,8 +115,9 @@ static void __noreturn sev_es_terminate(unsigned in=
t set, unsigned int reason)
> >   static u64 get_hv_features(void)
> >   {
> >       u64 val;
> > +     const u16 *ghcb_version_ptr =3D (const u16 *) GET_RIP_RELATIVE_PT=
R(ghcb_version);
>
> Is this one really needed? The ghcb_version variable isn't referenced
> before fixup, right? It's referenced in both decompression and early boot=
,
> but I didn't think a fixup is needed.

You're right; it looks like we do *not* need the fixup for
ghcb_version in both instances that you identified. I will remove
these particular fixups in v3.

Thanks!

