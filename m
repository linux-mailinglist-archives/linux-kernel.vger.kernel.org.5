Return-Path: <linux-kernel+bounces-128390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05130895A33
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994DA1F21870
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03FF15AD80;
	Tue,  2 Apr 2024 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYxqqwpn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AB6159916;
	Tue,  2 Apr 2024 16:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076484; cv=none; b=Px7anMySimUwvqM87POAtho6dEp3EaBWitYnZ5DlLhNHP6IByrKFozILesA5fuoZQdKxPHc/nNEW2tkf3EZc5Tx9rwiUne7/vaR4ODFRKQrpc9RMVl2mQcP5QvE5szkNrv3LrNXFuTAVmAm15555z25uItop/Rg/92v3AEEy0f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076484; c=relaxed/simple;
	bh=qc/zRn44QBe4hWpr219p01FEpH9uDc+aUrPnpDuiaq4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OO+OePXnx4i5MaQBtvtorG3G/jHNtYMEfKQEBaH9RxUh9v1edtHYAyGbknNZuIKA/JGjJ9j1F9Drz6Ii+J3LJE/Q2chLI+kwuu1oagapgqrCywLU2Y2+iPK0sOk/W4B+s9MfXNXPdC8TYqyDHhl8wR6hc9Q0bfggxrEZypQ6Mec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYxqqwpn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E90C433C7;
	Tue,  2 Apr 2024 16:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712076483;
	bh=qc/zRn44QBe4hWpr219p01FEpH9uDc+aUrPnpDuiaq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uYxqqwpnmxdSqu5hH2Fr3hwvG7SiTv4vicfHHIkl0jIGxEbf3ErAh4Sp1WXgo7j2d
	 uUvPI0yx9VwLPhyFhCqq/0/vazfpKjh4Fpf71M3AS+isr5OhHNsJYmeYZxg8d2C7BW
	 q5NOvKOqTLkFk/OqsJPTBjAxdSHMNQ6E/pG0KQoJ/G8iwrh68DbFTfNoVRSnLeDxYA
	 G22MqX6qP5356Cy99W5Q3qT7Y2KPbs5o7Ow2CsdErY4VYdOs8ULgkymtkJK6R1y0ad
	 /UmwoRNDXw4vzB4GA58pnA7fQslxa8cRKVZRSwWv6EaWxif6Z9I4ciDfkeME0UmWyA
	 NwpQS5F3nKXeQ==
Date: Tue, 2 Apr 2024 09:48:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Dmitry Safonov
 <0x7f454c46@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 <nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] netdev_queues: fix -Wshadow / Sparse
 shadow warnings throughout the file
Message-ID: <20240402094802.6fb25869@kernel.org>
In-Reply-To: <22021664-6630-4663-ac28-c0df4187d8b6@intel.com>
References: <20240329170000.3241460-1-aleksander.lobakin@intel.com>
	<20240329170000.3241460-3-aleksander.lobakin@intel.com>
	<20240329131857.730c6528@kernel.org>
	<20240329135344.1a310f31@kernel.org>
	<912d1f9f-a88d-4751-8d91-b82a75f82a32@intel.com>
	<CANn89iL+goDgitdic97+um6D-PZDw2xYf=2eYgnNYEYU-Nws0Q@mail.gmail.com>
	<22021664-6630-4663-ac28-c0df4187d8b6@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Apr 2024 17:53:08 +0200 Alexander Lobakin wrote:
> >> But what if there's a function which calls one of these functions and
> >> already has _res or __res or something? I know renaming is enough for
> >> the warnings I mentioned, but without __UNIQUE_ID() anything can happen
> >> anytime, so I wanted to fix that once and for all :z
> >>
> >> I already saw some macros which have a layer of indirection for
> >> __UNIQUE_ID(), but previously they didn't and then there were fixes
> >> which added underscores, renamed variables etc etc...
> >>  
> > 
> > We have hundreds of macros in include/ directory which use local names without
> > __UNIQUE_ID()  
> 
> Most of them were added before __UNIQUE_ID() became norm, weren't they?
> Lots of them were switched to __UNIQUE_ID() because of issues, weren't they?

Lots of ugly code gets into the kernel. Just look at your patch and
then look at mine.

I understand __UNIQUE_ID() may be useful for libraries or global
macros in the kernel, but within a subsystem, for macros which are
rarely used, we can just patch the macro var names. Sprinkling
__UNIQUE_ID() is in bad taste.

> > What is the plan ? Hundreds of patches obfuscating them more than they are ?  
> 
> Only those which flood the console when building with W=12 C=1 to
> recheck that my new code is fine.

I have never seen this warning be useful in the context of a macro.
Sure if you shadow inside a function that may be pernicious.
But well written macro will not be a problem.
I guess that it may be really hard for the compiler to understand that
something was a macro but perhaps we should either:
 - ignore the warning if the shadowing happens inside a compound
   statement
 - add a declaration attribute to turn the warning off
?

