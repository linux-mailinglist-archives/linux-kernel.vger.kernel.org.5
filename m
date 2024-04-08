Return-Path: <linux-kernel+bounces-134989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5F989B9A8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176372827B0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32452C853;
	Mon,  8 Apr 2024 08:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SA7bhGqM"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6A429CE8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712563471; cv=none; b=b6bD53R/b+M8ppRjtFCheLhz4ewBQbpZ857iv+gSy02x2WKUW7GHonXxRNf+AnwFpvucABiA36foW3BAXFsx3EbGYjSjesu512KANUG/kskYwyRKKfN8Ok21GszyDyrPI67cJIQFUFhRzYgZv/EFhv88+88IWqII7qfBRwrPSKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712563471; c=relaxed/simple;
	bh=M3C8rM8DeyxXdmwLP5rZUOxDVPuH43HP8/2t6W4VfWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=az52MHPpPpS6yLA5VQdtdHIKlK0lB43vXZxi+rQtfdkvln1N+f5wfJ9tsUgc8BY6IvS1Yo33wM7mmBXH3KkWZWmsIm2rLwVVU8UJwlxKpDZ+TSlCN5ZPhpjVhWS/kyaWypIK2JwaB9+0hgGOSJtCeP2OSvLPNNPCYipz/DOTYWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SA7bhGqM; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4dabc6f141bso446262e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 01:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712563468; x=1713168268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHOIPSa/Ioif2qoA5aZKv29U1sNgEs2SSy9Tn1rKK+8=;
        b=SA7bhGqMXzV00sWKdEgYFhkV/fJzaPdphiDTlY0oETXYHircKxk55DtDnVhtXC6AHd
         8WqrmP28cALHBC7EdV0eAvnkPmk5oPK28A7l7Jjgj0omUQFk9zD1+9Gwg9zRjSFo8SBZ
         UYufWO8ucG5zgumqrBanzxa2tuAZLN2Es1F3vjy9bsAFvaVe99ahoojkcHOZjzdQjwa4
         qLHULTzmT2fkKadIRQHhoej2h7D4KowlmOIwGOv27KllDK+4hYMz7kr9g7jaeAcmFOYz
         U1icnkgehd0/9etpZgR0/Pl7zwHN9WfRF3Juije2arstpK5IPr+Kp+SryDa3XCUmp6WZ
         x69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712563468; x=1713168268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHOIPSa/Ioif2qoA5aZKv29U1sNgEs2SSy9Tn1rKK+8=;
        b=skrOib8+MNS7pd8gtCFmy4K51qpQnwmu4/MMGOP0v+OaUHRBkiE1bz/atvV2F8SFAz
         gGTBcJF9Q2UfM3X9PpjKBS0Xe2mtmQZJeq9lde5Ujo+N6sO24DyLj7RttX+J6NvyjTS8
         d02LVbuNVtZnon3Zw58i9DBqIpjSoLy1i+yIKvbI+GhAQ10cz8Y5UXBkmRsUtq4qEtVZ
         7KP+oOOh4UB2ksWdvXFuVDInx1zzNw3LZCPRZPez7OxkXmHOClJohYamswFaA/azRtU8
         e8f7X1+DvKR6BYN/71rAhlssnGVNEADehff5yJHIo+/DySXxds0uWvTVtX4bdUWTIkhl
         26PA==
X-Forwarded-Encrypted: i=1; AJvYcCVGmV3av6jujInAq3iXUOtNI1OXxJgf0qSCU/BfpB1vXoFjJtmNtnntTEENq+RZKAR9rnUF7Z68ZV5VNynr5GbcT875rh7MPgnreY/r
X-Gm-Message-State: AOJu0YxiI3okWeRhmtWMPNRCY+oAUD+VA/LwWGsepbLu3sUo5WbNAaqT
	X8wN26YGn0AughexMcQGhJ7G+9rm8XIR57/XgVSmfA5d4vMSjx0Dy5CD0BVE8VxNu9IdfVgM1ja
	/+GD8zxBXI5Ntc9/0Gego9HbhkDNA8HebfPc8
X-Google-Smtp-Source: AGHT+IH4c+KiXj+m3N/uzw2krgh4ClVFA0wTz3UhVe767p1XAz01S6p8dj1sCL449dsAAnuwrzgUjx36W084eWgc6Lg=
X-Received: by 2002:a05:6122:491:b0:4da:9d3e:a7df with SMTP id
 o17-20020a056122049100b004da9d3ea7dfmr4346854vkn.5.1712563468420; Mon, 08 Apr
 2024 01:04:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402-linked-list-v1-0-b1c59ba7ae3b@google.com>
 <20240402-linked-list-v1-5-b1c59ba7ae3b@google.com> <d896a813-3081-40b4-985b-ef257d55cec2@proton.me>
 <CAH5fLgiN3jcd_HMgmP7H-026daMw0xkMk=CGaGc9AM7uHkFXFA@mail.gmail.com> <3f3cf5ae-30df-4032-b752-77126035784c@proton.me>
In-Reply-To: <3f3cf5ae-30df-4032-b752-77126035784c@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 8 Apr 2024 10:04:17 +0200
Message-ID: <CAH5fLggF=dBYzySEt-TgNT+Tr-SNYvQxp3A26NktXNb2SNhDDg@mail.gmail.com>
Subject: Re: [PATCH 5/9] rust: list: add List
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

On Thu, Apr 4, 2024 at 4:51=E2=80=AFPM Benno Lossin <benno.lossin@proton.me=
> wrote:
>
> On 04.04.24 16:12, Alice Ryhl wrote:
> > On Thu, Apr 4, 2024 at 4:03=E2=80=AFPM Benno Lossin <benno.lossin@proto=
n.me> wrote:
> >> On 02.04.24 14:17, Alice Ryhl wrote:
> >>> +        // never null for items in a list.
> >>> +        //
> >>> +        // INVARIANT: There are three cases:
> >>> +        //  * If the list has at least three items, then after remov=
ing the item, `prev` and `next`
> >>> +        //    will be next to each other.
> >>> +        //  * If the list has two items, then the remaining item wil=
l point at itself.
> >>> +        //  * If the list has one item, then `next =3D=3D prev =3D=
=3D item`, so these writes have no effect
> >>> +        //    due to the writes to `item` below.
> >>
> >> I think the writes do not have an effect. (no need to reference the
> >> writes to `item` below)
> >
> > ?
>
> The first write is
>
>      (*next).prev =3D prev;
>
> Using the fact that `next =3D=3D prev =3D=3D item` we have
>
>      (*item).prev =3D prev;
>
> But that is already true, since the function requirement is that
> `(*item).prev =3D=3D prev`. So the write has no effect.
> The same should hold for `(*prev).next =3D next`.

Oh, you are arguing that we aren't changing the value? I hadn't
actually realized that this was the case. But the reason that they end
up with the correct values according to the invariants is the writes
below that set them to null - not the fact that we don't change them
here. After all, setting them to a non-null value is wrong according
to the invariants.

Alice

> >>> +        unsafe {
> >>> +            (*next).prev =3D prev;
> >>> +            (*prev).next =3D next;
> >>> +        }
> >>> +        // SAFETY: We have exclusive access to items in the list.
> >>> +        // INVARIANT: The item is no longer in a list, so the pointe=
rs should be null.
> >>> +        unsafe {
> >>> +            (*item).prev =3D ptr::null_mut();
> >>> +            (*item).next =3D ptr::null_mut();
> >>> +        }

