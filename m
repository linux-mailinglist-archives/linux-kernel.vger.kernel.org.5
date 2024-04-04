Return-Path: <linux-kernel+bounces-132073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF59898F5B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105741F27F26
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9936134CC2;
	Thu,  4 Apr 2024 20:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BzqwXqNr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jt8XReyX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50CE6D1AB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 20:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712261118; cv=none; b=lY9X4SEO67hzMC3uSEsdoa92GMLSzVK0gL9hh4YoixBL+hTqcAzsSL+2ZWwVMKFEBRgRNA8dYJM743qtvbdYFucfMdv5OUVSlEdq1cVu/ETcLpuDd4HwviKg+fyeGIQa5KNU2RQz4ySchUITvT/yWVSpN1LzoggfJ/7cB9FMVL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712261118; c=relaxed/simple;
	bh=wsHuS/KXt9orAfcZ3WyjyEtk4smY9xBR+xVYHxV/BcA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PAYA0/4Scz2AGHG0DIlncRGWIdxlcFeb/3qhWxtc2DXGlIttz1hshB3kA0dHAJ1o1OQgHGUq+JiDmK+J6o1Fd+xGZBj7PU7f+KSjFU5g+Kv0RRmbXQaF/meAXZrDbsQGbkXi7N9iHTE6zvRvmOGk721ySmtNoKVPrPvHmsxEq5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BzqwXqNr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jt8XReyX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712261115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wsHuS/KXt9orAfcZ3WyjyEtk4smY9xBR+xVYHxV/BcA=;
	b=BzqwXqNrLuAUB60Mmnr9dKxOiWhkni341JUmCIqBh+sgoYx2Vrhd5y73HsO+5iWHTB66eR
	+MThA+4iXALxFXzQNrycUpjMQEWcRf+XO1N9RyE7Ohf3BG5+n3flDdl0Qv052z+TcMtshz
	Eg73ohNNoR70/pluyoBlyTDi+bRf4raYYsPv5oELQO5f1c/3i14F0Zlt1cn/KJGTR2cZNS
	6hzY6dPF9i69mdedIh8WbUmNoYtMbF6HGOtI8mlYdpU1sPIprWbbo2hjdllUtYn72h8lXh
	q5pUmM7yoP8f/vCEYfIyBQp4Vx/Z8AgGjnjU/5wobMqdWK0+fMGPg3zgApcXJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712261115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wsHuS/KXt9orAfcZ3WyjyEtk4smY9xBR+xVYHxV/BcA=;
	b=jt8XReyXTulKwGpd7gPsFitdDLwXkgG6t/uQd/WEX8ON/N8AjWw5P4LkF3y8UdNc1Xe640
	754OL5bwdO+F1zDQ==
To: Laura Nao <laura.nao@collabora.com>
Cc: kernel@collabora.com, laura.nao@collabora.com,
 linux-kernel@vger.kernel.org, regressions@leemhuis.info,
 regressions@lists.linux.dev, x86@kernel.org
Subject: Re: [REGRESSION] mainline boot regression on AMD Stoney Ridge
 Chromebooks
In-Reply-To: <87frw19bz8.ffs@tglx>
References: <874jchb7na.ffs@tglx>
 <20240404152317.464796-1-laura.nao@collabora.com> <87sf019kbd.ffs@tglx>
 <87plv59f45.ffs@tglx> <87frw19bz8.ffs@tglx>
Date: Thu, 04 Apr 2024 22:05:14 +0200
Message-ID: <87cyr4ao79.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Apr 04 2024 at 21:14, Thomas Gleixner wrote:

> On Thu, Apr 04 2024 at 20:06, Thomas Gleixner wrote:
>> On Thu, Apr 04 2024 at 18:14, Thomas Gleixner wrote:
>>> Can you please provide 'cpuid -r' output too as 'cpuid' does a few
>>> tweaks to the raw data and it's hard to match it back to the code.
>>
>> Don't bother. I think I figured it out.
>>
>> Can you please test the patch below?
>
> Bah. Won't help. Let me dig deeper.

Can I get the /proc/cpuinfo output please?

