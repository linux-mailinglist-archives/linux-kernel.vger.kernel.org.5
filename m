Return-Path: <linux-kernel+bounces-42583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB034840376
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED3C91C217FF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CF85B1FE;
	Mon, 29 Jan 2024 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pz7NKky9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93B75A799
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706526385; cv=none; b=nNPB3WYDzSRwuYR39SUBX84cWWKWCj3k/HaFaw+vbG1spgoNAvnodnnS7yYuMOF42rQ/MzFsvq8bZkPUv1mMv5V/c6gPC5dX8NGj5kS81q4//a4jBpnGaZQx9sg4hGsSC6BYpC72rS2Q1FuESUkryBTiiDdIpUqhrhjRIXO0oLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706526385; c=relaxed/simple;
	bh=TnVAwkwndXh3G3bGKC1EQlHHDq8Xhg5GNLD4X/BSEvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uf1oK87ywC1BdZELf0IwEfdbqcOMZxoIpi3g52cBkORolHSR7o3CMuw7a89ciB0gktfjvbkd6TEtMlNMqz2WR4DqGZR4LwK5nXSLvCv6DpEMiA2D+Ukk7LXSNu1koPCFkUCPIm1WRoEHgJRcrU4Ji56XpeFztaiH9wFnpDfVCqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pz7NKky9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F7CC43394
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706526384;
	bh=TnVAwkwndXh3G3bGKC1EQlHHDq8Xhg5GNLD4X/BSEvQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Pz7NKky9U/hfIRx4S3MKi0qS2DxorX9TZC3ZV9WQlHTyUgX/LkvXIk6L5c0CymFAT
	 yj/nIH7Oz9Mzuc0SJsyvYRPRCxKg3qnWEYwtMdRPllvzhO2x8NquljyL61uImK+OI1
	 K/P3Fz/FBBy9vz702tgCYy/EDFY0NfFg8AyNESbxHEene/m+fzByEy7fdI4pQkK0nq
	 pcqxQysrbZoqjO9dBKdtCYZ5QYEUXYbUOSnmXufe4Hk+Bwf4uSJGtZd4/44o6FQORt
	 ojEK+3uUtmk4QKm/tM5NiwMI3Oe/EHTJThLkmpKiWPH2bM3X40lIF/idG3C9Bl09RS
	 gexgfWQMi8xpw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5102b00c2cdso1659881e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 03:06:24 -0800 (PST)
X-Gm-Message-State: AOJu0YwFiJEFykK8k1GMACBw5nE4LTHbjnY+52vohM4J9uxPPsQBozMt
	90bI8aw3oJto8tjSGeUn1mkxwqRcSDuT9y/0IcTyN67Yrl85OaJRB+QvdB9DzB9mOZrxFktDcPi
	ux8KDdySSRaozAEApIsqokSLaR+M=
X-Google-Smtp-Source: AGHT+IHKaolwTP3TqaX2Qrfhbe3cV4oebtLBiGehaQv+hguucdfgWrnqQb8eonBgKBJ/qW/2cWU4ZUDaDI6rbTed/6U=
X-Received: by 2002:a19:e01c:0:b0:50e:a91d:422a with SMTP id
 x28-20020a19e01c000000b0050ea91d422amr3184140lfg.29.1706526382680; Mon, 29
 Jan 2024 03:06:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126163918.2908990-2-ardb+git@google.com> <20240127105240.GAZbTgeOwAmYbSfgXR@fat_crate.local>
In-Reply-To: <20240127105240.GAZbTgeOwAmYbSfgXR@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 29 Jan 2024 12:06:11 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH-RMhkQMWq0jVWbp=UgsE0=k0E-6cMN32rsYuANWY+6w@mail.gmail.com>
Message-ID: <CAMj1kXH-RMhkQMWq0jVWbp=UgsE0=k0E-6cMN32rsYuANWY+6w@mail.gmail.com>
Subject: Re: [PATCH] x86/sme: Fix memory encryption if enabled by default and
 not overridden
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikita Zhandarovich <n.zhandarovich@fintech.ru>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 27 Jan 2024 at 11:53, Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Jan 26, 2024 at 05:39:19PM +0100, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Commit cbebd68f59f0 ("x86/mm: Fix use of uninitialized buffer in
> > sme_enable()") 'fixed' an issue in sme_enable() detected by static
> > analysis, and broke the common case in the process.
> >
> > cmdline_find_option() will return < 0 on an error, or when the command
> > line argument does not appear at all.
>
> Is it just me or cmdline_find_option() should be fixed to return 0 when
> there's no cmdline argument and < 0 only when there was a real error
> parsing?
>
> Hohumm, sounds like a TODO for me or someone who wants to audit all
> callers and fix them up accordingly.
>

I intend to propose removing this occurrence entirely, and move it
into the EFI stub/decompressor.

Parsing external input in security related code when the entire kernel
is still mapped writable is kind of gross, and since I'm cleaning up
the early PIC code anyway, might just as well rip this out.

Another issue here is that it does not honor
CONFIG_CMDLINE_BOOL/CONFIG_CMDLINE_OVERRIDE. I.e., if memory
encryption is enabled by default, and the kernel is configured to
ignore the command line, the current code will still disable memory
encryption when mem_encrypt=off is passed. Probably not a big deal,
but unintuitive nonetheless.

For the other cases, I agree that this would be a good thing to clean
up. Note that someone has been looking into the handling of the
command line recently.

https://lore.kernel.org/all/20231110013817.2378507-6-danielwa@cisco.com/T/#m817c573e25f6f7da237272178a8f6b116192a6ad

but I am not sure what the state of the code is, or whether the
approach is the right one. I was meaning to look at that but haven't
found the time yet.

