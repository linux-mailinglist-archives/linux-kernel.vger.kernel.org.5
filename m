Return-Path: <linux-kernel+bounces-116507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CC8889FF9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56E971C36D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF1B6E5ED;
	Mon, 25 Mar 2024 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gAf7kALX"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FC71BDCE
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711339197; cv=none; b=rujyHcQr9cDqzgu2lDMETKU9gfyLpq1ps64IhV9zVFUpQ///hoPE6Xgzg5buHUqP4lRaIjiG6O6rv0mzGRMv299bOoQVeF1r9GMOy6BwEfjw9qDCcBm3RiiNjgu544wfHT9KHC5d/S6/Zcr72w1BOk25ToBePA5yBVQaa4sp6qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711339197; c=relaxed/simple;
	bh=mZBZAdxK2BxmYNtPI0ZDmEsamY0wcrZvwum+qSOABcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JVfuCLItmHGFUuULI7YmFElz5DCIp81w3RBgGwc93EBegd8h+mPScULgDYftIbmtmdnXVPsYEjaX87P4wVAHpr9d8I2Rk5Htl9qpTrI4qsZezxCNDxK+dJWWguMK56Ceb8z4q1hTiLN/oQy9exuhnARFsGpEE+wBliN0A7BJE1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gAf7kALX; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2220a3b3871so2017428fac.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 20:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711339194; x=1711943994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZBZAdxK2BxmYNtPI0ZDmEsamY0wcrZvwum+qSOABcw=;
        b=gAf7kALXYbYezUJ82yd7B1vTXXvWvixkWeOx0ACF5Bp74UXwTalSKVSeU9Df8pUUxc
         mGgqEhSLSfX6LJnPGsDVTBlPjePzfmqLpJ1paWNPl9v8M1CA6fUO6B0TG3tPbYUP8k3R
         /CescorFC6Zqmb1LbDypR3l1yXndoLa17W1Ap1wjO/jws6X1OPqggyfb+RoAf+rWqbbm
         HBHSdcEd2W6SbK7PfbvuLyhvaTso6DbYVXzoqM8ZWakDtfQjoV/2LNmQdGjgi+ZDJGDa
         qbOre32VVVo7JS+UbF8baU4muBV21AQ3fN35rVoX7TY2p0rwu0uTw15f6Mdhru4MfXay
         wSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711339194; x=1711943994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZBZAdxK2BxmYNtPI0ZDmEsamY0wcrZvwum+qSOABcw=;
        b=WTIwzAVH0tpu0mGFZUD6kr1IihA2BFzXFNLYhxlNIoCOFmoJhmfY4f5zKQkPdEZXMC
         iiWdvjUd99EJ+oxQw6nEtWk6jxdN5KqF9ooAXv+XvsSXylc8yK+uR+ZzGGTuA71AGLho
         9bDvkV8uEVJOXs9sqgyk8FsEkysimsPBMoWWvHj7dw5bwC85afkakMkn7VGoFxpggPcm
         oPN3U13J7y9LaKwQc0vkLShdyDn6RWAcvGsddSk3dGDqnOE3LT2qpyCNmN5zcJcF/Jl7
         gBiPnpaESWj5ZyJrFW44IC5n1dPA8lR7ZMzztyXbETOQO9yyOOEi8Lj0sJR+K3DDtgDU
         ufCw==
X-Forwarded-Encrypted: i=1; AJvYcCXrocUeTrGeiw72QjAcGRLBy20SHMBA14FX0b0t4lYk2OrJT4BQpDArb4P4c5QGRSDSpSbWnH7OauJL6GCpjyyoiJWj0xnoHbCXLZiV
X-Gm-Message-State: AOJu0YxNy8S25Whebp4Kt0lG1GdfYBIzZ+IuKvuPLYlB0WITwLci5h5r
	gq4QdgmomNJ4rjfG3CEBcHSGAvNpV7St8hMyk5mfGxQMnNrzROl/K6qxDY+HhyvNDWu1LvDgjTa
	tA9JopGo5yLPtOjyopUy+TatJKJZGtMUVb72iFw==
X-Google-Smtp-Source: AGHT+IEvSLOPrvBORb15O7t5WcFvLwtHwr21gOwWhl6ba83FG95/dPss8gUWkSUuH/IqNj/BJ12lEoHWHOFQw32Yq0c=
X-Received: by 2002:a05:6870:c69e:b0:221:9442:4d58 with SMTP id
 cv30-20020a056870c69e00b0022194424d58mr6705190oab.28.1711339194101; Sun, 24
 Mar 2024 20:59:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322112629.68170-1-alexghiti@rivosinc.com>
 <20240323062625.2488-1-dqfext@gmail.com> <CAHVXubisa6HQJDbj_GfjwhP1Y4as0DzrxsU0B7N6DSU6HZNaaw@mail.gmail.com>
In-Reply-To: <CAHVXubisa6HQJDbj_GfjwhP1Y4as0DzrxsU0B7N6DSU6HZNaaw@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 25 Mar 2024 11:59:43 +0800
Message-ID: <CAEEQ3w=mXXTwxph+_ttBLQhvNb66bq9b6Wo-Ka35qpp+3iq2JQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] riscv: Improve sbi_ecall() code generation
 by reordering arguments
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Qingfang Deng <dqfext@gmail.com>, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	samuel.holland@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Mon, Mar 25, 2024 at 2:20=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc=
com> wrote:
>
> Hi Qingfang,
>
> On Sat, Mar 23, 2024 at 7:26=E2=80=AFAM Qingfang Deng <dqfext@gmail.com> =
wrote:
> >
> > Hi Alexandre,
> >
> > You can simply make sbi_ecall `__always_inline`, so the C function call
> > overhead can be fully avoided.
>
> I understand your point, though I don't think we need to mark
> sbi_ecall() as inline, it's not in any hot path so it's not worth it.
> This patch simply gets rid of a really useless overhead, but it does
> not visibly accelerate anything.
>
> I hope it makes sense,
>
> Thanks,
>
> Alex
>

The compiler will have inline size restrictions, so I agree with the
modification of this patch instead of inline.
Please refer to:
https://github.com/gcc-mirror/gcc/blob/master/gcc/common.opt,
"finline-limit-"

So=EF=BC=9A
Reviewed-by: Yunhui Cui <cuiyunhui@bytedance.com>

Thanks,
Yunhui

