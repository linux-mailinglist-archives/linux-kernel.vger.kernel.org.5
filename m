Return-Path: <linux-kernel+bounces-85845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DED86BC26
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 388FCB2117C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4BD13D319;
	Wed, 28 Feb 2024 23:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nFzLWLde";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XrrtfC3L"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF36913D2EE
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 23:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709162790; cv=none; b=GwzVHCS5sZQ8NilDcQi5H2OgltNLdV8JlEOHK1tN06sYLJw/4t+ufG9jFx0CLTvypjbp6vsUNoGureotTe6gDwEWuQ7EmpVZybuoNtMJRoDRwo7F5zt1Vy85KnVnD0F46CLU51AAl1uKxq+ur6MjNJ3fqHCQxdeve0yQP4ORp9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709162790; c=relaxed/simple;
	bh=lvzNbHMux8kYW4Qr2USEaO+QnqLQjOklCQuREhqmM60=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nx2Rk5iKDTuGQesqyC7BQGcfcuqJriUmSdScmyUxeRBLf8q2tsIdZwrnOYSYMedsx2Fn+8tzD7ZNkJi9b7QwwHz8577Z1eUn41SgPkhDlVJlK38oGbtfvAfKzhVmugS+N+USi+T753l5Yj2Jxy9+xG+k1i20P2QZZUVpQd6WcLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nFzLWLde; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XrrtfC3L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709162786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WILh8BPSHXfAxjCpDXq5cvSk7cP9m3kjlHYnbAdrmBE=;
	b=nFzLWLdeXnmVm8fFmKbb5AqRMicnpkEPdoVf2uMyYPB+SYZy/VhRR861ogn82CvurxjqH6
	OrSKtaDw+fM3h0LIhdTMHSdS67crIt1aQKN3KH4iWZvGyZIl1XDvXsswYJrjvgjEhOuB8D
	Q54x980kCytM/zP9ASuxEQK7UOt6W2HLLKEuMQfkcIvz7W7ipuNsQKLqWv0fgOsS2QtsKN
	YrGy9rvtioFMZb5Q9pXPdFk7xScAr+LfXaLdhsTgCDOzbbTlKpno/JEKFbGIMkZVxDzP0g
	f3PF0Ni32DGWOJam3hRjOBfj/KJ2pEFNyle7wHXLKydU0YydhKhK9ReJ2y0vsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709162786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WILh8BPSHXfAxjCpDXq5cvSk7cP9m3kjlHYnbAdrmBE=;
	b=XrrtfC3LY01+rmQkcm2RC7k8TS85BLvffCJ1MMjXvVqGdy+5efHbEeDXyHmFDOZaGfXwk5
	u39N4rpv8Cc7B5Aw==
To: Andi Kleen <ak@linux.intel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2] x86/mtrr: Check if fixed MTRRs exist before saving them
In-Reply-To: <20240110150806.22531-1-ak@linux.intel.com>
References: <20240110150806.22531-1-ak@linux.intel.com>
Date: Thu, 29 Feb 2024 00:26:26 +0100
Message-ID: <87edcw8925.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 10 2024 at 07:08, Andi Kleen wrote:
> This one place forgot to check the fixed capability.

This one place forgot? And what the heck is a fixed capability? 

> Otherwise there will a harmless but ugly WARN_ON for the failed WRMSR
> when the MSR doesn't exist.

This is not a sentence as it lacks a verb,

Also it does not matter whether you think that the WARN_ON() is ugly or
not. Can you please write a changelog in technical terms?

> Noticed when testing X86S support.

Who cares?

> Fixes: 2b1f6278d77c ("[PATCH] x86: Save the MTRRs of the BSP before")

This fixes tag is pointlessly truncated. The correct one is:

Fixes: 2b1f6278d77c ("[PATCH] x86: Save the MTRRs of the BSP before booting an AP")

It's not rocket science to copy & pasta correctly.

Thanks,

        tglx

