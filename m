Return-Path: <linux-kernel+bounces-120040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE9788D0B6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E8D2E7846
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF4913DBB6;
	Tue, 26 Mar 2024 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kxNQxJ/S"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DEE13DDA4
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 22:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711491718; cv=none; b=ghVuwaXU1Do5ma4rowBAMPDwqOBz8M9rv9uAjjDi7+kY12TLfCd/DyrfNowgbi+OsYUvp8fB0ZVJkgnbe/lwoJtAUvghliXyhkWFQwZgQ+UpNvJKya4GnTc3LW9obd9pyyT+H0g0rLfkICSiKgEROiveDlsFcMYeihaGCIl81BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711491718; c=relaxed/simple;
	bh=G6+CVysg1aI5vujSNnI7SO8vhrH7Q65FI/W+9DIgwFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QceXF1mu18XgiKgnElH3+1ugQHuhfX8REvaLd84xputFmD40iLPzCBZE/ozv3PHl5JVQ6t4SJl1ygM1C5OJafC2L6U8+zTjrdiCRMCo6RJBD63d0/pXzzrVrdGerHgd7spnYdtsw8qVnUpAHgMsJ7aw0iiJOv7Ldhjhm5/59tJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kxNQxJ/S; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D3E0340E02A2;
	Tue, 26 Mar 2024 22:21:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TDdz5jh5-tzC; Tue, 26 Mar 2024 22:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711491708; bh=acLMxcr3wgCFsfsM3gv7qsdCSQbB1J66ZYH/u3NXG1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kxNQxJ/S5lJIfikwym4ziVrOzM8WAuXo6MJyhel033FyNUPgncoz0agh+QQf0VqqS
	 GxC8wiymUhOl0ZvCUVne8uCZ/dPBUcU95IMrFYAjciI6LpUJT5C8JrLxux4f2To+g+
	 BvyeHwx9wDVXKLeqpEO7zD3patx3oUXVNKO5+yaUvRsospUxK46t2hLftc4w1Cd6NS
	 D4p/Orw5qVIxNqh0SAiZtGVjRbVREFyQXWhO3HXoRWQhkQsaXkkIzAQr7HDD6l/MLt
	 l9XNpKv7uGciAnT3H00gqt1TV4B+MFHOb6+UHnZdvFcsGyi4f+21ZXPydbuRjgYY6z
	 HGSpX+96hy6YnqsU8mq7G/KlR//WJedOSr5veLjmzE7WQxU6FsClEsmr9wEh6WUp9b
	 DZV0jgo7ZOjRZzM8TNIsg1HJrLdB6ndUjd/TwkRNtwAjExVhNP6eJh1RLDz2LAVbto
	 yghBwlqGSm5HFPxDFFl3oAHG0/cqrMN68hC/K1Z4zcT4riJ7yUQORONXsCofEY5kIF
	 jyY4w+eOkxE/XccD4LHSLaF/uBEkeqENr4VAuJZNI4PS7wu5dYwWHy4v5Pyh4Bx3WQ
	 y7fJThuqY6yJoApfFfnpGbC9Srbzb8BoyNL81XBrdTEePHnp1/+N7fc+iDx+IRgCxC
	 Rm0LKIpwtsdtIRdVg6xNV8pI=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0877D40E016C;
	Tue, 26 Mar 2024 22:21:39 +0000 (UTC)
Date: Tue, 26 Mar 2024 23:21:34 +0100
From: Borislav Petkov <bp@alien8.de>
To: a-development@posteo.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	David.Kaplan@amd.com, Andrew.Cooper3@citrix.com,
	jpoimboe@kernel.org, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 00/17] Fix up the recent SRSO patches
Message-ID: <20240326222134.GNZgNKbgdBUsAU98RV@fat_crate.local>
References: <cbad6acb30e33e8dd387080e5936cc38@posteo.net>
 <20240127191942.GEZbVXTtDNzLB9hTpr@fat_crate.local>
 <181005cf4a78a4c3c5e1de77498f6c23@posteo.net>
 <20240127194139.GFZbVcc2RxhNtO3ZHD@fat_crate.local>
 <6170a3f60cd1ca68bca5829db4a8568a@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6170a3f60cd1ca68bca5829db4a8568a@posteo.net>

Whoops, 

this fell through the cracks. Sorry about that.

On Mon, Jan 29, 2024 at 06:18:00PM +0000, a-development@posteo.de wrote:
> I have the feeling that something else is amiss.
> Currently under 6.7.2-2-cachyos with srso=off.
> https://0x0.st/HDqP.txt

Yah, your tasks refuse to freeze on suspend and they have this fuse
stuff in the stacktrace:

[ 6346.492593] task:btop            state:D stack:0     pid:279617 tgid:1548  ppid:1531   flags:0x00004006
[ 6346.492600] Call Trace:
[ 6346.492602]  <TASK>
[ 6346.492607]  __schedule+0xd44/0x1af0
[ 6346.492614]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 6346.492617]  ? __wake_up+0x9d/0xc0
[ 6346.492622]  schedule+0x32/0xd0
[ 6346.492627]  request_wait_answer+0xd0/0x2a0 [fuse db37c699d94393e946cf93306449ea0f307959a1]
[ 6346.492638]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 6346.492643]  fuse_simple_request+0x21c/0x390 [fuse db37c699d94393e946cf93306449ea0f307959a1]
[ 6346.492653]  fuse_statfs+0xf2/0x160 [fuse db37c699d94393e946cf93306449ea0f307959a1]
[ 6346.492667]  statfs_by_dentry+0x67/0x90

> 
> Now I feel, further communication is rather selfish, as a clean environment
> is hard to provide.
> In any case, my FUSE arguments are sshfs -o kernel_cache -o auto_cache -o
> reconnect \
>                -o compression=yes -o cache_timeout=600 -o
> ServerAliveInterval=30 \
>                "$source" "$target" -o idmap=user
> 
> With this line, I somehow managed to have the FUSE mount infinitely mounted,
> even if the device was offline for couple of days.
> A followed suspend would fail to freeze.
> srso=off would reproducibly work.

Not in your example above. It would fail after a couple of suspend
cycles.

And looking at your splats

[ 6366.524953]  ? switch_fpu_return+0x50/0xe0
[ 6366.524956]  ? srso_alias_return_thunk+0x5/0xfbef5
		  ^^^^^^^^^^^^^^^^^^^^^^^^
[ 6366.524958]  ? exit_to_user_mode_prepare+0x132/0x1f

the right cmdline option to disable it is:

spec_rstack_overflow=off

not

srso=off

:-)

> Please provide me a specific version of a kernel I should try in my
> configuration to try and reproduce.
> I'd prefer a pre-compiled one; if not tell me...
> I use archlinux.

Just build the latest released kernel, which is 6.8 now. Take your
config and use it to build it. The net is full of tutorials how to do
so.

And then try with spec_rstack_overflow=off and let's see what that does.

> Please give me a reason to not feel bad about myself.

Don't worry - it's just a machine. :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

