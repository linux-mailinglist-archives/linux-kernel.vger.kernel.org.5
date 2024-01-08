Return-Path: <linux-kernel+bounces-19842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34C4827522
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66B7FB22BBC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CB345C04;
	Mon,  8 Jan 2024 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="MdS1b4ha"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBF253E16;
	Mon,  8 Jan 2024 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4ECBC377;
	Mon,  8 Jan 2024 16:28:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4ECBC377
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1704731299; bh=wq9SjBGaG0x7BK6duWay1nTcX9VdeS5D83MxyhQYxH8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MdS1b4haLNtmbhmLT7JQZh+oO6+6oYPvKiSi/216/qZqR9FBZKRiIjXGDEUoSv/2g
	 mgwv13z4PKIUyupKtNmzwQgxiIy/KXfARS1OHCNib6jhFDnCW2m/yz0Mz125LOqWBS
	 9iApfqzUv519ZkGoEhIWT4Yrr/10qrp88v4qI2p6uLh0ohVY1O6BMdp21GY+r2HN4D
	 crPUi0KOC56A42/3Bf4Dq5U63qh6uDNMSnvT3sKWj8yfSUiVpCnC3rDroNBrWS59El
	 k04jHh3ntAEiHhL39g8M2RswQ4aK8NuPQsGxXClskWlUUHXGjLRrSHB20x2vaMHp3t
	 jeoBAvshlQmFw==
From: Jonathan Corbet <corbet@lwn.net>
To: Yueh-Shun Li <shamrocklee@posteo.net>
Cc: Yueh-Shun Li <shamrocklee@posteo.net>, Hu Haowen
 <src.res.211@gmail.com>, Alex Shi <alexs@kernel.org>, Yanteng Si
 <siyanteng@loongson.cn>, Randy Dunlap <rdunlap@infradead.org>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] coding-style: show how reusing macros prevents
 naming collisions
In-Reply-To: <20240108160746.177421-3-shamrocklee@posteo.net>
References: <107b6b5e-ca14-4b2b-ba2e-38ecd74c0ad3@infradead.org>
 <20240108160746.177421-1-shamrocklee@posteo.net>
 <20240108160746.177421-3-shamrocklee@posteo.net>
Date: Mon, 08 Jan 2024 09:28:18 -0700
Message-ID: <871qaryel9.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yueh-Shun Li <shamrocklee@posteo.net> writes:

> In section "18) Don't re-invent the kernel macros" in "Linux kernel
> coding style":
>
> Show how reusing macros from shared headers prevents naming collisions
> using "stringify", the one of the most widely reinvented macro, as an
> example.
>
> This patch aims to provide a stronger reason to reuse shared macros,
> by showing the risk of improvised macro variants.
>
> Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>
> ---
>  Documentation/process/coding-style.rst | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 2504cb00a961..1e79aba4b346 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -1070,6 +1070,28 @@ Similarly, if you need to calculate the size of some structure member, use
>  There are also ``min()`` and ``max()`` macros in ``include/linux/minmax.h``
>  that do strict type checking if you need them.
>  
> +Using existing macros provided by the shared headers also prevents naming
> +collisions. For example, if one developer define in ``foo.h``
> +
> +.. code-block:: c
> +
> +	#define __stringify(x) __stringify_1(x)
> +	#define __stringify_1(x) #x
> +
> +and another define in ``bar.h``
> +
> +.. code-block:: c
> +
> +	#define stringify(x) __stringify(x)
> +	#define __stringify(x) #x
> +
> +When both headers are ``#include``-d into the same file, the facilities provided
> +by ``foo.h`` might be broken by ``bar.h``.
> +
> +If both ``foo.h`` and ``bar.h``  use the macro ``__stringify()`` provided by
> +``include/linux/stringify.h``, they wouldn't have stepped onto each other's
> +toes.
> +

So everything we add to our documentation has a cost in terms of reader
attention.  We ask people to read through a lot of material now, and
should only increase that ask for good reason.

With that context, I have to wonder whether we really need to tell our
readers, who are supposed to be capable developers, that reuse can help
to avoid name collisions?

Thanks,

jon

