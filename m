Return-Path: <linux-kernel+bounces-159230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46C08B2B20
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12D3F1C218EC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E6F15573A;
	Thu, 25 Apr 2024 21:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YzlkcV+6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dkQ9IDDJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B8A1FC4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 21:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714081366; cv=none; b=HW5PWEMTHo1HokOxjgLT23NgOa52BCu+FXkrCzGylUegvviSysY88wxAysvEuTN1bGG7wOF2vWuyBtsa5GD9OTVaJw6Ki2n98dBMoiOl6LvY+ScXxZhmD4QftPLKdRzMYxvYVDMDbrEt6UYeSB5NeUV5QQPeFmkG3E/lYHHdp8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714081366; c=relaxed/simple;
	bh=FzKdYEKLWGjvznZ3ZLuDkvQAtXkLbCroU6soGsSlzR0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e1oS01Lip6pWOTVRcbuGyBU3upIpQHlY++y0dV/2EdnlUe4tLvMCRRkeqrzZ2k1bqzG9zl7k4D2xidv4zMQ+zFOiil3oFpSuylwaJ+OVTVynieKUTkvrMEA+z92Yigf0QjUbJOzijpmQCkkp0A7qDwvkbvBipR8+LB72QdI4tjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YzlkcV+6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dkQ9IDDJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714081362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UaaNtzca06bXu38h5O1TFgrZCt/zSA1O6qAPUMjaY6M=;
	b=YzlkcV+6L6ZX239UTura25dxrYpZPQZycb5B17QuIDYa6kBKSVtZROxzyROma61VLWqNbB
	zmg7tCAa7XnxeVwqgh/8tLSf8RHtOq0Fd059HG5uBnajRHn+pBMetzo2w2ibmQuwYOsx+O
	K4lvCtcAB/d7vPCCKVfOJ+YEwPujmTacCFFcn+1OvGiSvSCR1GbHhas/O0mL+9yaGhWKf4
	LQftUF6/TscPJJitEmpScAS+1oatppyF7Z3cbHMEccIFoGXL7PSDgqouu37cSwQyzDq5ys
	F0sW0EGhKAYHTIUx2m1FTigy8RSyuPtWrOKgk9zLKHd66DBv65e4QfCHVYRl7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714081362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UaaNtzca06bXu38h5O1TFgrZCt/zSA1O6qAPUMjaY6M=;
	b=dkQ9IDDJsCfXJu08NkfefRN/tpZBaw571q1v2C9M7EKRXUeDuPgeM/QDqmbkbLMITu/4ZQ
	lhEWHog3Pz7AG0Cw==
To: Lyude Paul <lyude@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Early boot regression from f0551af0213 ("x86/topology: Ignore
 non-present APIC IDs in a present package")
In-Reply-To: <3b1d16e357c1f9badeef405366492f05af26c085.camel@redhat.com>
References: <3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com>
 <20240418082703.GCZiDZVyra7qOQbyqn@fat_crate.local>
 <fd040809d95b3e12b2fdc78a2409e187716bc66f.camel@redhat.com>
 <87plumxz4x.ffs@tglx>
 <abbb7d7ca781f6c664e4c5b1dffc19394ac79691.camel@redhat.com>
 <87le59vw1y.ffs@tglx>
 <3a0afe545747e5314a9cb6bbaa9ce90b259ddfac.camel@redhat.com>
 <87edautcmz.ffs@tglx>
 <3b1d16e357c1f9badeef405366492f05af26c085.camel@redhat.com>
Date: Thu, 25 Apr 2024 23:42:13 +0200
Message-ID: <878r11t8zu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lyude!

On Thu, Apr 25 2024 at 11:56, Lyude Paul wrote:
> On Thu, 2024-04-25 at 04:11 +0200, Thomas Gleixner wrote:
>> 
>> Can you please boot a kernel with the commit in question reverted and
>> add 'possible_cpus=8' to the kernel command line?
>> 
>> In theory this should fail too.
>
> Yep - tried booting a kernel with f0551af0213 reverted and
> possible_cpus=8, it definitely looks like that crashes things as well
> in the same way.

Good. That means it's a problem which existed before but went unnoticed.

> Also - it scrolled off the screen before I had a chance to write it
> down, but I'm -fairly- sure I saw some sort of complaint about "16 [or
> some double digit number] processors exceeds max number of 8". Which
> is quite interesting, as this is definitely just a quad core ryzen
> processor with hyperthreading - so there should only be 8 threads.

Right, that's what we saw with the debug patch. The ACPI/MADT table
is clearly bonkers. The effect of it is that it pretends that the system
has 16 possible CPUs:

    [    0.089381] CPU topo: Allowing 8 present CPUs plus 8 hotplug CPUs

Which in turn changes the sizing of the per CPU data and affects some
other details which depend on the number of possible CPUs.

But that should not matter at all because the system scaling should be
sufficient with 8 CPUs, but it does not for some completely non-obvious
reasons.

Can you please try to increase possible_cpus=N on the command line one
by one and check when it actually starts to "work" again.

One other thing to try is to boot with 'possible_cpus=8' and
'intremap=off' and see whether that makes a difference.

I really have no idea where to look and not having the early boot
messages in case of the fail is not helpful as I can't add meaningful
debug to it.

I just checked: the motherboard has a serial port, so it would be
extremly helpful to hook up a serial cable to this thing and enable
serial console on the kernel command line. That way we might eventually
see information which is emitted before it fails to validate the timer
interrupt.

Thanks,

        tglx

