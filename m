Return-Path: <linux-kernel+bounces-50056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 340AC8473C8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAC9FB25AC9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A6D1474A5;
	Fri,  2 Feb 2024 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FK0DbzpH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421DB146916
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889421; cv=none; b=moFJozw3U6HZgI6ue04K1QO6k+dDTJ6HfQ+WRbsELlhjzeT2ZqnVsOnBXwkrMOZS/NMf9E0hItvw6ea3mi1nF0QqL+7whiaZv7+qGr5cFn9xSopvRAApgapbGDWud7ruPawvMCwbJ3DGi+bjuAqqR80rJpv+4B8IYHJedSVW4eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889421; c=relaxed/simple;
	bh=MmO0Sers5UlYOvIhkdegHIwY3ye7rpzzr9dSXdHC/0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HakGpoKQV8CKeY44vBeiWFjxunJ6vKMK7tIcafIJRowgvyF+Ae3Ft9Lj3+sbKdFQ1yYkeI0kKTkPo7zl6t6ZZUdIu3soStoU6sR3hEmBbkLiUUZEdDCxADcU/wJZMoctAuR0//TFAznlwCcLeBR3hBxfMmAAGLohMjKk3OHk0us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FK0DbzpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFC3C43394
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 15:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706889420;
	bh=MmO0Sers5UlYOvIhkdegHIwY3ye7rpzzr9dSXdHC/0E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FK0DbzpHUrAJYUPC+vn2IIX8xS6omoVzZBE8ov/RPcr2T7n27+ReQ1fNFaTKd1xYP
	 54zlt4uAdtjO3ikHZ19YqYniazqlPYu1Nd1qx03scTR5WvgxWDZxA0RoGK5+aKrEnW
	 we/wy45XOMGk+SGKbAtTv+32o57IPK6Cqg3iKM/Tj0fyG/vd17BcuwNHE9S2GImkd+
	 mN7bzRMpfkJbFuYlWRnpz2B3Q5Uf8gXeCIxZYPf2lxhpxjFeXxaSiBPrESiONw86Cb
	 DEBKiOX5k7UxsR/vsZwAKFjrsoPZj/qulPgpEGhyL+OyMaAE864FqsUwr0bKMQskMH
	 5iPtiBKqytFmA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5112d5ab492so2958468e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 07:57:00 -0800 (PST)
X-Gm-Message-State: AOJu0YxXUq+zRxrzQRZ2+osxjVF5BTw304OLbu+9s/wO7MbB7jxvWHAF
	Af0QzJS46oCZNXHaCZ92aT2cYwIDKxe5BHo4UETckOifr4rfImXqNFBGR8L93K58BgKRJ4u2ocY
	0CMROyusT9jzbHb6D6j2EXa46Szc=
X-Google-Smtp-Source: AGHT+IHqNlvYafMk1+0b461FMWQjXcpspXWu5GnSpp2uz9lVucLsHstGODLsZdjvf2AnS0uXTizXtd6fZqq79gASNcg=
X-Received: by 2002:ac2:420d:0:b0:510:17b1:cfdd with SMTP id
 y13-20020ac2420d000000b0051017b1cfddmr3148277lfh.67.1706889419286; Fri, 02
 Feb 2024 07:56:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121235701.239606-1-masahiroy@kernel.org>
In-Reply-To: <20231121235701.239606-1-masahiroy@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 3 Feb 2024 00:56:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQXw8owCpehxnUQG7upkENMezazzHFsdu9kggcZQLgykg@mail.gmail.com>
Message-ID: <CAK7LNAQXw8owCpehxnUQG7upkENMezazzHFsdu9kggcZQLgykg@mail.gmail.com>
Subject: Re: [PATCH 0/4] x86: vdso: clean up vdso Makefile
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi x86 maintainers,


Gentle ping.

It has been more than 2 months since the submission.



On Wed, Nov 22, 2023 at 8:57=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
>
>
>
> Masahiro Yamada (4):
>   x86: vdso: consolidate targets and clean-files
>   x86: vdso: simplify obj-y addition
>   x86: vdso: use $(addprefix ) instead of $(foreach )
>   x86: vdso: use CONFIG_COMPAT_32 to specify vdso32
>
>  arch/x86/Makefile            |  3 +--
>  arch/x86/entry/vdso/Makefile | 28 +++++++---------------------
>  2 files changed, 8 insertions(+), 23 deletions(-)
>
> --
> 2.40.1
>


--=20
Best Regards
Masahiro Yamada

