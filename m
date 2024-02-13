Return-Path: <linux-kernel+bounces-64280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC8E853CC7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308011F2526E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A351478669;
	Tue, 13 Feb 2024 21:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b04k04Kq"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A073A77650
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858320; cv=none; b=hS/3L4yPpdz0YOxNAB6EBPrhmaFdV6CRJjkkbzRXKvMCR/nA84coML3+haMvWnxQP8MDTDz4s99PAZNYoOe8YaJg25XhNPtJeW4YppZC8l4FL4r8cJ0b5UkSynxJ+AAmfwZmOIKHTYuzlp9GDszS7LYlGZilYH7UvR4Y2n6oU8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858320; c=relaxed/simple;
	bh=slvPZNAhdUhtLT6LxI9v3D50Iqbpq8FOHzaAde3HX00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pew8l0V2EnXe7A/rttm30TY2D6S92KuoQmcc9v0jzxkfCUjOsYGOZ5EtPb9JWm21wEt4cfZXTtmB2//hAPFXzrMOzYnZxhxj4ntXUivKoaJKD3Mmlvc/9+V/n6tHAnGyKI1Rb3pIpbj6BT21Zu21cp6i6dvfGtjJkyUqI4c4OrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=b04k04Kq; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-511a45f6a57so127705e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707858314; x=1708463114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySOOdg4wYWt6f6vHtFlMsiVLUg95P8J28FlWNKszByE=;
        b=b04k04KqhWKWoLdxZtZ/U8kjSTN/IF8QbVwh6+tI1FlvjDSJ3Aha3Hhm2DRBgilcn0
         D+pAitxxws2jWxQpZVDWMMOAnv8PIIZlMVCiD3rhBlB0pun4Jf9z5MFjop8QIyndEUXJ
         VCsW+et9L7GbiTJw5e0mfRyf4NAiCvNtulxpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707858314; x=1708463114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySOOdg4wYWt6f6vHtFlMsiVLUg95P8J28FlWNKszByE=;
        b=UlVrv9d/4HsrrTGkoQTKKwLdfTMoq3lepJDGANxukAF1mhr1DEjtWCaUIGkEcnAX95
         8tO2I0sTwZPhfs5aUqJXV3p7RhJNaJ1a2P8tziH8xNN9irW4Ru0woVWnZIXk0MPdDDuS
         6siiQ3K+V05kSrOoVOdvzZrUvMUlQnqxZkt6zHMNE3Q64pBpgbaGZDfCEIvfOIRhcpS4
         S0OYJS7e9CGEFveyRv+PLz0s1wyzrPYpcErnEODvg+k2ZNlAItNbrA6G2Mw7+1S2gV9y
         z87DGWsOLg6VoGPWab+bOlA1fEN+6GX8/9VsiJUbMwgT29EJJylLeWza7FjkRChiee1b
         0GRA==
X-Forwarded-Encrypted: i=1; AJvYcCWG0whDuqUREfpoQv+B7ynRPIL5orhI+Kq5lfEmnYhJ788GmTNLIDcCeyarCv0erUniKafE+XPlSBl/JZjb+fuBqicj+lJv6XfuyYVU
X-Gm-Message-State: AOJu0Yyp8Oov6uhGgHpZfG0AFET6FH+LkDPE2Bkf0DfTUSY/m9DYIJUJ
	v3siCA0kYq/yXc7C2rlykiR4T+k6xzJQpSHXNz1f7aiG39zkx7IB6l6YDkZvGcn9xOP6abRk25c
	HAg==
