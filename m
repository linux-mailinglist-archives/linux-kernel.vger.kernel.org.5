Return-Path: <linux-kernel+bounces-74712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0352E85D819
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08501F228F1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E7469946;
	Wed, 21 Feb 2024 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="AU/ea/9N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C2F1E4B2;
	Wed, 21 Feb 2024 12:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519469; cv=none; b=t0AZbymyxOY/LYKzvZlTwDYZdKaAywNtSjbi650yObZIy3lb/qJlt5tVWjnoWTy1G1m0/wEfLgWlL4cyPtwLFL8Rb5ZGG7UdTkEYgHTVawUE1dYzciukHWcEw0nu+GP+i4cmUrAiOMTC2Dc9yTaIE8ylT3AX0ERN0M+uFIZ5XMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519469; c=relaxed/simple;
	bh=6RGYH3Mz3J4oI1+bd7RNZjaP2Hii8P88hCDFkiTiKZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bs9eOueNRyJp/qUFSOhdWxbLwHXtUvm3FRgwvpGYSDg47dBbKgHshcW/TKMx/8lbp9DduRcY1oB/PH3F+q4Os62/6fU87ck1d/MLrKJZbqrbXAr7JaOY9zgigCGCnxrFLhYgPp9t1o/P6rf2CE7HoSlqsPrTj/D6BLRU28LmdlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=AU/ea/9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8E4C433C7;
	Wed, 21 Feb 2024 12:44:27 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="AU/ea/9N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1708519466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nc3S63HnHPZQylcpdCcFUjXiCtNqqh7GaTPTZjBcLUw=;
	b=AU/ea/9Nf/8SNgcEDQLYzmpd4dQXJG1pJL8aADu2kynh+2TE71g3X5rVv5xdxUfCXLzT28
	nSLzrS0UKCM3HN0UOMnEuSGStLtdh/Cn0cjT7XbMtL0E1RmAQzg2mzuKQgJK2HwxilhfOh
	vgJz418ao83XgWFeybKM0LtvvOnSDKU=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id dfd66421 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Feb 2024 12:44:26 +0000 (UTC)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-60821136c5aso24912237b3.1;
        Wed, 21 Feb 2024 04:44:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUk7YTGKX1f9xeTBHAhj05cUU666BOTH3T6xnbz49XLRgD83ksK08cQHG+LLAqkvQjxYAkWRnTTJBnPIjab8ek1uiGWXooKzEmrW72F8G917qPvSfN84bKHsxfvmifd0J8vZCnnCLpyllGBvTrW
X-Gm-Message-State: AOJu0YynXAhgEys5mMNLB+LEvPdAix0CbaKMFU6L+SD/vD2vLx6zRz3o
	ddvieTererzPP4VAOr8ZjDXrBh6Fjzdzql4PRfBP+HcEF2lBjOUhk5n+HAjKGuttK/mAguoSVFi
	uXohM4IKcLKl1nL/0af0ZzUcUPPY=
X-Google-Smtp-Source: AGHT+IGsqEFjPblcfmv8FF0KYxHPu+5nTEQXUnLz9NDETtqoeMqGfXrSnBwXvKXJPcVeMzhH+TIxl/qnF7fjzTpgd6Q=
X-Received: by 2002:a05:690c:4448:b0:608:bcb:b43a with SMTP id
 gq8-20020a05690c444800b006080bcbb43amr14459370ywb.8.1708519465411; Wed, 21
 Feb 2024 04:44:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221020258.1210148-1-jeremy.linton@arm.com> <202402202226.A6817927@keescook>
In-Reply-To: <202402202226.A6817927@keescook>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 21 Feb 2024 13:44:15 +0100
X-Gmail-Original-Message-ID: <CAHmME9pYS=YZM1b0ftrjj_qjz_U4V8PsiLzB15JmBRr39Av2Ng@mail.gmail.com>
Message-ID: <CAHmME9pYS=YZM1b0ftrjj_qjz_U4V8PsiLzB15JmBRr39Av2Ng@mail.gmail.com>
Subject: Re: [RFC] arm64: syscall: Direct PRNG kstack randomization
To: Kees Cook <keescook@chromium.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>, linux-arm-kernel@lists.infradead.org, 
	catalin.marinas@arm.com, will@kernel.org, gustavoars@kernel.org, 
	mark.rutland@arm.com, rostedt@goodmis.org, arnd@arndb.de, broonie@kernel.org, 
	guohui@uniontech.com, Manoj.Iyer@arm.com, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, James Yang <james.yang@arm.com>, 
	Shiyou Huang <shiyou.huang@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 21, 2024 at 7:33=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
> > +#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
> > +DEFINE_PER_CPU(u32, kstackrng);
> > +static u32 xorshift32(u32 state)
> > +{
> > +     /*
> > +      * From top of page 4 of Marsaglia, "Xorshift RNGs"
> > +      * This algorithm is intended to have a period 2^32 -1
> > +      * And should not be used anywhere else outside of this
> > +      * code path.
> > +      */
> > +     state ^=3D state << 13;
> > +     state ^=3D state >> 17;
> > +     state ^=3D state << 5;
> > +     return state;
> > +}

Can we please *not* introduce yet another RNG? You can't just sprinkle
this stuff all over the place with no rhyme or reason.

If you need repeatable randomness, use prandom_u32_state() or similar.
If you need non-repeatable randomness, use get_random_bytes() or
similar.

If you think prandom_u32_state() is insufficient for some reason or
doesn't have some property or performance that you want, submit a
patch to make it better.

Looking at the actual intention here, of using repeatable randomness,
I find the intent pretty weird. Isn't the whole point of kstack
randomization that you can't predict it? If so, get_random_u*() is
what you want. If performance isn't sufficient, let's figure out some
way to improve performance. And as Kees said, if the point of this is
to have some repeatable benchmarks, maybe just don't enable the
security-intended code whose purpose is non-determinism? Both exploits
and now apparently benchmarks like determinism.

Jason

