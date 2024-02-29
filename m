Return-Path: <linux-kernel+bounces-87103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 507BD86CFB2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684001F22DB0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFCD3BBF3;
	Thu, 29 Feb 2024 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bJuiE59u"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8930E2E3E1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225491; cv=none; b=Fla36iBuIGJMahGAhtSK64uUce2LzWGbfkKQ/lIGYR/GkulRNT3tDAfsNqVSVajHtEYQa7gUeGBPg0Fwtb3vWIN7WLo/ZMSKEDafK9nkl3j+Fqf9yELIKzQmd0mL0sPu74GizkQBzbuHJZmgBtTIW5DAt6KhtpqJd3Aqy2nhy7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225491; c=relaxed/simple;
	bh=jeB0jLSy8q+eh9qYQtqC3QlywNP/Xfpi3Eu7iYzC4es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gq8+F5NAvc4WqDg/z7IncKxOiOVX7MMh4w+rcmH07A5ql1VlUJ5kzHcqu6vMkv4zm58NdU1X4gPZ+ASZOTMtu9Tpvpj3zqWkD4wWJnpU8vAttu+ziZq7x1RyxQTe7ZraWLGWoNwuXpJ17/Dlul0HwyVotpX9aqwiPyaZfeCTdH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bJuiE59u; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a34c5ca2537so194037466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709225485; x=1709830285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAGKZhcS7Vcqv+9qUnLEagGLoWPuyfJ/EEdRmEE/75w=;
        b=bJuiE59uBnxLDLwmJHZCpz8l2z13AQsOVqU3GKcWKlowbC3YkfjaV31Bwff90H+ssM
         h02luHq2+ECyGOBoj1jgmBokKY/fOF5oZ5TPzjjgmTR835WE+ioNeJ/ZDY+mvg1q1asw
         GAEb+dOStFXUu6F4zPQ5sAs02jB7KLSCHcuNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709225485; x=1709830285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAGKZhcS7Vcqv+9qUnLEagGLoWPuyfJ/EEdRmEE/75w=;
        b=XWidCutqtdRWNrVD+nXPrlEnLyMXyYTDzG3yrJ2mmrNPTrpTUtXMLHg1e2g5ihDOXe
         qa/msx6LlFSipjePN5+9GSON7ZIuWp0zM61NTdHa+usxU3XDhp+AYhk59uZHsiVL72/K
         1WOB/cpVxRwNsqxXr71blf6Si1WQ+9izpRyOC365Renlf1CZUJziCJZn4gCqti8yQQMI
         mH1BmUZScOS7i+k7hOSs8ZFnogGcYNS8Hz58CpS3UmTtZ7JoTSgrUCREgVU0UiUPyHOO
         PZR8sjbir5NobrFJFW/wYQpKzY4mIWCnRFYGI/MQTZ4XoEb6mJXxAkHlVBk3FPRT6oGJ
         ykbw==
X-Gm-Message-State: AOJu0YxKmPR4j9oAgy00Vv04MYDnqI2MwFstlpV6ax8QgJxJ+H22auT5
	M7e6QBC+QgXx+geNWVl+ehncimNz4eTpkbYcjj/AG44IXFVwKEOUGCsU15z7aMEvjeQ1Fh3XNya
	OfSNy
X-Google-Smtp-Source: AGHT+IFcLGnW0iXbacRx+s0/BGNPXALwz0PW+Glf8irZnYo/+JSx5BH3xSiRWDWant7mhx5xgE+5wA==
X-Received: by 2002:a17:906:24db:b0:a44:4ed8:6a3e with SMTP id f27-20020a17090624db00b00a444ed86a3emr1360413ejb.13.1709225485547;
        Thu, 29 Feb 2024 08:51:25 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id gu24-20020a170906f29800b00a3e4f554900sm845922ejb.135.2024.02.29.08.51.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 08:51:25 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-566b160f6eeso6888a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:51:24 -0800 (PST)
X-Received: by 2002:a05:6402:34cc:b0:565:d0e4:d8a0 with SMTP id
 w12-20020a05640234cc00b00565d0e4d8a0mr153095edc.3.1709225484579; Thu, 29 Feb
 2024 08:51:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229154946.2850012-1-sashal@kernel.org> <20240229154946.2850012-21-sashal@kernel.org>
In-Reply-To: <20240229154946.2850012-21-sashal@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 29 Feb 2024 08:51:09 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wb4meRvghR00LTzXRAobgioGo5g2oYqMLuO8nYWDa7Rg@mail.gmail.com>
Message-ID: <CAD=FV=Wb4meRvghR00LTzXRAobgioGo5g2oYqMLuO8nYWDa7Rg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.6 21/21] arm64/sve: Lower the maximum allocation
 for the SVE ptrace regset
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>, catalin.marinas@arm.com, 
	oleg@redhat.com, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,


On Thu, Feb 29, 2024 at 7:50=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> From: Mark Brown <broonie@kernel.org>
>
> [ Upstream commit 2813926261e436d33bc74486b51cce60b76edf78 ]
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
> Tested-by: Douglas Anderson <dianders@chromium.org>
> Link: https://lore.kernel.org/r/20240213-arm64-sve-ptrace-regset-size-v2-=
1-c7600ca74b9b@kernel.org
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/arm64/include/asm/fpsimd.h | 12 ++++++------
>  arch/arm64/kernel/ptrace.c      |  3 ++-
>  2 files changed, 8 insertions(+), 7 deletions(-)

As I mentioned [1], there's a hidden dependency here and without it
the patch doesn't actually do anything useful in kernel 6.6 nor kernel
6.1. Maybe the right answer is to backport this with the hardcoded
value of "16" for those older kernels? Maybe Mark has a better
suggestion?

[1] https://lore.kernel.org/r/CAD=3DFV=3DWSi=3D9V-Oe5eq0J-Uew45cX9JfgB8me-N=
w-iFRfXm59Xg@mail.gmail.com

