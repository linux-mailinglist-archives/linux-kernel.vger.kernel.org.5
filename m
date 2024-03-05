Return-Path: <linux-kernel+bounces-92675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 150EC872412
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7CB1F220D0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9EC12880D;
	Tue,  5 Mar 2024 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KS5qbk7m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mqNDQ/LQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93A2128370
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655740; cv=none; b=eDtTynYHX1C/BvjzAHgi691VOl2jzXK4dGTElmT0AFriRmlnrNxicZJnxzhPV4Cd9eSjh2J4vTtEKhDGXWxo2sEFZh/SqjY3hf+mR8cJFIFlRjB9PYsOGLQ3+BC8CBHGO8p4+KdsKrd0KvTU0uMdxQpK2X51BLz1QlzFLvn6l8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655740; c=relaxed/simple;
	bh=gtC0RZy2ucxfsmBeQ86VFebjkMyssVri9al0wcWgXkk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DuuPAriyVCO+sbPsId1zB+2YlfBnAcBgu8lX8e5TWM0PVDptGO/NCiXKm/lHiKhIJWoPvKkGOLsPrsnC7uVk29ixb1e1Wx7ccEm9YLj6jkCZ//Wk/EIEapmdBA9KMUAT2OT0OF6LUWBsE7ic/lnMC92tvPijODIoFyguPp9Tc74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KS5qbk7m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mqNDQ/LQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709655736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gPaYZu1ZJgqkEmBUOLNfaZez3N3u9RgphNBODKwfEcM=;
	b=KS5qbk7mLOabfmZC/Dp3Waebh5uFxm8rj7eK8+mijZGXybtPyXWOhw1Q7CllnC2gWeCYMJ
	YPmhtbYg0ED1cfnD/wFO2O1wFOaTR1fHAP8cEzrZQZzRBT7cd11gfMe6ZRaOlYBwD51EVs
	wpGuU9z+TkSKSy1YTdrryfaEhRGG0Hz0/C4qzC5EO2xuefDOS9kA88WVnzW6ODAKcXap/l
	iULqAs4njvV2McNYwB6uW07b640KVoT2dz/pq7QuI7NIfghW6NGVbAYDG81+N+Ep2jtRRx
	+0PAtwwt6Av/3fOQpD3UDjfUUY8rh7JHSPWW49JYal+3qC3IwWMvlLjg0t13uQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709655736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gPaYZu1ZJgqkEmBUOLNfaZez3N3u9RgphNBODKwfEcM=;
	b=mqNDQ/LQ0YkSNFgkKxse6qpRkboIvRLdE+Qu0ySEdh5gwDERegpPMhbzLZrAo9m2kC1KN5
	KcKoJ+P44oCYGPCg==
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, LKML
 <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] x86: disable non-instrumented version of copy_mc
 when KMSAN is enabled
In-Reply-To: <06c11112-db64-40ed-bb96-fa02b590a432@I-love.SAKURA.ne.jp>
References: <3b7dbd88-0861-4638-b2d2-911c97a4cadf@I-love.SAKURA.ne.jp>
 <06c11112-db64-40ed-bb96-fa02b590a432@I-love.SAKURA.ne.jp>
Date: Tue, 05 Mar 2024 17:22:15 +0100
Message-ID: <87msrcvebs.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 05 2024 at 20:31, Tetsuo Handa wrote:
> This is current top crasher.
> I hope this patch is applied before the merge window opens.

Maintainers have weekends too. The world is not going to end if this is
not applied within minutes.

Thanks,

        tglx

