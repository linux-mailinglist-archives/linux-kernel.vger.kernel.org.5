Return-Path: <linux-kernel+bounces-125354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D2E89247D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED8A282B5A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B5C13A403;
	Fri, 29 Mar 2024 19:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJG2iTV+"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F245E139CFF;
	Fri, 29 Mar 2024 19:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741746; cv=none; b=AQWhmFEFSceKYikUKcFiZuxjyxpG5lag41PD/N+kWR1giVTntAupPbGIou1C1J7tolZ9/ElUshmBwWs6ypXCrpJD+A6rAsyCKDtrliv76z/o1tejlHPmuuiqiCcYq0nws5JivCeBxuSPG3GzMnrB1aPII02sKxAd7kSuc1EzZqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741746; c=relaxed/simple;
	bh=W3HYFvglRKdilk96vaAk5kw+aBWJdgn/FMqCTcLa4R8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AM6DnlWYweWxt9kYSq3ekQ3XD3SxCJdst9I48DIFr93AWuThHSjswoPodUO9e5fBe6+3IUT19ZCuTdCNbP2m6lpH6Cdykeo434XoDgePAyQANI8l4Y9AJcJqM6IHnVX6LWY/pM/nQltd2kUpY6L7cRP9SByAaLV7F8g48ua3OnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJG2iTV+; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso1529232a12.3;
        Fri, 29 Mar 2024 12:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711741744; x=1712346544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3HYFvglRKdilk96vaAk5kw+aBWJdgn/FMqCTcLa4R8=;
        b=KJG2iTV+wJKLFtRUw5JcF/nOgHJRm98Z30itaXpKgacvvYghp4a4o40SoPfxcQQfuT
         5yKtP6VtzB+15qaWmP8rXLkMoJbL8MhNAbKLJWTRJD2Hxmr4jhj/MB7w/8oyo4qkCuYG
         lR0Rt6smvX61y1QwY56YwXMg2uSPZeRhamF83pX4mlikxhkaVf23XJOf1v0StqQlIQO8
         aJxnwrmSzUgbh1ILPxUfKuc8HU/1vLvTd0k2+YaHFxFl9QZo0sE/g0iytU7697ev7c5q
         iCfHjaHMuo77ReSULOB4cY7lHNbi+ZRHofSjSFx/swsygMERvOuAvcJr+Eq/DgeD7w8c
         IUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711741744; x=1712346544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3HYFvglRKdilk96vaAk5kw+aBWJdgn/FMqCTcLa4R8=;
        b=S5zvSXnDXmWDHRjHBhgY4SxLxrl5x63HyzRo0Tm7smzqGbAfoO7xLqaLAmhkQuATcF
         iGO7GOkYzY/AIIpNBAKz8rW6fVhgNUT6eiT0HjsjpTxi3ovWdJuxLwSVkj4cshRIWZeO
         KWsuNZYUIwC8JnyeaJKzEQZM97VeAZI9T1PNaxIeRCbVl8Xy3JcpUFoM2QiLv6T+YrWx
         LEsM7M+0ab7o89C5fkE9ieGLVwQftncNqx7LR2ka25RduUIHbYUuqKPeE9UNd9gjkzGj
         4BtVzCKenmoPqgk9ZMLxgY8kRxEVWnFg8y2hV/P/RZKRKt0oB4oAKvwdVrHV22yZQKEM
         I+jw==
X-Forwarded-Encrypted: i=1; AJvYcCX6UfonKDhIkCws/xFoFTbeMMWlH6fcTzfWVjtbEumJq0bjeIAIkUuByBVF7GrgANyuVcdZQmyr5yViRhafOVra2MeBcvHBaCAqCrueYEMnFww2kpIQwMeijR98Yy/lW4DIKUMDZQRICUZeqwL7XxrwWfoZHqcumRhcLJ3OpQq/P/b8lKb+8q8zYhQ=
X-Gm-Message-State: AOJu0YxleNkqCz7cWUngbQV4V7NtpmAo+wL6CsDXR3sqP+6adJveCBP8
	bQhdRiXrKzjyGGka+RdOChO7YTMqkvzc00zscJVl2OHJW6Mvb9cbX3aww6npx+yS/K87WNa+Dpr
	PZ8f/cXNxh4DIbBhbOKEvG1lRZuo=
X-Google-Smtp-Source: AGHT+IGEy6+3uxyFBSJbr3Fn4p72c4+8xBi7LoZEISiKilxJyP7xbAbgAPG4swR5ei++MiSvRWyZIl812IgvpWiaf6I=
X-Received: by 2002:a17:90a:3ee6:b0:2a0:3a16:7489 with SMTP id
 k93-20020a17090a3ee600b002a03a167489mr2889022pjc.44.1711741744273; Fri, 29
 Mar 2024 12:49:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217002602.57270-1-ojeda@kernel.org>
In-Reply-To: <20240217002602.57270-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 29 Mar 2024 20:48:30 +0100
Message-ID: <CANiq72kuaEtsf2i=wE3H9sEzDAa9864DXQN7nJuO3nPs8fFSJg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rust: use `-Zdwarf-version` to support DWARFv5
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 1:26=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Rust 1.64.0 introduced (unstable) support for the `-Zdwarf-version`
> flag, which allows to select DWARFv5, thus use it.
>
> Link: https://github.com/rust-lang/rust/issues/103057
> Link: https://github.com/rust-lang/rust/pull/98350
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-next` -- please feel free to still send reviews or
tested-bys for this one!

Cheers,
Miguel

