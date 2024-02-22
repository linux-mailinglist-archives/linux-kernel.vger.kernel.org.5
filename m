Return-Path: <linux-kernel+bounces-77406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE398604DB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB90BB212F7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7356F12D1E7;
	Thu, 22 Feb 2024 21:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E8IKGWFo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fDIU63ci"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51A371738;
	Thu, 22 Feb 2024 21:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708637643; cv=none; b=JQm7MX14UL2nG0kVqJfpjIusaTj/5z0ROUKboGTeba8ED4EQYKbQjKCHxImFageE+kMwKuOTiOMKEYGGgHTMGu0F9IpTwp7NpnLL9lUROQL7xP8TlhX5rSDmpxn229fI7SH1zC4tuRuoHh3xBhS386Q071C7geuLkB4QwjTd9L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708637643; c=relaxed/simple;
	bh=PrJ6YaFxatvY2iijd5Wqk9LxjgKfLoik+dqgECHQvCc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uonv+t4+HGuEb97sm1ymxd39DdydwpQzmY9S8RdNxenn0qc6MA52nfD7K/lHKMdfUjlVXOMR/+RK34SAfyECyEjec1gs7+mcUosSg/vJ+qOtM/3yUZCWZkLyouXjJtybYyK5q4LFFV/j5a2BFcsk1lF4ARiImkxy8t9kR4Ly7Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E8IKGWFo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fDIU63ci; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708637638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PrJ6YaFxatvY2iijd5Wqk9LxjgKfLoik+dqgECHQvCc=;
	b=E8IKGWFobvMuydi/MYlCGtioOqkIyOjB766pK5NO0O5XAbWMgtCQk2EakY7kz56uIkMp3A
	fJbScBQ7wtn6rKFXSCse7HAP0zIHNNRFq8Ui3HnKIRcHVv/O9A7dOQ6zsE4xtAO/3shZDu
	23y7JebnE1ZqgWTCB3f+GBIYWpf2KD4JcGH/n7wROMMpEU5bjsYRQQkyvREUxOWN/82puZ
	yudaq144aPD64IIrSwauXD1UAtqhEMgF3BHJg+rFhOCmk9oLQQttGgkoVbUWVsWI1tTVVf
	mqGzlP45wJkqZqOGx/jyqNSr6gyeRP5Z+KfnumjcBO+2r6ws4mpxbJxuDmtoag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708637638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PrJ6YaFxatvY2iijd5Wqk9LxjgKfLoik+dqgECHQvCc=;
	b=fDIU63ciUTcRIKaxF7jIPyC9HLb4PBqsycE7avUV7D+2/qWfEpyl+pqC54WNOiNeW+0k7b
	moIvBy70qNb/RwAw==
To: Yu Chien Peter Lin <peterlin@andestech.com>, acme@kernel.org,
 adrian.hunter@intel.com, ajones@ventanamicro.com,
 alexander.shishkin@linux.intel.com, andre.przywara@arm.com,
 anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org,
 conor+dt@kernel.org, conor.dooley@microchip.com, conor@kernel.org,
 devicetree@vger.kernel.org, evan@rivosinc.com, geert+renesas@glider.be,
 guoren@kernel.org, heiko@sntech.de, irogers@google.com,
 jernej.skrabec@gmail.com, jolsa@kernel.org, jszhang@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-sunxi@lists.linux.dev, locus84@andestech.com, magnus.damm@gmail.com,
 mark.rutland@arm.com, mingo@redhat.com, n.shubin@yadro.com,
 namhyung@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
 peterlin@andestech.com, peterz@infradead.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, rdunlap@infradead.org,
 robh+dt@kernel.org, samuel@sholland.org, sunilvl@ventanamicro.com,
 tim609@andestech.com, uwu@icenowy.me, wens@csie.org, will@kernel.org,
 inochiama@outlook.com, unicorn_wang@outlook.com, wefu@redhat.com
Cc: Randolph <randolph@andestech.com>, Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v9 02/10] irqchip/riscv-intc: Allow large non-standard
 interrupt number
In-Reply-To: <20240222083946.3977135-3-peterlin@andestech.com>
References: <20240222083946.3977135-1-peterlin@andestech.com>
 <20240222083946.3977135-3-peterlin@andestech.com>
Date: Thu, 22 Feb 2024 22:33:58 +0100
Message-ID: <87r0h4dvzt.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Feb 22 2024 at 16:39, Yu Chien Peter Lin wrote:
> Currently, the implementation of the RISC-V INTC driver uses the
> interrupt cause as the hardware interrupt number, with a maximum of
> 64 interrupts. However, the platform can expand the interrupt number
> further for custom local interrupts.
>
> To fully utilize the available local interrupt sources, switch
> to using irq_domain_create_tree() that creates the radix tree
> map, add global variables (riscv_intc_nr_irqs, riscv_intc_custom_base
> and riscv_intc_custom_nr_irqs) to determine the valid range of local
> interrupt number (hwirq).
>
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> Reviewed-by: Randolph <randolph@andestech.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

