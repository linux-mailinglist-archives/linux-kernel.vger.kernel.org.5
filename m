Return-Path: <linux-kernel+bounces-89235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C98E86ED0E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8883A1C21B7D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB655F472;
	Fri,  1 Mar 2024 23:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPJHmZR3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404E01EA90
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 23:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709337328; cv=none; b=mfuwOlJeB2qA0zUA338+shdbqsQxwLiZDtwBx6Mv58LKWpEK2GGEh8Yl2o9fRAfh0mGUxHerpOuPxLyCDCUwmudnfqC0ebfuHfdtjucuQyOOYpy7kp8QETiZs7LRu1OmDqRZkC1GVYBfDR7RCaHM02n83w9EwbzA7hpUlXwr4kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709337328; c=relaxed/simple;
	bh=L0sJDVc72tYrX6Umv/zQoLCUu+SeLRSZmt3bzBVk0Nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tflez5XvvNw2DTJSDR4DTaI0UeivZjXojtGbVQYelk7qIowi4KHmKqiYeCLDSN3iSXpBELfM/5GGA3yw3U/0wkwx8QaImhXYG3Fq1DGYCQI/WFSoC8MUslu4UF5EVIf8ZECpY50YnxQacwgI1shTC5DMW3BjOUeD+kvu9UB3iX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPJHmZR3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF3EC433A6
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 23:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709337327;
	bh=L0sJDVc72tYrX6Umv/zQoLCUu+SeLRSZmt3bzBVk0Nw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rPJHmZR3H/iz15s1Eu2o7BPiMvAo/OetIf1Re6Mc/ZwIGbM03njx6y3/n1fxrlZe+
	 k/R5cCjQrFLV3LPWZ1XDq7EbCPCWcZ36cTG99v6VjnD4TKdkNDjqaBrxrSOG/O9B7/
	 qibR7RTgcWSMKtFDW77ZfyUN7joejf23nrkiDD332WkIFoPCNwTDzQdYe/jzitfq/Y
	 gQBIVeUbg8mdyDMVyZUgeNPzjGBF7AbMyzq9j4b/woBO8IKSEQkAjMp9XZMnb4Zbxg
	 dsXlb9RHpwiiPplMfzmtMXyUBe95+LaGu7ujKl+Wib3CBKayggqzX41ZRNa+kj8EP9
	 w+gehm+uDYV5w==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d28387db09so29483441fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 15:55:27 -0800 (PST)
X-Gm-Message-State: AOJu0YzCdxS1kkpwVBpNp7solmSAsAWi+e2hYu1wb7g4s3V3R7FIO70+
	OAYT5OtmYmATMFdAYWi5Ivxtsm3s8Pyc6jPTgVaRjHGkcJDsFYftCkTB0/DQy6zJiH1h2IeNVaS
	kNeIdCivmZ0TaQO3NtNDJB4/t2Ok=
X-Google-Smtp-Source: AGHT+IF8UuAFZOT9w4FFGzdfq7qizZSO8A7oQuclkWZ013xF/EopdH8hyywn4fG2TygATFRNfYW9d4msqUZd+frN4ss=
X-Received: by 2002:a05:6512:1284:b0:513:2c6c:4cc8 with SMTP id
 u4-20020a056512128400b005132c6c4cc8mr2673828lfs.63.1709337325748; Fri, 01 Mar
 2024 15:55:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227151907.387873-11-ardb+git@google.com> <20240227151907.387873-20-ardb+git@google.com>
 <20240301192017.GOZeIqcbI9S69zdBYW@fat_crate.local>
In-Reply-To: <20240301192017.GOZeIqcbI9S69zdBYW@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 2 Mar 2024 00:55:14 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFoYR6rD6GZ6NFLuCXE-q8G4HV0htEcx1omjymbfxVyAg@mail.gmail.com>
Message-ID: <CAMj1kXFoYR6rD6GZ6NFLuCXE-q8G4HV0htEcx1omjymbfxVyAg@mail.gmail.com>
Subject: Re: [PATCH v7 9/9] x86/startup_64: Drop global variables keeping
 track of LA57 state
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Mar 2024 at 20:20, Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Feb 27, 2024 at 04:19:17PM +0100, Ard Biesheuvel wrote:
> > +     asm(ALTERNATIVE_TERNARY(
> > +             "movq %%cr4, %[reg] \n\t btl %[la57], %k[reg]" CC_SET(c),
> > +             %P[feat], "stc", "clc")
> > +             : [reg] "=&r" (r), CC_OUT(c) (ret)
> > +             : [feat] "i"  (X86_FEATURE_LA57),
> > +               [la57] "i"  (X86_CR4_LA57_BIT)
> > +             : "cc");
> > +
> > +     return ret;
>
> Yeah, I said this is creative but an alternative here looks like an
> overkill.
>
> Can we use a RIP_REL_REF(global var) instead pls?
>

I don't see the point of that, tbh. Patch #2 already ripped out all
the fixup_pointer() occurrences. This patch gets rid of the need to
#define USE_EARLY_PGTABLE_L5 in each translation unit that contains
code that might execute before alternatives patching has occurred.

Today, pgtable_l5_enabled() is used in many places, most of which
resolve to cpu_feature_enabled(), and I don't think you are suggesting
to replace all of those with a variable load, right? So that means
we'll have to stick with early and late variants of
pgtable_l5_enabled() like we have today, and we should just drop this
patch instead - I put it at the end of the series for a reason.

