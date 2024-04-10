Return-Path: <linux-kernel+bounces-138643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAC489F898
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A71F228C1D6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4046415EFD3;
	Wed, 10 Apr 2024 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2IqzZRrh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dFsRKC0T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA632AF16
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756293; cv=none; b=aHPkoOCJNma7AjnusZco4SGdmiqGwz+QjXYbjyku0qDNtbq948qigNYZW/vGukH7r8meakc52E2u1x9zLVs24sI4uM2uW362qxpOni3qSSFB1tSPDTNZ6GA3oaaEFWK44d/58WiVxcz/7wNU8osqBfX3SPIfCxt00LB1eO3a/PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756293; c=relaxed/simple;
	bh=G/Cy5WPY96g4Vl+cNSJrgwM1kif9xH6SaNAxGLyC81I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ieM3vWdDajCTbMubhorOL7N7ymS7qgwDnx+IVqXoINut53pPVI+bfbjv5NfVZM103HIoLiyiHFrPiQ3CHbOhqHLhc05QWbSmqCf3EmyOsVu48yvhqVeRjilhPVNSxsHyZ5MmHH7NfMlYjfyyUSeK2qlqqBqXKt8zTv9GnNHu0gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2IqzZRrh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dFsRKC0T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712756290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7KWwszC1gDIImnfxbJ4YyzLnz2jQUcsGLC9WpM8+8rY=;
	b=2IqzZRrhZcPb5nY6Q+9wyV0sCb+QNwaSj4CHOMo4dEH3vuM2qV7MzFMxf3HM+F9NqC9r9e
	U70ne/3u16q+roLOmZyErczNiVYIyRjchWVsbiEoE1PiOgA3BWjO/keUaYL7vOxHbxa7+V
	pl6KBIonVNu/tktRp8iRzgE8R2JAqZBWn4cfL/4CjoC0FZDdgJOBJXXSiqIaI7zcgnotlo
	1VBfhxOX086hviMwZDVtAMGh9c7LCFJ4xG5TRVNWZPb5jG5+MWNu6kh1VAeAUNkVVxg31+
	7A7IWxTPJstXib5rLTpXN/p/5D83OTYll6aQtQUQyv50w9J5H8npoxdfm9KdkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712756290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7KWwszC1gDIImnfxbJ4YyzLnz2jQUcsGLC9WpM8+8rY=;
	b=dFsRKC0TzEd4cIVGDe0cKMC7uvNHbBGWU3gVxmOGF8OhejSVRne0O/QO3U7oA4bpwqq6sj
	lNGeKAQjrhgOxzAA==
To: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>, Linux kernel regressions list
 <regressions@lists.linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>, xiangfeix.ma@intel.com
Subject: Re: Call Trace when adding vCPU to guest
In-Reply-To: <b4929457-23b8-4ad4-8324-cc1cde5ecece@leemhuis.info>
References: <b4929457-23b8-4ad4-8324-cc1cde5ecece@leemhuis.info>
Date: Wed, 10 Apr 2024 15:38:09 +0200
Message-ID: <87bk6h49tq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 10 2024 at 09:34, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker.
>
> I noticed a report about a regression in bugzilla.kernel.org.
>
> Thomas, I wonder if it's caused by your topology changes. But it's just
> a wild guess and I might be totally wrong there, so feel free to ignore
> this mail. I already asked for a bit more log output and a bisection in
> the ticket.
>
> To quote from https://bugzilla.kernel.org/show_bug.cgi?id=218698
>
>> Environment:
>> 
>> Host OS: CentOS 9
>> Host kernel: 6.9.0-rc1
>> KVM commit: 9bc60f73
>> Qemu commit: e5c6528d
>> Guest kernel: 6.9-rc2
>> Guest commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
>> Guest repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>> 
>> 
>> Bug detail description: 
>> 
>> When hot adding a vCPU to the guest, the guest happens Call Trace and reboot.

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/urgent&id=a9025cd1c673a8d6eefc79d911075b8b452eba8f

It'll be in rc4

Thanks,

        tglx

