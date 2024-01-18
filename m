Return-Path: <linux-kernel+bounces-30495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8DC831F79
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0128286FB4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5496D2E3FF;
	Thu, 18 Jan 2024 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vAl+N9Je";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0abrX3sC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51343A53
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605037; cv=none; b=tZlB1d6/cMvCxGNA2KU2GB4moL3k4o1FGw9DKcHHk9N8J5v5JOMYzinv6WiIQQnekafWXfMKMLJH+RjwIP77mt3pjj0a8L8GV1UhWew867GkM9hqjMr++qk7bCGZjzBx8xCvQvdW+KCmjsm5CeUaX2aKHECIqxNsbAMiydXAa40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605037; c=relaxed/simple;
	bh=WV70zRfG4XpA6ugA8D+dQY1mNxqDB4rrPNevP5E9Tvc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nAxncaZvnOpaJBXBl68WdvtIAPu2uSrnSUY4ixZOubevxvabpcp5vdLJBV2oRy/xxB6TB8qRRpGUb6sFNBogDHiWV4FRL4wnhV7zEWMCeUSoXygC5VY6OropWLtdxuUqKqLgBFwqFtHJSjsJhjOnB62EwVhSfuhSn8nn80qJC0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vAl+N9Je; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0abrX3sC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705605034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WV70zRfG4XpA6ugA8D+dQY1mNxqDB4rrPNevP5E9Tvc=;
	b=vAl+N9JekCi/KC9ANbydrYk7de6GTpdIPwUmV8ekeABHSto9XDF/GjWn3Q3V3Ha+OZCSVK
	NzpQyA8OtW7ilGPoyL4dZJCjge7IrOryVVI4jd3sNAtKUR3zYWpdaUJBrnYiPpPboZLGz4
	FxjZxr5lF1i13BSQWUymhzzUphtQxodQLM8Ui9KrqGGeFjCucKG06quFN+JOO8Ivy+xTRC
	2Uvek9w28gGWJs6nq14xIxIlTyuSSyQQ3Reh/KkP0M9TPqgvWSjB9/vPHnx5dpyfXqtyJ7
	+y/0U4vqJXhHM1dNX6LEMtXkLhLZpWEGlrg9J28VzEi+8xlywFoxOmHcLaDSvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705605034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WV70zRfG4XpA6ugA8D+dQY1mNxqDB4rrPNevP5E9Tvc=;
	b=0abrX3sCdMGU5lXB8+IR49I/Cr/Oi9H1skotXC7PbPx9+r4soKigQiotiVFdSCK/btjQg0
	Z3+qD8mvR+wxKQBQ==
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Arnd Bergmann <arnd.bergmann@linaro.org>, Randy Dunlap
 <rdunlap@infradead.org>, Tony Lindgren <tony@atomide.com>, Joshua Yeong
 <joshua.yeong@starfivetech.com>, Sia Jee Heng
 <jeeheng.sia@starfivetech.com>, Inochi Amaoto <inochiama@outlook.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] timer drivers for v6.8-rc1
In-Reply-To: <3eace156-b097-4076-a585-e7a61d798fc8@linaro.org>
References: <0f07af92-e4b2-48de-88a6-dd9aa9e49743@linaro.org>
 <3eace156-b097-4076-a585-e7a61d798fc8@linaro.org>
Date: Thu, 18 Jan 2024 20:10:33 +0100
Message-ID: <87il3qfoeu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 18 2024 at 12:50, Daniel Lezcano wrote:

> Hi Thomas,
>
> it seems this PR was not taken into account.

Correct:

> On 01/01/2024 19:21, Daniel Lezcano wrote:

I was on vacation and cleared out inbox on Jan 8th knowing that all
important things will come back :)

Let me take care of it.

