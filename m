Return-Path: <linux-kernel+bounces-96435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33177875C11
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4FA1F22866
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8CD2263A;
	Fri,  8 Mar 2024 01:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bmAGwlbf"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D946523D7
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 01:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709862463; cv=none; b=R9G7dyucBpcCqSWoemBHU+HGsiZLUt8igb9aVKoLsjvKN+bIRW9Mia74Goam3sCz5i3lTFWLrom2EZtWpxv3bmeGMN8w62ksk4fHiNhEoWmld2uzpdC3JUqax8T++qYb6Xxu/96j45vHmJPHgMnuqNeq19/iuANu4ehGPfhXtZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709862463; c=relaxed/simple;
	bh=cnZ9yuC3MdU1ljMWVNI7gN+v/Dv5mrzJIaBRs1Mi8nQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gjy7pbVdpl9oxaO30sPGf2TAlHY6p0V0n62YsCP4g5+kUvX46XdvnDQdCPSsp4dbsWzhlT3oDJwzyAkNo6SPjtjoMJM7zusOb+ZhIobJp+UL7l9C1lhwMg9cgmvFKn8zg4ZYkJUYr+nKEaRvxbYH+aVe4RhSjOK4pGjY66m0Kz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bmAGwlbf; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64e0fc7c8so2451510276.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 17:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709862461; x=1710467261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gfpgu33XDv7gN5c8kt8Yl/1FH+hpdm97kb/imNVS4FI=;
        b=bmAGwlbfjhj6jHgRZdF9rloPbnJQRUjj+MQOClgjji0T/Ibp1G/ep6pZIEvkZ1ifLM
         /13ff2rFm7uji/2B5RZSqAfNjtYv5l6NCDDLrs0p0iVXPsPnNF0qjmpcNcLAQiPmscEi
         JLYGMAB5U4UCusHKtUPiyqpTU5Vrwt8Uf8m60f4+lQp57XViemL+KeIXTt5Fa9j84q/d
         +3GxoKZmKnWQOqwu+vxlpYT/1gbJoag0//TlebACkUwTzVE2AiF67ll4iSUapV7AAG+z
         xqOznnD33NopST7VRVND5gNm2M3Setmupjj1+EH5fUMcJ1d4bU/bihSvmEpUvxVQfdoL
         ZUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709862461; x=1710467261;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gfpgu33XDv7gN5c8kt8Yl/1FH+hpdm97kb/imNVS4FI=;
        b=Oh+KoNRcQkREUxqZfxxoOHlOxiqMHrzgT2sbQnOCrPMEldg9uJgPc8glYPIXO7ZC2+
         eg17ArhoaB8tpoaRDRimngKDwKWfV/KigFLnqCAVgg5USbxESehQiC2nJTWTGLTuuLs4
         KETnRdVREMYe/8Mciqy/nlvJS+yOfmInLRLRYa1XsOYWXHji0bHT4PASqgZG33/JgWKw
         sxjhfSM79Ssubcm4R/WagdUFkhSrqGQxhHbAABeuXokGHKcqccytPgBTPfR4PNB4kwaU
         tbeqa42o8Md+TBesylkEwiobQ+MGDz3zYJJsA+J8dvqYPo+unMPHCAhyV7Sszf5rk0SQ
         1G8w==
X-Forwarded-Encrypted: i=1; AJvYcCVWS7t8eibExEDMvXwemjzbGT+ltUpMdLy07Wlq06PgbxFOPCkuyPENWkz78fQY75UH/xV4lOq5Kbj51aZ6kqKX/Kypuc3xU6dFDBh4
X-Gm-Message-State: AOJu0YyscCFN6CWuKekt6nqTxL8c/hhlukS/n0Ql72JKBxx9x0PjzUM3
	ufusz/oQD/PW0sw7Uie7l17ISxebpdiIUbSZ9X7xIEoV9v7tvybFFFxaUBfYsZkMDiQQP+yAGqw
	Jv9qvDYudpGlX94zruw==
X-Google-Smtp-Source: AGHT+IEm1M+oGVLssHL64fBS/glWkZaxFmMJGGdFsNWWr37E1HSxI9bR/8WTdkuSFSgHSnIMFlAMyRb29kIpm944
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:6943:0:b0:dcc:4785:b51e with SMTP
 id e64-20020a256943000000b00dcc4785b51emr893146ybc.12.1709862460910; Thu, 07
 Mar 2024 17:47:40 -0800 (PST)
