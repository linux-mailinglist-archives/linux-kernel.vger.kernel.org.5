Return-Path: <linux-kernel+bounces-138814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C1689FAAC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05A61F3119E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43A116C86C;
	Wed, 10 Apr 2024 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GQFzNF0B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rz7yx78a"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA0316D9B7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712760740; cv=none; b=nvHkUui28LaLSsu2BlC05AwZdgTDjeblEVqP9UlL6zwKrnxVllHN3DhHU2kGVtQ4Cn/UtLbTHauKpTEdbRQiG7BJRkovHJHuJu2tEtw+EuVNzjZ6t4Ux9Tnd1scunbWZej7GL7VkxOTdMU3mNcDo3DNN01jwnr3zzJroe3Ry5YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712760740; c=relaxed/simple;
	bh=V/whf2NgJi4jjsL/BuQVyIZUl0yZ8lKE0/G90die/Go=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fquszngni9naZtMjINNC5oz6N3IUbMgX+w+dwd6btVxOLGDmgOWebVTrflc7dlhsIpq7IPtv8fWzy/Vr8N8lcmQBcOh7K7dxM+exXjAaQQFGC2yzLLfpZiIWylm4wMHSs7l71sjNPD9Jm9ujTXhzmzBsaPwDfBm6heFcaPYRMQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GQFzNF0B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rz7yx78a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712760737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ohxUODTZAldM0Ht/9Tv92UeRT+mq+q4icxH6L3Lk8tQ=;
	b=GQFzNF0Bg+4k7nNSSdY5l/ZgMCwL5A7Ej6m72NDN5ma9AlLvCtkvlcB+NdU+AVtWoxlihj
	8GW/qHneqjCt78BgB8PqAwURYjkT/lEOksxe3NN/5XIqnOutAmnJCi4qN+gBKDTFmu4+Tp
	vKIMWx5c9SR3oLX9OZlKNHN9vbu3WIK3e/NjS56mrD7/o/GG2+1SrUHAOfXVOk8ogmhut2
	opqTxWyA3ZbLCq78fbWbCrGueDg/xQXh0R7CgV1qBaLcQIB3XHGKh4L+BDGnafVjLVrtdu
	c41PKab4toQQTWXNRICaVxjG7mT7EYYS/h4JKRfjwhVbeCmcH2VPrXM2Sg/ETg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712760737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ohxUODTZAldM0Ht/9Tv92UeRT+mq+q4icxH6L3Lk8tQ=;
	b=rz7yx78aiQwqLc36Qkc3Ic5L1U38cgWJsjDy+sM0mxaPPWOmgxetSEvO9ZVMX9p9RSGvFo
	bp+Ar6onyszePSCA==
To: Thorsten Leemhuis <regressions@leemhuis.info>, Linux kernel regressions
 list <regressions@lists.linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>, xiangfeix.ma@intel.com
Subject: Re: Call Trace when adding vCPU to guest
In-Reply-To: <b9e54d33-7f5e-45a5-b215-d3f9daef5a8e@leemhuis.info>
References: <b4929457-23b8-4ad4-8324-cc1cde5ecece@leemhuis.info>
 <87bk6h49tq.ffs@tglx> <b9e54d33-7f5e-45a5-b215-d3f9daef5a8e@leemhuis.info>
Date: Wed, 10 Apr 2024 16:52:16 +0200
Message-ID: <871q7d46e7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 10 2024 at 15:48, Thorsten Leemhuis wrote:

> On 10.04.24 15:38, Thomas Gleixner wrote:
>> On Wed, Apr 10 2024 at 09:34, Linux regression tracking (Thorsten Leemhuis) wrote:
>>> To quote from https://bugzilla.kernel.org/show_bug.cgi?id=218698
>> [...]
>>>>
>>>> When hot adding a vCPU to the guest, the guest happens Call Trace and reboot.
>> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/urgent&id=a9025cd1c673a8d6eefc79d911075b8b452eba8f
>> 
>> It'll be in rc4
>
> Ahh, splendid, thx for replying! Ciao, Thorsten
>
> #regzbot fix: a9025cd1c673a8d6eefc79d911075b8b452eb

Ooops. No!

I just read back and noticed that this is a report against some whatever
kernel:

> [   49.782913] Call Trace:
> [   49.783039]  <TASK>
> [   49.783147]  ? __die+0x24/0x70
> [   49.783309]  ? page_fault_oops+0x82/0x150
> [   49.783518]  ? kernelmode_fixup_or_oops+0x84/0x110
> [   49.783753]  ? exc_page_fault+0xb9/0x160
> [   49.783948]  ? asm_exc_page_fault+0x26/0x30
> [   49.784144]  ? cpu_update_apic+0x1c/0x70
> [   49.784327]  generic_processor_info+0x7e/0x160
> [   49.784541]  acpi_register_lapic+0x19/0x80

# cd linus/linux
# gcur
master 2c71fdf02a95: Merge tag 'drm-fixes-2024-04-09' of https://gitlab.freedesktop.org/drm/kernel
# git grep generic_processor_info
#

generic_processor_info() was removed during the 6.9 merge window with
the topology rework before v6.9-rc1.

So the guest kernel _cannot_ be v6.9-rc2 at all.

Thanks,

        tglx




