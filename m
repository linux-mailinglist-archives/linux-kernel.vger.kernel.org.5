Return-Path: <linux-kernel+bounces-150346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94238A9DB1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3071C2017E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3502B16ABC2;
	Thu, 18 Apr 2024 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pf47Y+eM"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661276FB0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452196; cv=none; b=ggKWrokJGKAdQFySEdcaabFawSM/oxtEq5WisXucE2GxTiOA33zwGTGy290DPqmTHUAS//FMzghVOcdHG3Hs1+KP14S1tW2p25MrEIEl0ZJ3xjoKuw840KschCdcrZ5cA5uUP1o6HNktRL1NTaqqLRfZt+c0WaXDlWdg0n6J7oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452196; c=relaxed/simple;
	bh=LCgK1Nl7X6eiOEgLnSDHPjrE4OmWhWaXYy1AgFyQE4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bL7pUsLkf8P0ggFt2lNuO+S2wGifKEUTYslqT89RUtCOqOiL5C4y0xX0C7hjFurn9Yjh5LnZ9qHYR8/fuo2JS/BQb5D6jhMKwoFZne+Z+/7FgDSeUWcRz2/L/kpLx63Verc9slMc8ugST01QKGeTWLO9qNXypU936dcPBXMXEUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pf47Y+eM; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-de466c64163so806851276.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713452192; x=1714056992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4lP11AC4mEgAygBmUrYdUs5fesWy/SPsDBJGp96UBo=;
        b=Pf47Y+eMT+p3ZzFS/PCe8WBSpgREFwme6x77bmIOwtmxRZalN0Wr2VPqDVYrQ/sK5A
         MZqSo1DF+vVUK1Tm1RJ9cLFAvAA8J8C/FLG63CtA8aHA1Q6SDI+q1hYJppLvtqWz0mkl
         grG8ywpcR1J/0o294kRuffKkS20NTJULm7bDSW0sX/SQAirRllihO9AMCfRi43zW04/T
         fivg2GkbKsV6Bm51SLJcQmQLOy6XkLgbQ2vXTTqi7LBJ56qPuwVm56AuYPMcv5CFswtl
         5O9+vUP83JKMldlcYxKpLx29A4EFFpGfg5fyb1YaezrGya1T8t8s4mMWHl3TdatprsTl
         7n+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713452192; x=1714056992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4lP11AC4mEgAygBmUrYdUs5fesWy/SPsDBJGp96UBo=;
        b=tQbm6nmm+4Zd+MmY18Hsj87MENZBSqzo82a4c0ZpSrkIwrJjAYrXBAVpwyAfnp9I+1
         tm4qDzN8FxU/hO3y6ywwyrBj11QJXc+z0Vwtav29y/iGwDSQQrKfhTqoa33hMZH4MlhD
         UwSB2RWCthwMlr8qwwjYXyj/20pqpLuNobFB4w1hmnPEFZ1zzWbKUG8XDuO0WmDbVNgA
         NuUZCHPE6iNkgRMfKtznGUk4DQKV/hS1yyEQwjFD+elRaIH6V0o+7M/hvk95wqGXcAcF
         UgxE48kQ4orX0kWpTGU9qc3Th8Kk0KUKRWAXrupVksmUuhh8wGbnXiNbTIUF87OovE8L
         7nug==
X-Forwarded-Encrypted: i=1; AJvYcCUgbD1c54eeG7A5sL3LJ/RDXEOCO4c874g6V99dmwMyghEdhtZlO2UNJ95IJ4hRKHrYQoGKYnDCKPpkzYDHqM6KjejngBFOMHaL4Q0z
X-Gm-Message-State: AOJu0YyV+Wgej8eV5wSQrt6yExZTLT5BC8pcomqJaeSb/AVcD/vnnm2k
	WvqK5eBlDJ3j0OfJVq+j/TpPX6TqON+3G6aRtwBdhxTJIL8Vf/VpDgFI0dhhgHtf5mLRxQ22y/H
	MS5udyc6I3oyk28jGjIgl5Om4gdQr9608obn+Tg==
X-Google-Smtp-Source: AGHT+IFYsnYxZkuoVUYNlb8Ts5dFS8t8z3/D+sz6e79RFN3U2QXIkbUK1DFABjBRkpsq61z+xoVBtqPAJ7iR6Mrk2nI=
X-Received: by 2002:a25:ae1f:0:b0:dcc:787:e8f9 with SMTP id
 a31-20020a25ae1f000000b00dcc0787e8f9mr3107129ybj.51.1713452192453; Thu, 18
 Apr 2024 07:56:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713348705.git.geert+renesas@glider.be>
In-Reply-To: <cover.1713348705.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 18 Apr 2024 16:55:56 +0200
Message-ID: <CAPDyKFqSmBOgiUumtctsd71_Ee1LqZ+vuZ87SkUYVPYT0VStNA@mail.gmail.com>
Subject: Re: [PATCH 0/4] pmdomain: renesas: rcar-sysc: Cleanups and R-Car M3-W
 quirk handling
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Apr 2024 at 12:31, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
>         Hi all,
>
> According to the hardware team, R-Car H3 ES1.0 and R-Car M3-W have a
> rare quirk where powering down the A3IR, A3VC, and A3VP power domains
> requires an extra delay of 1 =C2=B5s.  So far upstream never handled that=
,
> but the BSP has a fix[1].  As support for R-Car H3 ES1.x was dropped in
> v6.4, only R-Car M3-W still needs to be handled.
>
> The BSP fix relies on hard-coded string comparisons of power domain
> names, and thus applies to all R-Car Gen3 SoCs (many introduced after
> the original fix was written) having domains with a matching name,
> whether they are affected or not.  Hence I took the opportunity to
> refactor the R-Car SYSC driver first, and came up with a less-intrusive
> fix.
>
> Thanks for your comments!
>
> [1] https://github.com/renesas-rcar/linux-bsp/commit/495e47e390499c522197=
352a08f423e8a3b41e83
>
> Geert Uytterhoeven (4):
>   pmdomain: renesas: rcar-sysc: Absorb rcar_sysc_ch into rcar_sysc_pd
>   pmdomain: renesas: rcar-sysc: Split R-Car M3-W and M3-W+ sub-drivers
>   pmdomain: renesas: rcar-sysc: Remove rcar_sysc_nullify() helper
>   pmdomain: renesas: rcar-sysc: Add R-Car M3-W power-off delay quirk
>
>  drivers/pmdomain/renesas/Makefile             |  4 +-
>  .../{r8a7796-sysc.c =3D> r8a77960-sysc.c}       | 34 +++------
>  .../{r8a7796-sysc.c =3D> r8a77961-sysc.c}       | 28 ++------
>  drivers/pmdomain/renesas/rcar-sysc.c          | 70 ++++++++-----------
>  drivers/pmdomain/renesas/rcar-sysc.h          |  9 +--
>  5 files changed, 43 insertions(+), 102 deletions(-)
>  copy drivers/pmdomain/renesas/{r8a7796-sysc.c =3D> r8a77960-sysc.c} (64%=
)
>  rename drivers/pmdomain/renesas/{r8a7796-sysc.c =3D> r8a77961-sysc.c} (6=
9%)
>

Applied for next, thanks!

Kind regards
Uffe

