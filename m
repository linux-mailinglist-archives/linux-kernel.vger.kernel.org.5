Return-Path: <linux-kernel+bounces-133201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF0489A069
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28CCF1C221A1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD2216F849;
	Fri,  5 Apr 2024 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Baaiar0l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qXPXpHH+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD9916F82C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329151; cv=none; b=VlywIP7Jzxni22H+BuNIEr5ehGZnB7FGzb6i6SKa+pCBU1lMPsIW2xAIPsMf0ai8ZFOfcNQexYjRoP4LYPKVkrWJRDc9f/ZwghkV7DoSqKGqVZZScT4AY2/eDq9tvqt2yraJWOUJL+y5yS7zIO6rVDvKxWGU5hjOjebVcaOrPdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329151; c=relaxed/simple;
	bh=GoD5cDngPo9za+wnO1zqHCoyvjOVhhc2Sev/5MLX6yo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nm2uZyKJmqWlMfsB7SQ8pwKfnHBck6FwF5Dy0i2m45x+WL6Fjg7Hj5jIcC3d0tSV12iwwwfC2kxvtMkUqZtPPHbu+3h9UCttibEEdgUu9+U5CJn+ZNjwz+vt35DKSnSUGIy00UTV6BVcM+bDu9tPwND2lxs9cF9W6jIIP77OkR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Baaiar0l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qXPXpHH+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712329148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7La8PmKGqPZj7+uG421aocfuKn6lduDBmlIV/b+eU1k=;
	b=Baaiar0lhJoVgsBN2kMiw9yiODR1K0JJ4kWjU5X5+Xofoa9xCjruZyOlhKA5KwncXK/RyI
	uUZJm2kxMcX3PFQUOdFNyJKDRuAV4d2r2f7JgTL3YmIDb2tJIEy54sVe8TgmwRkJab/y1Y
	7ZEN+JLcqdKb2g8D9R4vdqjG1e4xI9rbY4x3LQgs+CvAq2mjREA+wGcocyOuURIb8b/fHa
	+lFyOi+YGpxEKrMp+UrbB7UPkFp7zVhcmE/muCw49ZAPwfH8nqqDwCJSMW+RsAlXS+woYj
	vuxWrllTLnak/TlBiMX487q2QLNHo2n1hjHvFVdxGmiulvEurLVatZNWOod20g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712329148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7La8PmKGqPZj7+uG421aocfuKn6lduDBmlIV/b+eU1k=;
	b=qXPXpHH+AlgUB7J0s2S/abzJFuQMBkbkPJFZ+GSLx3dIG3toXRc2FeVdQIjK9rQt5xevRm
	hdsJwUXR7UZ8FuCA==
To: Laura Nao <laura.nao@collabora.com>
Cc: kernel@collabora.com, laura.nao@collabora.com,
 linux-kernel@vger.kernel.org, regressions@leemhuis.info,
 regressions@lists.linux.dev, x86@kernel.org
Subject: Re: [REGRESSION] mainline boot regression on AMD Stoney Ridge
 Chromebooks
In-Reply-To: <20240405135837.306376-1-laura.nao@collabora.com>
References: <87ttkg7wvg.ffs@tglx>
 <20240405135837.306376-1-laura.nao@collabora.com>
Date: Fri, 05 Apr 2024 16:59:08 +0200
Message-ID: <87msq797pf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 05 2024 at 15:58, Laura Nao wrote:
> On 4/5/24 15:38, Thomas Gleixner wrote:
>> 
>> Can you please boot a working kernel and provide the output of:
>> 
>> # rdmsr 0xc0011005
>
> # rdmsr 0xc0011005
> 2fabbfff2fd3fbff

Ok. So the CPU does not advertise FEATURE_TOPOEXT which is consistent
with CPUID.

Now I'm even more puzzled because then the patch I gave you should make
a difference. I need to run some errands now, I will provide a debug
patch later this evening.

Thanks,

        tglx

