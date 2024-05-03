Return-Path: <linux-kernel+bounces-167779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D66A8BAF11
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01C41F225A0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03EF179BD;
	Fri,  3 May 2024 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PNVOBWjT"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E062D045
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714746976; cv=none; b=QLSwnpRwjliv5CFjteCnr7RWFtWubY9Im7kpmHUo0CPTVQ08GLT1EfaZV0F/GCXu7H4b9Hg78EJCunJnYW+kmgXmRlmvivGzXBAlNi0Kj9TSVSF8eLyRftgoS9Aqo8OxDZYRTNW0hdxTdxuG6ARtCcslRHWJPw3F3PWYdby6v2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714746976; c=relaxed/simple;
	bh=daN1x2gi00cSob1DmX9fc38vEUCgnDKbKOdXdiCaBCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZiOXFcxRy5y6J6gj2xylac0qkkjJh4Nh26y+hqfC5tFjVkgZr8TYvZlkScm8gzD8kexGtXekEWGJDi2A78xnMA/KniaT0gJlcIWg4ybIECC7tqopNef/Z2gkvUuD0K6OcD/DkffQ0LfMxHyERkC4huUsAyB1bpGtXcm1tvuKIM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PNVOBWjT; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5b1ca71532bso789775eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714746974; x=1715351774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajN0BJTmgIGLTJx2+JqXb38Pd8n8N6KRNSjh1lBU7Gg=;
        b=PNVOBWjTY0oFb8n1NssmzOAVRRL29bTP7eVtzsyehKp34w3gEQXEevvThQ353ZW4K8
         0E8jXoesKUE0+m1OVThcl+t14OUX7saF1/DBmA2WlmV1W5q/nRvpZQxkFuR7vhXH7MnQ
         csD/+vjPwLc41PpOj5j3IPYBfy7HlwAPs6t26JdKyerdNeewuNWtLTV5JahuDF5R4lFh
         Ei885Oyb2RXkzCKC51R5mHFk6I7Le+vcjzX9X4dysFVaLK35S5tZVFbV18c/R19lUr7Q
         I5QTMSTnFaqQn2gsOTi773F1585nS0Z/qvlAIbXvCP6ryVc3YEidffftugFXfRUwosh/
         rxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714746974; x=1715351774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajN0BJTmgIGLTJx2+JqXb38Pd8n8N6KRNSjh1lBU7Gg=;
        b=bPcLTH3iWoHAOqZmkECTefBHh89loA5XNVJtOiB2+U5Cz88Ye0yz/AV/eCKKmgdEj3
         QbrraSyT1FeUqXZCfTanbrpxioF16imPKJOiYYXux/t8X2vrgonHGobHI4XSyIfaDkgh
         agG9ZMc5mdPQy9XlCAQBLKUnWuKBB1s0d+/gM7lM0nJcQO5DcE/4MLMLtVYuEI2TC8s3
         ZrBGJ0V0RnwkI9YDhHVlCjroCN4tf34vSIdo6C/f8Fq2YfWjNgYvFIJ8MSNYj2pytRtn
         Xy+cNSxKzz1Sk4Q0/xvM0/GjYqyKIn7W6t5KxOhQddKquhDrz4VNXDaCla+EZdfiwHqm
         LONQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFPD53LYSXR7JFe56pNStqZY69PBxXfLLaOLl/MsH3eXMAED97hpgazcKMGdLp5K3sPBzqMv3e+OX02cSRGD345AUoQZ9KyaTgSvhX
X-Gm-Message-State: AOJu0YwxmXrYKuLvXRPnGUsnjO714RmaLjE/DlI9PyXaGKtxVoE/snQr
	eX5lJ5luPwoJkZCDrBoVQk7pOXCQqe0nrX567Wij7/6EIqXe1dnIJPmA1IM5KqUJ4Xe7dGG/HBP
	7BEBTF4c10mmhrkzu4PWOQuvKRkKwShuZB+YP
X-Google-Smtp-Source: AGHT+IHoTU5A3vFElJmmz36t8Ht05rUxakrvP1P6x/IV4m/3JuZwplO8bo+8j4PHy+v5410tkSzd4K+jp31EaDezWyY=
X-Received: by 2002:a05:6358:311c:b0:186:2ac7:316c with SMTP id
 c28-20020a056358311c00b001862ac7316cmr2859376rwe.20.1714746973495; Fri, 03
 May 2024 07:36:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com>
 <20240402-linked-list-v1-1-b1c59ba7ae3b@google.com> <2f25f21e-fad8-48bb-aa2b-d61bf8909a41@proton.me>
 <CAH5fLgjqyfExjckh7KnSLnT+Ok+yjcoJ+DpDkj0gUZRmoz=M8Q@mail.gmail.com>
In-Reply-To: <CAH5fLgjqyfExjckh7KnSLnT+Ok+yjcoJ+DpDkj0gUZRmoz=M8Q@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 3 May 2024 16:36:02 +0200
Message-ID: <CAH5fLgj49zs2=O-e3h=VqkRDDzhozvV6p=-5AKN_Q9-caT++cQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] rust: list: add ListArc
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, 
	Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 4:00=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> On Wed, Apr 3, 2024 at 5:51=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
> >
> > On 02.04.24 14:16, Alice Ryhl wrote:
> > > +impl<T: ListArcSafe<ID>, const ID: u64> ListArc<T, ID> {
> > > +    /// Constructs a new reference counted instance of `T`.
> > > +    pub fn try_new(contents: T) -> Result<Self, AllocError> {
> > > +        Ok(Self::from_unique(UniqueArc::try_new(contents)?))
> > > +    }
> > > +
> > > +    /// Use the given initializer to in-place initialize a `T`.
> > > +    ///
> > > +    /// If `T: !Unpin` it will not be able to move afterwards.
> > > +    pub fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Se=
lf>
> > > +    where
> > > +        Error: From<E>,
> > > +    {
> > > +        Ok(Self::from_pin_unique(UniqueArc::pin_init(init)?))
> > > +    }
> >
> > pin-init has a general trait for this: InPlaceInit. I don't know if the
> > other functions that it provides would help you.
>
> I will use that.

Turns out it's not possible to use the trait in this case, for the
same reasons as why Arc isn't using them either.

Alice

