Return-Path: <linux-kernel+bounces-61861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFF7851782
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A813282F1C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9F63C68C;
	Mon, 12 Feb 2024 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z1Q3cIZp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DL0xfnIw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B373C680
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750225; cv=none; b=Rm0LXlx86Nh4kqwwLVb0hvDCoGtY5bzYNm2NJcWmB56NL84MAibGftQ3+GTZLu+dl5kbIzICb6pAVNPLLaUaxPmaS3CIj5GZO9twv6XfENq2tYHiSyDJGIN8MA8777S+/nZyrSSKje0t33U//+wlLjXfJkLJQh5bvsxwXfGBi8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750225; c=relaxed/simple;
	bh=yLdZ044RR8tzkqHTq1T2/FUjDwuAMQovYCA01kek/r0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=arzjdc0vDU301BFNpEozwbWNz8Q78q2B5VyrVMrp6NVKk090AesZ5BRWEThZ75ceRXXl5tsbPi7byfXbvUrMvshnb9cNKtZG002EQYV45Y9J1leDv9DFTwxc6HHoILl6yFMlKNwFagSI7+bO542BjuphlTg7B2ZL2Wc2ZtmRrh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z1Q3cIZp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DL0xfnIw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707750222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v1glk031wqZcbbm/jOYZ8J2yM9vWz7AxqAE4GGPiTx4=;
	b=z1Q3cIZpknDXRTBZVv2/sOH092ZX7SMy+oAk3dFq0AgvoKq76vWK9yE5cCDWKggrTvnZMA
	sKLsoinsoJPrhAGnVSEDgz1ePru2xlVwtarnAc6QbWGPQa63vccX4VIw0EqDP3peDy0VaU
	rKNTp/bTKfHsYAjNcZr8prLo8kpOszZoIJoFMT0sXSlvNWcsLmKVFkzn1kEvYO0gUHuxcx
	TS8AqZFpjnQ8ZJh7lOe+0i+L9jqkxKpbMvnXmCD7VwDJVrtBQ6OXs4+ao9ONp/5vV0Knlv
	7bvM3P1FjjElib1poPwevve17e/wc9SJnBbMVnVyDRXMH5Z5uPppHHaYVOXnXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707750222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v1glk031wqZcbbm/jOYZ8J2yM9vWz7AxqAE4GGPiTx4=;
	b=DL0xfnIwOuRH+z4PyPUnb7bEgnertudTfObU/RUGFRSeD/+5XnxyMuc2wQlV5u0ZtvE+N/
	5cHk4Z5p4oPP1JAg==
To: Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Tom Lendacky
 <thomas.lendacky@amd.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 Arjan van de Ven <arjan@linux.intel.com>, Huang Rui <ray.huang@amd.com>,
 Juergen Gross <jgross@suse.com>, Dimitri Sivanich
 <dimitri.sivanich@hpe.com>, Sohil Mehta <sohil.mehta@intel.com>, K Prateek
 Nayak <kprateek.nayak@amd.com>, Kan Liang <kan.liang@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Feng Tang <feng.tang@intel.com>, Andy Shevchenko <andy@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>
Subject: Re: [patch v5 06/19] x86/cpu: Provide a sane leaf 0xb/0x1f parser
In-Reply-To: <87il2tlqba.ffs@tglx>
References: <20240117115752.863482697@linutronix.de>
 <20240117115908.674834306@linutronix.de>
 <20240130193102.GEZblOdor_bzoVhT0f@fat_crate.local> <87il2tlqba.ffs@tglx>
Date: Mon, 12 Feb 2024 16:03:41 +0100
Message-ID: <87a5o5lo6q.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 12 2024 at 15:17, Thomas Gleixner wrote:
> On Tue, Jan 30 2024 at 20:31, Borislav Petkov wrote:
> TBH, the // comment style is really better for struct definitions. It's
> denser and easier to parse.
>
> 		// eax
> 		u32	x2apic_shift	:  5, // Number of bits to shift APIC ID right
> 					      // for the topology ID at the next level
> 					: 27; // Reserved
> 		// ebx
> 		u32	num_processors	: 16, // Number of processors at current level
> 					: 16; // Reserved
>
> versus:
>
> 		/* eax */
> 		u32	x2apic_shift	:  5, /*
>                                                * Number of bits to shift APIC ID right
> 					       * for the topology ID at	the next level
>                                                */
> 					: 27; /* Reserved */
>
> 		/* ebx */
> 		u32	num_processors	: 16, /* Number of processors at current level */
> 					: 16; /* Reserved */
>
> Especially x2apic_shift is horrible and the comments of EBX are visually
> impaired while with the C++ comments x2apic_shift looks natural and the
> EBX comments are just open to the right and therefore simpler.

Aside of that it would make the struct generator in the CPUID data base
more complex.

