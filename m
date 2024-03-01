Return-Path: <linux-kernel+bounces-88710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CA886E5B2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922AD1F26923
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D453C3F;
	Fri,  1 Mar 2024 16:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUg5VHhR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866631FAB
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310958; cv=none; b=B50LgnDbNJVMaKtvBDxUqG7NyKQCF5BgBKGxb6duOzShNxLAvRZhe+wN9Vutb3XwMOIi2+oHJmMu5Mul1BqCthUwP1cirKaA5uapaYM92OhA1TRcPFijx2i42Obg2Kae02RCkX3aTxsNAhagX095Z8x8DTIfUDQgTNkii7TEzNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310958; c=relaxed/simple;
	bh=UsRbkLa0yerir383cqzaT/O58UqKQZXBWw0CKzi2W7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l4y39b3yrteD1B1Y4iWqyimITdiE3C5Z636ogaZ1kGy4rQJ2XNZJqwLcyGd7KaUnPd67jPxdnTUhtcRcNU34yl0u4V1AtB3KnPjbxjAYqa03jqoXBsr1pAhHH9mrljnxTVJSscDW0tQwN4dZCk9IoKghMav4qWpf02JrejmFJxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUg5VHhR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11F9C433A6
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709310958;
	bh=UsRbkLa0yerir383cqzaT/O58UqKQZXBWw0CKzi2W7M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IUg5VHhR4FV4zYf7VWPubgDQr0DYoaijrNq8k51hoUv2BJaddrMsFdKp4/KQltSNm
	 rNnHiJPbXvX4h1AalToO/exN/OWw0haQHT3s+r7vkgQLlOQE5BvkGLu76K6pjDWM6q
	 7EFTjeuFWkSyicydY0L1/AVqVBmMwn5DDVYvErxe0puiV3pmVJ/rnUBWijxqg4tAg1
	 Zt7jb3WTHnssNWHan+iIlMAtKuHy2B3qj/HokkXvwB7vXuCB4SpZCNa4ATjuOjiRNH
	 pnaIe/wIqK9PA3sKkEty3PiP1By6c7QKSD3wHyDUWRz36kzcxs9ZgeVVbilEJbITaV
	 MzwyYcDR6Eoug==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so25464801fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 08:35:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXYSRUroT6zIS0mo1Q3fAitMT+rBM3eJQAFsY3QJeh/ZnfUYNehZo+w3+V9tu4tRxWbfYOoOuzv9l0svbY7y/96yh7tbX2UoEc2HLJf
X-Gm-Message-State: AOJu0Yz/eGwvMdAOTpaiTkNKWgPoS0sj6C3pmseIxskYFN39HCzIMgIJ
	4tJcCb15zXGcP+jcwVnEzPaLKOzv7ddrghiKAcS5UmwH5qxBzZnIXfQy5HYAxhOV9ikUTjmzaYy
	GH1ZJZR7J4x5lOltdx523ILsxM3k=
X-Google-Smtp-Source: AGHT+IFJ550sf9L1k3rZKyBzwWaPgUm+rkKOhLedJMN/dNPsx3f1GIwszQec7rv+YbW9TJVUAa4DX7NCyKJR/U3K5IQ=
X-Received: by 2002:a05:651c:3c2:b0:2d2:eb57:3ac8 with SMTP id
 f2-20020a05651c03c200b002d2eb573ac8mr1343322ljp.34.1709310956162; Fri, 01 Mar
 2024 08:35:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124103859.611372-1-ubizjak@gmail.com> <170929679278.398.4143931058196373559.tip-bot2@tip-bot2>
 <CAMj1kXGc5_AM2AkE+h8EcvYjAGHqeDWRyVRYUGfBjeubeUmJ6Q@mail.gmail.com>
 <CAFULd4a1sv7LZyT4CMCCsCxi+F9Rm0qAmSV-s=1re_1h71SB7g@mail.gmail.com>
 <CAMj1kXEg=mFe0pJyiLNVV2Am8NJadPR3M-2iAYYj1+jNyaHgBg@mail.gmail.com> <2fadcf62-e77d-49b4-b194-1cfa987d8709@citrix.com>
In-Reply-To: <2fadcf62-e77d-49b4-b194-1cfa987d8709@citrix.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 1 Mar 2024 17:35:44 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEAYy0vaA-es7ug9a8=YBj2dX8BMMi-=K3=j03VaYtdPQ@mail.gmail.com>
Message-ID: <CAMj1kXEAYy0vaA-es7ug9a8=YBj2dX8BMMi-=K3=j03VaYtdPQ@mail.gmail.com>
Subject: Re: [tip: x86/boot] x86/boot: Use 32-bit XOR to clear registers
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, 
	Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 1 Mar 2024 at 17:02, Andrew Cooper <andrew.cooper3@citrix.com> wrot=
e:
>
> On 01/03/2024 1:10 pm, Ard Biesheuvel wrote:
> > On Fri, 1 Mar 2024 at 13:51, Uros Bizjak <ubizjak@gmail.com> wrote:
> >> On Fri, Mar 1, 2024 at 1:45=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org=
> wrote:
> >>> On Fri, 1 Mar 2024 at 13:39, tip-bot2 for Uros Bizjak
> >>> <tip-bot2@linutronix.de> wrote:
> >>>> The following commit has been merged into the x86/boot branch of tip=
:
> >>>>
> >>>> Commit-ID:     721f791ce1cddfa5f2bf524ac14741bfa0f72697
> >>>> Gitweb:        https://git.kernel.org/tip/721f791ce1cddfa5f2bf524ac1=
4741bfa0f72697
> >>>> Author:        Uros Bizjak <ubizjak@gmail.com>
> >>>> AuthorDate:    Wed, 24 Jan 2024 11:38:59 +01:00
> >>>> Committer:     Ingo Molnar <mingo@kernel.org>
> >>>> CommitterDate: Fri, 01 Mar 2024 12:47:37 +01:00
> >>>>
> >>>> x86/boot: Use 32-bit XOR to clear registers
> >>>>
> >>>> x86_64 zero extends 32-bit operations, so for 64-bit operands,
> >>>> XORL r32,r32 is functionally equal to XORQ r64,r64, but avoids
> >>>> a REX prefix byte when legacy registers are used.
> >>>>
> >>> ... and so this change is pointless churn when not using legacy
> >>> registers, right?
> >> Although there is no code size change with REX registers, it would
> >> look weird to use XORQ with REX registers and XORL with legacy regs.
> > You are changing an isolated occurrence of XORQ into XORL on the basis
> > that XORQ 'looks weird', and would produce a longer opcode if the
> > occurrence in question would be using a different register than it
> > actually uses.
> >
> > Apologies for the bluntness, but in my book, this really falls firmly
> > into the 'pointless churn' territory. The startup code is not
> > performance critical, neither in terms of size nor in speed, and so
> > I'd prefer to avoid these kinds of changes. Just my 2c, though - Ingo
> > has already merged the patch.
>
> Without trying to get into an argument here...
>

No worries, we're all friends here :-)

> The better reason is that Silvermont Atoms don't recognise the 64bit
> form as a zeroing idiom.  They only recognise the 32bit form of the idiom=
.
>
> Therefore in fastpaths it is (marginally) important to xorl %r15d, %r15d
> rather than xorq %r15, %r15.
>
> But this instance is not a fastpath, and it also doesn't save any
> encoding space, so I'm not sure it was really worth changing.
>

Yeah, that is my point, really. But let's move on. And apologies to
Uros for the tone - it didn't sound as grumpy in my head when I typed
it as it does now reading back the thread.

