Return-Path: <linux-kernel+bounces-72791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C599B85B8AE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65E991F23D7C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00AC64CF2;
	Tue, 20 Feb 2024 10:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eDB1pBdZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="evAVoWIL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E8460ED9;
	Tue, 20 Feb 2024 10:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423883; cv=none; b=iZWcHKYnEwPJYUlM51AUR7OLN4H6emhgyAQbhDLlQ0fBopn/sZsHjchlmSlimRnY6WN0k+iRhxH4wEgb+XNB6AHQ2z35jt5Wi1o+9vFEZH9PqGkNMRD2N0LZJ8GM0SwVSR6rmcDWsNZNQTbUp3GmFzBv5PTbZx40/NzsV3DlnyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423883; c=relaxed/simple;
	bh=L1g1X+C35L+9q+i1TRp/4imMANNNfHvR1BbqTEm1l0o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dx/OMgRXbch5RBozD3uXaCbyOF9MEu0AUKNA4i5R3paqNdb2tRG/nAW+IOc7pnddSvEY5JmdOTN0BSPFXsM27D1IDtG2mARE8i3NWJ8QQsLinmixEQAcZUGmpNih2PZSHosnLyY9ACuthyO4520F2sFpyda7N8RM9mGtTxN8fEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eDB1pBdZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=evAVoWIL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708423879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=in6V0tATuxP4n7VcDzSoSG7lzzMjrpnmMLAUnJYqlUI=;
	b=eDB1pBdZjBtgeBM0iMFA3XI4L1yWTD9h1FpaSKMOqIrO3YUNxSpQ8W6D0zUtWuz6Ng8uJV
	io4eno98m107yXtFUz41S+1anbi/0JdvGBNir5BY71ERzMiIuoyIqUulIG5a0jGfU3zmXq
	x0CROufbYLfSXQcLYpOP22m1x1lKSy9alWKsKabMGjckr7KTRf8AJnqDdhOA4y/L5c+VYI
	TSS3UnnEL9Mx9yY0hzVIt1aqM+XAt9vrxGtG2oVJS950lm+HJbKWOBjJqEOB22So6wWDbb
	lZwxe1i0Cad4cI+KCsoDi+utl27jklszyBnLwfWgUmTM4x7Sv6739FgoVua85Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708423879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=in6V0tATuxP4n7VcDzSoSG7lzzMjrpnmMLAUnJYqlUI=;
	b=evAVoWILlx+PTEd1aPDdZd+kDLc77vRgr4NzPJTBR+bDTjDQxg3aekt1yJMur+8M9Zbakr
	SwPdNTN3Pw3TSDDQ==
To: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand
 <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Atish
 Patra <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Saravana Kannan
 <saravanak@google.com>, Anup Patel <anup@brainfault.org>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Anup Patel
 <apatel@ventanamicro.com>
Subject: Re: [PATCH v13 02/13] irqchip/sifive-plic: Improve locking safety
 by using irqsave/irqrestore
In-Reply-To: <20240220060718.823229-3-apatel@ventanamicro.com>
References: <20240220060718.823229-1-apatel@ventanamicro.com>
 <20240220060718.823229-3-apatel@ventanamicro.com>
Date: Tue, 20 Feb 2024 11:11:19 +0100
Message-ID: <87frxnigxk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 20 2024 at 11:37, Anup Patel wrote:
> Now that PLIC driver is probed as a regular platform driver, the lock
> dependency validator complains about the safety of handler->enable_lock
> usage:
>
> [    0.956775]  Possible interrupt unsafe locking scenario:
>
> [    0.956998]        CPU0                    CPU1
> [    0.957247]        ----                    ----
> [    0.957439]   lock(&handler->enable_lock);
> [    0.957607]                                local_irq_disable();
> [    0.957793]                                lock(&irq_desc_lock_class);
> [    0.958021]                                lock(&handler->enable_lock);
> [    0.958246]   <Interrupt>
> [    0.958342]     lock(&irq_desc_lock_class);
> [    0.958501]
>                 *** DEADLOCK ***
>
> To address above, let's use raw_spin_lock_irqsave/unlock_irqrestore()
> instead of raw_spin_lock/unlock().

s/let's//

