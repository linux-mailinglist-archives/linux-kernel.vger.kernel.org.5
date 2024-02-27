Return-Path: <linux-kernel+bounces-82514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740418685A6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31C61C2173B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6234C6D;
	Tue, 27 Feb 2024 01:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2A2XetG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD70E23D0
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708996564; cv=none; b=s9rxoWjLddyReETsXBmwIwgorpjOstXYDttBPn5ecl6MQg9xJJ2a88kNqi1qDFE3i6O2XMiWbre9QJUlX7CYSOrPIrGsqVGqLA+OhzSHxieAgzhLPF/atmmcXxOyHk07lAYfneyJtXozKx6bBf8D8cIloHKaq0tiDRLbAIrraPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708996564; c=relaxed/simple;
	bh=kBGrvbSRlRLnVicTFJpreNPon70Basc5aHlUoOOm/Ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T1Zst3BCqJx7J4I0UVzZ4twImolgJEhXPBJmp8Ormxfty7ARDydocJoqla0iIOEOwA2LYdB5HEi4aurP1BmEO+T8bXngzRRW2Ap6uB7VWVH/QPQM/cxRMAkDbdFhdDkYPNCeIsfODVqepWVzHsMqEqdDvfANaSxbRlBa4D8QCI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2A2XetG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C20C43390
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708996564;
	bh=kBGrvbSRlRLnVicTFJpreNPon70Basc5aHlUoOOm/Ns=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K2A2XetG+eBGqGxXm7AAVV5Gh/V7TCGONV/LN1UNcPA1DV1TTN01yiNYFNema3KSh
	 Aa0f/aYOEAhN2v/xCRCLFA6tfFTTh3+mht8nWHE0gzozma/gyIS7jjlXcPWntJzDTB
	 Cm7efls2jyzP/7kXrO2ErD4Inya1AG6G8qZTCr0IcvuwIUS+HQLSVJa9k9hIqiEn9R
	 Uy4/q4MrByBKTY0V/u5gKtKNnMfyCrqxsH3MAQLxHZ88T9sBjC0GByXVjULa/2JlLc
	 gcfgdDzw4fMeDnMCKDRY1MP3cPWYgZtkArQxnJgBCm2K5FCeTMn2LyJ87tQaUJzYIX
	 O4Vv+IBP7I7Zw==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso4582325a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:16:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWBbCNQx2sazFfSKQ/urmBTFg2qA4LoQgI+/T8ZCJW4v9qwexjgigUZpePVutCZhi6YA18COa02VOj2GEWa76ucxVZjqpi83U4J3eF2
X-Gm-Message-State: AOJu0YwIWx0THnfLCeqOPZg+AW3f1c1xlml11SsUQGw09Gufg+hPEcs3
	zW1pYy2u2Rl3OgFXve6AO8UIAl7JN+RpC38NJt/elMFfaLl2vb1NcuyM2qTlh+g9hUwqbDlocvd
	FXhP20pIQNB4FukduFIWU1bfj42U=
X-Google-Smtp-Source: AGHT+IGpOays5UZ8vBtnwcbyePxBQOQ0iVEMo8+JLIlwy5JlqlTTfpH9lPMbEJnRP1d93zV0NRH743gJXC+xt3vconA=
X-Received: by 2002:a05:6402:3587:b0:565:a5aa:22e4 with SMTP id
 y7-20020a056402358700b00565a5aa22e4mr5591891edc.33.1708996562715; Mon, 26 Feb
 2024 17:16:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <738d3b74-1e10-4eb5-8c0d-1db33feb740a@intel.com>
In-Reply-To: <738d3b74-1e10-4eb5-8c0d-1db33feb740a@intel.com>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 27 Feb 2024 09:15:51 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQcdg7LErGec_Omh5V7ewZ9zFnmH_Mt_aLjU+QQw5-4KQ@mail.gmail.com>
Message-ID: <CAJF2gTQcdg7LErGec_Omh5V7ewZ9zFnmH_Mt_aLjU+QQw5-4KQ@mail.gmail.com>
Subject: Re: riscv syscall performance regression
To: "Wu, Fei" <fei2.wu@intel.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 1:29=E2=80=AFPM Wu, Fei <fei2.wu@intel.com> wrote:
>
> Hi All,
>
> I am doing some performance regression testing on a sophgo machine, the
> unixbench syscall benchmark drops 14% from 6.1 to 6.6. This change
> should be due to commit f0bddf50 riscv: entry: Convert to generic entry.
> I know it's a tradeoff, just checking if it's been discussed already and
> any improvement can be done.
>
> The unixbench benchmark I used is:
>         $ ./syscall 10 getpid
>
> The dynamic instruction count per syscall is increased from ~200 to
> ~250, this should be the key factor so I switch to test it on system
> QEMU to avoid porting different versions on sophgo, and use plugin
> libinsn.so to count the instructions. There are a few background noises
> during test but the impact should be limited. This is dyninst count per
> syscall I got:
>
> * commit d0db02c6 (right before the change): ~200
> * commit f0bddf50 (the change): ~250
> * commit ffd2cb6b (latest upstream): ~250
>
> Any comment?
1. I think this is about generic entry performance, all architectures
should move to that framework and improve the generic entry
performance together.

2. Another point is there are added sched functions in the generic
entry code, so using a simple empty syscall can't show the benefit of
generic entry.

3. Could we use vdso to improve getpid?

PS:
Now, the syscall arguments are using pt_regs instead of
syscall_wrapper, which broke the rv32 syscall, ref:
https://github.com/T-head-Semi/linux/pull/5

>
> Thanks,
> Fei.



--=20
Best Regards
 Guo Ren

