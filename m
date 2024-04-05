Return-Path: <linux-kernel+bounces-132669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A29DA899845
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F95FB21B45
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF83215FCF8;
	Fri,  5 Apr 2024 08:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EFmc8d5S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FcdNlC4C"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7E415FCEA
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712306574; cv=none; b=f1BVlK0++vLEcq5nQpzA7JM0ecTWz7LkSZmpLxh9MgFPOIOrG33AaDA4rm7UPPmFME0gNUuvNwfkUL+GZqYd2KmR40WM1FtGM+/+DMSgYV0bNFwDcR+2ncq0kAnf7RqLeMMHnRq7z+664DpctbDgroGW4ZsmyQAn5ryihW3jUmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712306574; c=relaxed/simple;
	bh=gH27NJNXWx8yHvqdIIM2H5tc5F94P1Mi80i+28bcZGc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OSnzt5rgcGegc5LBkSAUdejQifqwBgbbRHy87Slx7IHIc4NsGLSIyncUjSdqcbjxG2IAwHeUaCxxW3hfON+bfL7QUZDNXPdvTSdD0jYlZaPX3GwEFBPBVRBVKUL4Mij7JLHSwqgsjiRnKWyrcMUlUf2ssGnAF6inwIbMAG0aBaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EFmc8d5S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FcdNlC4C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712306571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8zy9gkE0NL3wEID3wV6rSctgthIXwXNWDbVxfqHZhIU=;
	b=EFmc8d5SU23iug9CgZKrNnehllIivytV50mkvFXjnhoo/aUn+bfy0IrN4Gq/kknOLciUWA
	jKQbi6HvE2gZ2v2lQVp99UCYfQaEdhqjP0wmMFOXZdHHga0sBh6xvT0oTK+kJTdPE+ReG8
	+Vl+10g+0buEuWVAUi0rf0ZxgWWtjq9yKu4UkQG3xr7fxh5zakjvXn1l62mNr5Y9aEr/j8
	NWCMuk3rgtdNFcKWXagex2ysCzqwflk+Mr9YIjGpw61pORbzzB8mranXJbDOILk7ObVZZ8
	vDRoV/NZnUdtLKrJkYGCUAf9/htMw+0P40eY3BgtcOijGnGboIpk9VMoOnZDbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712306571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8zy9gkE0NL3wEID3wV6rSctgthIXwXNWDbVxfqHZhIU=;
	b=FcdNlC4CKZ9wDtWyDg7qc3UE2yr9b+PEl+e14BdmO5V+pDLiomtTItE+MOcgH8Ra9wIyBd
	6LOGgpXWzCBVEjDA==
To: Laura Nao <laura.nao@collabora.com>
Cc: kernel@collabora.com, laura.nao@collabora.com,
 linux-kernel@vger.kernel.org, regressions@leemhuis.info,
 regressions@lists.linux.dev, x86@kernel.org
Subject: Re: [REGRESSION] mainline boot regression on AMD Stoney Ridge
 Chromebooks
In-Reply-To: <20240405081415.15170-1-laura.nao@collabora.com>
References: <87cyr4ao79.ffs@tglx>
 <20240405081415.15170-1-laura.nao@collabora.com>
Date: Fri, 05 Apr 2024 10:42:50 +0200
Message-ID: <877chc9p4l.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Laura!

On Fri, Apr 05 2024 at 10:14, Laura Nao wrote:
> On 4/4/24 22:05, Thomas Gleixner wrote:
>> Can I get the /proc/cpuinfo output please?
>
> Here are more logs from the same device running v6.8:
> - cpuid -r: https://pastebin.com/raw/YmDrnw06
> - cpuinfo: https://pastebin.com/raw/Ki0vwdDE

Thanks for the info. I'm still not seing why that wouldn't work.

As the machine seems to have a serial port, can you please replace
'earlycon' with 'earlyprintk=ttyS0,115200' on the command line and see
whether that gives some output. I'm not sure that the current 'earlycon'
has the same effect.

Thanks,

        Thomas


