Return-Path: <linux-kernel+bounces-61873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C8F8517A4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63691C218A1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DB13BB31;
	Mon, 12 Feb 2024 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WY2nOOXl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uLQ3jf8I"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCF33B797
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750515; cv=none; b=Qxl8mc3Qzs+Y3IJQ3gbSBE6Ssnvp5uwSGaTBprOiCkxbEG75h3ekGAO+oh3ECiTUEn/4yxQOACkUfWbBG9WlqvUwBlCxyJm/DI+rKH+UczuHba6akZgaW+PYOiqjAC7iCpF0RiBLUDJuIUyFYwolTC/NloRmyrhvki8PT5aGZlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750515; c=relaxed/simple;
	bh=/rvn5jicE71XyqvaOd7yAVNV1Vin691oFFChx0vgNUw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a9FlAqnN3n33AxiBObIEVJoDwlJPEbwig5uxd0FUoQoa+St2Y2FoVhhiRYB2CWTaUslJz4GwI1/VcWwmrB6nhLQ4joT2IC2PFIXYYmg4KJ1YVDnwFJ/l0LJgVx3s8lC44D/rkrw9PDmxe4QpE1LrIgUI0oL+x7xxP7UxLNIejQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WY2nOOXl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uLQ3jf8I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707750511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C3NiDZ+KHPgo640GV/RsQI0vce8s6DSpW2uzrRS6dmA=;
	b=WY2nOOXlSebe5e1JYkmk0ykHg9GrGIjsEtnLGngNEEslOVwCE4Vm3JokH1qONzJTrpziB8
	weEWerFFmvAKYb6LScYt/AJTiNHq/HCZSi7x5E83lhDqjH68YtE/SdhdvUm4r+QTwa7gmd
	8scppCBk2qoRPXD10UXv8+tQU9zEaeNVmt2j05iyXIfc3Typt/VHGG4JnC5OtJaguEVeVr
	DC+ZMJa/PUFcT0bdbJyHpTJnzqb4TQY5sS70ms7V56zW2NDtCKPv3iqWOZgB0hFMOrVOOU
	odE/dbQZavGhqDd/OCUgIUe6chioHeFG5M4iKzYDfG7YkBPcicesMZTPJYqYBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707750511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C3NiDZ+KHPgo640GV/RsQI0vce8s6DSpW2uzrRS6dmA=;
	b=uLQ3jf8IP2FaT6Kmm8Ud/6bOJGaxVphsPr6g9fQPOU5FoYyAiXioVa9+4Ur7pvwJ5Rm6aT
	dCpv3+gygDAkD4Bw==
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
In-Reply-To: <20240212150053.GEZcoypaBQPB1IcZGY@fat_crate.local>
References: <20240117115752.863482697@linutronix.de>
 <20240117115908.674834306@linutronix.de>
 <20240130193102.GEZblOdor_bzoVhT0f@fat_crate.local> <87il2tlqba.ffs@tglx>
 <20240212150053.GEZcoypaBQPB1IcZGY@fat_crate.local>
Date: Mon, 12 Feb 2024 16:08:31 +0100
Message-ID: <877cj9lnyo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 12 2024 at 16:00, Borislav Petkov wrote:
> On Mon, Feb 12, 2024 at 03:17:45PM +0100, Thomas Gleixner wrote:
>> Especially x2apic_shift is horrible and the comments of EBX are visually
>> impaired while with the C++ comments x2apic_shift looks natural and the
>> EBX comments are just open to the right and therefore simpler.
>
> I'd say, put comments *above* the member versus on the side. We don't
> like side comments, if you remember. :-)

In code, no. For struct definitions if they are strictly tabular
formatted, they are actually nice as they are more compact and take less
space than the above member variant.

		// eax
		u32	x2apic_shift	:  5, // Number of bits to shift APIC ID right
					      // for the topology ID at the next level
					: 27; // Reserved
		// ebx
		u32	num_processors	: 16, // Number of processors at current level
					: 16; // Reserved

versus:

		/* eax */
                	/*
                         * Number of bits to shift APIC ID right for the topology ID
	                 * at the next level
                         */
		u32	x2apic_shift	:  5,
                	/* Reserved */
					: 27;

		/* ebx */
                	 /* Number of processors at current level */
		u32	num_processors	: 16,
                	 /* Reserved */
					: 16;

This really makes my eyes bleed.

