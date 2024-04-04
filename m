Return-Path: <linux-kernel+bounces-131519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD37F8988FB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C28283138
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D09E12837A;
	Thu,  4 Apr 2024 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PgH0YwT/"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1B92E401
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712238051; cv=none; b=iCx0MmZg8wxq5UkkRHBFDm065EI67PpDu6DykQJUzebMO9N+mBtrBVy566Api+CjcMfN8c2XLgOnSDt+uIcQNpUSXl9CzBll2xja04Ij95/su0xSJZiTKpC3iO9AAE6lCR6vpvEaCXfkbGSql9BbyhqJVeUsRNsuPsxCLGD2Zrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712238051; c=relaxed/simple;
	bh=z89MX8HYRU8eftunJgLf/N/hvA+22G0MlIRdKBYcBOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzSCXniAtQQTrW8GcvCMy3KVFCdzLgZKAsECOK+AR5tW6szhSyXf++BNEEhkNpn6xI3ylOyYpBf72y1H/bzKy7Si/v4Reuwq/VhkQT/fHEPzdJsmMFNWaQurAB/hs0yBkmMZBjzqxRMiEKQvKVjgCgXpBuO8mT+S7PaajtoIpyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PgH0YwT/; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7e3d93697f7so332497241.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 06:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712238049; x=1712842849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOS6jB5q96k7GK5LtcB2yIdNav1TsSAYvbOvkVp9ZNE=;
        b=PgH0YwT/maUKinOEMoJeJk4WnIxwiZTejcEeGmI/DPQLzkTNGgss4D9gmgLTe1l37p
         6daai5ETDqoMwVDYmAyXjk8nLsPA12joiLU9WEvcYRA27ICOl4KipMdTFiS1IdRJb8LD
         ZOwUy4nyc8vwwUIqeZ79nUayH7EduYwkxzGVA8YzUxrS38dQIIqLwNEBuBZXHexkrH/0
         hLDKtDUDRp+ui+9lL0yLgCasVBSYz+e/swMLNP5RgFHTRPnPiNFpz0IuswuxfAnfYixy
         Lf1z/9aGI6Uy64pPIfJyQFW6v4ErYNSLZmG9HqJ/F5fM0wJPuOy120CRPoM/LkCWVVzR
         g0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712238049; x=1712842849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOS6jB5q96k7GK5LtcB2yIdNav1TsSAYvbOvkVp9ZNE=;
        b=kjLq6LA3Dy+bl7KfUeK1b/kO6T/mtaB96j4vRObXRgE8AfUIEx527Z+cZjrmjq11r4
         Ed0Xr9Nl88Wrka956N9R7WKP3p5p2sSukp4p26b5C6aBpsayLJQ9yTBjE8zXpSvQre+/
         qUChn/A4KtLpfBBRdiB0atgwAWqrm6qRG2UN0UifDTvsSGcX8MNzyFhJ7rYHzMBAAFVW
         WCrD5SqV6E0mdKz/7X9HKNQH01/Faa3iBIvwl6eEbrYrin1URQMqMmisardUfMPfApv4
         o1gFroeWjeKBrcmPYGUL1u5kmZbGKJMXaZBK3JgBbjOqQmetnyGQ8KPFRJxfNbBfnMw5
         54YA==
X-Forwarded-Encrypted: i=1; AJvYcCXPrFeLcsE/t08BwNxf1vwqwtMARxhmg1Uc+E2xU6yZI7R3jeSUcmc4+5PjISJe5V2lywHIdMuNd0kN2WP24UyUEpUG9YICM0f+4aMF
X-Gm-Message-State: AOJu0YxwgxaDr6DDMCYTYKW0IYXylfG7AjlXSBrBKURqgxKdnk5nE1KJ
	gNXzQXhuBxjO4W3b68SriPFeKC8LxHeHJHPBp1Q8vAkGjRo8mblQ0paVyoq2R093ZrG4Xi5wlJR
	xH+eL5sv5SDyrMC0lJufAo6gPJPCdhLJt+GwH
X-Google-Smtp-Source: AGHT+IGpIspdlUNbRLtFDNytIXGtHZMaPzFQpb3jBaHTsPiM4ZMVlngt4/RaBpp9RWjLv+l1kAIe39yYGp5s9H9JN5c=
X-Received: by 2002:a05:6102:f0a:b0:479:c181:a659 with SMTP id
 v10-20020a0561020f0a00b00479c181a659mr3220344vss.14.1712238048672; Thu, 04
 Apr 2024 06:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com>
 <20240402-linked-list-v1-7-b1c59ba7ae3b@google.com> <4aaf7fd7-49ed-4b3e-b691-0d8d7d426d3a@proton.me>
 <CAH5fLghEg37m_PhJxE8FVORHGROE9rd1CJttaWBGc7cXZCX+yQ@mail.gmail.com> <fe34947f-2daa-438a-b621-8557b78f1da6@proton.me>
In-Reply-To: <fe34947f-2daa-438a-b621-8557b78f1da6@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 4 Apr 2024 15:40:37 +0200
Message-ID: <CAH5fLghDBzaDf38FQtt=DROmJ7qV+cXCxDn3nAmeaZibW20Trg@mail.gmail.com>
Subject: Re: [PATCH 7/9] rust: list: add cursor
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

On Thu, Apr 4, 2024 at 3:28=E2=80=AFPM Benno Lossin <benno.lossin@proton.me=
> wrote:
>
> On 03.04.24 14:49, Alice Ryhl wrote:
> > On Wed, Apr 3, 2024 at 2:19=E2=80=AFPM Benno Lossin <benno.lossin@proto=
n.me> wrote:
> >> On 02.04.24 14:17, Alice Ryhl wrote:
> >>> +impl<'a, T: ?Sized + ListItem<ID>, const ID: u64> Cursor<'a, T, ID> =
{
> >>> +    /// Access the current element of this cursor.
> >>> +    pub fn current(&self) -> ArcBorrow<'_, T> {
> >>> +        // SAFETY: The `current` pointer points a value in the list.
> >>> +        let me =3D unsafe { T::view_value(ListLinks::from_fields(sel=
f.current)) };
> >>> +        // SAFETY:
> >>> +        // * All values in a list are stored in an `Arc`.
> >>> +        // * The value cannot be removed from the list for the durat=
ion of the lifetime annotated
> >>> +        //   on the returned `ArcBorrow`, because removing it from t=
he list would require mutable
> >>> +        //   access to the cursor or the list. However, the `ArcBorr=
ow` holds an immutable borrow
> >>> +        //   on the cursor, which in turn holds an immutable borrow =
on the list, so any such
> >>
> >> The cursor has a mutable borrow on the list.
> >>
> >>
> >>> +        //   mutable access requires first releasing the immutable b=
orrow on the cursor.
> >>> +        // * Values in a list never have a `UniqueArc` reference.
> >>
> >> Is there some type invariant guaranteeing this?
> >
> > The List owns a ListArc reference to the value. It would be unsound
> > for there to also be a UniqueArc reference to it.
>
> I think it would be good to add the existence of the `ListArc` as an
> explanation.

Will do. I'll do the other suggestions as well.

Alice

