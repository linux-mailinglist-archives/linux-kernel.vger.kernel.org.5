Return-Path: <linux-kernel+bounces-144658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 422798A48DF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 730F11C22E2D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3A222EFB;
	Mon, 15 Apr 2024 07:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fl+Fy9hu"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5410208C1
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713165735; cv=none; b=WF0UQpszUuaxeu/b5/C/DzZFcr6oS64dvkSn9veni6sdFjexklpbBhoKHlH7FkiGctsx7r4o5/WWYnqbYH0erotP2GI99vKpu4GuO9v4SwDjoVlXGHC/QheKomsnJTL6yqpCV+DMqdl+unNYGxoQItriNu4OSoTxxgakE5QxniQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713165735; c=relaxed/simple;
	bh=DT0z5c5Soncl7yZ6BZd8jDaZqESFh46sM5dtII7EO4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsDZET7Kp8znrCt8hD635GYVib3vQOWWJDG7CIOKTsIn4RIDAiQgi6/uhVhID1Uj6Ku7ZdIpTOiAMP1HKb9aYYQ07mEP9OS7wiO9vi7JqLknWCaB6LH5NB8LX2v5leox2U3j8T3Dej2l0BBBs3mWlMrQICcFJiPari4ETugLuUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fl+Fy9hu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pixuZERIF45TRFIuK2/vWu3NO2feKHANcyjnSRqQK+0=; b=fl+Fy9huSIq8mnnizg7USspAUP
	aFpfyUYuLo6/2ZoHez1uvg4xXUFONmv5jcHD8kj6UtZELRdxEYLjhorLbwO7Qz9NLB3j0OSuVLYpI
	IoQP+dvU1+OSIUDbWaRcHp2hpMaHNIv78sKnaahyAiVCo3gfeGODlb+/rsS5yhi0bV+VvPvYsOrYR
	tnEFSamqtFHMRt4+A7Icu/9bQ95QUehlpCIC104cZ5vWSEXCvFVWLYF7II7X3Vr6R59v/uAI0ZIUJ
	yYCpHR4ymrxrfPjtUAnujE25cZivXIK5hLJSd6Ec0NTlle1mBVtekUlmrrt0v2yTebFWsdGibsLDL
	Li942L5w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwGfI-0000000FC06-3IBh;
	Mon, 15 Apr 2024 07:22:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3F79D30040C; Mon, 15 Apr 2024 09:22:08 +0200 (CEST)
Date: Mon, 15 Apr 2024 09:22:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Daniel J Blueman <daniel@quora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Trust initial offset in architectural TSC-adjust
 MSRs
Message-ID: <20240415072208.GE40213@noisy.programming.kicks-ass.net>
References: <20240226072533.341382-1-daniel@quora.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226072533.341382-1-daniel@quora.org>

On Mon, Feb 26, 2024 at 03:25:33PM +0800, Daniel J Blueman wrote:
> When the BIOS configures the architectural TSC-adjust MSRs on secondary
> sockets to correct a constant inter-chassis offset, after Linux brings
> the cores online, the TSC sync check later resets the core-local MSR to
> 0, triggering HPET fallback and leading to performance loss.
> 
> Fix this by unconditionally using the initial adjust values read from the
> MSRs. Trusting the initial offsets in this architectural mechanism is a
> better approach than special-casing workarounds for specific platforms.

Given the amount of BIOS fail in general, I'm thinking the number of
machines that have multi-chassis and get this right are far less than
the 'small' systems that get this wrong.



