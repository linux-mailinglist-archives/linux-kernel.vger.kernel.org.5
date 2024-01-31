Return-Path: <linux-kernel+bounces-45929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 577138437F4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F3C8B2385B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B208524DF;
	Wed, 31 Jan 2024 07:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpxtTrY3"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07D85024D;
	Wed, 31 Jan 2024 07:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706686559; cv=none; b=Vz9qyp1rdIpapwC4/fnFs2i2zkuihbqA+tCdqKBzWE18OBfvPLUHQFy4gdNozwUF4XIq8fJ4RbITkeklJMhvF76fv0QVhf2/3qO+esntGXT81CeTrwcw6fj91HwR/H6lOW64tgGP/799N5+OIxLeVTu7I3Rvt4MXXnQdKH8b8f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706686559; c=relaxed/simple;
	bh=wiCMoWj9nmzxRl/WMka5POG0ajQDE+Q+5XHVM5pLA/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jchgCMupkMtHus0JONKnv/0wARxNSa9eDvYGV1sYqrg6UVsXDOMJ+jCqJyyPlhdcxibuGTTRjwZJA5/74eyvU6bL2vkBf+pJzImck6EpwC9M2ebKikFb0zom5B3W2+vMu9pgSE+Gd23fdfH+ppvrqertr1NKUdTUdU3Vp9rkmd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpxtTrY3; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a36597a3104so87850866b.2;
        Tue, 30 Jan 2024 23:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706686556; x=1707291356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfYpSw62i20XZmKiYb+vSRw3Dr5BWaF12J2TMLUW1zI=;
        b=kpxtTrY3qRVOkxZxL1wbS/iE7F3ezxMQHc6+j8mGeMgvszELiU7+JSb6ZBecVphLNc
         WH7ipnQ6zw2kiU+7AovHfWwakdIwQshSKkO1mCVuT+c5hi8HebIHYg4xunWIpBR7c7iT
         ihKm3yuH0uWv6dhiwyzYPY271dvVAsFxbIWF9ekDInqH3fbxKpnzQeZ9dNILpyS8UX/T
         MuudLZou6GZWDdTvdAEUCVfcW6sRnUvysc1/UNLMO13Ur+A15a/AqZncHnmJq/yYipnb
         SSFXkn3JMFoOgF5+BGeMaUGCV297BcHDfdv1+C7XR9XH7T0egWwvLU78yTRQ6pUPqjtv
         NoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706686556; x=1707291356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfYpSw62i20XZmKiYb+vSRw3Dr5BWaF12J2TMLUW1zI=;
        b=dJynZq9DcV1j2IGZMcEbMVZe4Asr6iHVyj7PA7P0CuzGtaGhVPA9J3EYKMsLJvjUzM
         lW6HhRuGmiTp14NL7XNXnWD5P4gQEKVnbTRTieVPJ3MMHXNXL9j8TxNcDqra7XN4ZNtU
         cZl6CMtwh31fEVMoQLK4Saioi1MUTfCCPs1KhgB1Nnf51XRDWMpsQcoG8SmoCnxSTTa3
         YE25IG6H6W4lFHN+YyabM0n9zSVqKOC95Jnnf93+tvPYZSpgoShks5OpeCBSF4vEn5mm
         q4RKnaphBePPrMZvlr/40cg4Vf2k6fg/FmgggxdhzPscwq/g9T7ePFcwp9PVnzt3VdKY
         7Nog==
X-Gm-Message-State: AOJu0Yx57IqbqOQytvbN52upIkEWGxqN5tYLGUXnOD7b6QUqeXiVabSA
	o8+2x6mulnRpP1aV12oXE5KMGVZkUNMaCfzYTwovRiFMfW62v8hs9ifYCK0X4S2r+9yrTOMeIo6
	5OlxCV4/SLVHa7+E7RZPvz3/Zt8M=
X-Google-Smtp-Source: AGHT+IFYfBtpTRLgI+IMbtGC8qDAVeTd7t77eZT//Fl0m4vObLvWSSsAC4pm16pfD/SagbkcfmiVVLy3y+ku7Q6BC0I=
X-Received: by 2002:a17:906:dfcb:b0:a29:7ddf:40eb with SMTP id
 jt11-20020a170906dfcb00b00a297ddf40ebmr537628ejc.15.1706686555570; Tue, 30
 Jan 2024 23:35:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131055340.work.279-kees@kernel.org>
In-Reply-To: <20240131055340.work.279-kees@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 31 Jan 2024 09:35:18 +0200
Message-ID: <CAHp75Veisrih_3Aj1TN=gX=d4+ebKOwnt3eUwATgAr+3x_iywg@mail.gmail.com>
Subject: Re: [PATCH] string: Allow 2-argument strscpy()
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>, Justin Stitt <justinstitt@google.com>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 7:53=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> Using sizeof(dst) for the "size" argument in strscpy() is the
> overwhelmingly common case. Instead of requiring this everywhere, allow a
> 2-argument version to be used that will use the sizeof() internally. Ther=
e
> are other functions in the kernel with optional arguments[1], so this
> isn't unprecedented, and improves readability. Update and relocate the
> kern-doc for strscpy() too.
>
> This could additionally let us save a few hundred lines of code:
>  1177 files changed, 2455 insertions(+), 3026 deletions(-)
> with a treewide cleanup using Coccinelle:
>
> @needless_arg@
> expression DST, SRC;
> @@
>
>         strscpy(DST, SRC
> -, sizeof(DST)
>         )

..

Shouldn't you include, if not yet, args.h to string.h?

..

> +/**
> + * strscpy - Copy a C-string into a sized buffer
> + * @dst: Where to copy the string to
> + * @src: Where to copy the string from
> + * @...: Size of destination buffer (optional)
> + *
> + * Copy the source string @src, or as much of it as fits, into the
> + * destination @dst buffer. The behavior is undefined if the string
> + * buffers overlap. The destination @dst buffer is always NUL terminated=
,
> + * unless it's zero-sized.
> + *
> + * The size argument @... is only required when @dst is not an array, or
> + * when the copy needs to be smaller than sizeof(@dst).
> + *
> + * Preferred to strncpy() since it always returns a valid string, and
> + * doesn't unnecessarily force the tail of the destination buffer to be

> + * zero padded. If padding is desired please use strscpy_pad().

For the sake of consistency shouldn't that be updated the same way?

> + * Returns the number of characters copied in @dst (not including the
> + * trailing %NUL) or -E2BIG if @size is 0 or the copy from @src was
> + * truncated.
> + */

--=20
With Best Regards,
Andy Shevchenko

