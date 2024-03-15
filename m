Return-Path: <linux-kernel+bounces-104733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82AA87D2E4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CE56B21F53
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C7348CCC;
	Fri, 15 Mar 2024 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fnbyhv5q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+k0NCTUp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC2345028
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710524169; cv=none; b=VzPsjbHZuQqKOhPCEQlbIsHW7v6x8T92WcHK7mFJJ5e4zRNDLYE1duMLMTGLeY24Trqi8NW+qF8YS5wUw9DINbPklHFlE7dR0ZY3h3DUY307yD9EMxSAlaFEEWjlR4SjreAUcy50fsTouJJ/omJNXxpewE64vkJW10WvT7d0XbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710524169; c=relaxed/simple;
	bh=5BCWEDkzaNzoh400/WqQl4TJLPYBKMOmh0anmXPME7s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pe1jjbgfciK3tMGsi2p8fiWkhOFFJBEW2P5bpWzTr5IPihZEqqtTrBZdkIwrWecWqrRQC4B4PCB5I1PRfdVArfi7v4UCUqc8Y9L66hYNL9ydlC5sthGST1FQ+uwaRoUxh9Pnr58zWD8McEeWW5IvFrZbY9tRUwahidDIoMHgfwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fnbyhv5q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+k0NCTUp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710524165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfmEo8wWEDxZSGruHVEe96arG32Yte4+z23QktqoVek=;
	b=Fnbyhv5qtbhjRIp1Tng7MrjXMjb21SkQgPbZHYhRjsragOmvRddHk5whf1SuTZfhYzl0+T
	sIniPDRmoUROFbtN7XngIWNNtkhTUcQzEMTLxuRBtN1GgMRuZnZ57tLsy6ThQUxOfUSbGh
	qe+Cp0a92aa3uD7Z7Sp+Mc5E+l01fAPEdpCZTBsf0TKWl+wSaV+QJCwsoLhGkzwjOzpubu
	UdWTraDh4camXHWHChim1rp4J+Ko3EP/YjoWjtjLJTno4b0dbqxd7cVC22wxvXJ55XHAvb
	icflzD+iEYoIkxQvS4T3BHyIG1zTzN4vxWHuc5t3AbHuS4338ZAMyAVLgjwHSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710524165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfmEo8wWEDxZSGruHVEe96arG32Yte4+z23QktqoVek=;
	b=+k0NCTUplZXGPZCfuwvvfRkrFZFPiMkaSJAUBmKJQEa7wo9qUrM68eJqR0z7FeCg/0qpbx
	bFmZ6rXx8/nbv4AA==
To: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>, Dave Hansen
 <dave.hansen@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>
Subject: Re: [RFC PATCH] x86/pkeys: update PKRU to enable pkey 0 before XSAVE
In-Reply-To: <349322E5-5E6C-48D5-BA12-1CF47CE82930@oracle.com>
References: <20240314172920.2708810-1-aruna.ramakrishna@oracle.com>
 <4bd2aea0-3cea-4ef8-9607-40447cd531e5@intel.com>
 <349322E5-5E6C-48D5-BA12-1CF47CE82930@oracle.com>
Date: Fri, 15 Mar 2024 18:36:04 +0100
Message-ID: <871q8bl7nf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14 2024 at 18:14, Aruna Ramakrishna wrote:
>> On Mar 14, 2024, at 10:54=E2=80=AFAM, Dave Hansen <dave.hansen@intel.com=
> wrote:
>> The need for this new feature is highly dependent on the threat model
>> that it supports.  I'm highly dubious that there's a true need to
>> protect against an attacker with arbitrary write access in the same
>> address space.  We need to have a lot more information there.
>
> I thought the PKRU value being reset in the signal handler was
> supposed to be the default behavior. In which case, this is a bug.
>
> "Signal Handler Behavior
> Each time a signal handler is invoked (including nested signals),
> the thread is temporarily given a new, default set of protection
> key rights that override the rights from the interrupted context.=E2=80=9D
>
> (Ref: https://man7.org/linux/man-pages/man7/pkeys.7.html)
>
> I'm not very familiar with protection keys (before I started looking
> into this issue), so I apologize for misunderstanding.
>
> fpu__clear_user_states() does reset PKRU, but that happens much later
> in the flow. Before that, the kernel tries to save registers on to the
> alternate signal stack in setup_rt_frame(), and that fails if the
> application has explicitly disabled pkey 0 (and the alt stack is
> protected by pkey 0). This patch attempts to move that reset a little
> earlier in the flow, so that setup_rt_frame() can succeed.
>
>> I haven't even more than glanced at the code.  It looks pretty
>> unspeakably ugly even at a glance.
>
> I agree with you - no argument there.

It's a horrible hack.

> But I=E2=80=99m not sure there is a =E2=80=9Cclean=E2=80=9D way to do thi=
s. If there is, I=E2=80=99m
> happy to redo the patch.

If it turns out to be required, desired whatever then the obvious clean
solution is to hand the PKRU value down:

         setup_rt_frame()
           xxx_setup_rt_frame()
             get_sigframe()
               copy_fpstate_to_sigframe()

copy_fpstate_to_sigframe() has the user fpstate pointer already so none
of the __update_pkru_in_sigframe() monstrosities are required. No?

Thanks,

        tglx

