Return-Path: <linux-kernel+bounces-140419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776828A1423
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A69261C21DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A98214B07F;
	Thu, 11 Apr 2024 12:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UUnJnOil";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5qa4bEXp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D98314B075
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837655; cv=none; b=m7amGR2bHzMyQlkg7g6aWtqRl09eeiuqM6MEDyN/YtNtbCUzYp7xNVwDJ6YlHR0nPPPzMGl0RCtVQZfGswv25tuwMcnzYJaF4UREkbFYTuNxn1ef6TA7jIo8Cbe8mS49sztDO9p4snvJL1Gk/QseItar7QX9p4meDrbh7FtH+b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837655; c=relaxed/simple;
	bh=avFSOEoI1zEvuZnhhf45vojpYeuYVijGIRwOstBRl1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DDrGu1uPwdWftEtAOoYBFOLee6n7l8zcpBsBbqcPlwUCtqigo68XdhmYFqdH/Jeq748nB4w5j3EidD46QPM/ZvJJCFcBIDlqBGDWwpDNO0oUHKO61lHavm7Xjluw79WeDAgH7jhieSMfmzR2VQMXm0YfoZJCg55uvbEYj4NHE0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UUnJnOil; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5qa4bEXp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712837652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dWtCYEoymlFCIzVZNgg2aWjtKrhpbjhpZI3uAp4Wakc=;
	b=UUnJnOilnpM0ZPtxjtMXFPTjkrq+2p5RCeYZiCLVX37PcPdd+JS4ng69VlfSVRW/ZrQ5iy
	DSqhCZM8xlgvfltkxOQD/H58PW23Sxi0YxBNqQCMh9Ac1HAantHwSF079BnXfSx6eroBwL
	owJW72cNYxlRynopYc1g+tJ7I54KNp7XExA+1yBRHNaKV12RzjMzmESmkB2C5xQGYCNhHq
	1c2PQxotbpv3oU0ZUUInmL6fqKbPzE+N4h4MSIm+agilyxTSTsYKSEkgiVKhudVTE2g+9B
	iswncZKgaIjDrU4pefYpDXHIvIWVCB0JjWjdo1ZLwFlX0vk1fve3M3G/h+h8cQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712837652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dWtCYEoymlFCIzVZNgg2aWjtKrhpbjhpZI3uAp4Wakc=;
	b=5qa4bEXpkPz8KZgMSbB+4pZXuaJ2Nzr2OQ8N8PHwrK3pGp+32Yisg7P1z23VwWLmhRV85e
	2QkH3buxgGxodLCQ==
To: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>, Laura Nao <laura.nao@collabora.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, x86@kernel.org, "kernelci.org bot"
 <bot@kernelci.org>
Subject: Re: [patch 0/2] x86/cpu/amd: Fixup the topology rework fallout
In-Reply-To: <6d4d3956-baf3-441c-86b6-493eb3ff72bd@leemhuis.info>
References: <20240410194002.909839385@linutronix.de>
 <20240411112743.232798-1-laura.nao@collabora.com>
 <6d4d3956-baf3-441c-86b6-493eb3ff72bd@leemhuis.info>
Date: Thu, 11 Apr 2024 14:14:11 +0200
Message-ID: <87le5k14h8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Apr 11 2024 at 13:37, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 11.04.24 13:27, Laura Nao wrote:
> No need to wait, we can do that now:
>
> #regzbot fix: x86/cpu/amd: Make the NODEID_MSR union actually work
>
> But ideally Thomas would add Link: or Closes: tag to the patch
> description (e.g.
>
>  Closes:
> https://lore.kernel.org/all/20240322175210.124416-1-laura.nao@collabora.com/
>
> ) just like Linus asked him to do a while ago already[1], as then this
> would not be necessary at all. ;) (SCNR)

Will do when applying them and I try to remember that Closes thing, but
you know at my age ....

Thanks,

        tglx

