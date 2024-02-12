Return-Path: <linux-kernel+bounces-61813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6B08516DC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39C1D1F225C0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD793A8C9;
	Mon, 12 Feb 2024 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f7vKC4QU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jIMdFGYe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB2628389
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 14:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707747468; cv=none; b=JY0pg9YfizyetUiAHDPBxXUlAMPT0Nv5toOVjjb7z7ktNWdkUaqNweD4SGHGsRdw6JGFPLESwyaYuXS4e/1T4GJEHh2c2z2vm/O+JdgcZwr7omYnvUTcxjT4MyE5hJ3YBdY7pqcAgI5K1fFNknjjmDbLTH+W3MWETbc4X/DB4DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707747468; c=relaxed/simple;
	bh=DxSwt9iZBh6O5oJA9uNksjmEYo7rwQkzPNsEYq66jGg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tzoAuz1hTqIqjJYiWdJHsLpvjHrLISY+eu5KG3RyxFMhXmlKgUkcYzzdDhcNVOx1OJ9aAnvzIWWczGKEUFawXr3Lmixnn+19jOegNx9c0TMvwXEO7VAGIyou5laXpu7ZBVTc5v8dSCwHsyIY1ExbCjRGyTiAO0qxMXd2lm744JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f7vKC4QU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jIMdFGYe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707747465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ci9Orws8yhzt/mZLpwKS8scViC6jaadfkxVx1RN+PuA=;
	b=f7vKC4QUWC8/mQD/UzVY4chx2C1OFUGLYBHIKZp40amA2vpSvcyf7ZZv/+SqZo35U5AlrY
	SYjzrAmdLYsyI5xUNAsLiQwm1qro80KowqV6uQrWXYl4Z6R14CZTLbWKAn7amvNAE2DtZn
	xPEjN6MT/WoVhN+1W9lds/wzQ7E/hg5OXsH0N9FdgtEI8rKALXmBUWs4094HeZpkuDPmIL
	yJbxxDaGvlRusqNiUZJl+lPh8PjjdVmdebFGBS3TfTZbDYV8EkCpBkTBH7AfdcjsDemaKP
	j2SwygABMW0yp+m1PcYP4dQO7ubrHqQNEQCGH2X1KyuRd2+nYKy8Huk0tzIsYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707747465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ci9Orws8yhzt/mZLpwKS8scViC6jaadfkxVx1RN+PuA=;
	b=jIMdFGYeftIy9fjnr9J4akvGt9l0ZCH8ZJkLdjPGecpSLiH9jBI2NkKinGkFV0tE7LHJ+D
	2tgyEM8YcNLB83AQ==
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
In-Reply-To: <20240130193102.GEZblOdor_bzoVhT0f@fat_crate.local>
References: <20240117115752.863482697@linutronix.de>
 <20240117115908.674834306@linutronix.de>
 <20240130193102.GEZblOdor_bzoVhT0f@fat_crate.local>
Date: Mon, 12 Feb 2024 15:17:45 +0100
Message-ID: <87il2tlqba.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 30 2024 at 20:31, Borislav Petkov wrote:
> On Tue, Jan 23, 2024 at 01:53:39PM +0100, Thomas Gleixner wrote:
>> +static inline bool topo_subleaf(struct topo_scan *tscan, u32 leaf, u32 subleaf,
>
> "parse_topo_subleaf"?
>
> With a verb in the name...
>
>> +				unsigned int *last_dom)
>> +{
>> +	unsigned int dom, maxtype;
>> +	const unsigned int *map;
>> +	struct {
>> +		// eax
>
> Can we please not use those yucky // comments together with the
> multiline ones?

TBH, the // comment style is really better for struct definitions. It's
denser and easier to parse.

		// eax
		u32	x2apic_shift	:  5, // Number of bits to shift APIC ID right
					      // for the topology ID at the next level
					: 27; // Reserved
		// ebx
		u32	num_processors	: 16, // Number of processors at current level
					: 16; // Reserved

versus:

		/* eax */
		u32	x2apic_shift	:  5, /*
                                               * Number of bits to shift APIC ID right
					       * for the topology ID at	the next level
                                               */
					: 27; /* Reserved */

		/* ebx */
		u32	num_processors	: 16, /* Number of processors at current level */
					: 16; /* Reserved */

Especially x2apic_shift is horrible and the comments of EBX are visually
impaired while with the C++ comments x2apic_shift looks natural and the
EBX comments are just open to the right and therefore simpler.

>> +	if (!tscan->dom_shifts[TOPO_SMT_DOMAIN] && tscan->dom_ncpus[TOPO_SMT_DOMAIN] > 1) {
>> +		unsigned int sft = get_count_order(tscan->dom_ncpus[TOPO_SMT_DOMAIN]);
>> +
>> +		pr_warn_once(FW_BUG "CPUID leaf 0x%x subleaf 0 has shift level 0 but %u CPUs\n",
>> +			     leaf, tscan->dom_ncpus[TOPO_SMT_DOMAIN]);
>
> Do you really wanna warn about that? Hoping that someone would do
> something about it while there's time...?

If it's caught in early testing, this should be fixed, no?

Thanks,

        tglx

