Return-Path: <linux-kernel+bounces-71467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA8485A5B7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF98F1C21DAD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A5B374EC;
	Mon, 19 Feb 2024 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="frQ8kNRh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sODlc3Kt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ECB376E1;
	Mon, 19 Feb 2024 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708352392; cv=none; b=Cidlx8tu0+bNZ8tR1EW/zdXvPUPfU9bQaiYPiuSeiZLD6EFRA7sVn56pfl3j2RlcrOLCQY1vj7fyqMjHCDNAUjQvxIIJbaKbEZ/Mmgf0NsDK40r/xJ5+ZzClacu9ZseIaOdGPwyZnCf3Tj7GgUyjsO1q6shV1kAMkKqg/wyEdcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708352392; c=relaxed/simple;
	bh=KYu8RMq70hHuIXzylNTw9t0x0hxX6OG/Bxv6l8o5iII=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vc1Ua/Xk2Ukn4LsBlje6TwBsvv8KdZwiH3DwocjwBSY6U1t4CjPbxIydfyCEXU3WLV4j83WFxvf4j0lbxrHqwcOMIfu5pGditMvY8F1iUjRct2vYEEyMc0SPB+xt3KpJgpWO9DAHVn8ZFAYixxop6z2d47KZiHU2jY1ezsUJaPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=frQ8kNRh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sODlc3Kt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708352389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4BDaZLTqv8flVHLwBSBJzsZbl4g4KjMo2i9irEnI714=;
	b=frQ8kNRhOUDh9H45iDzVKlbTHnj6Y0VsAOHRIlY49tvj1LZNBXe+PezwDEnItsNxMZsh8p
	2Z5aLH4SCKuy2M/5lqgziKmvuYJURIi1JhwdjVbpY5R50hzu3C0w0766Z5r3NjGc/EmH0u
	/+uMF5UYZpy3HFGPj+0PRHsvkTMYMDr1v+dNdWHdbdEgPq3Ouote5UJRyx5xnv1VzH93do
	sI80DW9bltBOzL9W4dB7am3ieelxqr1yI6uuTZPnEOw1XguJg/xArA9RIyITsvIj/LyLWY
	LKILtM7XbgSL4Y6cmISaVsS2PaCH1ELIzlzS6fWg1j3ZNTcxZ32YnFFyciRmeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708352389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4BDaZLTqv8flVHLwBSBJzsZbl4g4KjMo2i9irEnI714=;
	b=sODlc3KthGTOnTfdZReeQ2PwJhyHyChOWXADSoZEp8mz7uT5blWEZDsmWvtvbQZl7Tols7
	XVU/WmdT4Aw/EtBQ==
To: Antonio Borneo <antonio.borneo@foss.st.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Antonio Borneo <antonio.borneo@foss.st.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH 02/12] dt-bindings: interrupt-controller: stm32-exti:
 Add irq nexus child node
In-Reply-To: <20240216094758.916722-3-antonio.borneo@foss.st.com>
References: <20240216094758.916722-1-antonio.borneo@foss.st.com>
 <20240216094758.916722-3-antonio.borneo@foss.st.com>
Date: Mon, 19 Feb 2024 15:19:49 +0100
Message-ID: <87cyssa64a.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Feb 16 2024 at 10:47, Antonio Borneo wrote:
> The mapping of EXTI interrupts to its parent interrupt controller
> is both SoC and instance dependent.
> The current implementation requires adding a new table to the
> driver's code and a new compatible for each new EXTI instance.
>
> Add to the binding an interrupt nexus child node that will be
> used on the new EXTI instances and can be optionally used on the
> existing instances.
> The property 'interrupt-map' in the nexus node maps each EXTI
> interrupt to the parent interrupt.
> Align #address-cells and #interrupt-cells between the EXTI node
> and its nexus node.
>
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

This S-O-B chain is broken as it suggests that you wrote the patch and
Fabrice relayed it.

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

But that's not the case. If you co-developed this with Fabrice then
please use Co-developed-by. See:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

Thanks,

        tglx


