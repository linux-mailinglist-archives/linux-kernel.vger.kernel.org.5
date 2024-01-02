Return-Path: <linux-kernel+bounces-14240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 341A98219A8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF641F22527
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CAEDDC1;
	Tue,  2 Jan 2024 10:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="CIoiT4SL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7524DDBA;
	Tue,  2 Jan 2024 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1704191166;
	bh=RaJlaI+6zhKJ4V+dN/O223tHLNAl7Jrq0UeV5Sr8+Z8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=CIoiT4SLj/jLoF5X0LjHIQbqIGSV9SwtR4Lf6PUnNWcstCtiud+Ksx08dxkjKdtmd
	 /wiO0LrApX0q3lbdWiUrDOUL5fBZruVQb/yBQIqVQneXMs3nNJ0FoQWtLeMqb4l+xQ
	 jKyZLgSIbA5H50ISH8WY93pDO3PfoWKu9Mj6Ajxo=
Received: from [IPv6:240e:358:11a9:2200:dc73:854d:832e:3] (unknown [IPv6:240e:358:11a9:2200:dc73:854d:832e:3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 923C266C06;
	Tue,  2 Jan 2024 05:26:00 -0500 (EST)
Message-ID: <f6e0b3a0e08a8100fa5dc9345af8582ff664321c.camel@xry111.site>
Subject: Re: [PATCH v2] LoongArch: Fix and simplify fcsr initialization on
 execve
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>
Cc: Eric Biederman <ebiederm@xmission.com>, Kees Cook
 <keescook@chromium.org>,  Tiezhu Yang <yangtiezhu@loongson.cn>, Jinyang He
 <hejinyang@loongson.cn>, loongarch@lists.linux.dev,  linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 02 Jan 2024 18:25:54 +0800
In-Reply-To: <20240102101711.10872-2-xry111@xry111.site>
References: <20240102101711.10872-2-xry111@xry111.site>
Autocrypt: addr=xry111@xry111.site; prefer-encrypt=mutual;
 keydata=mDMEYnkdPhYJKwYBBAHaRw8BAQdAsY+HvJs3EVKpwIu2gN89cQT/pnrbQtlvd6Yfq7egugi0HlhpIFJ1b3lhbyA8eHJ5MTExQHhyeTExMS5zaXRlPoiTBBMWCgA7FiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQrKrSDhnnEOPHFgD8D9vUToTd1MF5bng9uPJq5y3DfpcxDp+LD3joA3U2TmwA/jZtN9xLH7CGDHeClKZK/ZYELotWfJsqRcthOIGjsdAPuDgEYnkdPhIKKwYBBAGXVQEFAQEHQG+HnNiPZseiBkzYBHwq/nN638o0NPwgYwH70wlKMZhRAwEIB4h4BBgWCgAgFiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwwACgkQrKrSDhnnEOPjXgD/euD64cxwqDIqckUaisT3VCst11RcnO5iRHm6meNIwj0BALLmWplyi7beKrOlqKfuZtCLbiAPywGfCNg8LOTt4iMD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-02 at 18:17 +0800, Xi Ruoyao wrote:
> The only other architecture setting FCSR in SET_PERSONALITY2 is MIPS.
> They do this for supporting different FP flavors (NaN encodings etc).
> which do not exist on LoongArch.=C2=A0 I'm not sure how MIPS evades the i=
ssue
> (or maybe it's just buggy too) but I'll investigate it later.

Phew.  I just managed to recommission my 3A4000 and I can reproduce the
issue as well with Linux 5.18.1 (the latest kernel release when I
decommissioned it) and CONFIG_PREEMPT=3Dy.

% cat measure.c
#include <fenv.h>
int main() { return fetestexcept(FE_INEXACT); }

% echo $((1./3))
0.33333333333333331

% while ./a.out; do ; done
(stopped in seconds)

I'm building the mainline kernel on the 3A4000 now, will see if the
issue still exists...

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

