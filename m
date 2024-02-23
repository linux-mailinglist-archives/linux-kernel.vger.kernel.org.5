Return-Path: <linux-kernel+bounces-77946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6168860D2D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23E0F1C2292C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0779A1A701;
	Fri, 23 Feb 2024 08:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WDQSYdJN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zmqCjShl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0041D18E11;
	Fri, 23 Feb 2024 08:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708678182; cv=none; b=KT1IBpQlZqRcyW6Td83t6+/RKT36MIgCMOz0UJ68pZsLC3jmqum+EJTUsa7ZCkrS6DhGPbJGRA+WqOQTzLLdYAB7htwOMbIJREtu6bmO890NbdnelELucTsxZz/lRCbWA9boptJENzxvTji46yPTTzmycNP3KushzATtPf5Lt0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708678182; c=relaxed/simple;
	bh=1Mwo8knrNwcUNyLOs2vDQjrp8LUcUoI9+o8mZdYrUio=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g59owadOwFI/HiAFgQ50Vp4gf0HMUHy9uUfANGNWS2zl+3GUGZOIvWMwy+ALj1LAWjqryVkEuA61q8M3SIccsmUUppki0VkndzUQ6R3J2w7U5iMn1FmMaqdahfbml51c+AmD6oIBZSFSohdvhxFtJrK0SBoX8sziv/6vLlfJ5tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WDQSYdJN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zmqCjShl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708678178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vNmFwVS5XAceDnohqFy+IAMBF11KyZ6r2KWYJrBWXE8=;
	b=WDQSYdJNE7KB1loQwm7NXyaz42xsOdADLSbKnDPfOGT488YF42+RDZ0TL2fHu6Pn9m2Gvr
	hzfu9+EHBUaWJdgLImrfL3BD5SE9cXhinLBRw6jPnuKTLw8+GFkREKHZGxel2hxO7uCBVg
	4iP7sT6RLpjAqCzlzcm8i2EHL7EhbCV3Ct7yZv5GFmt4rW7bkzS24o/J8mT4mq4pWbzxsp
	CVhBWRE8Ge9x4q0WfLrU2XDLUGS2+Dq9A2u5P+sqi8XiKBqEv7MtwnWDnU/laIWNgqIM7T
	rwkDU4JB3fJDGCSKV+WbN9v+WngZukZ2qsfNfc3EWlu1w17E7z+UuxpcYnHxxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708678178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vNmFwVS5XAceDnohqFy+IAMBF11KyZ6r2KWYJrBWXE8=;
	b=zmqCjShl7l6tJAOsDJ+efEVxrr1uXCcMteB/fuXZejOarW0ha8dUCYEuv3yfXSbMPNigm8
	1KNRL/SBEt99JbBg==
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
Cc: Randolph <randolph@andestech.com>
Subject: Re: [PATCH v9 03/10] irqchip/riscv-intc: Introduce Andes hart-level
 interrupt controller
In-Reply-To: <87o7c8dvv4.ffs@tglx>
References: <20240222083946.3977135-1-peterlin@andestech.com>
 <20240222083946.3977135-4-peterlin@andestech.com> <87o7c8dvv4.ffs@tglx>
Date: Fri, 23 Feb 2024 09:49:38 +0100
Message-ID: <877civefa5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Feb 22 2024 at 22:36, Thomas Gleixner wrote:
> Palmer, feel free to take this through the riscv tree. I have no other
> changes pending against that driver.

Aargh. Spoken too early. This conflicts with Anups AIA series.

  https://lore.kernel.org/all/20240222094006.1030709-1-apatel@ventanamicro.com

So I rather take the pile through my tree and deal with the conflicts
localy than inflicting it on next.

Palmer?

Thanks,

        tglx

