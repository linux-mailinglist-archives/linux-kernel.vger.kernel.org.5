Return-Path: <linux-kernel+bounces-137621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2490689E4A7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3C8B1F23048
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C781F158860;
	Tue,  9 Apr 2024 20:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dpznEsTK"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632FB153BDD
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 20:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712695735; cv=none; b=hWMRY2LQxlVsve8NDzEXCNCKgl0i7IqBBUoycj5Xbtp5J+jOwTuzZwwioBP7nmDPZDFnCfWHfDe0uq7CiBEIZHAypyJLl6fg801AFF7bzuP3XXmwTbwOKs0Dn5x53Bz1J0geZR7RD/RMhmwXiB48sAE9vGRoxB8+C2euyroAn/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712695735; c=relaxed/simple;
	bh=AkzPRwIJ73o3QRSvWCo1z6HvR+da50xyrwDb6AgOtP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CHRzH/jSO/86TC0yxbCZ0BkvT5xsJ6b8TADSNe03yXDA4jhu6dYASf2jqOK43D54F5q4K6nrLItjUGpTA6pFaLrwCAuyw3gHa1NM8t8lJZfM4CnwjJXnwPqRFv9Z0s6FQUbIJ3cxJKbPC/1qffdNepKyjXLN5VO2AEvH1SdkO1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dpznEsTK; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e346224bdso4132497a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 13:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712695732; x=1713300532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8FBvT4U9jWO7n57wctvYSnbs8wWD3G7D/bsJH6yrak=;
        b=dpznEsTKTkI4z/SZ7icROPfOb+Xx4omuK6mA1iWdeMYqh8yvdUNjO5tBOChPDNkyYg
         4LxH/WWjrSW14/ZRU9O2kQaSQAeaKntlAU/m26o2UB1vYdU7rEY3+jeNJdOxKvupKTbG
         fEy4rW4bvi3A6Il2mN17wjIU0+SCQF4lp8tbpo0dIAcDGnm/Z/LPEK6RFaqmG732la8b
         tTjrqt3HCYPQNcTVRud5wJ408YatIFu8GEY23I3CKn7Q7GomYK1oXSuxVuoGRPYLoJmR
         Pg9qilI/K7k1Ewn8V7hggv5MDjOisEsfOLSWirZjxuX5UNQD2IecBezcn/ux+A3yDs5F
         Q7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712695732; x=1713300532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8FBvT4U9jWO7n57wctvYSnbs8wWD3G7D/bsJH6yrak=;
        b=UualnwrMZrKNxOyUSXXUyNRPxkNlakRTK/xWPmqFo212RlxUthwoGrBSE+NzirtND2
         +Jyb4MwlKSbnT/QiY0pwVNeleVCj4WMICHOUkVj6WJ0QrsQp3JU8dIpgFc/cqaTsJOYy
         ned0mW9SoQDixNPgBFbN3JtEWdfCeMG9yrxeP8c8tCBL+ZdvAxD1PXoOZj7oMM6czW+U
         55IpAEH+VYjETugQ2b4XolYj/QR8bopGp5s4flOjcdmtxauTLbPI4UehSrzd8nlLxnvE
         qSfF+VQGP8/u/4y0AoeK1UX/S6lDU1adHJ1J4PxpvDGtDouxkhaT81QFHqcI2YdyZX9l
         eOAg==
X-Forwarded-Encrypted: i=1; AJvYcCVUuHzyJ5CuoPse9RsD1JTMnoZcCmFT7rFeGUxxBQsOUldChf096IXs1QqXncOqnTUmPfJ+hDtefqJMVqHC9LMPYjAyIS7tbBUsvXkW
X-Gm-Message-State: AOJu0YwlrJaVKdxLoEbkl5Bz6jz037lvTqqlTAeLufQgjt6FvmMK1N5f
	bMKKp+3pcaJfpfJsxmnRbOLhjqGmm0cokljd/d5tlJfM2o8QTmcB54IYLqSt6CgbLeGorNKYWLj
	93f6hhGHzJUGWmm8AfQdJv8sBsLdxLcvpGLOQ
X-Google-Smtp-Source: AGHT+IHmdRG/nFnqS9OEuLDhWFqseJucDLixYntzV9YZk7CKKlWhzUyPbXqLfCYRT3uZPpxDKB0xkdf/1sRhAlzoBmg=
X-Received: by 2002:a50:cddc:0:b0:56e:99e:1fac with SMTP id
 h28-20020a50cddc000000b0056e099e1facmr383240edj.39.1712695731585; Tue, 09 Apr
 2024 13:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405-strncpy-kernel-debug-kdb-kdb_io-c-v2-1-d0bf595ab301@google.com>
 <20240405095144.GB2890893@aspen.lan> <CAFhGd8q99emm1SFJSs=L7Pn0A79vCtDHtTD5XUbVCNh=DDadaQ@mail.gmail.com>
 <20240409183558.GA7510@aspen.lan>
In-Reply-To: <20240409183558.GA7510@aspen.lan>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 9 Apr 2024 13:48:38 -0700
Message-ID: <CAFhGd8qESuuifuHsNjFPR-Va3P80bxrw+LqvC8deA8GziUJLpw@mail.gmail.com>
Subject: Re: [PATCH v2] kdb: replace deprecated strncpy
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, Douglas Anderson <dianders@chromium.org>, 
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 9, 2024 at 11:36=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Apr 08, 2024 at 05:46:42PM -0700, Justin Stitt wrote:
> > On Fri, Apr 5, 2024 at 2:51=E2=80=AFAM Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > >
> > > >                       len_tmp =3D strlen(p_tmp);
> > > > -                     strncpy(cp, p_tmp+len, len_tmp-len + 1);
> > > > +                     strscpy(cp, p_tmp+len, len_tmp-len + 1);
> > >
> > > Again, I really don't think the third argument provides the number of
> > > characters in the destination buffer.
> > >
> >
> > Right, the third argument is the length of the "remaining" characters
> > from the completion point.
>
> Which is not how strscpy() is designed to be used.
>
>
> > if you type "tes" and press tab then kallsyms_symbol_complete() will
> > populate p_tmp with "test". Prior to rendering to the user, @cp points
> > to "s", we need to catch the user up and print the rest of the symbol
> > name since they've already typed "tes" we only need to print out "t".
>
> I'm more concerned about the case where you fill the buffer entirely
> then move the cursor left until you get to the tes and then press Tab.
> I think at the point we write too many bytes to cp.
>
>
> > len_tmp is the length of the entire symbol part as returned by
> > kallsyms_symbol_complete() and len is the length of only the
> > user-typed symbol. Therefore, the amount of remaining characters to
> > print is given by len_tmp-len (and +1 for a NUL-byte).
> >
> > So, yeah, you're right. This isn't the length of the destination but I
> > don't see why we can't use memcpy() (or strscpy()) and have this not
> > be considered "broken". The pointer arithmetic checks out.
>
> The problem with substituting strncpy() with memcpy() is that is *not*
> obviously wrong... but it could be subtly wrong.
>
> We can see that the person who originally wrote this code made a pretty
> serious mistake with strncpy() and the third argument if garbage. It is
> therefore important to figure out what the *correct* value for argument
> #3 should have been *before* we attempt to replace strncpy() with
> anything.
>
> Transforming something we know to be broken without fixing it first
> means it is impossible to know if the transformation is correct or not.
> Hence the original question, how do we know there is enough space
> after cp to store the string?

Gotcha, I will find time to seriously refactor/rewrite this function
(or at the very least the tab handling part of it).

At the end of the day, though, I just want this strncpy() gone.

>
>
> Daniel.

Thanks
Justin

