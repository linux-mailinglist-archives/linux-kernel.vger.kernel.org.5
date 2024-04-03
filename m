Return-Path: <linux-kernel+bounces-129204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4171D8966E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB30BB27327
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FB46027E;
	Wed,  3 Apr 2024 07:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhqBeS8t"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151405C909;
	Wed,  3 Apr 2024 07:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130243; cv=none; b=jPHESsqv3yF5b/KsYKzzklxKiryckEzROkY8M0UVK389evqSVGCE+MsahUG/gEDACk5R+if1IV+mFzxQcpork+ElR7cpJie/8tzv7f/AWBqlOrJ39alEPz++Fy62hn4VRBJMFG+sfJ2Ydp0wQLF86q1FAtiTD7n5B+BcKUvQUd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130243; c=relaxed/simple;
	bh=WxT2NrqKc9rZ+AczxjU/VMrhScF5GqxfG8yAuJSLpw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQqS19xs2pTPn1jm2A9xYu+EIq7QPRb4VJFM0pgf3djCrTQsvtlSWfRblsvSNNwo6PcDk9YnPyuOWZLpqGf/rlQ14KqKA2DRafShPm/gfuZNbYKvXsm8UmAqKAQ3KcR47C9tp2p6KNzyWXMFIP3GR90tlGWaLp7OLhoWTHv5bJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhqBeS8t; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d8129797fcso41177221fa.1;
        Wed, 03 Apr 2024 00:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712130240; x=1712735040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Aw6SnPFSKMPLWv57SKdwOjvO7+j+ocypSzZRlCpxvg=;
        b=FhqBeS8tRqnMkBpGjftxwSuPsx44FCris/pSRpDLTY58bokBNi2Bt6jGAokoJvNNcP
         dLAOrvTvA9dYvtl6j3O+7XJ8uGx03ZXL8J/gfXU61QFot3kxakhTfWBfwDDaTFsikhjo
         OFYRilcoTsCQ/UoxeXFydkAXoJauNQVCpTHQdxda4FpOtIai/qlRYvCTTgddHbyMbAdr
         LHeShnPPh9Ev+cOorX+6SFgQtVJ9k/Cw0EARLih68ANi1lteoiSav1cr/h/hBr/vVlEk
         Sr6EtNXl0pHWASp/++Myg0ADCl5lALrf3d5umwz7S/we2qkpaaA2TvhS/mVdpTrvTyte
         uUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712130240; x=1712735040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Aw6SnPFSKMPLWv57SKdwOjvO7+j+ocypSzZRlCpxvg=;
        b=BnSu0/92nuetQZ1hbjCV5D6LSrDY8Krv/nvo0RbAPXIC3Y/LZRzPRqRMAeabSnHEvF
         csdYdR3NCb3wVdH/KJaruwilmH0JfyBl4Gc2IDVsAMi7xO2KQqA3y6D3mMNtIB2iU4R6
         Ido+Vt6VyVsVHBrTHHyNigQTB++umcIGvyLNG4OvxDlM5H70S/eeQyUqCsHSFh9AoVcv
         g0Kja32aBMnjlfrzu6vX+HKh8eVkwI0DjY98p4gcgk6gba4kJS/nLEaftg53GcPNhmXX
         lxrFH6PteZU1l8JRyr2O0N7PZqyBiXlA70VGJyBCHTRIwL2Q6GWhu3KRG9k4ZBvC0sEZ
         c2NA==
X-Forwarded-Encrypted: i=1; AJvYcCUa8VlLDGZt7QoQc0wc+PNmDl6885GZidv6CV0ZU4JkcKiyfA43bsk+HTd18kLmi07qKJdqXV0v8Qe3Gu1Qs2i1QKICjoTZRYebhaJajI9Q/VzJNMCc+LZTXoq3bw0kgq2AUYfI4bQntq8ags+ZXnKnIvdIK0G2ROfb
X-Gm-Message-State: AOJu0Yww9OuEjgTlLta01bSVNNKQmmydRiDyThVnqgRbY/+Gxq0tQ2cR
	oKhNQcjjBbzxWBhE++tmAJtf4v2E4zDw+Mx0K6U178u1mlvof7J2gSbqjO7vK1W5qAOrVN8R2aa
	UPj8fimRGtBv09DHgBEUS700YOVg=
X-Google-Smtp-Source: AGHT+IEV0+wldfYSrTvITy5YoiQhHmuY2y9giFihTstsngpgLda37H+mQISf5eyBJQsaiP/CU0J3GyNEJuN7h9OKK7w=
X-Received: by 2002:a2e:8895:0:b0:2d6:c672:b301 with SMTP id
 k21-20020a2e8895000000b002d6c672b301mr8231316lji.50.1712130239881; Wed, 03
 Apr 2024 00:43:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401185821.224068-1-ubizjak@gmail.com> <171203102833.24910.7566029980709800852.git-patchwork-notify@kernel.org>
 <Zg0EtEkIIA45cuPT@gmail.com>
In-Reply-To: <Zg0EtEkIIA45cuPT@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 3 Apr 2024 09:43:48 +0200
Message-ID: <CAFULd4Z0RmiWu4Kf0YFBMqA7YFMd65f3J760Do8-h83zWCx9oA@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf v2 0/2] x86/bpf: Fixes for the BPF JIT with retbleed=stuff
To: Ingo Molnar <mingo@kernel.org>
Cc: patchwork-bot+netdevbpf@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	x86@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 9:26=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrote=
:
>
>
> * patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org>=
 wrote:
>
> > Hello:
> >
> > This series was applied to bpf/bpf.git (master)
> > by Alexei Starovoitov <ast@kernel.org>:
> >
> > On Mon,  1 Apr 2024 20:55:28 +0200 you wrote:
> > > From: Joan Bruguera Mic=C3=B3 <joanbrugueram@gmail.com>
> > >
> > > Fixes two issues that cause kernels panic when using the BPF JIT with
> > > the call depth tracking / stuffing mitigation for Skylake processors
> > > (`retbleed=3Dstuff`). Both issues can be triggered by running simple
> > > BPF programs (e.g. running the test suite should trigger both).
> > >
> > > [...]
> >
> > Here is the summary with links:
> >   - [RESEND,bpf,v2,1/2] x86/bpf: Fix IP after emitting call depth accou=
nting
> >     https://git.kernel.org/bpf/bpf/c/9d98aa088386
> >   - [RESEND,bpf,v2,2/2] x86/bpf: Fix IP for relocating call depth accou=
nting
> >     https://git.kernel.org/bpf/bpf/c/6a537453000a
>
> Just wondering, which kernel version is this targeted for?

The whole series is intended for the current mainline (v6.9), this is
why it is developed against the bpf (*not* bpf-next) branch. Please
note that the kernel panics with retbleed=3Dstuff even without
%rip-relative changes (patch 1/2 above) [1], so patch 1/2 should be
backported to stable branches.

[1] https://lore.kernel.org/lkml/20230105214922.250473-1-joanbrugueram@gmai=
l.com/

Uros.

> The bug is upstream as well, so a fix needs to be sent to Linus.
>
> I can pick all of this up into tip:x86/urgent, if that accelerates
> things.
>
> Thanks,
>
>         Ingo

