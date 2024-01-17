Return-Path: <linux-kernel+bounces-29029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3040830737
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C01A289390
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32211200CB;
	Wed, 17 Jan 2024 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWxT4sLD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC3B1EB48
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705498728; cv=none; b=elmdULxE6dxS8dJ6uJn+YSZQ5ZaSADWqfob1NKrLwOmizi+eK/fH+nLXQPMsD3cQEQGpK1cEg0A8+YKyT/5zaMAa/S8RUkLD4jR5VhtbZ9bi1msb6O4E4qMOrtXdpcuc5zQTEc29a//aSj8hSp+GjZmpGmkzj+Z7MVUGLC7XWWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705498728; c=relaxed/simple;
	bh=voSmOWLAFkYsGKasSFnRn3AzaRkdaEJ5pp5KBG2PYyg=;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:Message-ID:
	 Subject:To:Cc:Content-Type; b=a1TKFgfVm1Z0peai2jNnx68DXx8Wkv7CknEdXV6yKp+Dj83v1FF55cB9qR+qtMrdC4wuFGSRgmIYaviNd0pXisfI9iUJzPSE0i2fHi+Q5+1Gd1w5CCFDxWfS61zgqvZ/f+22ilMER9ypLdFtE7UzrLtcXnrvoPK/AAeUozZdhJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWxT4sLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA833C4166D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 13:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705498728;
	bh=voSmOWLAFkYsGKasSFnRn3AzaRkdaEJ5pp5KBG2PYyg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PWxT4sLDnWR5NgoNm8iVkRCmQiVKDViYLD7AkhNHa8c9n8VVgi9bqHYwpVBT76p1V
	 LsVYkF+Uhh0mZ2oe7tSQ7lhw1y8txg3YMwjhxYQSF+CC4dedy6jc5AguYSbjPY0H49
	 7JdiHTFjEJ37TgWP2Nf7Ux4FsvSW6ZoFzlKTlT/OTnrXpLgzmgHuJD9WOgBq8f1d5p
	 T5Hv3EWq+eQToHMnjh7QynOVX107m98JC+WVlGrpzROKGVmfzhUSF3pNcoZL47dAqL
	 dRoiVdvOaEj62vXtt4z1dpaH6ovphaJljeTuAeVjzj66gRcvvCYxqFeXZdlpqjZEJw
	 N1Q0UVW9ehNMw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e7c6f0487so12890078e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 05:38:47 -0800 (PST)
X-Gm-Message-State: AOJu0YwqBYChzgbOtyC7Pwntd1ukmtzbh1pVM4NUxBq/5WZSHZ/wizTW
	B014rQ6mL4d4imIu0I/jGWtOakwczgN4ReGbZqk=
X-Google-Smtp-Source: AGHT+IFF5YZotCcYG3bNeBcr2nqGCODiLpBYXlVhXhnBM/nZs2B/jMst7ZeuU5NbjVzQzEqYycnrSCOp66e60p2Tt8s=
X-Received: by 2002:a05:6512:3298:b0:50e:70b0:6d2f with SMTP id
 p24-20020a056512329800b0050e70b06d2fmr2576145lfe.159.1705498725881; Wed, 17
 Jan 2024 05:38:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZ7YuEexYSaZYmLK@tassilo> <20240111223650.3502633-1-kevinloughlin@google.com>
 <20240115204634.GHZaWZqsVyU_fvn_RW@fat_crate.local> <CAMj1kXH=k26nNyB+LQJ7WUJgbD2f3PREyjCzSngMCGc+72XJ6w@mail.gmail.com>
 <20240117130557.GDZafQtfRyeVFbBUXA@fat_crate.local>
In-Reply-To: <20240117130557.GDZafQtfRyeVFbBUXA@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 17 Jan 2024 14:38:34 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEML99u7a8mZMhiWXXozsJYhVPaaTzYkegiSJcLw2pNJg@mail.gmail.com>
Message-ID: <CAMj1kXEML99u7a8mZMhiWXXozsJYhVPaaTzYkegiSJcLw2pNJg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/sev: enforce RIP-relative accesses in early
 SEV/SME code
To: Borislav Petkov <bp@alien8.de>
Cc: Kevin Loughlin <kevinloughlin@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Kelley <mikelley@microsoft.com>, 
	Pankaj Gupta <pankaj.gupta@amd.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Arnd Bergmann <arnd@arndb.de>, Steve Rutherford <srutherford@google.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Yuntao Wang <ytcoode@gmail.com>, 
	Wang Jinchao <wangjinchao@xfusion.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Brian Gerst <brgerst@gmail.com>, Hugh Dickins <hughd@google.com>, Joerg Roedel <jroedel@suse.de>, 
	Randy Dunlap <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Dionna Glaze <dionnaglaze@google.com>, Brijesh Singh <brijesh.singh@amd.com>, 
	Michael Roth <michael.roth@amd.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-coco@lists.linux.dev, 
	Ashish Kalra <ashish.kalra@amd.com>, Andi Kleen <ak@linux.intel.com>, 
	Adam Dunlap <acdunlap@google.com>, Peter Gonda <pgonda@google.com>, Jacob Xu <jacobhxu@google.com>, 
	Sidharth Telang <sidtelang@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jan 2024 at 14:06, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Jan 17, 2024 at 11:59:14AM +0100, Ard Biesheuvel wrote:
..
> > On arm64, we use a separate pseudo-namespace for code that can run
> > safely at any offset, using the __pi_ prefix (for Position
> > Independent). Using symbol prefixing at the linker level, we ensure
> > that __pi_ code can only call other __pi_ code, or code that has been
> > made available to it via an explicit __pi_ prefixed alias. (Happy to
> > elaborate more but we should find a smaller audience - your cc list is
> > a tad long). Perhaps this is something we should explore on x86 as
> > well (note that the EFI stub does something similar for architectures
> > that link the EFI stub into the core kernel rather than into the
> > decompressor)
>
> Grepping through the tree, is __pi_memcpy one example for that?
>

That is an example of a function that is known to be callable from any
context, and so it is emitted with an alias that makes it accessible
to other code that is position independent.

There is some linker foo in arch/arm64/kernel/pi/Makefile that builds
a couple of objects in PIC mode. The source symbols have ordinary
names (even the external imports), but will be renamed by the linker
to have a __pi_ prefix. The result is that those objects can only call
into each other, or out to ordinary code that has been marked as __pi_
as well.

The entry into this code is

arch/arm64/kernel/head.S:885:   bl      __pi_kaslr_early_init

which is called before relocations have been applied, as that requires
knowing how the kernel base address is randomized.

