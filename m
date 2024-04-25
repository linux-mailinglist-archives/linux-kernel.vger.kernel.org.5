Return-Path: <linux-kernel+bounces-157930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7855C8B18C6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162D11F23DF4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B4C134AB;
	Thu, 25 Apr 2024 02:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4imO72Q0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QlaXmZe5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B2710A16
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 02:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714011102; cv=none; b=bXi6O4N1d0FKYiACkZTQrtlO6FYhLJcbsQZNtW7NuDxLkIXYB9f4FrUBgYl7nHcKttbmejg6rQnchvj461MFMVO6wnkLCp3Dt71MFp1ilbbbNuKDD5XKOaAaVQ7Fg/2nUAeSieEKOoYm1L+UmH8cPMFr01XN1TYwQ09tPm9bbM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714011102; c=relaxed/simple;
	bh=DJcpG+MqSFibXno8VdaF/4H+Z9GVE458K9cYb1s5RL8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J7MnJSpK8qv4aFTc16/uKmz+3OAqwLx7HHX+zqBqAA+mw0z0rv92v86eUXuKn8tpauzVLnSxDIkcxZh1JKqNOirXyF6wIYgGbef8wZqHOxEIMRyDTzVxfJ/V2ar8GSIJ4tXcLsefm/u01OXGNdvfBml55hjISFlcvFHnCqvfKnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4imO72Q0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QlaXmZe5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714011098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BioXVpNosp+NvluXb69ryhG29p5YhlH51Sb1KybnhX4=;
	b=4imO72Q0kojZF7nKlnjSk/1mG1g9/4X5OSx8zq7gcqtrilIWg3UVxyz1d/06N4Swi4J8rB
	+17mSHTdeiRCCvZnuPABsFzL6FDePOjABJVGO90iqwCK4MLI1U/nKcuQ91CVRPzYhhxHOk
	a0i2y5qoTCWblA9Gj+SdHnMROafQy0VneKtNx/FoTpNP6wsmsu3aoKJdEl1dcWYqBSuaWL
	mwe329VBv3jfhXRLUst2XfUo8p0QKqTQheJnqdlc2hLLELS/SvDd0Ppiz2LXQnqj9rKOYG
	DsI2mK8Ev4pkrYlurPcFammZZgENPenUb3X1TJCl4/8XpkzBbIM+cCY8MXkFcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714011098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BioXVpNosp+NvluXb69ryhG29p5YhlH51Sb1KybnhX4=;
	b=QlaXmZe5QPZryZ62kj6TLUmqYUKeokqJdAXUf2m5bQmnBV9xOz+o5idvQXIVM8DyUr+Cfb
	Hx9nmH0OwYqyamDw==
To: Lyude Paul <lyude@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Early boot regression from f0551af0213 ("x86/topology: Ignore
 non-present APIC IDs in a present package")
In-Reply-To: <3a0afe545747e5314a9cb6bbaa9ce90b259ddfac.camel@redhat.com>
References: <3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com>
 <20240418082703.GCZiDZVyra7qOQbyqn@fat_crate.local>
 <fd040809d95b3e12b2fdc78a2409e187716bc66f.camel@redhat.com>
 <87plumxz4x.ffs@tglx>
 <abbb7d7ca781f6c664e4c5b1dffc19394ac79691.camel@redhat.com>
 <87le59vw1y.ffs@tglx>
 <3a0afe545747e5314a9cb6bbaa9ce90b259ddfac.camel@redhat.com>
Date: Thu, 25 Apr 2024 04:11:16 +0200
Message-ID: <87edautcmz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lyude!

On Wed, Apr 24 2024 at 16:56, Lyude Paul wrote:
> On Sat, 2024-04-20 at 00:15 +0200, Thomas Gleixner wrote:
> Lyude is fine BTW :P (I get the confusion though, Paul is usually not a
> last name lol)

:)

> Anyway - unfortunately it doesn't seem like this patch helps :s, I'm
> still not seeing any difference and the backtrace I'm seeing at early
> boot looks the same. Any more information I can provide?

Can you please boot a kernel with the commit in question reverted and
add 'possible_cpus=8' to the kernel command line?

In theory this should fail too.

Thanks,

        tglx

