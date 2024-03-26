Return-Path: <linux-kernel+bounces-118207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492E488B5E0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BBC42E7C38
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328B1634;
	Tue, 26 Mar 2024 00:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rCjMMln7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fjvGN5Hm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15740366
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 00:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711412089; cv=none; b=YIycLXKqC2TYevwiaGoXm3BZMckKZISuP43WGzvWFL+si+3zIPX7ENzPz8JSCDvHlBy2pNmBoBfEaZWmuC9FCy3maygLui7fSxh0YoYbFJm0whug0IvpWOM3tGcueP6sMySnXBSzTMhQ3q8oVY8G9z0CfVApKNcwRcdojQkxxSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711412089; c=relaxed/simple;
	bh=E4KTnXt2Y7NcapFOcTmzVfW2aMNP+O+RjwJpSGQNtl0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VvrBLqpLJ6BpK+TU50Fq2dj/AFHEUaqS3jAfKyZ9MhPf2WKeUEPeMgWvRIQMHGP0p9e4Y8qVSIwUy15/Ce4FCIxbm17LZvNmfZKzduWWEzGOycJc2BXttPwQzblQM+MLYxitRvcczlTBaqWUDEZTrbzXbrot0ZbtT0X3/CQt95M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rCjMMln7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fjvGN5Hm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711412085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eZJgdlzdI+hCvUn2/5zVki0rpf+2SpFCgxZhk5PiSEY=;
	b=rCjMMln7w9Pe4GsPJaKuJv4FkWDk2zbCq5WMvEJwa+L+OF0XFrgbu0UgIXQtZbxh/LoO44
	vBxlrX46RC/zw1P+pBhGzQEy6l6VB9bGZZSnhmTS0CjM/9poEQPUypqIiMNTMvtpGPmpXo
	AJl44fcf09OtdlDfGbDzFgA021XN8KYlCXY3+b1fha92ojzht7B5y5zcDtJJKF36ZRQ8nt
	X/CfvCQjKdX7semp8YnQ0kDaIGMJAyBvMnpja/WyEWNs+ZwDTuZUjgw6Rd5d71AOFEapUa
	sAcUJ0Sf0xqEV5osSGRF8L1Rcrzu50eSAG5mewd2oqDWUx4pGU8PmWKrFZk5Dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711412085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eZJgdlzdI+hCvUn2/5zVki0rpf+2SpFCgxZhk5PiSEY=;
	b=fjvGN5Hm9cFXxR3eQxk74HFh5aVXQHWgT30TcnRHl3kzndlrkviHgfwfNACRNyGyqOvzKu
	vE9Nd57WvVWxgfBg==
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
 linux-kernel@vger.kernel.org, ssengar@microsoft.com,
 sgeorgejohn@microsoft.com
Subject: Re: [PATCH] x86/numa: Map NUMA node to CPUs as per DeviceTree
In-Reply-To: <20240325162421.GA2326@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1710265404-23146-1-git-send-email-ssengar@linux.microsoft.com>
 <87v85bfzg0.ffs@tglx>
 <20240324162833.GA18417@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <87jzlqfk4n.ffs@tglx>
 <20240325162421.GA2326@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Date: Tue, 26 Mar 2024 01:14:45 +0100
Message-ID: <87y1a5etmy.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Mar 25 2024 at 09:24, Saurabh Singh Sengar wrote:
> On Mon, Mar 25, 2024 at 03:42:32PM +0100, Thomas Gleixner wrote:
> Thanks for suggestion, this will fix for all the x86 dtb platforms at once.
> I wonder if there will be any user of x86_dtb_parse_smp_config outside
> of this file after this change. Possibly we can make it static ?
>
> I can send the v2, however if you prefer pushing all these changes yourself
> please let me know.

It's a suggestion. Feel free to make it work and write the change logs
for it :)

Thanks,

        tglx

