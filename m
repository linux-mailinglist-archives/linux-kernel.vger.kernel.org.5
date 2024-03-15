Return-Path: <linux-kernel+bounces-104503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA7087CED3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8137B2375C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EF1381A8;
	Fri, 15 Mar 2024 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZTLv3vY8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8d9dnjcl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D084F25543;
	Fri, 15 Mar 2024 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710512952; cv=none; b=sR7wnbemKAD4pvBnqmee5LH65QcxwHJD1IIrkg4L+iqmvR66IYlruNctsRVfrsZxwVCVkml+gSwW5R+ttNT+ZS6VyI28ABvX52ZFqsw/tq8dMxxdY0FkoNuxAmG+S/y/NIa8pWZEiC5VKpofSat2uCGO52gRUkzPNvu1i43AnFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710512952; c=relaxed/simple;
	bh=3owbwbA7LC4s1nBpSvyqPuPZl3o69XNTK+kKnae6XDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p5LEkco0HWANpsZo6vgUDMesgwAa3xb32qUR+WoBH/4qi5E8gf0wRCTuCzmvniqR56NW82SnyssBGCFyt52per2qqMJhm7fMN9xeGFnBcCD8wPCUSjUD3T6qhe+th3SMy9eQkGYp/t6hntG7BoD1O3d7Q2F+ygkL42AYU33dMs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZTLv3vY8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8d9dnjcl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710512949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xEaToLqBLfDE+R+pxwQzimCE7Et4+oa2DfTlEb2kMME=;
	b=ZTLv3vY8FChFMrE2V5oVJQgWng4zELUDixyTeT7k4PbKjASv75CqOKP07NRQyic79bJIy9
	1Dj/re077crcqIbKNSfKDB4a3In//QIH8RKC0ut3/PsaHP7PL/NOMkxbWVTd3hHvCDxfl0
	nj5GUOn5dPkvMnIDyvcTjhNZBkjhz4TdDApB0Lh6erhw8zfycAfEDgZuRHMBTL5Cfy19dD
	5mRTA0VMi5KjQnmO1M4d4Q2GYALW7b1F29AWaDU+2P2ImS68W2A7ZY51QIA18Du1uAfPFq
	C257pNHLb22JzCiKIo4B2/UktzpLJ5+mRYzsPjCV/ZUx6f7P5hKV6iwXjci/EQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710512949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xEaToLqBLfDE+R+pxwQzimCE7Et4+oa2DfTlEb2kMME=;
	b=8d9dnjcl2nsTLUL/EjSPc0hMSpYASxiGXq3Yax54cDvJdX9TcHaBWIqDJJww1ikIBdzsuS
	K+jObj2ooi1oO7AQ==
To: Stephen Rothwell <sfr@canb.auug.org.au>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the tip tree
In-Reply-To: <20240315080958.42ad2d91@canb.auug.org.au>
References: <20240315080958.42ad2d91@canb.auug.org.au>
Date: Fri, 15 Mar 2024 15:29:08 +0100
Message-ID: <877ci3lgaz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Mar 15 2024 at 08:09, Stephen Rothwell wrote:
>   4ce937160ba0 ("irqchip/riscv-intc: Fix use of AIA interrupts 32-63 on riscv32")
>
> Fixes tags
>
>   Fixes: bb7921cdea12 ("irqchip/riscv-intc: Add support for RISC-V AIA")
>   Fixes: e6bd9b966dc8 ("irqchip/riscv-intc: Fix low-level interrupt handler setup for AIA")
>
> have this problem:
>
>   - Target SHA1s do not exist
>
> Maybe you meant
>
> Fixes: 3c46fc5b5507 ("irqchip/riscv-intc: Add support for RISC-V AIA")
> Fixes: 678c607ecf8a ("irqchip/riscv-intc: Fix low-level interrupt handler setup for AIA")

Indeed. Fixed now.

Thanks

        tglx

