Return-Path: <linux-kernel+bounces-100092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 072FE8791AD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 895CFB21AE7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB8A7829A;
	Tue, 12 Mar 2024 10:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SiE2pY22";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f0o2Zrht"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B203D3A7;
	Tue, 12 Mar 2024 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710238061; cv=none; b=GsudIj8Z3Y9uxvmlOWZnib2fMYkmoZ17yv7/b7umoRk04PEVreYDCvc7U8jHGAVRU3F0AiQIUGRGKBgWoZvSsp0QRg48PVwlt692Jbm5wSDq4R1S30gOFHlGqUZKGK4Bdtm67tfVVdqxp+xuwFo5H6MDANSDqjCIz+lq7RetD/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710238061; c=relaxed/simple;
	bh=Dd9d0UnxqufVfdrX22bmS5DDjMof9oB963Q+fw5StGk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qqy28GSabaNHXpu1Ddzm6pvo51m4BppWPUnCvk3GEg0MZ/ds+SCcIZAtTslwilV/9PuoIrihCAIku6aTxEiB5ZZePjt/w3w9D5TP27aTABk0kHh6hTwx3hqksRiHiWS3ry0JOHnsk2bZxawj4ejc8QGfXxaov2XMQt3eqJORWcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SiE2pY22; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f0o2Zrht; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710238058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yhjK5b3mLPLjt7IRKiFb96a/RGCJHwt7u3VLnuYDLqA=;
	b=SiE2pY22XIbt74fR5+g2hNoNj0RHmko1vTPOMNDWKAzlkp5cx1OB+Ilo2MsjiQloBgK88q
	nSI3QE08TUPWZCmRyGz6sZkhaMvF2stbmJrWZARVO5uRHiPlIol2WfXG5Gl7q6GI0YOR5A
	YhPCZYUPe4JfibKcmeC4GxrtbWMXcR2RPPVacgl2mIgsiGYuE3hFb2HvaREc9DiyCjso9p
	bMySyLf2SwDjskWnSFSn/ll1a99Rd3i/NRoaHet08ihN/SvJDLc1scF0qqtH55jaapN4Po
	0dFBVTcV3bQMafDzUbb6L+TrksQb6kwcCZGszcnH6o4r9XT0qMQh0TUJheoIGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710238058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yhjK5b3mLPLjt7IRKiFb96a/RGCJHwt7u3VLnuYDLqA=;
	b=f0o2Zrht095O28J8Uccd+vmmzvLXXUYxOaEPM3OX74O386o2g55p7o8LepzAvnAOWAkHNQ
	LIcF4YFs44W+y9Ag==
To: Linus Torvalds <torvalds@linux-foundation.org>, Borislav Petkov
 <bp@alien8.de>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-edac
 <linux-edac@vger.kernel.org>
Subject: Re: [GIT PULL] EDAC updates for v6.9
In-Reply-To: <CAHk-=whTBKoHrBpMxh7OHQ=pcdy6K2zqqsJOZeCC4xSqRXb5Bg@mail.gmail.com>
References: <20240311155651.GAZe8pw0urOnUZj1y_@fat_crate.local>
 <CAHk-=whTBKoHrBpMxh7OHQ=pcdy6K2zqqsJOZeCC4xSqRXb5Bg@mail.gmail.com>
Date: Tue, 12 Mar 2024 11:07:37 +0100
Message-ID: <878r2npxue.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Mar 11 2024 at 18:12, Linus Torvalds wrote:

> On Mon, 11 Mar 2024 at 08:57, Borislav Petkov <bp@alien8.de> wrote:
>>
>> -       return topology_die_id(err->cpu) % amd_get_nodes_per_socket();
>> +       return topology_amd_node_id(err->cpu) % topology_amd_nodes_per_pkg();
>
> Ho humm. Lookie here:
>
>     static inline unsigned int topology_amd_nodes_per_pkg(void)
>     { return 0; };
>
> that's the UP case.
>
> Yeah, I'm assuming nobody tests this for UP, but it's clearly wrong to
> potentially do that modulus by zero.

Duh. I clearly was not thinking at all when I wrote this.

Thanks for spotting it.


       tglx

