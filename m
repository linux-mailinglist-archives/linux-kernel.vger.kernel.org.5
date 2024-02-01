Return-Path: <linux-kernel+bounces-48707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5532D846005
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10701290A17
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12417C6EE;
	Thu,  1 Feb 2024 18:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELVB8cY5"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC7B1E88F;
	Thu,  1 Feb 2024 18:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706812462; cv=none; b=BEBiVlw4guBdMRoNdB71HP5NxpTZuQMLSfmrQglYnEJS7VpPP2macQgJ8OIwktTIQw6tkNxzoB4kfglDFpMgpBzSeqQZO7IOBkiGACF5GUg+am4dR0FaYpx96yeFVZXkgJbP8BSZ5UtqgQZftld8U8JLs0lo1uU2fg24myjPUtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706812462; c=relaxed/simple;
	bh=2Fd7ZWV1LtdaA8VIvBJoCEjDaseHpe8ZGvyJPTjzAFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BFCzyaG2pbWTRLyYGyBqwY95oqBunjA5tqbtzJvQpDMK1nPk8JYulA5JQXzU7oxhpf+6hm3elDdNKHQOUJwPI4IRYtDM5zN6rX90vnZkijpILytgEs8OKTVPBEmm/xm8YHiMowCQNxc5XMwaq23f4Ff5MLkLRTmJzWFrE545Fr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELVB8cY5; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-603c5d7997aso12588407b3.1;
        Thu, 01 Feb 2024 10:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706812459; x=1707417259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Fd7ZWV1LtdaA8VIvBJoCEjDaseHpe8ZGvyJPTjzAFU=;
        b=ELVB8cY5XfkLaja7Z7okOUs1TbOA+Ea2Td6p3UGdyc9TLUlh/zyK6kMpJ5tJgTvuVQ
         1MDVXsUBnIJ6WgtUmebRNquh1qBOGH38AwKSAdzpCTBBgkdctv+RbAWU3SUJBVMfXh8S
         XEUfaoZKmawGm0MSXgBnKlnTN6gvMWlRvN6M5liZI6iozUddSBlWK0yC3HA6wxV03KvV
         XWtbq4OW666hUeCoBceJcz61JHofzJTxHBw8SsmyRF9vwh72o1MvFHjerJdwZf7s0Cm9
         1WNoBInk0IMtQCB5SeBQ3XOYpZ3XGalIbgwHVkK2Wgk7YQBQFdJ52PcZssOkXC0SWSPz
         JFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706812459; x=1707417259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Fd7ZWV1LtdaA8VIvBJoCEjDaseHpe8ZGvyJPTjzAFU=;
        b=pEnjffX9xy1y+RFcAC+k6DXIDD83Cfa2DhuPZY9qxGuMfnCcYQs4QWrYkeDRhGbkIA
         nyRTSjGR6BqnySeh4g/NkGLLuwwjzvE1fWT95jyoRqcSi5troZUW6YxM0jzLHgxdnYtd
         vcfeFMjjUkeyezJ+PWqj+UZne2W397k9B4bQFcIoa6Ac5bQQVZSdastki8BO4/buewMj
         ICN+kpFzmYxnO77t6BWsu2hNX8HFei09spPXcGubRRuD46ceT93bzUgWb4UMTDBxqNDc
         +tYKyeXKSX0UY93G4atanwhyGKC5l5gX0PS+m8hw+DMNj8Z/DUc4CvK0jQKGf166v0nh
         82xQ==
X-Gm-Message-State: AOJu0YzhYnajFPqLR2ovg7DAhhbsx7V8ImmEg3SH329TAn5aEZoRSXDV
	wmdZW48bY/T3v/HbQ/jcO6JZPSSGp81kek7hLCg09LQ0diHZ5i5tnVR1w4WxivB7v1VVqXlfbV3
	C6RtTnx9sy/txYYilzlkVPt1iND8=
X-Google-Smtp-Source: AGHT+IE1UzMW3ajeW1lZaI3w44rZhcB3D2va3eYE5sqzhtCO0UvDe9iJkrBl3dzQEm5YGU+2doCeOCar7s2MtUlbPZk=
X-Received: by 2002:a81:b64b:0:b0:602:cf62:6590 with SMTP id
 h11-20020a81b64b000000b00602cf626590mr5631484ywk.34.1706812459677; Thu, 01
 Feb 2024 10:34:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201-rockchip-rust-phy_depend-v2-0-c5fa4faab924@christina-quast.de>
 <20240201-rockchip-rust-phy_depend-v2-1-c5fa4faab924@christina-quast.de>
In-Reply-To: <20240201-rockchip-rust-phy_depend-v2-1-c5fa4faab924@christina-quast.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 1 Feb 2024 19:34:08 +0100
Message-ID: <CANiq72nE6vy3dy3VTUkdKb3Vep72jxvHb=Jd2ykue8Nd1Vk-jg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] DONOTMERGE: rust: prelude: add bit function
To: Christina Quast <contact@christina-quast.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Trevor Gross <tmgross@umich.edu>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Heiko Stuebner <heiko@sntech.de>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 7:07=E2=80=AFPM Christina Quast
<contact@christina-quast.de> wrote:
>
> In order to create masks easily, the define BIT() is used in C code.
> This commit adds the same functionality to the rust kernel.

Note that it is the same kernel :) Typically we would say "to the Rust
side" or similar.

> Do not merge this commit, because rust/kernel/types.rs in Rust-for-Linux
> already contains this functionality and will be merged into next-net
> soon.

I think you mean the archived `rust` branch (it is useful to point
this out -- Rust for Linux is not just that branch).

However, has the `Bit` type (assuming you mean that) been submitted? I
don't recall seeing it, and normally something like that would not go
through `net-next`. If it has been, could you please send the Lore
link?

> But this driver does not compile without this commit, so I am adding it
> to the patchset to get more feedback on the actual driver.

Assuming the patch was not sent, I would suggest replacing this commit
with the dependency you want to use, e.g. the `Bit` type, since it is
a small enough one.

In addition, this series has v2 in the title -- I think you did that
because this patch was already submitted, but this is not really a v2
of that series since this is mainly about the driver (and anyway this
patch in particular is not meant to be merged; plus you didn't change
it from what I can see).

Thanks!

Cheers,
Miguel

