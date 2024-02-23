Return-Path: <linux-kernel+bounces-78175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C45860FCF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B99F1B21A4A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A55963104;
	Fri, 23 Feb 2024 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mc8ZASG7"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4358563111
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708685369; cv=none; b=KOB7gVqtqmyUnTAN/qh+3QaD6KjrChC62NIDcC1UMZBEHLYHoQxph2ZQBWuYlKiGmI4bRuUsHszR+O5UnhdV3m88UWI/10XZqMByGKA2T3dKZbhcc81KELBuAz5rGm6Gbq3JKsMFPgW3OU/O+nP6z62IDBlNUaFKD7tpC7/CxdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708685369; c=relaxed/simple;
	bh=xKmHqtYAcI8JTc51pSNY0Si56PBb13xYvaijXtKZ6IE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVA3PcarC0B+Ppj3Q8h3+q9MxKEofoNclXHB20WZAynwPO53R01+IRe+b97FeK4EHxn0GsFKAEIzuuJZboTIcMGpg6Mc3AzJ1oHxXwS+04Mei6cghcXdb3Ro9ZowwlC3Sb9Q3tRPmfLggPmWkIupx6Gm0E3DYDYAgm06jKDcuFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mc8ZASG7; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7d643a40a91so352119241.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 02:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708685367; x=1709290167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GE+2ynBhau0YKFYIh74VjetPhnXxE9fhhkw20RQkbUE=;
        b=Mc8ZASG73TJLsAICDEowTcrPWK3tauWP9pPv32dNBcMqtIHxsJWmqAf6j0Uq/PGfrT
         BfHwRPSYprbjOcS0Dox18cP8x7shyDMH0nO67fKbDlqktO53x6qoxH/vn7DLJExLq38m
         fhX+1JmgEanNyrtjoOetKWtqfmh1Zrps+rUUimZzduINm5pw9wZ2NqlOwRrEK0tPPrNT
         WgnRb2OXmmlkyF2EcdPTf//AfGViU+/A3AAS4/vVnIaHfX9UKBACLvVuur9rxnxZhcXj
         b3L26FvROgDfuclRd1uuIUydDp/co9OGhCXaT7SNaYS9L1FJ6kmCpki/lVVhrwIgEo17
         herg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708685367; x=1709290167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GE+2ynBhau0YKFYIh74VjetPhnXxE9fhhkw20RQkbUE=;
        b=fjH7Ouo0JxK3TeiRXKv7ODmETggPeyR7xHxyudVArEx9UgqIpDCT+udV1whZ4fRvN1
         12J/i2TfUfXhqY/VPFjLUjSGWRWIzrrN0CvgqsjkhTfKxJNbyLHcJnWtnTvYV8wRYQjp
         sKIPZNaO20Wl6sh9vQpAYsQ+y7KFJev2+oI4pSfwjyzDxxunSsNmczvDtb5MaxQ5QV5B
         9YNb/84RVcMMyutTa9BeKe1vx1DzKgx529t6OlB1tRvMyxDba3k9fG8Nvdv/mJ4Ik6MO
         IpmmpetcanLdIP7kEDbTOBkaivJmDod+1rpuOnYAMK+qBzXri2mDA916zPmdYvNvvmG5
         omBg==
X-Forwarded-Encrypted: i=1; AJvYcCWCQKnXtG9yEjJaALSaWqERRw/9TXtKQf5CsOsbj8xc34cWbkTXqWVBgQQIG4xVapLKmoot2oa2RxguzgX8YiJvX/9Boz9AeXkWED1q
X-Gm-Message-State: AOJu0Yz9wPqgpPr6K6UFXpgfFr89PByqLXDLwRvZ8L6NkklDvh2pDaEW
	xhUH4KOfvVHlGLAvouQbSex3hLR/vBhJF6l1i8qPemTAXioNnFdh/GeXvWUCiCNpF2uCjDOE0RI
	SFtCKDPOezDLqTV5JBr7gFa/bSU5BXMnDC+df
X-Google-Smtp-Source: AGHT+IFVKUTApUEEXzyYgMbKLZNHK0/f69f+1zVhwvpBprrQ1a6a7pE2JZNcM3/2fyl0R5mGU45zfZ5p+LPe/PqqPeE=
X-Received: by 2002:a05:6102:3584:b0:470:575a:f4bd with SMTP id
 h4-20020a056102358400b00470575af4bdmr1645580vsu.28.1708685367012; Fri, 23 Feb
 2024 02:49:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222-rust-locks-get-mut-v3-1-d38a6f4bde3d@gmail.com> <ZdgIVxrwBfTEjuEe@boqun-archlinux>
In-Reply-To: <ZdgIVxrwBfTEjuEe@boqun-archlinux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 23 Feb 2024 11:49:15 +0100
Message-ID: <CAH5fLgj8g1d47u0eFD83topKg2d7FEG+cHS5+Be6+TLt06NmHg@mail.gmail.com>
Subject: Re: [PATCH v3] rust: locks: Add `get_mut` method to `Lock`
To: Boqun Feng <boqun.feng@gmail.com>
Cc: mathys35.gasnier@gmail.com, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 3:52=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
> BTW, while we are at it, I think we should document the
> "structural/non-structural pinning" design decisions somewhere, for
> example in the struct definition:
>
>         #[pin_data]
>         pub struct Lock<T: ?Sized, B: Backend> {
>             ...
>             /// The data protected by the lock.
>             /// This field is non-structural pinned.
>             pub(crate) data: UnsafeCell<T>,
>         }
>
> Thoughts? Or do we think "non-structural pinned" should be the default
> case so no need to document it? I want to have a clear document for each
> field to avoid the accidental "everyone forgets what's the decision
> here" ;-)

I would normally assume that "field is not marked #[pin]" implies that
it's not structurally pinned. But it could still be worth to call out
here.

I prefer the wording "not structurally pinnned" over "non-structural pinned=
".

Alice

