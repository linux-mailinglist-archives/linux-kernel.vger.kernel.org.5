Return-Path: <linux-kernel+bounces-55628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD32684BF3D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27168B26350
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170571BC2D;
	Tue,  6 Feb 2024 21:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="lnMYX+xS"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D84F1B950
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 21:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707255071; cv=none; b=IsoL6ZOO3lRQ4y4q2KjeDq6ILogXZuXHm7ZZSjwd0pBJ6C/fsdcR4B8VM/cFuzoMJXHCR61r9MNclLTCtebGb0cyZtpSPvGl1M/ueLS5rPiik9XNl5xeYo6H6vl0H5HzhTNFBLByyr/fLsxW4ozA8MibAZ6gpgev2C1T7JjQvFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707255071; c=relaxed/simple;
	bh=VhV9Y2ehoq2QR/dvYkGZ3565MBi13h4c1EWlFat09sM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3gc1NOeu33QFok69Bm9sSJMnb6PIAANRdk9IojjoXl3CoGOnY9UPzN0JAvm6/pDg4NBLmCIncHgcXQUx9qYrInRqCoGEKDA7Uykd9NckfmHDOqEAxdd11Iyqbi4SwB11TpEikkaZ1XePGA9i38PK8IM3zx1uCvwVa1q8RjrUeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=lnMYX+xS; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60484ffb635so4428877b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 13:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1707255068; x=1707859868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhV9Y2ehoq2QR/dvYkGZ3565MBi13h4c1EWlFat09sM=;
        b=lnMYX+xSSKdpMZr27IDA7Zu4pzAF+15Kege5EY3dGOt+5lSSekvOr8NqA1N6eoaHA8
         b9Q+CjpSHeszCI0BaL/Qzpn2pt+L02fJGEnIE/y5ktMNP/fKAFAgBk6PGP3ye6RO0ItK
         Ixx1cOtTLlM4gWb4+brUkw9dcPMh22QMX6wyWMv8MZJ7XAdE5NnlZ485RcWak+bxGswT
         /EZk0fmS6wgeecGvFF8q77AVtk2xr3d60hMF9N+a8BBt0m2kKakSFPp3tG2LKF37YNNU
         pMY3oyFiIc+ka0YyM5evLuHRQJ8RGJ8f14qCiWds4du5gE2Vjpiz4G2lmMwr1k6I5Nk4
         TEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707255068; x=1707859868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VhV9Y2ehoq2QR/dvYkGZ3565MBi13h4c1EWlFat09sM=;
        b=t3xjPxyD5QKRM6XsZTbxsoKAib3UaBaYSCZzGvdNDpIS1+kT6JWefAghlYvv0UJN4U
         QBoMQhBBjBXnuCDi+eVz8FAYDWt8DVEHqNBAYCufNsfV+Kr2lwRLabvW/7qHeHgQFZBC
         KYUeR1eyCEfTrs6qEbiWQouyxJvK96drgH/H8Z6cMZXrJDiks6uFyhw0qFJ7rw+crfvF
         nDj2tzTzlKcOxuFNlCv4iVlcw273UVqMaHfqpz1w+J13Ul8ztAr+ZirfUnm0QHUj6tH/
         KtRV49KwYMCOQ62XX2EoTCaHBsSXk/acRPo5PwSlgBTRYiUHemlmJeCDxXPSiPdCL6GH
         l3Pg==
X-Gm-Message-State: AOJu0YySmgyX/vp409o7b1654bXYSkrHawNcvYOBXKs0zQGI7KFiimAN
	XZrl/3EYLuDxFL6/tdYvqir30uqmvHRFaksVUGupOkYQOFZDjKwBfrIrWzfYQ0ldfF4ff+vfMzB
	yRl7tmrbqzjPZMe8hVc6n7FqbDPugiYdWM6yMfg==
X-Google-Smtp-Source: AGHT+IFD2ZtVNg+yyFr7gOe+lmhrUgZsDA+InS6rti8MMhXWEbu1XvWLZZAzBuooSjg26Rp0Iuv+ch+bOB9DNvbOdYw=
X-Received: by 2002:a0d:db4f:0:b0:604:3ef:a729 with SMTP id
 d76-20020a0ddb4f000000b0060403efa729mr2685245ywe.15.1707255068386; Tue, 06
 Feb 2024 13:31:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201-rockchip-rust-phy_depend-v2-0-c5fa4faab924@christina-quast.de>
 <20240201-rockchip-rust-phy_depend-v2-3-c5fa4faab924@christina-quast.de>
 <CALNs47tnwCgyvM2jBo=bTt1=2AJFt3b6W+JsTHM3Np2tbNJYCA@mail.gmail.com> <eb229460-0efc-448a-863f-ac0634a72f2c@christina-quast.de>
In-Reply-To: <eb229460-0efc-448a-863f-ac0634a72f2c@christina-quast.de>
From: Trevor Gross <tmgross@umich.edu>
Date: Tue, 6 Feb 2024 16:30:56 -0500
Message-ID: <CALNs47tfmcayLdbLbArPS=AHwETiaQKZ09h69_Q4HmfrMPk4-A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] net: phy: add Rust Rockchip PHY driver
To: Christina Quast <chrysh@christina-quast.de>, Shashwat Kishore <kshashwat13@gmail.com>
Cc: Christina Quast <contact@christina-quast.de>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heiko Stuebner <heiko@sntech.de>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 2:20=E2=80=AFPM Christina Quast
<chrysh@christina-quast.de> wrote:
>
> Hi Trevor!
>
> Thanks a lot for your review, I learned a lot! I felt, from the feedback
> in the Zulip forum that rewriting more phy drivers might be interesting,
> but I think I misunderstood something.
>
> There is no specific goal behind the rewrite, I just thought it would be
> useful to bring more Rust into the Kernel.
>
> Cheers,
>
> Christina

Happy to help :)

There is definitely no harm in experimenting, but the general
(reasonable) rule is that there shouldn't be duplicate drivers
in-tree, even across languages.

What you probably saw on Zulip is that we were trying to locate newer
phys that don't already have a C driver. Shashwat reached out to a few
companies and mentioned that Microchip was interested in drivers for
some of their VSC84xx/82xx families. They are a bit more complicated
(MACSec, XFI/SFP+) and apparently somewhat difficult to get hardware
for, but that might be an option if you are interested in working on
something like this.

Andrew might have some ideas too. There are a lot of new phys coming
out since MACsec is getting more popular, also some newer specs like
10GBase-T1 and 10Base-T1S.

- Trevor