X-Google-Smtp-Source: AGHT+IHDO3iRdgBTK35tjDnHAXLb5um1I3qRPa9GcxqFF6iy7PCSd5/CKc2r6BGJdfpWwCyeS8c8Ow==
X-Received: by 2002:ac2:5bcd:0:b0:511:7abf:45f with SMTP id u13-20020ac25bcd000000b005117abf045fmr554031lfn.63.1707858314215;
        Tue, 13 Feb 2024 13:05:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWrEhwxAKMSnHu7Tm2p8pStHw1XyaNPc8J9CNZvIJze1z6sPN5i3Q/4XD9+EitEeiWjuJBs6DMUkICCK15FyXBduEmEhgOvZiFKdoBJ
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id lj8-20020a170907188800b00a3d22f53210sm432356ejc.188.2024.02.13.13.05.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 13:05:13 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-411d9e901dcso30565e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:05:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUxpMoqvH5DTPEq972S4IOMF3R4SycV9cfAH3Deo/0CzRtMmF7T2V2h4Q6u9A0Br5gPzG6lEHqrjg4AUyGHhgG7BG+BdY1JiqUcLwYL
X-Received: by 2002:a05:600c:a384:b0:410:69ad:b169 with SMTP id
 hn4-20020a05600ca38400b0041069adb169mr29863wmb.3.1707858312975; Tue, 13 Feb
 2024 13:05:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213-arm64-sve-ptrace-regset-size-v2-1-c7600ca74b9b@kernel.org>
In-Reply-To: <20240213-arm64-sve-ptrace-regset-size-v2-1-c7600ca74b9b@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 13 Feb 2024 13:04:55 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UaLTtjhHdKDj=g6xzcAZjU+9XvQ8GCYyrwq5oWTec1dw@mail.gmail.com>
Message-ID: <CAD=FV=UaLTtjhHdKDj=g6xzcAZjU+9XvQ8GCYyrwq5oWTec1dw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64/sve: Lower the maximum allocation for the SVE
 ptrace regset
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dave Martin <Dave.Martin@arm.com>, Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 13, 2024 at 10:24=E2=80=AFAM Mark Brown <broonie@kernel.org> wr=
ote:
>
> Doug Anderson observed that ChromeOS crashes are being reported which
> include failing allocations of order 7 during core dumps due to ptrace
> allocating storage for regsets:
>
>   chrome: page allocation failure: order:7,
>           mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO),
>           nodemask=3D(null),cpuset=3Durgent,mems_allowed=3D0
>    ...
>   regset_get_alloc+0x1c/0x28
>   elf_core_dump+0x3d8/0xd8c
>   do_coredump+0xeb8/0x1378
>
> with further investigation showing that this is:
>
>    [   66.957385] DOUG: Allocating 279584 bytes
>
> which is the maximum size of the SVE regset. As Doug observes it is not
> entirely surprising that such a large allocation of contiguous memory mig=
ht
> fail on a long running system.
>
> The SVE regset is currently sized to hold SVE registers with a VQ of
> SVE_VQ_MAX which is 512, substantially more than the architectural maximu=
m
> of 16 which we might see even in a system emulating the limits of the
> architecture. Since we don't expose the size we tell the regset core
> externally let's define ARCH_SVE_VQ_MAX with the actual architectural
> maximum and use that for the regset, we'll still overallocate most of the
> time but much less so which will be helpful even if the core is fixed to
> not require contiguous allocations.
>
> Specify ARCH_SVE_VQ_MAX in terms of the maximum value that can be written
> into ZCR_ELx.LEN (where this is set in the hardware). For consistency
> update the maximum SME vector length to be specified in the same style
> while we are at it.
>
> We could also teach the ptrace core about runtime discoverable regset siz=
es
> but that would be a more invasive change and this is being observed in
> practical systems.
>
> Reported-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> We should probably also use the actual architectural limit for the
> bitmasks we use in the VL enumeration code, though that's both a little
> bit more involved and less immediately a problem.
> ---
> Changes in v2:
> - Specify the value using the size of the bitfield it goes into.
> - Link to v1: https://lore.kernel.org/r/20240203-arm64-sve-ptrace-regset-=
size-v1-1-2c3ba1386b9e@kernel.org
> ---
>  arch/arm64/include/asm/fpsimd.h | 12 ++++++------
>  arch/arm64/kernel/ptrace.c      |  3 ++-
>  2 files changed, 8 insertions(+), 7 deletions(-)

FWIW, v2 still works for me from a black box point of view. :-P I ran
the same test I did from v1. Repeating here:

Confirmed that when I send a "quit" signal to Chrome now that the
allocation I see for "core_note_type" NT_ARM_SVE goes down from
279,584 bytes (n=3D17474) to just 8,768 bytes (n=3D548).

Tested-by: Douglas Anderson <dianders@chromium.org>

