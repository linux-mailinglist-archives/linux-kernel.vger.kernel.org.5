Return-Path: <linux-kernel+bounces-152585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 775FC8AC0C7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 20:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F43280E84
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 18:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA96836AEF;
	Sun, 21 Apr 2024 18:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ya9ajvWO"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F8579FD
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713724672; cv=none; b=eBxkRJBjdwUtLLIyOIQMFL7aZSw4KZjUx+1cBNkYqaI5R2kD/hoekEQgA8oz4Ec+L2uhHKZLiCu6hfioqCnacYDay+6YHt3O/3kRQXayyCwJL3cBDCKkoETlTMLUirMV8dCwLx15cC7IXXcs9EJFHgK5iUT1voXsKwhV6xuSWhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713724672; c=relaxed/simple;
	bh=W0qXdv+3SHyokXrLV1y0MFYXcFm8D5IujwYvjvLIrU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRWhrRNutrxvlRgScRQbsz0p9p/BNq9+IOAcVI+9W09LRRfkNe079PL6B01Xsse+zkjUtVpjBdumMwfPZv2bypaYwBAx+tqM8I5XRIkcnlni7+/2DYqKkeLhh1YSiEqlNmR326/5GhulUwnXMMy2C6gyiwO3szhPas5U4rxMA8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ya9ajvWO; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7e7af556187so1241435241.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 11:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713724670; x=1714329470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0qXdv+3SHyokXrLV1y0MFYXcFm8D5IujwYvjvLIrU4=;
        b=Ya9ajvWOysApoUVKR/09qKBEwN6FcjPde9U02kMMfGNQw6XMkJb5HehsZsJuErfRAf
         NBbtf0kFQSkm37X4/ApHH1QCPfP116ECgCqfwiIZ7OTk1LEUb4iD8sRvIKJ3z0qWOOdZ
         rftdo3/kP+/Gpo9mPwRry7UVwUIS40cVIv/1xcrMiB/3Kk7sh9LcjkmoyMroT4Ce/uB9
         vW+qKB9XhPxbUrS2+EIHFe1QE764PHgZ+0zPOlfe79kYCyuUHogBe7GMYQrrbSiIf34u
         t7tDESJMR0XjOq2iDTJkMlZD069pNqdnTz+TmtJEuS8TnUL3sw74+FV8EK4ryd/E46+t
         KUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713724670; x=1714329470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0qXdv+3SHyokXrLV1y0MFYXcFm8D5IujwYvjvLIrU4=;
        b=MBS8z4qtFDcxfywKez/PH47O6TQTGZ6cd7aR/QQCz6Uxdg/pJ4PyuLKij+tpDex8MH
         ukBAhedSpxI/xjFC55jdSp0XgA4n0BbnaTKZxij6ECT9by8s2aztBajyFOCt+s8kueiH
         b67KY6UbrTNQFwjZRNHhy7I+M9PsZTA7gHij1oC9PvlNWY4Zn767d9gLhKRvQjCUGIfA
         Y7rggWjbxrN4Fg1UUajmzY/e+mvLCG6KQyQhUehysZu0yRQrdLHVWBwPFUJ/0ZsCJI/Z
         o269wCxlf//aN8nICY/S40HaVxLnpv1F2hgqADwEryLDJP2HlN3ewkg/Xyq6zA+ilE5a
         AlFA==
X-Forwarded-Encrypted: i=1; AJvYcCWpekz8pXZxKlSsSmgQDI8OMnLYeAA1D4jhQV+Kb+SUBLW4TxKYh1qpAWDTS5MD62Yv1oUKmmOaxcbb9MZNHm8+vbH6FSpBT8SECvpA
X-Gm-Message-State: AOJu0YzSlwHGR0y16GpPGdv0Y5d5EHW7yA9XQRacw9El+CEMz+rkoLGP
	6y5JbXvrNMlNwKsiBAgpgAROaHYi28oXqm+lVvRU0SBz9m4CdWUC1zCAsAgbauPXjpwFHVxFxZ/
	ac06r5zNvrkWql2oG8gsu+FG4cBPrnC93tjOv
X-Google-Smtp-Source: AGHT+IE0S7CkW6ce5AaFQOsR60gb8bjk0JT06KmI7f9o8pfwt/TS8eDEruGkyzxb5KdYD+veTuyDkqVJq6m+Eqwjavg=
X-Received: by 2002:a05:6122:2191:b0:4c9:a9c9:4b3b with SMTP id
 j17-20020a056122219100b004c9a9c94b3bmr8241148vkd.9.1713724669627; Sun, 21 Apr
 2024 11:37:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zh2hw0uQrkN5yVVA@boqun-archlinux> <20240416095323.1107928-1-aliceryhl@google.com>
 <5a45ccc04cae4976900d031989104737@AcuMS.aculab.com>
In-Reply-To: <5a45ccc04cae4976900d031989104737@AcuMS.aculab.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sun, 21 Apr 2024 20:37:38 +0200
Message-ID: <CAH5fLgj9xt9RnohE1fbLfWBAHv47AgwzrMf8cWZO4hEYC2Mnkw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] rust: uaccess: add userspace pointers
To: David Laight <David.Laight@aculab.com>
Cc: "boqun.feng@gmail.com" <boqun.feng@gmail.com>, "a.hindborg@samsung.com" <a.hindborg@samsung.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>, 
	"arnd@arndb.de" <arnd@arndb.de>, "arve@android.com" <arve@android.com>, 
	"benno.lossin@proton.me" <benno.lossin@proton.me>, 
	"bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>, "brauner@kernel.org" <brauner@kernel.org>, 
	"cmllamas@google.com" <cmllamas@google.com>, "gary@garyguo.net" <gary@garyguo.net>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"joel@joelfernandes.org" <joel@joelfernandes.org>, "keescook@chromium.org" <keescook@chromium.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"maco@android.com" <maco@android.com>, "ojeda@kernel.org" <ojeda@kernel.org>, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "surenb@google.com" <surenb@google.com>, 
	"tkjos@android.com" <tkjos@android.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, 
	"wedsonaf@gmail.com" <wedsonaf@gmail.com>, "willy@infradead.org" <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 21, 2024 at 8:08=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:
>
> Should you be implementing 'struct iov_iter' ?
>
> Even if it means creating an IO_UBUF for ioctls?
> (Although that might take some 'fettling' for read+write for ioctls.)

That seems to be intended for when you have several chunks of memory
in userspace that you want to treat as one contiguous chunk. That's
not something I need in the Android Binder driver.

Alice

