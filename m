Return-Path: <linux-kernel+bounces-157580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AE48B1329
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83ADE1C22112
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8321CF9A;
	Wed, 24 Apr 2024 19:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="nt4A8HS0"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D711CF8F;
	Wed, 24 Apr 2024 19:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985487; cv=none; b=aSLX0EJnfe9nQtJXk5pNmb+I6ZebfDHgMt26OolrfpbFPF7LpsFvWmLAfYVO4TnkQyOy/3SgNgEGBcZrf0ZLFh8F6JXRxAxwNxNgWCgJJRdUfeMnOCSLXY3JSESwp/XSaKlWgb4ERvQU3oqcU7TD0sn76d2Qzqdd9IeBMHNQl4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985487; c=relaxed/simple;
	bh=x6shHUnIQesEwIbukRUgPxXYDXOp6+ft3svHp1S2jFs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sq1H2g5I78pKE+NMnOil3hRe28HQT8MInb6peAIIvY3yyq7ACMkLAHR8WUhAAPVkjAZjv8lZSDsB5nVCbhkwaq6FoTbLkCNyP5yafQxKmKfWd85T5dGAp6DUF/LpTiQpo+yIuVchKBzxJdTvFO0gcSQrKO58EFj2ySus5/A0kiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=nt4A8HS0; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 73AC247C41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1713985482; bh=dRKcaBKo5fuMcFfCN9azIg90Nn+9aKeHsYVea/r9kxc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nt4A8HS0pYyr1iSnw7rMOJONecbH7FLlGeAbC3P5JPX9VAUtzMqIr4h9LBZQM/38V
	 un2TEvFOOcsqkal+c1YM40JET5RD71kjCoUQw/lPcHK/B3Z8Fs1XLOY088AVBNj0Vl
	 XAmoJHMnCwomAHfXGCsyO0Ox4zg+RIfEdYEJc9nggjrnst8lryJ20C58STkn3pRrRL
	 /BwpjY0pUgNuRlpVKMo52Di8U8VTc1g2mx3XJABNVvojKNvZOCFk8MMYlthAWhCziw
	 2HNQdqw6Fe3A2MHcNYVvLDetiAdH4kB7fDAahfHgjMthMxq/zky7vTSx/7wNLGaQXx
	 FijRybMiXCKBQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 73AC247C41;
	Wed, 24 Apr 2024 19:04:42 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Thomas
 Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra
 <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
 <pawan.kumar.gupta@linux.intel.com>, "Joel Fernandes (Google)"
 <joel@joelfernandes.org>, Chris Hyser <chris.hyser@oracle.com>, Josh Don
 <joshdon@google.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <linux@weissschuh.net>
Subject: Re: [PATCH] admin-guide/hw-vuln/core-scheduling: fix return type of
 PR_SCHED_CORE_GET
In-Reply-To: <20240423-core-scheduling-cookie-v1-1-5753a35f8dfc@weissschuh.net>
References: <20240423-core-scheduling-cookie-v1-1-5753a35f8dfc@weissschuh.net>
Date: Wed, 24 Apr 2024 13:04:41 -0600
Message-ID: <878r12twdy.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Wei=C3=9Fschuh <linux@weissschuh.net> writes:

> sched_core_share_pid() copies the cookie to userspace with
> put_user(id, (u64 __user *)uaddr), expecting 64 bits of space.
> The "unsigned long" datatype that is documented in core-scheduling.rst
> however is only 32 bits large on 32 bit architectures.
>
> Document "unsigned long long" as the correct data type that is always
> 64bits large.
>
> This matches what the selftest cs_prctl_test.c has been doing all along.
>
> Fixes: 0159bb020ca9 ("Documentation: Add usecases, design and interface f=
or core scheduling")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/util-linux/df7a25a0-7923-4f8b-a527-5e6f0064=
074d@t-8ch.de/
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>  Documentation/admin-guide/hw-vuln/core-scheduling.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/hw-vuln/core-scheduling.rst b/Docu=
mentation/admin-guide/hw-vuln/core-scheduling.rst
> index cf1eeefdfc32..a92e10ec402e 100644
> --- a/Documentation/admin-guide/hw-vuln/core-scheduling.rst
> +++ b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
> @@ -67,8 +67,8 @@ arg4:
>      will be performed for all tasks in the task group of ``pid``.
>=20=20
>  arg5:
> -    userspace pointer to an unsigned long for storing the cookie returne=
d by
> -    ``PR_SCHED_CORE_GET`` command. Should be 0 for all other commands.
> +    userspace pointer to an unsigned long long for storing the cookie re=
turned
> +    by ``PR_SCHED_CORE_GET`` command. Should be 0 for all other commands.
>=20=20

Applied, thanks.

jon

