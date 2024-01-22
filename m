Return-Path: <linux-kernel+bounces-33095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F022C83646C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C69328229A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AC83D0BF;
	Mon, 22 Jan 2024 13:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q1nfMhaa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AA2wTtB2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B663CF5A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705929966; cv=none; b=e+ScO9/aT7grcZop5kEyvFygu+rIxXLbeUrXBjq2bB6/ANLhhH4kCkI6TuIiOIQZ4PRE/OAlP8GFU1cFXGIp5VRsf69aw0po18+dHEYLPHI1Wys6qB8y6/WDdMF0kU/kmxtvkGf3O+LEU4NwO8GJVcGq2gYW9RyjBcGmz8KOfWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705929966; c=relaxed/simple;
	bh=AdkQZSRn2mxv5gZ8faSB3eUvx2yITrTIfL7sVlooOF4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p5fS/cDN/YXrBlYrt+4uXmJYh67tGeQlVwBN90ig2LdAdi07IufI/hqraRIOUwzFxhKAFfo6i9Uf7l2F6wnktAfImlS5DBWcvv2kzMW4mll0DuXAdTJPZpbVjOy23Wj0vt73MgxZ8wKCryYKtHxV37vEJS/shhIAac+jBOdTUuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q1nfMhaa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AA2wTtB2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705929962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/42ekYY9I1DYMe5I59ciu8BkLOqVsXg7fjJStaWmaBQ=;
	b=Q1nfMhaaYGWZB3nLG8/NJ0JyXepz6AbLtfWS34hs02HOvENNS8y5II53DWOkMicdIK0LOh
	sq5aJ2a715lP0GtXsilAOBfO+88pSpQjDa7r5aD2bnMt5honXPhorTmvBTvuneeufYr9wt
	goWCUl4mVzK0kXaxArdrbOe7DPSkPaKI02xi1cfwAXI+oakXDJcPxhImHjsJdHclNdMje6
	6GfuGAQ8OaRvSavNZIFuMoQn5cFkGgN9VPtFRiSujdskjYrkKInpqJBCGVLT+/c9nUXync
	ZlESjJ0azB2oS+68IjaL1N4H8x35KNeRAzGRO13DNCcNwthcckUBCXKPSxAn1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705929962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/42ekYY9I1DYMe5I59ciu8BkLOqVsXg7fjJStaWmaBQ=;
	b=AA2wTtB2+KVnci+jSJ7YPI8GWO4VdIGMf8gzCiU1EKe/aB9PFvV+xciQfcuIiDQCHWgzKG
	kPAeklacqGZhPADw==
To: Andrei Vagin <avagin@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Andrei Vagin <avagin@google.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/fpu: verify xstate buffer size according with
 requested features
In-Reply-To: <CANaxB-zaa0nMFmep9jtJh_QDdAj=2K9G5PAKF4iTuNbNnYj4bg@mail.gmail.com>
References: <20240116234901.3238852-1-avagin@google.com>
 <30cd0be4-705f-4d63-bdad-fc57301e7eda@intel.com>
 <CANaxB-xu+zG=5_EAe4zapC5a_x4CkkDovmVX7LjiLk+E7kU75g@mail.gmail.com>
 <b3e5456a-7113-4868-b8ce-020421e898ba@intel.com>
 <CANaxB-zQYC8=7frWGU2pRTDJrkVu0iR8QZCmUxSzGmBG-_b1cg@mail.gmail.com>
 <54bcb902-0fab-4a53-8b8e-85b6e4484b03@intel.com> <87cytyfmd8.ffs@tglx>
 <5bddbb34-4081-494b-8c12-c2e70898a608@intel.com> <877ck6fg0z.ffs@tglx>
 <CANaxB-zaa0nMFmep9jtJh_QDdAj=2K9G5PAKF4iTuNbNnYj4bg@mail.gmail.com>
Date: Mon, 22 Jan 2024 14:26:02 +0100
Message-ID: <87v87lebyt.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21 2024 at 19:58, Andrei Vagin wrote:
> On Thu, Jan 18, 2024 at 2:11=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> >> After staring more at it, it's arguable to pass fpstate->user_size to
>> >> fault_in_readable() and ignore fx_sw->xstate_size completely.
>> >>
>> >> That's a guaranteed to be reliable size which prevents endless loops
>> >> because arguably that's the maximum size which can be touched by XRST=
OR,
>> >> no?
>
> fpstate->user_size isn't constant.  It can be modified from the XFD #NM
> handler. For example, it happens when a process invokes one of amx
> instructions for the first time. It means we have to be able to restore
> an fpu state from signal frames generated with a smaller
> fpstate->user_size. Can it trigger any issues?

I know, but the #NM handler does not run in the signal restore
path. fpstate->user_size is guaranteed to be correct at that point.

The untested below should just work.

Thanks,

        tglx
---
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -274,8 +274,7 @@ static int __restore_fpregs_from_user(vo
  * Attempt to restore the FPU registers directly from user memory.
  * Pagefaults are handled and any errors returned are fatal.
  */
-static bool restore_fpregs_from_user(void __user *buf, u64 xrestore,
-				     bool fx_only, unsigned int size)
+static bool restore_fpregs_from_user(void __user *buf, u64 xrestore, bool =
fx_only)
 {
 	struct fpu *fpu =3D &current->thread.fpu;
 	int ret;
@@ -309,7 +308,7 @@ static bool restore_fpregs_from_user(voi
 		if (ret !=3D X86_TRAP_PF)
 			return false;
=20
-		if (!fault_in_readable(buf, size))
+		if (!fault_in_readable(buf, fpu->fpstate->user_size))
 			goto retry;
 		return false;
 	}
@@ -339,7 +338,6 @@ static bool __fpu_restore_sig(void __use
 	struct user_i387_ia32_struct env;
 	bool success, fx_only =3D false;
 	union fpregs_state *fpregs;
-	unsigned int state_size;
 	u64 user_xfeatures =3D 0;
=20
 	if (use_xsave()) {
@@ -349,17 +347,14 @@ static bool __fpu_restore_sig(void __use
 			return false;
=20
 		fx_only =3D !fx_sw_user.magic1;
-		state_size =3D fx_sw_user.xstate_size;
 		user_xfeatures =3D fx_sw_user.xfeatures;
 	} else {
 		user_xfeatures =3D XFEATURE_MASK_FPSSE;
-		state_size =3D fpu->fpstate->user_size;
 	}
=20
 	if (likely(!ia32_fxstate)) {
 		/* Restore the FPU registers directly from user memory. */
-		return restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only,
-						state_size);
+		return restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only);
 	}
=20
 	/*

