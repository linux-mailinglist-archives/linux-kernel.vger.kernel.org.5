Return-Path: <linux-kernel+bounces-91925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0C2871880
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF191C21188
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3B8F9EB;
	Tue,  5 Mar 2024 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0TroF50"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340BC4F207
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709628404; cv=none; b=trT5DASAPpHxKOQUWH6v2DG2c6PwCIeyACBHFLlW5Joz+FeA0JFEjTpH40zYo95DlihSX6sZGATf4DmwOi+DwhzauTxtt2AE9PMVpX5DjUaucQfEOgzqvO+u/seUXOPmrYA02S+dDTzgM4zTFCPfIW3wwEoCEg0i/v1DdmNwdUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709628404; c=relaxed/simple;
	bh=ACsKrMA09PUjUMvCgOJSi9nrek+2aX3HxwzXtRSHH44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=unx5oHZ77RdmhJCrhOZX+6kki7WbbwMDpVyPy2vhV3FWDaaY49l4NT7RUDs97IuqoePM/xihOYnupksLFT8SWgE7S2U0VY4OuWD1wTKB2f+G+EUED1RmuQI2aAdlrwViqQ2CPcwyUWDpbhWi3Kf3PARzdWAqqeJGgDspXQUWGFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0TroF50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B17AC43390
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709628403;
	bh=ACsKrMA09PUjUMvCgOJSi9nrek+2aX3HxwzXtRSHH44=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J0TroF50rN1LKLAwhhj+Ru4NJ+V9qhaqERzNZ+5PN3nasWgWmEL0PmiNaRrGwFReW
	 dzk68Qtlo/H2zPSiDyUrL5UCuN1yMGP69cbfHx+Z5z2DQ3TWabxti//zaxjNxYMnnu
	 JwyNcd9cZFP85orq6GY67A7A3n1HPunuWEYpz15tdIKO+iPF7NwxmUszb14LSrdzgo
	 ebmXQaqzK9Pe7kuqb17nz7fnoCkds8wj37HVafslPqqZA/a1AT58f8xwl7Z3DPAZl/
	 nPMARBnEO2Kh38eMYtlCsXwpz6ihgRPzybMFspvsG2DQuHZHfy1RB/FF66m58YtQu6
	 9BvYHVZddrsVw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51340e89df1so2648429e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 00:46:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUufl4THWK+ddEd85fV/GVyUdCq5J5+xgZDTSACOzlds8rL3e9MMqyjV1wk/4KS56Ga7c4oOu0c44gfr+G7iK2iPsElR91y0BTwXT4E
X-Gm-Message-State: AOJu0YyFBVFO4NXghrnjaQw9fwuFv2WJu+u1nc2s1QVELqF+0v0Pie+W
	T2AXwVO6ytbQ3kspe0W/ywLrtNwQvzr7kCI6YR/kgeIAoQ9yf9+sbiUd5V/JOfUexMwC9YP93m2
	zewO5ZuE6RQfdL/W8OUvzoAHSoCU=
X-Google-Smtp-Source: AGHT+IF0MQwV5y4P9mqykzEKCfwao701q6Hj8pGvOieWkxsFb0NCYF9NGDXwTCs3gYB5DJWrnxC4U6lxdrrkPM9h/+A=
X-Received: by 2002:a19:3846:0:b0:513:3e1a:75af with SMTP id
 d6-20020a193846000000b005133e1a75afmr680525lfj.16.1709628401830; Tue, 05 Mar
 2024 00:46:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227151907.387873-11-ardb+git@google.com> <8b412f69-a08a-51cb-8223-ed1933031d5e@amd.com>
 <CAMj1kXFgUNDusUzVKh=2Mn802+x+0iop7O-aEZH0iuQtdOAFcw@mail.gmail.com> <1e40efa3-3d16-4fc6-8686-2bcb254c7c5e@amd.com>
In-Reply-To: <1e40efa3-3d16-4fc6-8686-2bcb254c7c5e@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 5 Mar 2024 09:46:30 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH9um-r09AGk7E4h+OHGUYWxvmqGM4QBUOhAnTg3T8yOw@mail.gmail.com>
Message-ID: <CAMj1kXH9um-r09AGk7E4h+OHGUYWxvmqGM4QBUOhAnTg3T8yOw@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] x86: Confine early 1:1 mapped startup code
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	Kevin Loughlin <kevinloughlin@google.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 23:41, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 3/4/24 13:13, Ard Biesheuvel wrote:
> > On Mon, 4 Mar 2024 at 18:07, Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >>
> >> On 2/27/24 09:19, Ard Biesheuvel wrote:
> >>> From: Ard Biesheuvel <ardb@kernel.org>
> >>>
> >>> This is resend #2 of v5 [0] with some touchups applied.
> >>>
> >>> Changes since v6:
> >>> - Drop flawed patch to move some SME/SEV related calls out of the early
> >>>     boot path to avoid the potential need for backporting patches #6/#7
> >>>     to kernels where SEV support may not be crucial. This problem will be
> >>>     dealt with if/when it arises while doing those backports.
> >>>
> >>> Changes since v5:
> >>> - drop patches that have been merged
> >>> - rebase onto latest tip/x86/boot
> >>> - fix comment regarding CR4.PGE wrt flushing of global TLB entries
> >>> - avoid adding startup code to .noinstr.text as it triggers objtool
> >>>     warnings
> >>>
> >>> [0] https://lore.kernel.org/all/20240221113506.2565718-18-ardb+git@google.com/
> >>>
> >>> Cc: Kevin Loughlin <kevinloughlin@google.com>
> >>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> >>> Cc: Dionna Glaze <dionnaglaze@google.com>
> >>> Cc: Thomas Gleixner <tglx@linutronix.de>
> >>> Cc: Ingo Molnar <mingo@redhat.com>
> >>> Cc: Borislav Petkov <bp@alien8.de>
> >>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> >>> Cc: Andy Lutomirski <luto@kernel.org>
> >>> Cc: Brian Gerst <brgerst@gmail.com>
> >>
> >> For the series, tested bare metal boots with mem_encrypt=on /
> >> mem_encrypt=off and boots of SVM, SEV, SEV-ES and SEV-SNP guests.
> >>
> >> Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
> >>
> >
> > Thanks a lot! I take it this was a kernel built with GCC?
>
> Yes, it was a GCC build, so I went back and rebuilt with Clang-14 and
> everything was fine there, too.
>

OK, thanks again.

