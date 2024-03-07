Return-Path: <linux-kernel+bounces-96229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC658758FA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B011F2121A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5765F13A279;
	Thu,  7 Mar 2024 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lr/ZqsuC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0I5TnNcy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C90E2376A;
	Thu,  7 Mar 2024 21:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709845395; cv=none; b=jVOyB6eR+6PbdW7eU1pUWwfOmD2mHqrYwREhpDV+jvWxuPYG0ewHSFgUxXSHnz73b6Vqzw6Qr+EXa3VZBMFOci0ry/2HtJZaTZDXcEZ7MZgQWL/S+Q/a96WLT/6qDU/jA35xezbAME7kzcQK+tdNnY8L9aaFDQQcsgl68gXwKHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709845395; c=relaxed/simple;
	bh=bbzmaYgVh70ecVw8vb6tXvfytQXTRz88/sO+hgGFjpM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lIjsoqGzfLS1K4BtoRHpWUftNrHItuOVd19zVAAyIc36F5QOjT5UrpaBMaRvD/ypQ0bDVRrknH8BMDiCeypOBKztb85bOrVuTfDwIj9FTv0lk8lu6PvGC6uZVa4iQF7oVIls4R2REgMrv9by+V0RbRKijg/bIojIMDytPFdbK9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lr/ZqsuC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0I5TnNcy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709845385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q3yCKZ0fMu8j0BuWFDPPCRn2jwTBHVks4xrfWGq48Ro=;
	b=lr/ZqsuCds4TsK9/nIk+SwHQ2HIFLSYy8t2O89C2liNSua8/g/+I9Y2uBL04KA7c4bOmZX
	GROFIER689kDxBIpbrsXTQVo7doIBwXal9KGRJxN6+30VChFNQSMPwGQVitl6nDrb8XiGB
	Jb237jkOV6ySGN5MQzb+9rrqnEJnWgDRSlmwtDTjrifYMAWwkF3UEYqNb/s6xeovGLD30K
	mB4PtHGZurTz0D5XGE3WWW63eM1lzr8EAsN6M9mf+/UB0/N+aL3GYnXbkLTNxSts1IXHkn
	yA1Ha8IqdnboICnWwuIKsDMk3QvhisxidWwXGUdoh8iGc73g9HE+skpKy5gDuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709845385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q3yCKZ0fMu8j0BuWFDPPCRn2jwTBHVks4xrfWGq48Ro=;
	b=0I5TnNcy2Me45QrWKSlDMYGm8WVdqeDhMZrEwCwknfuZye1/r2jjWoOw4rKr4xsvuqBbJo
	ZPDfk4Ax2jaS2aBA==
To: Anup Patel <apatel@ventanamicro.com>
Cc: Marc Zyngier <maz@kernel.org>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Atish
 Patra <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>, Rob
 Herring <robh+dt@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>,
 Saravana Kannan <saravanak@google.com>, Anup Patel <anup@brainfault.org>,
 linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, Conor
 Dooley <conor+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v16 0/9] Linux RISC-V AIA Support
In-Reply-To: <CAK9=C2UHbcnUoVvQFQzqCvHLngFsAi=4vaxaMM2+C1GoVxRa-w@mail.gmail.com>
References: <20240307140307.646078-1-apatel@ventanamicro.com>
 <CAK9=C2UHbcnUoVvQFQzqCvHLngFsAi=4vaxaMM2+C1GoVxRa-w@mail.gmail.com>
Date: Thu, 07 Mar 2024 22:03:05 +0100
Message-ID: <87edclu54m.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Mar 07 2024 at 19:41, Anup Patel wrote:
>
> Can this series be considered for Linux-6.9 ?

Sorry no. I stop taking patches which are not fixes or trivial cleanups
at rc7 latest. I marked it for inclusion into my post-merge window tree.

Thanks,

        tglx

