Return-Path: <linux-kernel+bounces-133078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60152899E81
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3472B23CCD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588C316D4E7;
	Fri,  5 Apr 2024 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bUPytcyK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Ha3b15v"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE7E16131A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 13:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712324311; cv=none; b=rQAfbZ3u6YIxgFK9quiq4IFUy0jHt12jJbFxVqkCJNhUDJYJ/frup29XZ8BYXF8GjUGEDOtSeix1B8N3J8DEVOnvghEI4U1smFb2OcjAyAjXb4BZAAtTCdZ9JFudKepPv/f6SepZcJqYuRP4/zEcRUGfisU0CNaePUVv1FyY7uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712324311; c=relaxed/simple;
	bh=gVVkwjKSOSxE1WHVk8TRtXqBvz0cu/8FQsy/IAjzn/c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=O4/itNjhsaQ/10mpx2wc4ORueH+q5L8lN4OtXztiNeJRz7Br/ux3N+c4RIliOVsC9tGe5TWAE/Ne+Zar58BHI+M52Clzz7Z7iktikK83MIVOS2Tp1x1SstdxNdEs/bq0bWcvaB8VAbF24K2a8cReCJrOdPLMQLcuIv9sMPru6rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bUPytcyK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Ha3b15v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712324308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=Hu+U42+S4zBToBDAuZQBhuX/6fAEhCT+vYDnuINULMY=;
	b=bUPytcyK3mjgIIOAciWJo9paiQFg5lDtJxUWHeFxyizTYPYpwHeTmT+pw0+vzCF94/46cQ
	nmxHn4xQ7n/Jb0XtsuEc4QXisAPoxmjdU6eoPZcNfPZVGrI/r/blko3r3vg/+dRcY6YIlS
	UwcyBPPaiC3TxwHJoMK+UyrA0q3RP9gUnB90NkaJnZYvTvTB6r7DNZqqBZwQbtrKC9GqN2
	EVUxeaw0sqeCb3ovmKRNy/jE648FyzOzMnGfzrDKWgeWIz7NVgs15vU1QD5MzZbWn47IWL
	IxBTqZl0zjUJhjNXaetH76zgBdHAEiyilch5ViP/9xOC13hkfba3CfgHMk6ABw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712324308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=Hu+U42+S4zBToBDAuZQBhuX/6fAEhCT+vYDnuINULMY=;
	b=1Ha3b15v8LcJ5G1pG3EdungRQHgLsiVnq/wE2lRYST1jQcxoGrpeVT3lPsjWS8H0ZEqXk8
	nunPzAZ7+i8akhBg==
To: Laura Nao <laura.nao@collabora.com>
Cc: kernel@collabora.com, laura.nao@collabora.com,
 linux-kernel@vger.kernel.org, regressions@leemhuis.info,
 regressions@lists.linux.dev, x86@kernel.org
Subject: Re: [REGRESSION] mainline boot regression on AMD Stoney Ridge
 Chromebooks
In-Reply-To: <20240405103233.268999-1-laura.nao@collabora.com>
Date: Fri, 05 Apr 2024 15:38:27 +0200
Message-ID: <87ttkg7wvg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 05 2024 at 12:32, Laura Nao wrote:
> I also tried applying the patch you attached above on top of
> next-20240404 but it doesn't seem to make any difference unfortunately.

As I said it won't help, but it fixes some other issue.

I'm still puzzled and trying to make sense of this.

Can you please boot a working kernel and provide the output of:

# rdmsr 0xc0011005

Thanks,

        tglx

