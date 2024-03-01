Return-Path: <linux-kernel+bounces-88934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C889786E8AA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E108DB2E15B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F59039AF4;
	Fri,  1 Mar 2024 18:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HtYBqy9v"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D5638DE0
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318538; cv=none; b=IZgzjUKEOdNPa5IhHEmJM9Q5nQQMe/jvX19ASNSiiEAX5inw19mUg22s24ah5ycgDlOVgY6YnPwHx6zdZEIE5tOLA4yMaOXwne/MVRFkej1WBxyAoYBOYx3bpeueKjKJZ+jiFAN4LrTfVaYcCU6fakBfLDGbK6nXeZNagLuONjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318538; c=relaxed/simple;
	bh=/UsB2x4B9Ti3fzOOEOC+JT9j6s1HDa+lM3xisIz14Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjunDvYYnUlrXwV0QxRF3c0FiE0qVghUetGNoj9FV2/s8pjTjP9bE3zsbu/BZKkPi9sBkfXrsmcS/KVw0hrNIAcs28CMOIKiK5Ds/sln9wGOvoguMU4AwdX9lZyVfdlMK64/xIY/lTfxGzUrObGEznnYCuO5mPh/C/rnolHUtS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HtYBqy9v; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A40B840E00B2;
	Fri,  1 Mar 2024 18:42:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hQ6gEvs1O20f; Fri,  1 Mar 2024 18:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709318529; bh=1ktczzyemgTKLB5e7bMrvFgJP3VRuViesWBbpoFxVKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HtYBqy9vJ8hxvGACE+eZnhpbsflLSYi6+ozsG4TEhHZZvf2wpM6W6CFdvHj7lN4aB
	 98LWCmC4i6pjMPBDArpgVwpg7Tq/dGJxtfzurrjEzgBmzYx/SDocLWjfoj78g0ynkp
	 1HRGeX1ceo4JYYp5jl8fLsAhe/SWLU9X24ExkvyKpNZ6nBCt6o6XdxEIfC7HGW1F+C
	 deiUWUzW04+S5DxzOJh6LOixicd8XycCap0ZaVRnYHw7quwJsTuaxBOWnbR7CGLYXW
	 C9TamDD2VXCf1aiXyVjEJtognYtFFtOKF2qxGJ4/OA8LG3cvdV4FaakUdAVs3oxfd8
	 joabtEyOALQI/+ATedIsD5iCJflsZgeGJuNmYSQ0kPDYpNfx9o54emL/28CR1K7dbW
	 zwRxxgKtFqqGkj38azFyXx3v85BL/45mCLVd2i/V8T4GW9m2LwQlZfa0dW6IlaE4os
	 wAHo89WcZP3HBJ0YFHpFMlCars6nk2ycJlPZaviQ+7i/5k8IBud5Avp82tKFleIlGO
	 MiOA3kfuZTpNdUwa7K+BE8Qdvun2lEQ0gcwIMyPCgyd1diJTDJoTDzCOPvpGTrwvcA
	 lKQPgGJFJyJK0r4pwx06nHE5fpteVUxnQOivn3ZgKDqla4Hapy0l/OBvFZzaReksG7
	 e6uEocpFyvZAX2xJ9pzCQtSs=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 92E1240E016C;
	Fri,  1 Mar 2024 18:42:04 +0000 (UTC)
Date: Fri, 1 Mar 2024 19:41:57 +0100
From: Borislav Petkov <bp@alien8.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [patch 0/6] x86/idle: Cure RCU violations and cleanups
Message-ID: <20240301184157.GEZeIhda2_UDfoWnwF@fat_crate.local>
References: <20240229141407.283316443@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240229141407.283316443@linutronix.de>

On Thu, Feb 29, 2024 at 03:23:35PM +0100, Thomas Gleixner wrote:
> Boris reported that a RCU related warning triggers in the tracer code on
> AMD machines which are affected by Erratum 400. On those CPUs the local
> APIC timer stops in the C1E halt state. This is handled by a special idle
> function which invokes tick_broadcast_enter()/exit() around HALT.  These
> functions can end up in lockdep or tracing which use RCU protected data,
> but the core code already set RCU to idle which means that the RCU
> protection is not longer given.
> 
> This series fixes this by handling the tick broadcast conditionally in the
> core idle function. While working on it I noticed a few bogosities in the
> related code and cleaned that up on top.
> 
> The series is also available from git:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/core
> 
> Thanks,
> 
> 	tglx
> ---
>  arch/x86/Kconfig                 |    1 
>  arch/x86/include/asm/processor.h |    2 
>  arch/x86/kernel/cpu/common.c     |    4 -
>  arch/x86/kernel/process.c        |   89 +++++++++++----------------------------
>  include/linux/cpu.h              |    2 
>  include/linux/tick.h             |    3 +
>  kernel/sched/idle.c              |   21 +++++++++
>  kernel/time/Kconfig              |    5 ++
>  8 files changed, 62 insertions(+), 65 deletions(-)

I refreshed my local branch with all your fixed patches and it still
works.

Tested-by: Borislav Petkov (AMD) <bp@alien8.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

