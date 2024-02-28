Return-Path: <linux-kernel+bounces-84312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DD586A4D9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F30A1F23A75
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309301852;
	Wed, 28 Feb 2024 01:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dJyOF1v6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sfyQEVc9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CE1EBF;
	Wed, 28 Feb 2024 01:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709083030; cv=none; b=dPEYbbJb/txVGovfkiaCrYSkc3HzlLaAamXXphFS4RSKsF6vKKgzhN64CuXwBEEgfS1MdhqXfTuIoP4lHoAQ3h5DDjYkxgp5F9B/B4Omg6lJZDwjtu2KY/l27iu0O7lDwOJRam8Su60B7+Metf29myytzVff8Db/ZPPm7WHXT8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709083030; c=relaxed/simple;
	bh=GlrWRft2zjOZR1DHUuRbrjc4zXkbHnkd4KRXZsq5PBI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jeGmuP5sgJbNS4tlykDpz/hjURLA6OfkJCt+Bp071LWzY2q1r46Qn9fdAg+L0nYX+OWd7x+o4q68DwY60MYxak3ar5ldi6CUGq8nMoe9UEIrOqwQdSbCuOFM3anRfN/9EpT+8PvnZariyEZlLLd6u2Iy3d0KdLf6fc+QV0o8rrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dJyOF1v6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sfyQEVc9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709083026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zDLJ5PCaooMP5sZjG8MJLQsp+tm97JokYiiAFtypwkQ=;
	b=dJyOF1v6zuD051FhXl7zkodB99ePkw0VfLJ5+oq2ql8DG3mPNLmAvfJqV/aXhH1iXi9vTI
	DiLSx8F26xZ/ZRSKVp5zV6Ig1zNCC/OTUqdIpHXd/kA41DxU/gnwQIACSh5TKTvPTAl1G9
	VJFyB9DohwOUC2OEnW3/B6Be1pdcjIzVXotvQnkfNtu6+cRzpdLxcokXu82XPDzhqw+3BI
	UIB6T22Mdn2sVMeJVL1W9UGZBnQ4EJbKSHCgzSkDRf8DOZ29p6r6ObtJwynHPJbB9O4qGA
	yUY3s0VtO8AXKyzrDJIeyd92a0ha7sAtc2Q+P4mjAM0YxQzSpoDPWI6RXPY4Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709083026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zDLJ5PCaooMP5sZjG8MJLQsp+tm97JokYiiAFtypwkQ=;
	b=sfyQEVc9bqgsvum0F30bZ3PD/r8OYLTGaGkiwzFH2VOwCHvnWxW8+iZx3HH0cKSECdILmd
	CHURrok4SW943xDg==
To: Stephen Rothwell <sfr@canb.auug.org.au>, "Paul E. McKenney"
 <paulmck@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin"
 <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, x86@kernel.org
Subject: Re: linux-next: duplicate patch in the rcu tree
In-Reply-To: <20240228120610.0fdd20af@canb.auug.org.au>
References: <20240228120610.0fdd20af@canb.auug.org.au>
Date: Wed, 28 Feb 2024 02:17:05 +0100
Message-ID: <87jzmp8k1a.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 28 2024 at 12:06, Stephen Rothwell wrote:
> The following commit is also in the tip tree as a different commit
> (but the same patch):
>
>   020eee167cca ("x86/nmi: Fix "in NMI handler" check")
>
> This is commit
>
>   d54e56f31a34 ("x86/nmi: Fix the inverse "in NMI handler" check")
>
> in the tip tree.

And why the heck is the RCU tree carrying x86 specific stuff which has
absolutely nothing to do with RCU?

Just because, right?

Thanks,

        tglx

