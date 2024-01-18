Return-Path: <linux-kernel+bounces-30594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2485783216E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9B58B23623
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 22:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B0F31A6F;
	Thu, 18 Jan 2024 22:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JgEPiifx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ciaocaMb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15D02E640
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 22:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705615905; cv=none; b=BUKP+k2ZiPM0GJFGicdE/HGSWUruCV081gPcVXqbILQ/e+Q0YE6L8rZcZ0hEZAofQtS2sCy0wIuAN46cIavgO7fwwuwkGMHH0viARBH2u0T7bDHjnkrcSn275dxSzbCS/U/NXXuXY7CHUJZ4KdQyKgxUZ32U8PCb1+Y/vK89vTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705615905; c=relaxed/simple;
	bh=OpJNRpQ+SSmWdmSOznoYKZnRIsdRAvixasMs7TNCrmc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KdB+mVcNBWZH707ziRpgVp6vaNj6srcFqgGnCymBKcgOeQcPK3s7AoWR4l6Zfv4Wyywjr39NjsQ58EDwxixnJwZd8Aa6dolY+3hiYSt+29nYDOwoI6QSuse2YBIGI/1JZvxurTg4ie44NeByFqYrpMoHVKVmXu8USSSpimMNcc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JgEPiifx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ciaocaMb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705615901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tDtVWcMaj7jj4XT6eyA4k8Tf0NHxgvS28FM4DOAYURw=;
	b=JgEPiifxwKN/IvmmGejYJOw51/jz0lWbxnaUBttFn4grsxUqtWqKel0IjulNRkgA6Vqv2o
	hyODFPnv2cScLvnQ/PLQNEVMderFzYyvwVVSgaqUz9YYnibEoXGIScetcgcGeOn/11o2sp
	LD1tr27eSvQ4qdVosL7J0puJTOdqa3UQB1Gd+61vM3Po3taK+61cv74Qg0QGnoiuym4HMu
	BSJLZb7A8v1g3HYEsle9yTuqoBDMKgD0BF1KRIsUzw+A3oJ7soaOFpxiJf0skHLMzmn/us
	jACrLJDpTVgU7wW7BkSdktJIkTU4J5tSyetrpqew6r18zmlDGTXVTAY6sx9WAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705615901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tDtVWcMaj7jj4XT6eyA4k8Tf0NHxgvS28FM4DOAYURw=;
	b=ciaocaMb0qk1X+Yx3OTnxO4UxrfnVV0eHuMjORdqZ1QaCU9xZgXPQDR0jCpwVFs3aIAwT3
	0tThV3b9mBMzzRCQ==
To: Dave Hansen <dave.hansen@intel.com>, Andrei Vagin <avagin@gmail.com>
Cc: Andrei Vagin <avagin@google.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>
Subject: Re: [PATCH] x86/fpu: verify xstate buffer size according with
 requested features
In-Reply-To: <5bddbb34-4081-494b-8c12-c2e70898a608@intel.com>
References: <20240116234901.3238852-1-avagin@google.com>
 <30cd0be4-705f-4d63-bdad-fc57301e7eda@intel.com>
 <CANaxB-xu+zG=5_EAe4zapC5a_x4CkkDovmVX7LjiLk+E7kU75g@mail.gmail.com>
 <b3e5456a-7113-4868-b8ce-020421e898ba@intel.com>
 <CANaxB-zQYC8=7frWGU2pRTDJrkVu0iR8QZCmUxSzGmBG-_b1cg@mail.gmail.com>
 <54bcb902-0fab-4a53-8b8e-85b6e4484b03@intel.com> <87cytyfmd8.ffs@tglx>
 <5bddbb34-4081-494b-8c12-c2e70898a608@intel.com>
Date: Thu, 18 Jan 2024 23:11:40 +0100
Message-ID: <877ck6fg0z.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 18 2024 at 14:02, Dave Hansen wrote:
> On 1/18/24 11:54, Thomas Gleixner wrote:
>> On Thu, Jan 18 2024 at 10:27, Dave Hansen wrote:
>>> If we have nice, reliable fault handling and then decide that we've got
>>> XRSTOR's running amok reading random memory all over the place that need
>>> a nicer error message, then we can add that code to predict the future.
>>> If our "predict the future" code goes wrong, then we lose an error
>>> message -- not a big deal.
>> After staring more at it, it's arguable to pass fpstate->user_size to
>> fault_in_readable() and ignore fx_sw->xstate_size completely.
>> 
>> That's a guaranteed to be reliable size which prevents endless loops
>> because arguably that's the maximum size which can be touched by XRSTOR,
>> no?
>
> I like it.  It takes fx_sw completely out of the picture, which was the
> root of the problem in the first place.

Correct.

I really don't care about the esoteric case where this might
theoretically result in a unjustified application abort.

You really need to twist your brain around 6 corners and then squint
twice to construct that case. Of course syzcaller might trigger it, but
fuzzing the sigreturn frame is a #GP, #PF and whatever lottery anyway.




