Return-Path: <linux-kernel+bounces-131480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFD489886E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9817C28F6E5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B101272B4;
	Thu,  4 Apr 2024 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qkya+Uxp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="264OAWp4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B364A1E4A2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 13:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712235696; cv=none; b=p7a+iglYkBitjW7foZUrAYvr+tab5jJX1pUon2nXrwTOOqcSmEOueGXKTokYo+W8p9L4lSRwS5kYnOr11lT5f2QZLYVBn9GBDgLL40znu8NxM0Z0y/HN7zNIuNPTzeBzwfxwQGs4QV3tJyrOhhqIp2b5S4ZCx/V2LSPCzwSitOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712235696; c=relaxed/simple;
	bh=Ef65XznV/bmQcGHmioaUFT0V+mvjSQhs27D1vrEQrRg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tu4mOte1K1MF0fT2SodZtxfb04j0LPBgleoV51ZgHXy416qAa39p/1NlIJ6CHcRZMeRuvDusdlaoh7A3jHBhfDVG1pOWSjLMg2ev9r5D9sNueL6vpaTy7pqxOPrsLCtAIwY3DLq4lescL8kCaQJyIkRSCkbrquAJj1pDoeY8bM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qkya+Uxp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=264OAWp4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712235692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SHqs79hU1DdSIz6PLmrqAUm1EAe6ocE8arUu1kzHUso=;
	b=Qkya+UxpinwX1RAfR2uRTvI5/3B37WRg2iapfpx424cis58HJqbLE2OjFPEVq+jEVq8QLT
	oFPM9JPMCX+vR5dFgPoAzYOjyN+z9EwIBnnDvqjV82IxUhpQe3s9gq0FrnxrUNmIeGScg8
	2Xpys0yMpOGKW6vE/bJ4YT87j68SWOVfTfDmJAo6FXfQvwqTZ/P4vxZ6rEdGeCmh8W5GWG
	JB7PBLqmII3/pYGa0mngND+dxFonVvWUn4Na9rv04Xpl4FNcPoqhXJCZL1eojUxsJEhEkE
	nejFVxECziJtNtqrtrI73tS2qZFSui4h2TCcR2fAqvfBrRuWHcbmhJxf6PkuhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712235692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SHqs79hU1DdSIz6PLmrqAUm1EAe6ocE8arUu1kzHUso=;
	b=264OAWp40k/pBW2GMWorGjhLz8xwkXh6FxvC7FZdd7ZGeYdhhgypHtsbrEOUHVC4HUpETH
	s/EP9qH18U36WjBQ==
To: "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, Laura Nao <laura.nao@collabora.com>, the
 arch/x86 maintainers <x86@kernel.org>
Subject: Re: [REGRESSION] mainline boot regression on AMD Stoney Ridge
 Chromebooks
In-Reply-To: <09d67d1d-2c65-4872-b38e-665eda154339@leemhuis.info>
References: <20240328094433.20737-1-laura.nao@collabora.com>
 <20240328115015.36646-1-laura.nao@collabora.com>
 <09d67d1d-2c65-4872-b38e-665eda154339@leemhuis.info>
Date: Thu, 04 Apr 2024 15:01:32 +0200
Message-ID: <877chdb7tf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Apr 04 2024 at 10:24, Linux regression tracking wrote:
> On 28.03.24 12:50, Laura Nao wrote:
>>>
>>> I ran a manual bisection to track down the root cause for this
>>> regression and landed on the c749ce
>>> commit from this series:
>>> https://lore.kernel.org/all/20240212153625.145745053@linutronix.de/
>
> FWIW, that commit is c749ce393b8fe9 ("x86/cpu: Use common topology code
> for AMD") from tglx that was part of the "x86/cpu: Rework topology
> evaluation" series.
>
>>> Do you have any insight on this issue or any suggestion on how to
>>> effectively debug this?
>>>
>>> Thank you!
>
> Hmmm, it looks like this did not make any progress. Thomas, did this
> fall through the cracks due to Easter, or is this this on your todo
> list?
>
> Or was there some progress and I just missed it?

No. It's in my easter eggs basket, but I need to eat all the chocolate
eggs first to get to this.

I'll have a look later today.

Thanks,

        tglx

