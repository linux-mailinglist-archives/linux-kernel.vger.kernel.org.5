Return-Path: <linux-kernel+bounces-71461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6161585A5A0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6BE28566F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC5A374EE;
	Mon, 19 Feb 2024 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x1dqBjRW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZdgxCb3v"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3762E36134;
	Mon, 19 Feb 2024 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708352195; cv=none; b=NTqzzizkHS4pvWhzbjBfKhTpSST4ytESCwjMZvKzrKS+J71v0qiUClCRuZ2colNCJ3Oh84rVchx30fF/xktptZZfulbJmFqSFZrPTU+u2jRGZETZxVKN14A8OfR9QMrsF3rECpAZMkDZ62/6Yl0Y2pYxy+A/CDjIFfhTwMhweFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708352195; c=relaxed/simple;
	bh=ll2VdEEIJdgU2iOwoEg/qVtQNtknBgy9MWYwSiCPnk8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tKzMBu2Smv0jdbsBe6V2YbGvD+ae/fW7ysnxQe5ImG875rCX1ZIDHOPM7FEtqfEQBBHqRLz95DzVtxZlV0CGwL5dRMZndmrQCp87tU+M+JE8uEMTWBBxDBwgIZ7z8Aym4sSs7fr+5PlkY6EtTAWAxvaGxl8AUp3nXEPMXfY39jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x1dqBjRW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZdgxCb3v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708352192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xH4JzvZDylh2Zn1ZVDw/BnRi6fetrxAuJedKHz5rKTg=;
	b=x1dqBjRW3HGe19iGHfetAQ3/V+tdpcCr/UZBaSD5KfmFSPEWp0KaUEgqhRlr0jutsdTedd
	68p/CtcLWEmdrioBvgqPbtPYR+Qr83E/EZ65HxI8Sho68Hs/w97BUkrtC8OdJgJ9v/LS8a
	pVm17ABVkshmFpLpruXmW6XVmcec32qAxEUSMYjsZmnu1UKBYAO5zGD455qluuVTa8EhRP
	+nP9KsGN4AWwBWNSY8x+8/gP1EzZzjoWrlhyir9kJ+eVIw35Dei6c1WWTFqQBmBLz59FbZ
	x0nfm6xyh36frWSZ0Eq/7k/yUdS0N+hTg4byvftXWZzMjBPYW1o64yW7uxrRwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708352192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xH4JzvZDylh2Zn1ZVDw/BnRi6fetrxAuJedKHz5rKTg=;
	b=ZdgxCb3v/fmB0RsOoIgRyXhCnWLE/zcs96uNnuHnF75KAn+D9DQqiQY8yQeCtmpZNY9M+W
	y7bj8efFd6hkh8DA==
To: Antonio Borneo <antonio.borneo@foss.st.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Antonio Borneo <antonio.borneo@foss.st.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/12] irqchip/stm32-exti: Fix minor indentation issue
In-Reply-To: <20240216094758.916722-2-antonio.borneo@foss.st.com>
References: <20240216094758.916722-1-antonio.borneo@foss.st.com>
 <20240216094758.916722-2-antonio.borneo@foss.st.com>
Date: Mon, 19 Feb 2024 15:16:32 +0100
Message-ID: <87frxoa69r.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Feb 16 2024 at 10:47, Antonio Borneo wrote:
> Use only TAB for indentation, removing a leading space.
>
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> Fixes: 046a6ee2343b ("irqchip: Bulk conversion to generic_handle_domain_irq()")

A whitespace cleanup really does not justify a Fixes tag.

Thanks,

        tglx

