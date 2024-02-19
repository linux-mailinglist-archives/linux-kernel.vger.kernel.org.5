Return-Path: <linux-kernel+bounces-71635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6E185A818
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53761B23D35
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7694D3BB48;
	Mon, 19 Feb 2024 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaJoKZ2a"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6655C3399C;
	Mon, 19 Feb 2024 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358634; cv=none; b=mIl+Kj8iMIWFPNYzGvRMjP5WxAdZuNnZ7GWShZohPlb9uLxuzZTLEMFwnwORey6mdvg4z3/u7uhuCD+qn3mkCh4k8xQ+drGjjQ9peMmROAQB5IIhMLsTaDQ8vtGNIUQb1qAKpAV49+wEixQSZAxw9tqBSIrEkyb1HFzS/tuHIM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358634; c=relaxed/simple;
	bh=WmRlSNkA/KdX9XPb6GEYSoKbr9CXuMXKqExqINGkwbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIp3XZ/PjMOE69MJkuVk9SPqNk11Iy78e5v9Q1gH+Ykcaa3KgcvXLAgZj1+dxlM8hlGSt/Ecw7DS9lStxzbcoyi9PAem6GhCPSsWj146LCL/iLV1aN6YUuapiwy/QIXMj8a3obrizDUdFy6IqHi1IJL7AzziT2TsbRR8Sim9iik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaJoKZ2a; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso4161014276.1;
        Mon, 19 Feb 2024 08:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708358632; x=1708963432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmRlSNkA/KdX9XPb6GEYSoKbr9CXuMXKqExqINGkwbc=;
        b=NaJoKZ2aIZ6BypJdqLRAfH8GBZ9hJOEb9bry/ZfGTfzwSp8+zsaBWTSp6ZTwASOdQX
         pB74qz1ShPeux8n2i71gtYNg8LiAkp3J/EWsQyldRW2pEM+bytVyi+pBnXZHMab4kCyc
         n7R0uzVgmRQZv8u7RDC10mavX/v3rcD6dv6Ld7rGbPqTrW9QRviHEV6R/zL1hoq1IZba
         s0dkkQQOybOZRjFImWooWT0bmXtgqNf16VOkeRu2CSlCsqzM+c1dwTtGby22l33cr/Jb
         TDRloC4R71vHlwwkXvAqejcISXHBiMGp6HjyiLm4olpnJ+Udv2LEjhghKj/CAd5sKdi2
         vbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708358632; x=1708963432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmRlSNkA/KdX9XPb6GEYSoKbr9CXuMXKqExqINGkwbc=;
        b=N+D4CUP5DXnb2/jA9+ucrrlGUIdAw35Cw42yiopcBoTW5D6T3MpKd7pjZk1Ejmofdi
         dLOgGVqln7/PxKgCtELGVX60wiE/rvS4NvJlTQKxAcT1BEqPYuj+93az9YJu7r3+IMta
         YeR8s8lUvnMgVxs0bP7QSWMp9btlej4b1ZWwh8uo2NAu0jaTdACkoKdsa7ByYHYOd5si
         Otw58q4cGvYPcnS1993NUPPM47ekb74XNYyK6h+qT6kMWr0nUxgUhmnJd7xtPeAXQt23
         duRalhXPX7NHEfPDs/s6aiC3J+uHaYcX9BzsxzT+nM0I7TsNk+1RQCA21Cy01iaB3CjQ
         NO0g==
X-Forwarded-Encrypted: i=1; AJvYcCW4wJXypXIHrawpJz+0jFaqe9KrzON/yxyIq3cFYVht6U8qHHOIOyoWsvzo2pEvNmrfskM/XueImRZOaoCokm/9t7BoHlGGpEltLmym9mFE1yt6KdWeNRwfHlrRfDdjCkosMO5Kw1Bzxb8yZ+g=
X-Gm-Message-State: AOJu0YzFVrfaeLer4kgSq6P/ZtJ4dqhfi5Y7G5bp38MXIeu6vgSRyqD2
	URkgJFe8dUcU9AnXVgZhsY1OWaMBNSxTsZyB30P6+4wTMc93kmLfP0JwfWHD6Wt19ESX6RiiwwH
	phoS0zLAQAqMeEjE8wyD/iqNLYs4=
X-Google-Smtp-Source: AGHT+IF1m6Ip0CcBIu/E+D6EL8tZaYd0E7pl/0FJrjViHllCekK5lu/AmUM3Gf4H0Avnm+Z8AE/nVZLC6R42mHnhSWU=
X-Received: by 2002:a25:ac9b:0:b0:dc7:5018:4022 with SMTP id
 x27-20020a25ac9b000000b00dc750184022mr13383631ybi.44.1708358632536; Mon, 19
 Feb 2024 08:03:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217002717.57507-1-ojeda@kernel.org> <87ttm4g462.fsf@metaspace.dk>
In-Reply-To: <87ttm4g462.fsf@metaspace.dk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 19 Feb 2024 17:03:41 +0100
Message-ID: <CANiq72nbr6qy1otJpdh3FVUN5cUfrkUPYEHJFm_QqfKvYEj-Xw@mail.gmail.com>
Subject: Re: [PATCH] rust: upgrade to Rust 1.77.0
To: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
Cc: Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 11:06=E2=80=AFAM Andreas Hindborg (Samsung)
<nmi@metaspace.dk> wrote:
>
> I am a little confused about this patch, since 1.77.0 is not released
> yet and the link [1] (currently) points to the release notes for 1.76.

Yeah, the patch is written as it would have been written by the time
it is applied, i.e. see the note after `---`.

So, for instance, the link actually points to the 1.77.0 notes, it is
just that they do not exist yet :)

> Will there be a new version of this patch when 1.77 is released, or do
> we just expect no changes to alloc when the compiler goes from beta to
> release?

There can changes (or not), so it depends on that, i.e. if not, I will
apply this one. If there are non-trivial ones, then I will send a v2.

(There are no changes so far)

Cheers,
Miguel

