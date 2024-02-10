Return-Path: <linux-kernel+bounces-60304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEEB8502E9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 08:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3C628471F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B53328DB;
	Sat, 10 Feb 2024 07:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="QBKiFI1m"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486302E652
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 07:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707548783; cv=none; b=VpViZeVR1jwcLVZHZD/jJPen8kTsKEHV+DR8dAYfVoDWwk69ajsee91dbehr/woQDBj3qe1xNVAP74IM6+1zAlLjkO18tEaGDyJcV31fi5uRw3ZsSuQEbZAcPyrmO8b0UOpxcEYhCqZzp9A58F0d1ACL4YnlM97evStx63Fq2Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707548783; c=relaxed/simple;
	bh=IVNAIhFgu3wzuB+0TCn1gIA0o9jgzX3mBnlxu6KTrrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=njW5caIvgOs452qyH9izZFHxWVvqn2DXek1VYYFzm3kWweS/BcsHMrH0xow0FqKG9UqdMNHDsUJLUnjR/QKyYfc7uazxSyV+bqtUJDbPbicc/iV9QyuqQEPDtzLk4HBBsMjFW7V3uxdj3CLF0owU9+C9hZjaFFEk7lNSQUX5NrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=QBKiFI1m; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6e08fde11so1815424276.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 23:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1707548779; x=1708153579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVNAIhFgu3wzuB+0TCn1gIA0o9jgzX3mBnlxu6KTrrg=;
        b=QBKiFI1mwYX/d0ak+yZl1aai8zX/OH7fScM1LMV5ixBOHdHfKdg6L/aBNSVy5iQzCY
         QZjZf+GY8BrdJgV3jlz+YOrtZxWkxl5CKIsVZ55lPMeQJR+mlV43Z8wnYxWrlvrXP7S6
         pCa5idKKSOCAyNxc3VG8ZP1rySXgAY2Tv5hNJkYrJ4gr/lA4CDRU1N/xJvZ5TxUgZND/
         qjE6Wy4YukdgWWH5Ny+viaFcRkTjfVwKptOTLWzbkaZEcMMQqTxY33lHzCH2CHU4dNGW
         N0evLFQuhpyUX2SD8Kh0TlFm5g9urNLvtUEaAV8Se81KPChtNcEJPDGMG4lF7t4zvOuM
         4LyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707548779; x=1708153579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVNAIhFgu3wzuB+0TCn1gIA0o9jgzX3mBnlxu6KTrrg=;
        b=QSXX82UFRVudNRYrN8GvD9ZaUL951lz7ZRfRURzcpVAdl8WINRv8woNMA2HFYcGLTo
         jPYunx8reEm3BxyUqIESeAiRnkBtnjdFyL2wgaHwTfnpFXDDZ8F4G5rgY+dIghREYPth
         DibWl4OSa49uZESdpHP8eXXZVZhoHdPweSU/3BF7FZVN/zCfn2+TK+H3dhQMi6HfYbzh
         /nwadAVSQ+A9bAkEO3i7t1BYY9EuNWaBiw2ePQzBmqqKkBMlnC4SM1PO+vcQk2UEOfPW
         6NJP1BiTTvR5bHkUupL0YsA200/4WBNL/xTtdP1tNr2Y7EiUVI/B3MSvHgHqhcpm8yw7
         ofgw==
X-Forwarded-Encrypted: i=1; AJvYcCUOVU16/Y8wUXSttiQGkSZmSRGL+i/fAv8pcsaBujONESdRZQjQBJVTQYbOlcRgctUlmleS8tnsl2PS0ejtm6StGsMVBY/+NCBkDbKn
X-Gm-Message-State: AOJu0Yzu3uI0kHLoB2ONoOVixYHTcJI5Vbiv3QLhlNYMVzclUGTQFvCN
	Soua3tfoRVOuW5M5fPr5g7164pf6PAbUlxHtjzixGPfj2GIxoRgNHeQc5P9PLR8JzbcaExoc/dp
	5LrNXspgMjUs7ByRoms7CMTzLfvWHI6RHAFRWZA==
X-Google-Smtp-Source: AGHT+IG6aq7ApN6uXPaXdmvOo/2SytSpE9H3XIU0AGh0g/v0Eo5l0YahD/aLAQHmUK/A4sGozgfxiPqCLqsf4fk2r2g=
X-Received: by 2002:a5b:b4e:0:b0:dc6:d313:c621 with SMTP id
 b14-20020a5b0b4e000000b00dc6d313c621mr1122754ybr.47.1707548779165; Fri, 09
 Feb 2024 23:06:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
 <20240124-alice-mm-v1-1-d1abcec83c44@google.com> <CALNs47uDaD05oD8TtZoSqUBc4SaRig80u2_1P0qMCXtE3H9_Vw@mail.gmail.com>
 <CAH5fLggdwWoq4wKv7VxZ-_VbWMV_Ui03rGOCMPbWn8=ewznmvA@mail.gmail.com>
In-Reply-To: <CAH5fLggdwWoq4wKv7VxZ-_VbWMV_Ui03rGOCMPbWn8=ewznmvA@mail.gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Sat, 10 Feb 2024 01:06:07 -0600
Message-ID: <CALNs47u-wVfgkK8cB_qe2JRfrxP9wM8J8e0RJwDcGbNVh_uBNg@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: add userspace pointers
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Kees Cook <keescook@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 6:53=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
> Leaking pointer addresses in logs is frowned upon in the kernel, so I
> don't think we should include that.

Sounds like the very correct decision from what Greg and Kees said. If
we add an impl in the future (to be able to `#[derive(Debug)]` on
anything containing this type) it could just print
`0x****************`.

