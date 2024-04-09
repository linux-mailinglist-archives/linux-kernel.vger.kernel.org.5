Return-Path: <linux-kernel+bounces-137342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A3C89E0D9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEDA7B24204
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBD415381F;
	Tue,  9 Apr 2024 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZcNb3Oo"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA46F6FCB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712681625; cv=none; b=VfjEewxXePNaM6nGcimEjuy/6DA/xZRefdV9jUg7E6dXwl72kl3kB6o7yX/kEXS6ta73yz6jECTinu4vLi0DtpuiQqNRoHCWwdQQd4aZqdKNbSBS8L/+07bLx2h/uAPTerMcqAbXbjxqF7FOkmD1/WudOlq3k6cieXDo3hvhf4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712681625; c=relaxed/simple;
	bh=Z5UrXYx7JFbheXSytyRul38kZzlkgMZgaLmQNOp0J+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b8hSa0mshlHMW0bXTS7s7SOZX3XiMpxO+PR26qiznJxDjj03egZu4quGt2YIhAJ81e4FLUUrhuMNuZ4RvHM4da3yZmBc6vStatR2PaIyGZaeGsQ19XokmWDmrOR2G6WLzOxPhzEAkH2V/KrT5PyxHym+z/g1/y3fdY8+IJeNKIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZcNb3Oo; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d886f17740so27435711fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 09:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712681622; x=1713286422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K94SiKIbCJp8SM00bpnKqldx2icgrR1O8gIbHUFQzuM=;
        b=LZcNb3OoDs3PdGzmToQHEnQe+A2dSh0L87Q/KFXSBCHyP2ui00kq089/P4BK03eN7Y
         2xMSpHAw7AUVg89MufSk4JE3OXDHu/bdvrkeiVAbk3eDBf5FxRoTHCTgGxipsYD2lCyK
         kLYfiQLh1HwqnwE0pn6VVhR5yfN8qWClOISyGgaBdLfakiE3JmGAlWzmpnAjK7sA/Zv+
         1QJIlm4AZenByJatezzIbd4/k24iFiZcm2JHu+HWTWykANUcLfqsKmYWvu6V1Qu6Ab8S
         42I/Px/ddaJzxXFGp0S6fF+ABGSNwW2KKyMZZ56Tk9COj4k87/8j2O7hrpvzbb9CsdeI
         /CEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712681622; x=1713286422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K94SiKIbCJp8SM00bpnKqldx2icgrR1O8gIbHUFQzuM=;
        b=iINIuRXgLk9G/yispJ50trr8eHW8gHUKkJURreVAEt3+cvACS+tX6ZnNQZBejxzWOO
         P2+Y15ApRflhhzb5ZsxqMj8EjBowjd3DwnHMi8LTmRkScOp1WchiqYBIwGpkm+Ihs5k6
         TsABUCFD17mLlbQx+9JayaOU41NKdAn0l3Gbopy7fqvxqloJxk/kSRwYn9aK0d5fQBS8
         xWsIP1rUm70AE99VB2S6H8OCzZXx/DXUEg9nweKgjC5VxtRoYbXtpQDAzSTNiZw9Rked
         lknTnm6wn8NMDwd9TWp04WfReml7+8GiqXfRBnbfa7c0BDZBoqcZeCiBUvzAsQ4noOkv
         /uvw==
X-Forwarded-Encrypted: i=1; AJvYcCUnY3AbjPftYnNDFx7CFcrkufW/pBciR/sJ1Izi7t0ZehcTgkg9j6HD7t5tk5SAakUbhdT9XSkEb0qiAOBBJ9qFhgqt7OM717rIzRA8
X-Gm-Message-State: AOJu0YwwMOXQL9QvLmjhWUbctC/XITWbdGzJE1JVRi1x4aO0kcqUiWn+
	x5FbRxnaut3KIEthSna+3KwgBpYaE6uvf/qgD5AjgKTizWED61GMfhEFU9vB66hCorDS9BTZFKz
	jHpMG148GcjyI0xMUGRio6C2fOFY=
X-Google-Smtp-Source: AGHT+IF2PQIT2bxI672nMn4SqqrQ5MsS2tt5NKrHuFiJK3CS2DA9nuDdSX6TCSRsxN5afjaUDqTr9TJb3sgz/d4PPUo=
X-Received: by 2002:a05:651c:1050:b0:2d8:606d:c797 with SMTP id
 x16-20020a05651c105000b002d8606dc797mr68765ljm.10.1712681622023; Tue, 09 Apr
 2024 09:53:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409100503.274629-1-ubizjak@gmail.com> <20240409100503.274629-3-ubizjak@gmail.com>
 <ZhUixk5I_n53dbBb@FVFF77S0Q05N> <CAFULd4bBmQ85UsPOOEA+5dj-_JOBNWeyM-jipM7Zov2V484quQ@mail.gmail.com>
 <CAFULd4Z8JTc_5p8apO680es0fYO5ke9yYPpPUfp=15XrRbKESQ@mail.gmail.com> <ZhVuG4J7aocGvd0-@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZhVuG4J7aocGvd0-@FVFF77S0Q05N.cambridge.arm.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Tue, 9 Apr 2024 18:53:30 +0200
Message-ID: <CAFULd4YM3ukFUst5ofMP8oz2gw8Spo_9A8UrAKHw_-dSyAwS7w@mail.gmail.com>
Subject: Re: [PATCH 2/6] locking/atomic/x86: Rewrite x86_32
 arch_atomic64_{,fetch}_{and,or,xor}() functions
To: Mark Rutland <mark.rutland@arm.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 6:34=E2=80=AFPM Mark Rutland <mark.rutland@arm.com> =
wrote:

> > Something like this:
> >
> > --cut here--
> > /*
> >  * This function is intended to preload the value from atomic64_t
> >  * location in a non-atomic way. The read might be torn, but can
> >  * safely be consumed by the compare-and-swap loop.
> >  */
> > static __always_inline s64 arch_atomic64_read_tearable(atomic64_t *v)
> > {
> >     /*
> >      * See the comment in arch_atomic_read() on why we use
> >      * __READ_ONCE() instead of READ_ONCE_NOCHECK() here.
> >      */
> >     return __READ_ONCE(v->counter);
> > }
> > --cut here--
>
> Yeah, something of that shape.
>
> Having thought for a bit longer, it's probably better to use '_torn' rath=
er
> than '_tearable' (i.e. name this arch_atomic64_read_torn()).

How about we simply name the function

arch_atomic64_read_nonatomic()

in the sense that it reads atomic64_t variables in a non-atomic way?

Uros.

