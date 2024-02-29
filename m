Return-Path: <linux-kernel+bounces-85992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E9086BE2F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38988287368
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9782D048;
	Thu, 29 Feb 2024 01:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="33atkk5Q"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2F5125CA
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709169642; cv=none; b=SoGKp+VnsWYuqi44bCQ+KuVdYFBnFYkDAGRqjDOoKzQ/VHDJtGYHqtkTo6609j2qsjQ6VmvMIfRwKiPC3KObIQJSF4NOwQQ8Ocpg2ayLP9x8Ed4KKIItKna/dsDqfhYk4RAtbo8iwE8PN2SQwDCftVJ8xHPnw/i9d00dhYZAqw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709169642; c=relaxed/simple;
	bh=vErBZyjJ3yM0jaH8Ik5aT7QuifA4uHCNsWPcG0ae9yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svFQMLfOrNaJZ9g8zf+gfyXvUuLdkjMfvcLUhgt6mzyCAuS2zkcG9FEYzfq3V0iXxl8k43P+DVGyH5L3ho7yiHt7S15c1k/e7S7xvD8YaXEEZfFzYHSootsIFtMEGy5Kbpzs84+L8gv/fMofblry2XMY9u+8K8Ji/T6ayej7YKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=33atkk5Q; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512fab8cc6aso811e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709169638; x=1709774438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vErBZyjJ3yM0jaH8Ik5aT7QuifA4uHCNsWPcG0ae9yg=;
        b=33atkk5QgfeUJtmxf3OBHJqW9VYBJPrL6rte/QbkzBUAGLtvBQGXMOYabzFaa4YEw4
         ZbmH+DB+i0PTMSvfWaD/6nLrmnjzAH9Ok0lHIplfF6psH+xFeWKUYfqbOMotyVzeDOU9
         KnVuJqueGKsffQHZ5Rn74yxuwrFdebxiEX/NHFTDuUaXMo37HX3sTFT2Zl9OxHdVEVHL
         /RISr5lIXa/e+hd6MzKbBSk4Uxrj02gYrh5EzsuRpRug+d8sM6hSLy/KrN76cu3+ndQz
         kIGHPoaz0jRxX8THQT2B5ggAnr30+TghXN4htHnLADMgeYIUXVvW9bjwggc7ZIi0nnOd
         w4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709169638; x=1709774438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vErBZyjJ3yM0jaH8Ik5aT7QuifA4uHCNsWPcG0ae9yg=;
        b=hDdoozOdthmTJxP6yZPu8VbQgwaayQhFaPpiRryxyWYESfF7XYW6VeCUKojyMc2y5g
         y1nlAwI99AGeYPE933/cB+1Y0MEAqPz2Pnl8ryWVSVRN8o96jrAntpFt5IUU4dtVTSpd
         c1lduXZfLKDiUhSj6pJ0W3hjsu2aiRum4qGiETAMJR3JOzWfKVs3A7bApZtREDsrIfaf
         lIh53OISQ6ujWEVFiwTQ2pbPKUu+eoFMyHZ5Vdqjwa2h+Qb100G0vhtwAEHqnyeH3op/
         A4YO68Gq3DBWI00k5Pv0fEP2OuOLMdOgKWIBtXvQViVTSei1WhKh/e9aGC607Js2IG7D
         f+ww==
X-Forwarded-Encrypted: i=1; AJvYcCUtJGFfMuF1Ugg5/SjcXOyI1BXvsJLbSShZVs18/nhLe22I+EZl4JAfKLdSc4wqyHVVl7PgPR7A1hzrw59SFawmRnus0xmtWW53kc+L
X-Gm-Message-State: AOJu0YyVNaCUNmj3loRyrRJLn/8X+yAla14KR6IHQOrSAIvqvkQo6iiB
	5gBTwV6mC4U3be3CUvCXTcyQPSw3Z/rhhFpZ80cj8HNO6aPI01+C7NAqOPGpV5qYuIzdMRKGVfM
	EDciBNlcZNXK/lff0/VIhUiu63czoZOrz64Y=
X-Google-Smtp-Source: AGHT+IH+1faJQ6/uhk0gfw8WjBzEoA6yFwJGOjkqCCQ5VIO4G5fNEb/+XhhhpVB3yiDXkNVFX0KRVuH2xhjKWBo/N64=
X-Received: by 2002:a05:6512:1247:b0:513:1cf2:e14f with SMTP id
 fb7-20020a056512124700b005131cf2e14fmr45944lfb.4.1709169638465; Wed, 28 Feb
 2024 17:20:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228140152.1824901-1-arnd@kernel.org> <87msrkhcz6.wl-tiwai@suse.de>
 <1265517d-b98a-4ec6-9215-10cd988ff78f@app.fastmail.com> <202402280925.5B709A60F@keescook>
In-Reply-To: <202402280925.5B709A60F@keescook>
From: Bill Wendling <morbo@google.com>
Date: Wed, 28 Feb 2024 17:20:20 -0800
Message-ID: <CAGG=3QU33tgfN_veiJWooXy2EhfZzUFkJZF3XdjSLE8fFCCkOA@mail.gmail.com>
Subject: Re: Clang __bos vs loop unrolling (was Re: [PATCH] ALSA: asihpi: work
 around clang-17+ false positive fortify-string warning)
To: Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, Takashi Iwai <tiwai@suse.de>, 
	Arnd Bergmann <arnd@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 9:39=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Wed, Feb 28, 2024 at 04:03:56PM +0100, Arnd Bergmann wrote:
> > My first thought was that clang warns about it here because
> > the 'u16 adapter' declaration limits the index to something
> > smaller than an 'int' or 'long', but changing the type
> > did not get rid of the warning.
>
> Our current theory is that Clang has a bug with
> __builtin_object_size/__builtin_dynamic_object_size when doing loop
> unrolling (or other kinds of execution flow splitting). Some examples:
> https://github.com/ClangBuiltLinux/linux/issues?q=3Dlabel%3A%22loop+unrol=
ler%22+
>
> Which is perhaps related to __bos miscalculations:
> https://github.com/ClangBuiltLinux/linux/issues?q=3Dlabel%3A%22%5B__bos%5=
D+miscalculation%22+
>
The idea that there's a bug with the __b{d}os builtins is
controversial. The consensus among GCC and Clang compiler developers
is that returning *a* valid size, rather than the one asked for, is
okay as long as it doesn't go past the current object's max size. (I
couldn't disagree more.) There are a lot of situations where Clang
reverts to that behavior. I'm working to change that.

-bw

