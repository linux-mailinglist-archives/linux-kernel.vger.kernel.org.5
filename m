Return-Path: <linux-kernel+bounces-132289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EE489928D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E85D1F22733
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587B381F;
	Fri,  5 Apr 2024 00:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SsZoH800"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E17160
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 00:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712276467; cv=none; b=Qq6QvFyOi4LBI3mE0aClx9KkDHCpXMfE6KMI/sOIiGeKkuz5eQmvbJQtnPlC5dbjdDOpVSWSVdmNVkelo765iT6KbaRg93hHyH/rO3XcNlQDDe/m2zWB4q6CBdk+pSv61JaO/aTHNdEGKR6qv10X/+qCesc+lUnUsqoXViuERS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712276467; c=relaxed/simple;
	bh=ARNyierJYWHiJ+gzMNK8+x1PijK9/iTWQlxWc4IFxAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJJMBJzeFB92jz+6n9MH5dHWrbgtOlvNqZKPurv+TCleFze7xj9pAcZQq9KCFM1i+gE/1vTo6Pc4lSu8/wixGeaBojF0rpVTogfh0juB7sw8HUIeSSr+r6sy23o787ONPYY/outIvKYUYdRl8rc1z67smG96/2C9NZ/U8jZhpDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SsZoH800 reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F206F40E0202;
	Fri,  5 Apr 2024 00:21:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YKTkZ4tzgMSq; Fri,  5 Apr 2024 00:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1712276458; bh=7VD9zpvYiheCzrxIDQHGLpkCEV2A6/HvSxjGeLs4DRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SsZoH800Aky6hm1FrNRBbMjj/uZl+Udw7J4kUqOGVx9V9lnohy/3egyghipY+sKXv
	 RR6NEQAThmfNRR18R4VAjIGvAHkv6idaQcpLBSmFiTHtSvRzoOo67yU+UiM1UBKHBt
	 7rPnR88uNLHNeu175YUHmO9hzKPLFaMTR25BGF/dg5ZbEYJdmfMdlv9wv65Zwx55uJ
	 QTY4MX0C6XP/O28iDZfA20rMw6hG/oOprGNILmIu4Py3e60kxszxVhROa6jQlQ3HiG
	 lArc+FofDlKLG0EhLFe7BXJXDho10SXqNdkN6uHrFBzpcI+ifblQ0lDJSvPnIVNQtF
	 IjKs1eB7DuUbypCOCEB3J7KwARvEtYdSTCUdZU+9yMsihtxD+M/tqwCpjJOoAbLH5N
	 B0EV4j+KTeU4PaAn60LGdqpsEH9q1L3KAqTloZ3Jj+1uYSfDTtLZGH4rn7cl6lhU2j
	 8v7FjLXZuLFWVZ5gRSYbxZxOwze7rxRA7BYju1d4Va4tsICFJpprMJEpO85iPiNjR6
	 n8zmrnXykZvdR31jD7xZuHlE7pT8o0dnRWBuuZIroOzDkyTDp+R841jktH1+nl1yEh
	 YyHbZKlyYsBXEEXoIaayYQnjmJITelA1u4NXkeBXmkx43HV5S41lPZNBDHiGS5TG1Q
	 I6gL9a0qnYV1agYh0nI4B/ME=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0DA3E40E0192;
	Fri,  5 Apr 2024 00:20:51 +0000 (UTC)
Date: Fri, 5 Apr 2024 02:20:51 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] Build failure on 6.9-rc2 with "x86/bugs: Fix the
 SRSO mitigation on Zen3/4"
Message-ID: <20240405002051.GHZg9D43hLP8DAm0Ph@fat_crate.local>
References: <658b2641-1f06-4680-8bf9-87b64ad5241d@o2.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <658b2641-1f06-4680-8bf9-87b64ad5241d@o2.pl>
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2024 at 11:05:28PM +0200, Mateusz Jo=C5=84czyk wrote:
> =C2=A0=C2=A0 =C2=A0ERROR: modpost: "srso_alias_untrain_ret" [arch/x86/k=
vm/kvm-amd.ko] undefined!
> =C2=A0=C2=A0 =C2=A0make[2]: *** [scripts/Makefile.modpost:145: Module.s=
ymvers] B=C5=82=C4=85d 1
> =C2=A0=C2=A0 =C2=A0make[1]: *** [/media/1T-data/linux/linux-6.9-rc2/Mak=
efile:1871: modpost] B=C5=82=C4=85d 2
> =C2=A0=C2=A0 =C2=A0make: *** [Makefile:240: __sub-make] B=C5=82=C4=85d =
2
> =C2=A0=C2=A0 =C2=A0Command exited with non-zero status 2

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D0e110732473e14d6520e49d75d2c88ef7d46fe67

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

