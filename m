Return-Path: <linux-kernel+bounces-29417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749C2830DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294E51F23B18
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D606E24B32;
	Wed, 17 Jan 2024 20:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sd+ghtGJ"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50CB24B2F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 20:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705523393; cv=none; b=PMlRT/CXNc9d3wCAb7VkKLu8taijw9VNJf2EZjXTxgZfSBAfgyqgnTTx8hR4SJjIDFjST7PfbXR9aCxYb1dxSVcM3kvoutqzOALFzBuzDJ9pp6n3SIWdM7/yQjwtITTnj7fr4BWq213+4gqVCO0JuKujw0LLaOGxTBBPLmt+x30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705523393; c=relaxed/simple;
	bh=YD575AqDWxtRQQng31p0N7tpxf/VKKoFokMvFPXs22A=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=IIJLsKGjoVc3qPve3UEpxbZq3g79DPDic24wv7D0+3bQZvlJ6NGd/nsm6ufXjhd/crmPIhuW/Q3UMRsXrCA1f8nfReqq6b6PDudRNCZJieT3+4uO1RHJpn9bleDxhItF0ScjgbUL9Ib1MWXxrm4XC3Ks/5PuTCkwDLr8LCLCbRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sd+ghtGJ; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7ce3c7566e0so2843982241.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 12:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705523390; x=1706128190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YD575AqDWxtRQQng31p0N7tpxf/VKKoFokMvFPXs22A=;
        b=Sd+ghtGJGDgR+cV1CO7AXrnYre/xniCvNl0iyzZ9mORv140T6ZC9rHVjbOaqroBnYU
         PPqv28JUMkw/selk4LCW0Iey3oUIoJ2kgtQjyhSy7UVIp0wU1GBug8INCoLaPq8XjUjC
         QnxmrJmU+mSU316rXvvKxx2KABd1ej/2ZY5OCExCaluyxb2o+Y+3pt3Lp62Ez6ZKUZa1
         +VzQhWg1oGV9GDbGu66fo1LC2qWPsSDYJreNjx2UB17eP3IRq9YFPJCrB9DPxpvDvfe/
         Ut2BTo1I5Q99ESfWgc+JoLEyNhiV9UAEM2r4mN80DzKhP74p6l1njIzQPFmf+IjjR7On
         BaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705523390; x=1706128190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YD575AqDWxtRQQng31p0N7tpxf/VKKoFokMvFPXs22A=;
        b=pTMGsi12q5+B/jeRIyAx+RXNhTV1hrdvZuuW47l3GJeQzqiYTunFNvpSkqFGtoEEyJ
         F3UVd3t77gAnVw3cwJi5k+bk8wN5xfiRNXS37zAPocIgPMm6c54k7yGBSpZEMDxtGbFJ
         /6y29Ay1nA95dU4uVby15UwcChdKzayp6o9DUTogyUuSVQizRBtm7GKpHn4Z9HrxAEpb
         b+g3nHQ4ySKtb7h9p43/FUv+bZilEP9Von60GviKz7muPuoJhsWT2np9c4BDwm/JQikk
         bzxyz4TGEL2saAgoFwQ8gcNZEeVcDjOZ0akmE+H2fl/DOE6cYcZyJ2zIMizoAe/PdJ49
         3xSQ==
X-Gm-Message-State: AOJu0YypnUxgPiGXoLH4+IG0ievW8OGjsNtwWxghNEO2JCUeskJQa9In
	E7UYnLSxYMXUhSCTzNK+vpUOsxnG7u+ME9I/MA9LjgLP/fyr
X-Google-Smtp-Source: AGHT+IEcHVbqKvU1d7EVd9t6CRSCb7KpK6x0WFogReXb/nzS1/CfbAfHDdma8k5FrNqyvEeozP9wt5g6lskJL31I8Ig=
X-Received: by 2002:a67:ef8b:0:b0:467:ddc7:e7c0 with SMTP id
 r11-20020a67ef8b000000b00467ddc7e7c0mr3765571vsp.17.1705523390532; Wed, 17
 Jan 2024 12:29:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230929211155.3910949-4-samitolvanen@google.com> <mhng-f0a257c6-a1f5-41db-b1c4-c178a77a79e9@palmer-ri-x1c9>
In-Reply-To: <mhng-f0a257c6-a1f5-41db-b1c4-c178a77a79e9@palmer-ri-x1c9>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 17 Jan 2024 12:29:12 -0800
Message-ID: <CABCJKudpbeJ+Orie3oMiWrYS0qsh+ZxXbz9tTJcHKvJjiOX+=Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] riscv: Increase mmap_rnd_bits_max on Sv48/57
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, 
	akpm@linux-foundation.org, keescook@chromium.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Palmer,

On Wed, Dec 6, 2023 at 5:14=E2=80=AFAM Palmer Dabbelt <palmer@dabbelt.com> =
wrote:
>
> On Fri, 29 Sep 2023 14:11:56 PDT (-0700), samitolvanen@google.com wrote:
> > Hi all,
> >
> > We noticed that 64-bit RISC-V kernels limit mmap_rnd_bits to 24
> > even if the hardware supports a larger virtual address space size
> > [1]. These two patches allow mmap_rnd_bits_max to be changed during
> > init, and bumps up the maximum randomness if we end up setting up
> > 4/5-level paging at boot.
>
> Sorry for missing this, I'm just poking through old stuff in patchwork.
> As far as I can tell this is still relevant, the discussions are just on
> the mmap() bits (but we'd already screwed that one up and have since
> fixed it).
>
> So
>
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>
> in case someone else wants to take it, but I'm OK taking that MM patch
> with Kees' review.

Is this still on your radar for v6.8 or would you prefer me to resend
the patches?

Sami

