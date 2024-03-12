Return-Path: <linux-kernel+bounces-100354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD5B879627
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB2C1286672
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC297CF11;
	Tue, 12 Mar 2024 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gkd42EZN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cD3gLAD+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112F77AE66;
	Tue, 12 Mar 2024 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253688; cv=none; b=ZKFPpmm9YA5Wo4QF5Puy07aklfxbO4NDYocrn1RN7U+noWHJ8RScbMu6b48JHFVIO4Fn5ljMGQptYlk+myczcadkPk3OPMLuvXmJDskK7Z4n2grXF9ZEuF9L8ABFuKJlFkXH1VAHak0JqdWMDgkabhnG6BExOF3ZJoSBf/y/U/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253688; c=relaxed/simple;
	bh=Jf+f71BudLnO/2W1fMmDx0pZd3N23SST9FD0UG7nlxU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KEh3eYRTLf+SlGbhPbcCEiYWq1Ov+ioIWL5gVl4oqzk//r+5HilnXdBHnlmGa1rvkYpNmi7BFarMbPrzSjpRhdT+VeV1m4C+oM2ZaGynDG1uCePJPqJDhTSslke2vrNvut4+MaM+aw1Nl8szF8TY5XFWMF6ecymxKKDiIzA3YgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gkd42EZN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cD3gLAD+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710253685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4XVmae+JgcDRh2ZKkyqUURMemYqkLUazTfEI4APXLG8=;
	b=Gkd42EZNkxkb0gExXtDTx7jWtBaTPBoUwDTCkVnine3q786/2VyXE+TFzta5tHdTvyY3r6
	0IppMKL/dDQgNVitWDG887sTq0mkp0YSMQMrp4J5KiWgryFdjcMAK0XI5+krNFTqqlkI24
	ZPRjAOpPr4JFL9A24qO2FEPoCqbJn3OsrOXd3gK9JhfIlb5jgABbKC+D0DhI1IH8SQtwqn
	VK/6/AA4WU+xKbG/bu3birdCHd/m1nZqp1Hl47hrjSXlrrTvsPkRZWmOqdhCXDTqi/hr1z
	nsXWLPu9GxRcJOS1zlHvRJfjTx0Qz1WpvPCqgOgeUuW7E13yopFjKq++prVDSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710253685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4XVmae+JgcDRh2ZKkyqUURMemYqkLUazTfEI4APXLG8=;
	b=cD3gLAD+A5hhLRuybrw9y36IXuxxC0wmJs+Kxm6eMNoqnmzJejztRvj6E/1wUaNsGms837
	7RFeuZJRKtJkUtAw==
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: peterlin@andestech.com, acme@kernel.org, adrian.hunter@intel.com,
 ajones@ventanamicro.com, alexander.shishkin@linux.intel.com,
 andre.przywara@arm.com, anup@brainfault.org, aou@eecs.berkeley.edu,
 atishp@atishpatra.org, conor+dt@kernel.org, Conor Dooley
 <conor.dooley@microchip.com>, Conor Dooley <conor@kernel.org>,
 devicetree@vger.kernel.org, Evan Green <evan@rivosinc.com>,
 geert+renesas@glider.be, guoren@kernel.org, Heiko Stuebner
 <heiko@sntech.de>, irogers@google.com, jernej.skrabec@gmail.com,
 jolsa@kernel.org, jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev,
 locus84@andestech.com, magnus.damm@gmail.com, Mark Rutland
 <mark.rutland@arm.com>, mingo@redhat.com, n.shubin@yadro.com,
 namhyung@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
 peterlin@andestech.com, peterz@infradead.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, rdunlap@infradead.org,
 robh+dt@kernel.org, samuel@sholland.org, Sunil V L
 <sunilvl@ventanamicro.com>, tim609@andestech.com, uwu@icenowy.me,
 wens@csie.org, Will Deacon <will@kernel.org>, inochiama@outlook.com,
 unicorn_wang@outlook.com, wefu@redhat.com, randolph@andestech.com
Subject: Re: [PATCH v9 03/10] irqchip/riscv-intc: Introduce Andes hart-level
 interrupt controller
In-Reply-To: <mhng-d47edbdb-0a36-4adb-9575-8af094d80e5e@palmer-ri-x1c9>
References: <mhng-d47edbdb-0a36-4adb-9575-8af094d80e5e@palmer-ri-x1c9>
Date: Tue, 12 Mar 2024 15:28:04 +0100
Message-ID: <871q8fplsb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 12 2024 at 07:23, Palmer Dabbelt wrote:
> On Fri, 23 Feb 2024 01:06:44 PST (-0800), tglx@linutronix.de wrote:
>> Contains:
>>
>>   f4cc33e78ba8 ("irqchip/riscv-intc: Introduce Andes hart-level interrupt controller")
>>   96303bcb401c ("irqchip/riscv-intc: Allow large non-standard interrupt number")
>>
>> on top of v6.8-rc1
>
> Sorry I missed this.  I just merged this into my testing tree, it might 
> take a bit to show up because I've managed to break my VPN so I can't 
> poke the tester box right now...

Alternatively you can just rebase on Linus tree. The interrupt changes
are already merged.

