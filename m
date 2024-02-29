Return-Path: <linux-kernel+bounces-87647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BABE86D6EA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00F01F23A49
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F3D208DA;
	Thu, 29 Feb 2024 22:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Al9Zuvmo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884B7200D2
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 22:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709246175; cv=none; b=RgvVm3MmcXW8KXDNPyGbUF//gcgNbql1vweQB0HMTnW993nJqfSPHaN8ccYHjU2oLFy//f4QhvSlreFdY8oWkKvU6aoO/4gp2dt3ULH6Y6PDd96tlRpCLHZ+686ZThCOQdkvQY5OAoZIevpyEa8tGXomq+0yV7zGygiqKg+w/ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709246175; c=relaxed/simple;
	bh=4oJnK4X0q0E7soeXpL893fC5pammD64Qbg/GREFx02U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rBZGni5YD/roGAuV5CSlwlsl/Y+uRX7cPNCekM1ZcGp1Q9WbxrPdcxzJC8vUgmCozu3cifGChv6CpsywueP638jhjY5vdWZ7wAhMwv3B1G7pRDIVrH0iE8VtI/6EIqMdjgPVL/MxYc4Ahjd2tfyDfTiLlbmqjfOa9s+1swEKIkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Al9Zuvmo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0973BC433C7
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 22:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709246175;
	bh=4oJnK4X0q0E7soeXpL893fC5pammD64Qbg/GREFx02U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Al9ZuvmoVketcm/HKGaFbsy3+3b/oS9psF0w91dCBtqmF2H6lnnrBir1eobQvjizj
	 SbS0cAv3rQASLEu4ZFCvcXNjK9FcRAoUHybbybrBl1Ipq10HlBsu6QHoOONKcsswkR
	 d2iSrWJuh2hn2xYTobxNtAZ/V8PceWlZELZ0tTfuOwLILg7h31f6yJBYRtINNCYusp
	 fui4KH3cboemgyamGVzWFNf7z12mTBkPW48BNuSNkE8Ul1C21sEB3FrLTT0fAQsuDl
	 dXNfGTrF9IOJubigO+SFQHq0DTfUfltmNuapVF/GvreSyFo1pr5q+WhXMZ3CgGO2EZ
	 az0d8UsLDskog==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512d19e2cb8so1745961e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:36:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW/7mZXC70JGGviNyzL3Mud6RpnOie3P3oc1TxRq/2wW5EKLKllct4DFxjVul6cS28Nd8DxHpOScAR3xxR1lmmOHd+DVY2EJlvY9UGa
X-Gm-Message-State: AOJu0YzbAuFc+SNZFuEo7S/gwz6N5UyhRRea654gEYnBDYuOxzw/HPBR
	cOKxeaKHqUK8zWm6pZg4nIelzk/2C+wDGleQ859l0V1xCAxBIxb8RxgnMYD5tHBOFr6g0cSEtxp
	ork0jQllwfYZOLx2URESGFA7t6v8=
X-Google-Smtp-Source: AGHT+IF+FzMpZZtQzFRTXSdUfB0l9yLGh9uLaiFRpm+N7qUANLzj7cc/h2QmuTzrZhNg8FD7fKiqSbDqQpkdcwfrx8U=
X-Received: by 2002:a19:2d5d:0:b0:513:1551:f0 with SMTP id t29-20020a192d5d000000b00513155100f0mr2254598lft.42.1709246173259;
 Thu, 29 Feb 2024 14:36:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227151907.387873-11-ardb+git@google.com> <20240227151907.387873-15-ardb+git@google.com>
 <20240229103740.GKZeBedEybE0IeOXUG@fat_crate.local>
In-Reply-To: <20240229103740.GKZeBedEybE0IeOXUG@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 29 Feb 2024 23:36:01 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEwRgbVtnNA2_Ewt0p2azpx=MBnc94fNWVZrzr4aH2EkQ@mail.gmail.com>
Message-ID: <CAMj1kXEwRgbVtnNA2_Ewt0p2azpx=MBnc94fNWVZrzr4aH2EkQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] x86/startup_64: Simplify virtual switch on primary boot
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dionna Glaze <dionnaglaze@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Feb 2024 at 11:38, Borislav Petkov <bp@alien8.de> wrote:
>
> First
>
> Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
>
> for the patch.
>

Thanks.

> On Tue, Feb 27, 2024 at 04:19:12PM +0100, Ard Biesheuvel wrote:
> > +     /*
> > +      * Switch to early_top_pgt which still has the identity mappings
> > +      * present.
>
> I was wondering why we've had this "discrepancy" forever - the boot CPU
> would have early_top_pgt *with* the ident mappings while the APs would do
> init_top_pgt.
>
> But we end up loading init_top_pgt on the BSP too in init_mem_mapping()
> so there's a short time during boot where we have this difference.
> I haven't found a reason to have it yet except "why bother"...
>

Because we enter with a 1:1 mapping, and so we can only switch to
another set of page tables that also includes this 1:1 mapping. Once
we are running from the kernel mapping, we can drop the 1:1 mapping
but we still need it.

What we could do for robustness is reduce this 1:1 mapping to text +
rodata, and make it read-only, but I'm not sure it's worth the churn.

> And now some details just for future reference:
>
> On the BSP:
>
> => 0x10000a0:   mov    %rax,%cr3
>
> cr3            0x9922000
> 111850: ffffffff89922000  8192 OBJECT  GLOBAL DEFAULT   22 early_top_pgt
>
> (gdb) p/x early_top_pgt
> $3 = {{pgd = 0x9924063}, {pgd = 0x9924063}, {pgd = 0x0} <repeats 509 times>, {pgd = 0x2418067}}
>
> first two PGDs and the last one are populated.
>
> On the AP:
>
> cr3            0x2416000
> 104747: ffffffff82416000  8192 OBJECT  GLOBAL DEFAULT   12 init_top_pgt
>
> (gdb) p/x (long[512])*0xffffffff82416000
> $8 = {0x0 <repeats 273 times>, 0xbe01067, 0x0 <repeats 128 times>, 0xc000067, 0xc001067, 0xc002067, 0xc003067, 0xc004067, 0xc005067,
>   0xc006067, 0xc007067, 0xc008067, 0xc009067, 0xc00a067, 0xc00b067, 0xc00c067, 0xc00d067, 0xc00e067, 0xc00f067, 0xc010067, 0xc011067,
>   0xc012067, 0xc013067, 0xc014067, 0xc015067, 0xc016067, 0xc017067, 0xc018067, 0xc019067, 0xc01a067, 0xc01b067, 0xc01c067, 0xc01d067,
>   0xc01e067, 0xc01f067, 0xc020067, 0xc021067, 0xc022067, 0xc023067, 0xc024067, 0xc025067, 0xc026067, 0xc027067, 0xc028067, 0xc029067,
>   0xc02a067, 0xc02b067, 0xc02c067, 0xc02d067, 0xc02e067, 0xc02f067, 0xc030067, 0xc031067, 0xc032067, 0xc033067, 0xc034067, 0xc035067,
>   0xc036067, 0xc037067, 0xc038067, 0xc039067, 0xc03a067, 0xc03b067, 0xc03c067, 0xc03d067, 0xc03e067, 0xc03f067, 0x0, 0x0, 0x7ffd3067,
>   0x0 <repeats 39 times>, 0x7ffd1067, 0x0, 0x9b11067, 0x2418067}
>
> and that one becomes the swapper_pg_dir which is the kernel pagetable we
> use.
>
> PTI then does two separate ones, which is a whole different topic.
>
> :-)
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

