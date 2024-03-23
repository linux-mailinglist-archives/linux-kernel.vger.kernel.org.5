Return-Path: <linux-kernel+bounces-112421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD96887998
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 18:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90D19B21041
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DB94E1B3;
	Sat, 23 Mar 2024 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OT9YSxGH"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8341E497
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711213613; cv=none; b=QnSHiEiB49DRqSdj69LXZaWQHlKkyy/asyYJ5LAGVOV0ClMai2zK8i2/VlyQeEATpNDSyEUcELwUvLzA8spZficzh26WkK97kGzKUn2BXv/1uCsQPFCDnluVPaRPC+q+y39VhcVuHQ6csBhrjxtRZGPyot+ww4nqOAeqrSwO/1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711213613; c=relaxed/simple;
	bh=9QGxIetIe2ArZtM5vrpzGMWaSsfHC/DUiAku9Vv2Tmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ek+/d25HJTqttne3JHZdq1POUMA5FG5NhUT4NpK8jnrxA2pqhCg24l4opwO2VjKBpuWvyyRl3HKdRMlSjP8c4t0deIWRTOPzSNTUjyUaHeQ9QKXFbh3iglXqOVsC7ycRvomFKxWeggts6FyG/9ME6rEZLkn62Bbxzs85GLI70xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OT9YSxGH; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d28051376eso60535941fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 10:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711213609; x=1711818409; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oTY1+Vi+84vpwbbOvlbyr/aAB2eQbLrAUm6SK4TjLtc=;
        b=OT9YSxGHAawQnQ4s5AnGce8gHY8PBSnMSUKCHP6Nnh6XZK2wNcS0+jFe5BR6BZalrw
         Y0pC+xMtJTaUKtG3wXwZDqFQpheaynkFqDBg2+S6IqwKbPfPtRYOeXr3lFVzmyd9Hvg5
         16N7THcQEWUCxZG77C9rY2jNTvQTfUunEwhoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711213609; x=1711818409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oTY1+Vi+84vpwbbOvlbyr/aAB2eQbLrAUm6SK4TjLtc=;
        b=SLXkWKnKLtyZI929gq0z6UWQQjFqEb7I1lAP1JpuEAdHJ/7yMg6JRLLnFZAQJhs+u+
         95xyVXCQ+iKL89y02Ohd+FjwzkPqbdtQuta3+R+iA3YweN4DlIqkCeL6A4muoTrYdraR
         z+FETMYLA0Rlr4jzO755wblmAmMIK1c0Eugcd1iVdtrwDvPYOz3Up3EsmrivWJjuFeo+
         4dGpN1LKFtVOmkV627bDkv20Fm1sg5kC+CPLDApRXI8p2A2Tvh/Z5hy3ABcPXWg/n2Mf
         xzlibys1JdzUNNsvLkm8FU0SuV+TdN+1cwwOLGs2Md8iHHl++wnfl4BRAl/XVijH4j4e
         jx1g==
X-Forwarded-Encrypted: i=1; AJvYcCXQlJTAcMRs65BGcgq3nxq4jhRlVGyp97KZKqUWqS1VBcwgKbIBO7uwGZTTb/PHi1zNx7uuL9mHjh3Qh4U3R9ThjJlxRly+BT/4CRRO
X-Gm-Message-State: AOJu0YyLQxME/JPLtC98EgKD1dKqZtQ0U3g3f5whjXzoyyGdF37MAWK3
	ZS7Jc3o2RTExihha+m4onRpXWjp/4hxBZOOLeV0gVf1JqzCOuLVlnTSxBEq2UoCqq2hFrPcFDdK
	/TEQl3g==
X-Google-Smtp-Source: AGHT+IHygLAskkCtARkB7G8HFhx1MTco3RIpMyV9q/p03hEiImpjT1p+y90+DRXHyYcNhtFXXZUXgA==
X-Received: by 2002:a05:6512:2e1:b0:513:24ba:466a with SMTP id m1-20020a05651202e100b0051324ba466amr2186519lfq.53.1711213608920;
        Sat, 23 Mar 2024 10:06:48 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id t6-20020a056512208600b005158569860bsm355045lfr.138.2024.03.23.10.06.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 10:06:47 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512f892500cso3605417e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 10:06:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXJB9GaS6m9ZcCD6e0X1Iw1GMneF+XMP/PdTGf9baKnWmIvl46QB+RsxzdYIRuVrXuWORW05UgqFEjPJJF7B8JRKVaXx5uhg2tuExSw
X-Received: by 2002:a19:9144:0:b0:512:e02f:9fa7 with SMTP id
 y4-20020a199144000000b00512e02f9fa7mr2232843lfj.1.1711213607164; Sat, 23 Mar
 2024 10:06:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322165233.71698-1-brgerst@gmail.com> <CAFULd4bCufzKjaUyOcJ5MfsPBcVTj1zQiP3+FFCGo6SbxTpK2A@mail.gmail.com>
 <CAMzpN2gOZEddWUgncaLutVDihcEK-oEUdSVxsgaaX9xiMWfqPw@mail.gmail.com> <CAHk-=wi0arqxMFFdM+jGv1YXXhY+ehxsmcfv+iAndD_dmpYjMA@mail.gmail.com>
In-Reply-To: <CAHk-=wi0arqxMFFdM+jGv1YXXhY+ehxsmcfv+iAndD_dmpYjMA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 23 Mar 2024 10:06:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0cMa6B6OeTtXjx4R-kqxWVHSJ=6y=stRuzk8WduJTsQ@mail.gmail.com>
Message-ID: <CAHk-=wg0cMa6B6OeTtXjx4R-kqxWVHSJ=6y=stRuzk8WduJTsQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/16] x86-64: Stack protector and percpu improvements
To: Brian Gerst <brgerst@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, David.Laight@aculab.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 23 Mar 2024 at 09:16, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And we might as well also do the semi-yearly compiler version review.
> We raised the minimum to 4.9 almost four years ago, and then the jump
> to 5.1 was first for arm64 due to a serious gcc code generation bug
> and then globally in Sept 2021.

Looking at RHEL, I find a page that claims

  RHEL9 : gcc 11.x in app stream
  RHEL8 : gcc 8.x or gcc 9.x in app stream.
  RHEL7 : gcc 4.8.x

so RHEL7 is already immaterial from a kernel compiler standpoint, and
so it looks like at least as far as RHEL is concerned, we could just
jump to gcc 8.1 as a minimum.

RHEL also has a "Developer Toolset" that allows you to pick a compiler
upgrade, so it's not *quite* as black-and-white as that, but it does
seem like we could at some point just pick gcc-8 as a new minimum with
very little pain on that front.

The SLES situation seems somewhat similar, with SLES12 being 4.8.x and
SLES15 being 7.3. But again with a "Development Tools Module" setup.
So that *might* argue for 7.3.

I can't make sense of Debian releases. There's "stable" (bookworm)
that comes with gcc-12.2, but there's oldstable, oldoldstable, and
various "archived" releases still under LTS. I can't even begin to
guess what may be relevant.

I don't think we care that deeply on the kernel side, other than a
"maybe we should be a bit more proactive about raising gcc version
requirements". I don't think we have any huge issues right now with
old gcc versions.

               Linus

