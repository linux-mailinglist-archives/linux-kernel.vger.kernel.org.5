Return-Path: <linux-kernel+bounces-130142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8334B897491
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC811F24520
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9846014A4E0;
	Wed,  3 Apr 2024 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=otheo.eu header.i=@otheo.eu header.b="dfQntqxO"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F71433A8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159677; cv=none; b=pkbhrZ/iufPViFeDddkIs28YA1Lh8safwt5/ShyNGsF1QLZLTNzPxjfajnOB61pEhGte6+4ntvetsfjKjbWGMQ+QudP1AaYOO+wXih9TVNoGTTpfd/yDtlIltgdcor2BoLmk5bHxJ0sRn4dDuXXMrNcNA7qkSdsbgz+fBL/aExY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159677; c=relaxed/simple;
	bh=05OiF9Hil9p8D7Cfga1eTO+wM09IY8TLggZiRioZhlQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uCj8LgaWAZVXMihQAkFjjJ2+dbFq1jYzEiZgQcU/nczCXYn88u8j11DwqfrQ2VMJZxgplZ6gHso7Qw6DiYtln9EgDJfcMF5L30F3sCVgtSqZkBYJaL8bK6AtF8GajYnJGmVKkzkKi3t5Mi1iIXdIKgjSSOV4KT3TLp8yS4s73zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=otheo.eu; spf=pass smtp.mailfrom=otheo.eu; dkim=pass (2048-bit key) header.d=otheo.eu header.i=@otheo.eu header.b=dfQntqxO; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=otheo.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=otheo.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id 020E740004;
	Wed,  3 Apr 2024 15:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=otheo.eu; s=gm1;
	t=1712159671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ofo5vb6A4bvjx7KiVorsSc25IQSpqMx4s4Q+1EW+4ck=;
	b=dfQntqxOP+nUFdIok1cTgZSNRo6A+M2UdGTocfag+BtJleObAAhTAYFPd1Rpr0hlskJOGM
	39grW98/Y4Qm+4DuAsfBhODtXYIQuw1sBOuXYhmLcwSJvCPB9ybN1gimEIE+z/n/8hn0QR
	COd6rHPsQz/gThIRcF4FxzTJNAcarR0+q1A1/gzwr4IOJxlYuu6xfvJDohJS0efjky1zzT
	18gZlmNawgchvyzcxcUB9QVIXZ64nBhtpqaLM4NdSMjxSlHppdex8T8irU4vsXn2wfiogm
	IM5UXBgMz0iILyKR56fC6NW9B+RtYgYCq4QMbIG6DnNkSI7I3BOGjb3se5IxaQ==
Date: Wed, 3 Apr 2024 17:54:07 +0200
From: Javier Pello <devel@otheo.eu>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
 <hpa@zytor.com>
Subject: Re: [PATCH 1/1] x86/mm/pae: Align up pteval_t, pmdval_t and
 pudval_t to avoid split locks
Message-Id: <20240403175407.f81ebc5cc3300ffa0c39f597@otheo.eu>
In-Reply-To: <d7e89d23-b692-4e70-baae-5df5b3984620@intel.com>
References: <20240401185451.6897208962d3fc47a12ffb5a@otheo.eu>
	<20240401185712.a80deeb2fddeded0ad42cc04@otheo.eu>
	<8ee463af-fdbf-4514-bb6e-bf2fd61fbc06@intel.com>
	<20240402192314.a9b4e05637444314f47557e4@otheo.eu>
	<d7e89d23-b692-4e70-baae-5df5b3984620@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; i686-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: #01#@otheo.eu

On Tue, 2 Apr 2024 10:43:26 -0700, Dave Hansen wrote:

> Fair enough.  I can totally understand wanting the convenience.
> But you're leaving _so_ much performance on the floor that split
> locks are the least of your problems.

Split locks may not be a problem, but tasks stuck in kernel mode
are. :-)

> > I see. So just annotating the variable on the stack with
> > __aligned(8) should do it? But the code is under mm/, so it
> > should be arch-agnostic, right? What would the correct fix be,
> > then? I take from your message that using atomics through
> > pmd_populate() here is not needed, but what accessors should
> > be used instead? I am not familiar at all with this part of the
> > kernel.
> 
> I don't think there's a better accessor.

That is what I thought, too, after looking through the code.

My assessment, then, is the following: The code in mm/huge_memory.c
uses a variable of type pmd_t on the stack, and uses pmd_populate()
to initialise it. On x86-32 with PAE, that variable is 8 bytes in
size but has an alignment of 4 bytes, and pmd_populate(), through
native_set_pmd(), uses an 8-byte atomic instruction on it. If the
variable is unlucky enough to span two cache lines, this triggers
an exception in kernel mode, and the kernel oopses. This is not
merely a false positive: a task gets stuck (repeatedly, in my
case) with user-visible consequences, and that is not nice.

I can see three ways forward:

- The first way to handle this (and the one requiring most work)
is to get rid of the lock altogether. There are two places in
mm/huge_memory.c (in __split_huge_zero_page_pmd, around line 2078,
and in __split_huge_pmd_locked, around line 2237) where a
temporary pmd_t is passed to pmd_populate() just to get a pte_t
for an address:

    pmd_populate(mm, &_pmd, pgtable);
    pte = pte_offset_map(&_pmd, haddr);
    VM_BUG_ON(!pte);

Variable _pmd is never used afterwards in either of the cases.
Such a temporary variable is not subject to concurrent access,
but (correct me if I am wrong) pmd_populate() is designed for the
general case and uses atomics, at least on x86. Avoiding atomics
here would benefit everyone, since they are not needed, as you
pointed out, but pmd_populate() is an arch hook, so the new
"pmd_populate+pte_offset_map without an intermediate pmd_t" would
also have to be. A possible course of action for this would be to
first add a generic pmd_populate+pte_offset_map implementation in
mm/pgtable-generic.c inside a __HAVE_ARCH_... guard and then add
per-arch specific variants. This would remove the need for
alignment because the new hook could dispense with atomics
entirely, knowing that it is dealing with a local variable.

- The second way would be to keep the use of pmd_populate() as it
is, but make the variable aligned so that it does not trip over a
split lock. This is what my original patch intended to do, because
I had not realised that the lock is not needed, as you pointed out.
On my system, this increases the size of the kernel code by 7K, but
increasing the alignment of a variable should not have any other
impact.

- The third way would be to disable split lock detection on x86-32.
This can be as simple as setting the default to "none" in
sld_state_setup(). Not the most elegant of solutions, but beats
having unresponsive tasks.

Would going for the first one be worth the trouble?

Regards,
Javier