Date: Fri, 8 Mar 2024 01:47:39 +0000
In-Reply-To: <420fcb06-c3c3-4e8f-a82d-be2fb2ef444d@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307133916.3782068-1-yosryahmed@google.com>
 <20240307133916.3782068-3-yosryahmed@google.com> <420fcb06-c3c3-4e8f-a82d-be2fb2ef444d@app.fastmail.com>
Message-ID: <ZepuO5bDoE-5T0RB@google.com>
Subject: Re: [RFC PATCH 2/3] x86/mm: make sure LAM is up-to-date during
 context switching
From: Yosry Ahmed <yosryahmed@google.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, "the arch/x86 maintainers" <x86@kernel.org>, linux-mm@kvack.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2024 at 05:34:21PM -0800, Andy Lutomirski wrote:
> Catching up a bit...
>=20
> On Thu, Mar 7, 2024, at 5:39 AM, Yosry Ahmed wrote:
> > During context switching, if we are not switching to new mm and no TLB
> > flush is needed, we do not write CR3. However, it is possible that a
> > user thread enables LAM while a kthread is running on a different CPU
> > with the old LAM CR3 mask. If the kthread context switches into any
> > thread of that user process, it may not write CR3 with the new LAM mask=
,
> > which would cause the user thread to run with a misconfigured CR3 that
> > disables LAM on the CPU.
>=20
> So I think (off the top of my head -- haven't thought about it all that h=
ard) that LAM is logically like PCE and LDT: it's a property of an mm that =
is only rarely changed, and it doesn't really belong as part of the tlb_gen=
 mechanism.  And, critically, it's not worth the effort and complexity to t=
ry to optimize LAM changes when we have a lazy CPU (just like PCE and LDT) =
(whereas TLB flushes are performance critical and are absolutely worth opti=
mizing).
>=20
> So...
>=20
> >
> > Fix this by making sure we write a new CR3 if LAM is not up-to-date. No
> > problems were observed in practice, this was found by code inspection.
>=20
> I think it should be fixed with a much bigger hammer: explicit IPIs.  Jus=
t don't ever let it get out of date, like install_ldt().

I like this, and I think earlier versions of the code did this. I think
the code now assumes it's fine to not send an IPI since only
single-threaded processes can enable LAM, but this means we have to
handle kthreads switching to user threads with outdated LAMs (what this
patch is trying to do).

I also think there is currently an assumption that it's fine for
kthreads to run with an incorrect LAM, which is mostly fine, but the IPI
also drops that assumption.

>=20
> >
> > Not that it is possible that mm->context.lam_cr3_mask changes throughou=
t
> > switch_mm_irqs_off(). But since LAM can only be enabled by a
> > single-threaded process on its own behalf, in that case we cannot be
> > switching to a user thread in that same process, we can only be
> > switching to another kthread using the borrowed mm or a different user
> > process, which should be fine.
>=20
> The thought process is even simpler with the IPI: it *can* change while s=
witching, but it will resynchronize immediately once IRQs turn back on.  An=
d whoever changes it will *synchronize* with us, which would otherwise requ=
ire extremely complex logic to get right.
>=20
> And...
>=20
> > -		if (!was_lazy)
> > -			return;
> > +		if (was_lazy) {
> > +			/*
> > +			 * Read the tlb_gen to check whether a flush is needed.
> > +			 * If the TLB is up to date, just use it.  The barrier
> > +			 * synchronizes with the tlb_gen increment in the TLB
> > +			 * shootdown code.
> > +			 */
> > +			smp_mb();
>=20
> This is actually rather expensive -- from old memory, we're talking maybe=
 20 cycles here, but this path is *very* hot and we try fairly hard to make=
 it be fast.  If we get the happy PCID path, it's maybe 100-200 cycles, so =
this is like a 10% regression.  Ouch.

This is not newly introduced by this patch. I merely refactored this
code (reversed the if conditions). I think if we keep the current
approach I should move this refactoring to a separate patch to make
things clearer.

>=20
> And you can delete all of this if you accept my suggestion.

I like it very much. The problem now is, as I told Dave, I realized I
cannot do any testing beyond compilation due to lack of hardware. I am
happy to send a next version if this is acceptable or if someone else
can test.

