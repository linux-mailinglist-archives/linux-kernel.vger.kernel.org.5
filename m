Return-Path: <linux-kernel+bounces-134971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA3889B976
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4736280ED2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC8C2DF73;
	Mon,  8 Apr 2024 07:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A7bDWPUo"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5027028DDE
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562894; cv=none; b=Ui5eQ4y9S276asmKeAMmZx2B0glWntY7ZOIyfSw3jWDJEz+aKcdOBx1JlfNbQEqdSpwoYijFZdQY9X31R0PriNhpJxMcRtKajHhFAwRExkE/hz8XJg0XCbBBkVDPxls7txQEC3tQxf+Gqd+SGUR51yyVyLyKZ4dcASvmSe1xvKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562894; c=relaxed/simple;
	bh=RVtr28lBoOHvIvD1ov1ffDQZp850k5qzsqBjP0G6FrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NhTW/+/4hWcF2vqwvonBbG9JB1j2umhRWTANzirXxrQT8lQV3LDlzTV2vKHjC2ECgWN78ZJudaFwAuTi4RH5UWpAQlctCtfrX+FtNMJbVlTTqWzjOjuoY2tHGxPiMmltqCAEBB7OLrUsMNyZVPILr28mYk5FyWYrdIYAqNviTic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A7bDWPUo; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4da702e48e0so1850879e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 00:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712562892; x=1713167692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVtr28lBoOHvIvD1ov1ffDQZp850k5qzsqBjP0G6FrM=;
        b=A7bDWPUoDhvn5fZDNyearHGhAII4mPhc3cGJW563d17s4FuspTuYzV3Fg+f2INji8c
         nS54eAg/vj8wLHW9lpa+UnkrYuwcwPsgUUCOABqtfzoXMNyYwhxcbikgp2EhiVSXwVJg
         A1/clYFgtidaZmwS9LleenIPRHjRWrW8pXnGUUaHWaf8ZWURu2A0XhDRCnm3U8fr/rCD
         ym3GF9j8wcTdKftZNO8n5Pq0qgJ6EW81B6MBTjLKvtiVaBYsZrBzwQUfYBSi6thY0yV7
         iH5536FEl3HxS+kxG77TOFVNUdvsHQy9LOgAlaLQXBDL7RzOtUKgbANY1XuIE5neyg53
         lk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712562892; x=1713167692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVtr28lBoOHvIvD1ov1ffDQZp850k5qzsqBjP0G6FrM=;
        b=SdMgFhDlKuz1TyN7m/M0m7c+h2mO0kjyCjUQYd8/KSrn0d8YiByUFVyODUhwarctTC
         vTUODxrjmpcR9F5uOwZ/YIl4uXaZdLP2qDhPX1yzOrmD3vw2HJVrBb8OMHTXQu8yIfZS
         4KVb/XOSkhF1J059r6IP1OOgQIJf7rrnwE1Wq0Aix35VRneSrfxypiOeKLO1smTlgBud
         9u0ouF30FU1gkPiC1ZBnPnr28K2O1FkO+HMKCXVdmUCQrufQJS2dEiAprFkmywKoHl7V
         uKNiETgk51VAquHTh3RSEJVh1+ORCLcs1Arff4cB4XrzIpe6FI1sITS/sN7CpHisCJbl
         zOHg==
X-Forwarded-Encrypted: i=1; AJvYcCXg5WzHFWLi2rxCh4Llvd2mPl2jVO3iB8XMXV0ynxiXZgXkwFM/I6cUI6wY7NNmGZXagwYDWMXqzC18IW7LHoX6seuyurBTQAHmaPHj
X-Gm-Message-State: AOJu0Yyyv1bnerywFiauTrhsNrXBBsojoFfW0QCi0jbYvbWrZapMCddY
	v5sPlweiouSVB/7czuxER0Mip8/SeFOixUoxC3eOZWdTvyoV0DS4kLFmWClDUXmR7oyJDdbV/aA
	fBLXeozN0YDQZfWZiUiQj0B0pm0Ek6GLBK/Ki
X-Google-Smtp-Source: AGHT+IGcCyaNVx367m9DP4JDrvGBbQiY4qh1tbucRREFcDFxokiEPF+PgsM+B5tIkA6dWC++IXhSDVvAoSrUN1h8r9Q=
X-Received: by 2002:a05:6122:a0b:b0:4d3:36b9:2c26 with SMTP id
 11-20020a0561220a0b00b004d336b92c26mr5325895vkn.14.1712562892077; Mon, 08 Apr
 2024 00:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404-alice-mm-v4-0-49a84242cf02@google.com>
 <20240404-alice-mm-v4-4-49a84242cf02@google.com> <a48b2347-b58b-432e-bdb8-d5449016ab57@proton.me>
 <CAH5fLgg3wpcDE+n6nd0CGtDzyXSrD2nLhY8RxdTHjAD8hQ9VDQ@mail.gmail.com> <c130a6f5-77d7-4d9e-984d-7a8bf48ff918@proton.me>
In-Reply-To: <c130a6f5-77d7-4d9e-984d-7a8bf48ff918@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 8 Apr 2024 09:54:40 +0200
Message-ID: <CAH5fLgigLV17+6U75MC43XFnYeqtgvrrTWD7JmDSB-ebNjCVvw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] rust: add abstraction for `struct page`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 10:59=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 05.04.24 09:44, Alice Ryhl wrote:
> > On Fri, Apr 5, 2024 at 12:33=E2=80=AFAM Benno Lossin <benno.lossin@prot=
on.me> wrote:
> >>
> >> On 04.04.24 14:31, Alice Ryhl wrote:
> >>> +/// A bitwise shift for the page size.
> >>> +#[allow(clippy::unnecessary_cast)]
> >>
> >> Why can't you remove the cast?
> >
> > Bindgen could decide to use a different type in the future or on
> > different platforms.
>
> Did that already happen?
>
> I think that we might want to know if the type changes, since then the
> value might change?

I mean, it's quite unlikely that the page size will not fit in an
usize, even if it changes?

From bindgen's point of view, this constant is just an integer literal
with no type information. So I don't see how we can expect it to
always be generated as a usize?

Alice

