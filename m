Return-Path: <linux-kernel+bounces-30491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1AF831F72
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D56286DEE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A132E3FF;
	Thu, 18 Jan 2024 19:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RaMnYhCb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3JlnqR7R"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0122E3E8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 19:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705604853; cv=none; b=uB07RVZZP47VL4GU2BBbD64w+w8bS2waNT4LGHQL9xMSLA0z85peIinH/Nf3po/x6t9NH5JabJVGZC5qLFEunbPNfj72TNb84TM3wP1bI7xrM6JV03PmmXwOnm8A2/gNz3BMrv/yW53dbsY+QvzRQjmCcbI6NhPVB1Cbu/7Pt5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705604853; c=relaxed/simple;
	bh=lpMV2kIqTCLoNOm0DLoCGjViSRDWTZLRhZws9AoPnJI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r4riA+9a2+iGspvszhnSIDh/xJVT+FFk7u82eBRwoeCkdX1tzfu4RepxY57oH0Zp0ZuEnDn28ORaKWBUOuhuZXkGFY7u5NrGTcPPdBht2eVOAsoLpdSLs1PB3WDllanQWqid/K+1I8tQz2ZzbPLunWVXOEsX6gQuRzfnq4LTy4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RaMnYhCb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3JlnqR7R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705604849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rdll5aIOpwdMCNDLKo7PDLyR3NkTQ6SzswoGCc4m3d8=;
	b=RaMnYhCbO5q1rz/Z/geQ9P5+E24vHZm9EBPTAjB2IdLUFpWvlq6P2IE3h3+EeLJCLCOqT9
	R93GCUl8U3AyJuOe54tRkl5RDbG87gDwOfGtz83OmItKlKcK21DtGC1+IDVKnbQhRJlMgB
	2rG+Nfw1JU6CQ6UGI762T9S0VNnYV/Ln2z9lRfv1vkvtNxHULGLdNjhswxn09WHMD2ZGod
	hf/CcllqbvCgUxBcHYLnl/JIHbfsOctvwsTvCqkn7atJFte6d0K5FYyUQlb1+P55ZJRZaU
	3vFUZE4u2HcpCuPj+GkA8TL/M+D/tVOkJLaZ4eBW97G/9POy37zGihmo9+t7WQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705604849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rdll5aIOpwdMCNDLKo7PDLyR3NkTQ6SzswoGCc4m3d8=;
	b=3JlnqR7RXYGdAudFDOj81AkDuSYaAgunes9yjlBsITM8y99hddTL6DeYfVD+qgFY6pOTuR
	i5xA/ieuh/DdDxBw==
To: Andrei Vagin <avagin@gmail.com>, Dave Hansen <dave.hansen@intel.com>
Cc: Andrei Vagin <avagin@google.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>
Subject: Re: [PATCH] x86/fpu: verify xstate buffer size according with
 requested features
In-Reply-To: <CANaxB-zQYC8=7frWGU2pRTDJrkVu0iR8QZCmUxSzGmBG-_b1cg@mail.gmail.com>
References: <20240116234901.3238852-1-avagin@google.com>
 <30cd0be4-705f-4d63-bdad-fc57301e7eda@intel.com>
 <CANaxB-xu+zG=5_EAe4zapC5a_x4CkkDovmVX7LjiLk+E7kU75g@mail.gmail.com>
 <b3e5456a-7113-4868-b8ce-020421e898ba@intel.com>
 <CANaxB-zQYC8=7frWGU2pRTDJrkVu0iR8QZCmUxSzGmBG-_b1cg@mail.gmail.com>
Date: Thu, 18 Jan 2024 20:07:28 +0100
Message-ID: <87le8mfojz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17 2024 at 23:59, Andrei Vagin wrote:
> On Wed, Jan 17, 2024 at 3:52=E2=80=AFPM Dave Hansen <dave.hansen@intel.co=
m> wrote:
>> I'm not really following the logic there.  What's the downside of taking
>> the fault?
>
> Let's consider a scenario where someone messed up with an fpu state on a
> signal frame.

Then he can rightfully keep the pieces...

> With my approach, a mistake can be promptly detected.

How so? Everything which ends up at the 'setfx:' label will just
silently fall back to FX only and init all other components.

> However, if we incorporate the page fault handling of xrstor, a
> mistake will only be identified if xrstor triggers a fault. In cases
> where a buffer is allocated in a large memory mapping, xrstor may
> silently read memory beyond the buffer.

It's either failing the restore due to invalid data (#GP) or it will
restore garbage. User space asked for it.

> Next time, a page beyond a buffer might be swapped out, xrstore
> triggers a fault leading to application crashes.

If it's swapped out it will be swapped back in, no crash.

There are two ways for crashing:

      1) There is no mapping or a non-sufficient mapping
         i.e. fault_in_readable() fails.

      2) The data in the buffer is invalid.

Crashing the application in both cases is just fine.

The nasty part is that the expected size of the user space buffer is
taken from fx_sw->xstate_size.

So you can construct a sigreturn frame where

   1) fx_sw->xstate_size is smaller than the size required by
      the valid bits in fx_sw->xfeatures.

   2) user space unmapped parts of the stack so that not all
      of the buffer (as required by XRSTOR) is accessible.

Now XRSTOR tries to restore and accesses the unmapped part of the stack,
which results in a fault. But fault_in_readable() succeeds because 'buf
+ fx_sw->xstate_size' is within the still mapped stack.

So it goes back and tries XRSTOR again. Lather, rinse and repeat.

That's what Andrej is trying to prevent by calculating the size required
by the valid bits in fx_sw->xfeatures and validating that against
fx_sw->xstate_size.

That fx_sw construct is yet another horror from the past. It's not much
better than xsave itself.

Thanks,

        tglx

