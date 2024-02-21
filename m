Return-Path: <linux-kernel+bounces-75579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068CF85EB76
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B464B283FBA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39835127B6A;
	Wed, 21 Feb 2024 21:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b="RvBAoFPk"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A63EEB3;
	Wed, 21 Feb 2024 21:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708552690; cv=none; b=B+0ibRukL//XMpPZuZa8mha4DrJ+fUjzGGmINW+3/s4emqIpGFAW08hAQusFqLzZNa8RNWvtOVhzdO3FkfubioX5yvP9cfDl1fHXPJv2lR8RSAR4izKukYKS+FA/fowjdoKa8K8l0A/h2uYL5VqJfWCo4UYsPzyeRONeshrX8mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708552690; c=relaxed/simple;
	bh=dF9IwFLl0Po1lq5MLlVQLSbQsLpawdVgsA5ipOvGk4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qsbKpO1tQZ4QuMyYtcop5ocM5EcsxGDBuY3nbLXdPeBy/0Rtwemb6YUX6jmrsM7Jq7Nz5XPBvCIl7iqKq2LX0oggtDOT2SRiEdT1i0JAAeUgZ5lYKzskDcGp1gzqxEWC//E+kr/uHEAseNOUVjiZ5GyS4pq+RPWgWAsaBU8r3b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b=RvBAoFPk; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=valentinobst.de;
	s=s1-ionos; t=1708552677; x=1709157477; i=kernel@valentinobst.de;
	bh=dF9IwFLl0Po1lq5MLlVQLSbQsLpawdVgsA5ipOvGk4w=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=RvBAoFPkDZs3ltUxVkZMu5Vo0E+IkHtH4imzi9XFQY6rL3XzqN/UTtCAztj36ViR
	 nSuNQ15iabcrPNMNSv2gjThTnG84DjXv7+A+wwqvpzVeFvkqGjTdLgeq1SGzxCCxH
	 d/J5th/78wf+yDoRAJEtXQP0mz/LVkSUCLczBtKGid7y0Lrbv1IH9U5UbcNfHGk34
	 lSsmbonQfwnnXyz4O/x0UtVEBK83UUTkXvJ/uMqx0yA1FWTBzBzaFtabGCYKgJfWl
	 lvcN7GSAgq3fcN01sD7SGi3pHKyiBNG6K3I3ExmFI0r92xa/UwiAawj+9G8Aq1XhU
	 xLplmZ7BdEdOm26y7g==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from archbook.fritz.box ([217.249.70.154]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MavF5-1r5ms727pb-00cMdL; Wed, 21 Feb 2024 22:51:36 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: miguel.ojeda.sandonis@gmail.com
Cc: a.hindborg@samsung.com,
	david@readahead.eu,
	gregkh@linuxfoundation.org,
	hpa@zytor.com,
	john.m.baublitz@gmail.com,
	kernel@valentinobst.de,
	linux-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	mingo@kernel.org,
	mingo@redhat.com,
	ojeda@kernel.org,
	peterz@infradead.org,
	sergio.collado@gmail.com,
	stable@vger.kernel.org,
	tglx@linutronix.de,
	x86@kernel.org
Subject: Re: [PATCH] x86/tools: fix line number reported for malformed lines
Date: Wed, 21 Feb 2024 22:49:32 +0100
Message-ID: <20240221214939.4715-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <CANiq72=gYWZ24EEqRL71Vh+YjjK9Bu0QfxGEBzee16QAf4Q6XA@mail.gmail.com>
References: <CANiq72=gYWZ24EEqRL71Vh+YjjK9Bu0QfxGEBzee16QAf4Q6XA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WW7p1+B4htmtBfW2x6I9T6uskQjvijUcuFVC6Pqcxdich+azJUw
 qmMgxKKJZsEuziGBdXIaiOokAujPVQlssvay9UqRD4+fLNmAQFZVaXiEkgaluX1HkNVLkW6
 lIdZKx60UPGYU4CJPeEjjvOC5PQs/SQxKZUJjwN/mVlrGoat20iSi59yocWcwAyrsxYrYHi
 Tezy9PHa4OXOnxdT+VwqA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mOOoXRIRWVQ=;kxOewaJtG6hZXrCnHemyZf/SZrx
 QQ/Q+2L73TzGrKO2bu0S6XlU3HcPKWw7Rzm/0CstjBGrSiMIvOMpA3mjerIkMfPA85ENlvqiO
 oG+N6zVs4Jiyzwapz3JUW21+DhI9MhP7kaRmKcAXbRw0Kc+22XNubcetaXPk5ptrIkwHmoNYk
 vuK8EBaL3+OKf4Be+i5yvcYkC5x3Y0VdK9OQUWypSvBaONhscT+X3BhQ8fdYcoq7bj9SgIjlw
 bhHMO35bgNV9JUfexPKDPLgt37o7xkw51NkTKOIwrwSP9QIjWohMwFGVbI26UEOolSena7OZy
 ewPGNvePYYb2DPWNgUvtzdXo4XuIsc9KZZ9AMqltppIzct0YC/sEtimbdQ6Lg0C1x5VewNJq7
 vdbvwrgFkNcoDyFYBbzWIalK/TTAj2PJ9uFM8D4BEKKTZ6YC6WDo8fqM+QNH0Q1IjxVlT3xDV
 V8rKbfhoQiIvpiEq1Vyedm6vckWTllAw4DGAUWCGf7dyXsQcXFYpOHf4y3sBJTEwEgknL3YvG
 RKFlsE7SxFTln3jlDSlSwBnTPk0LOOAR4XeXj9x8duNdzKh2C9M6j9BQ2/KtAdXYdsbF2C/ls
 r+Rc9mbEdx7HdC62kFlQvB1NtLLpz7/CnpWzNoi8PSbig3tlBM5Mreji4uQcfVM6s0EUEqptT
 qHT90jIX3GJ20xOAUDM7E7nxf1Wn9/FCa4RLCpCXDlC/UfQe2/HLvIe9BDoSd+31HqgBJIIYO
 t74x7AwE/GuYbpMlFNajsNmySR/RH3oHaqsCSPu2k2BlYfiv719eUw=

> On Wed, Feb 21, 2024 at 10:00=E2=80=AFAM Valentin Obst <kernel@valentino=
bst.de> wrote:
> >
> > While debugging the `X86_DECODER_SELFTEST` failure first reported in [=
1],
> > [In this case the line causing the failure is interpreted as two lines=
 by
> > the tool (due to its length, but this is fixed by [1, 2]), and the sec=
ond
> > line is reported. Still the spatial closeness between the reported lin=
e and
> > the line causing the failure would have made debugging a lot easier.]
>
> Thanks Valentin, John et al. for digging into this (and the related
> issue) -- very much appreciated.
>
> It looks good to me:
>
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

>
> This should probably have a Fixes tag -- from a quick look, the
> original test did not seem to have the problem because `insns` was
> equivalent to the number of lines since there was no `if ... {
> continue; }` for the symbol case. At some point that branch was added,
> so that was not true anymore, thus that one should probably be the
> Fixes tag, though please double-check:
>
>     Fixes: 35039eb6b199 ("x86: Show symbol name if insn decoder test fai=
led")

Cross checked this as well, can confirm your assessment. Thanks for
bringing this up.

>
> It is a minor issue for sure, so perhaps not worth backporting, but
> nevertheless the hash is in a very old kernel, and thus the issue
> applies to all stable kernels. So it does not hurt flagging it to the
> stable team:
>
>     Cc: stable@vger.kernel.org
>
> In addition, John reported the original issue, but this one was found
> due to that one, and I am not exactly sure who did what here. Please
> consider whether one of the following (or similar) may be fair:
>
>     Reported-by: John Baublitz <john.m.baublitz@gmail.com>
>     Debugged-by: John Baublitz <john.m.baublitz@gmail.com>

Absolutely, without him reporting the test failure and narrowing down the
config I'd have never looked at this file. Adding him for **both** is fair=
.
(This particular fix was not discussed on Zulip though, its just something
I noticed along the way.)

>
> An extra Link to the discussion in Zulip could be nice too:
>
>     Link: https://rust-for-linux.zulipchat.com/#narrow/stream/291565-Hel=
p/topic/insn_decoder_test.20failure/near/421075039

Didn't add it because the discussion does not mention this particular
issue, but it might indeed be good for some context.

Will this need a v2, or are all of the 'Fixes', 'Reported-By',
'Debugged-By', 'Tested-By', 'Reviewed-By' and 'Link' tags something that
maintainers may add when merging?

    - Best Valentin

>
> Finally, a nit: links are typically written like the following -- you
> can still use bracket references at the end:
>
>     Link: https://lore.kernel.org/lkml/Y9ES4UKl%2F+DtvAVS@gmail.com/T/ [=
1]
>     Link: https://lore.kernel.org/rust-for-linux/20231119180145.157455-1=
-sergio.collado@gmail.com/
> [2]
>
> Cheers,
> Miguel

