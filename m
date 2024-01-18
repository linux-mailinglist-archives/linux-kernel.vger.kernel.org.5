Return-Path: <linux-kernel+bounces-29598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D5C8310A0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3AB1F20C17
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDEC186E;
	Thu, 18 Jan 2024 00:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="H++MzVIP"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F24010EA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 00:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705538907; cv=none; b=Ww8DXtyIbBArKPcu+ukeEsH6+xz4o6iRd9VO5pdj8Y20BxYm5Kp92vTEaWs0oOb2zjw/tV4+/FQD6KB/LPOXg+8Z30lWTfTzuV6NuM7nlAlYScrLbkaK1p+KBpI7cmICs629/inKdYhcbCXdV5u+ST1g4AoNiUh3QImtBN8jfYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705538907; c=relaxed/simple;
	bh=HgQZtLiPZ8yieYv69i+veXHyaQ1J23tRMff66BkFe0I=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=jXi/TYjJfqsW9UzyoHnYhk7RJ/uErWqP5hg4TJGfNj8XwwPn9jgko1adRaTMALrJ/f0u6oeVPYqi+c7KReRL4F4WegyMEyAJHMKNh/yIOSymm1f45yEwvb07jGCJjO6P+wdJ06HtCoirlSsUC1A0uiIZ/j1G6mX49LkGKqwOfY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=H++MzVIP; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc24f395c84so196089276.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1705538903; x=1706143703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnQZVIdAe+SPFcHTrlVU0cLodcCnQ2+sbTo4x3UpZMA=;
        b=H++MzVIPiqt0SKwia0D8kCyPrgp3dxOuFP+Itz+PsXVzI7log0196dIfPkO2L9FI08
         jr8zm6n2zZM+m6U40e77Wf00+FUcldi4IMbhg8wYy7qfIDxQCDoOLo7eCeunq3IMsiRL
         6XqeO0D0KxGyzHqMZc9nn/qzkEzhNUI8qRAxJTpht0agyYHZVDkzP5GZnho/vLTucDpo
         1wieBvgqbC0UfEW3CA13U+KtiYCwm+6Dh2nK1TpHiL6WsmptFi/1QQe+bH8ct7w5cy5q
         eKzGcs5DMj0TNI1RYkze6WWp6OF7H9KW5+HbBwCfa98T5jhZAHNzCkd5tbUgD9I/8Khr
         zOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705538903; x=1706143703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnQZVIdAe+SPFcHTrlVU0cLodcCnQ2+sbTo4x3UpZMA=;
        b=LeJmewfSm+dllNnVrBmjhVIw4oZVtk/5FYurw6Em4yzlcqF0R3FIjBFiJWdRvbXkQ5
         fl4ErRBaNH8hhWkPB2y/IYYeU01Gs050nVOIfSQkTEIV/xW/luJzk9ceyeE7XdfRmj9N
         ULfQ5miqH+iByadAWjXDkricVWHl/EE9LzbvQGl6YWivsQ6Jc5O4tdmnnnOvwxb52NC0
         C3Xi1geJXHETD38JbA5aAGeh5zEXa391qy6CSVdL4AIqdHFOp1Y264MLIxNoqioJlBoP
         vo00SxS4Bw3rsCuGCddGm720JdEgUM3rxpi0nb/oP/MyIfbHVs8E46eHpc+eFPu1Btr2
         4aUg==
X-Gm-Message-State: AOJu0YyFD0hvuwrM//VyNZHHNwoC2jKXpNXNx6M+OE+Q+WrNQthRpK+W
	gDkebM1XqYN8kdqMSPkp71CA3MLm5sJGYZ5e33rCdgLbv7ckhCNzrHxLZYl5uLgAtjMwl23aLIl
	3Fb+Uw/ZIUiFKS4Zfgn67f88OIMOa8w/H0xT1TA==
X-Google-Smtp-Source: AGHT+IFaH/HdKGGfwYN91eIoUq8ud2h3bJiadflP+e5X3ly/7ZaddV/vxJG3xX94IwXuoCFM0qeVeQzb7g/lq9Gwi+4=
X-Received: by 2002:a25:2046:0:b0:dbd:726a:21f0 with SMTP id
 g67-20020a252046000000b00dbd726a21f0mr97044ybg.16.1705538903270; Wed, 17 Jan
 2024 16:48:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116160141.165951-1-kernel@valentinobst.de> <20240116220615.168083-1-kernel@valentinobst.de>
In-Reply-To: <20240116220615.168083-1-kernel@valentinobst.de>
From: Trevor Gross <tmgross@umich.edu>
Date: Wed, 17 Jan 2024 19:48:12 -0500
Message-ID: <CALNs47v4=VatsUVfnNsT9jgtbYxvqhR5mgGMu0zrr18ORQVVNg@mail.gmail.com>
Subject: Re: [PATCH 06/13] rust: str: move SAFETY comment in front of unsafe block
To: Valentin Obst <kernel@valentinobst.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 5:36=E2=80=AFPM Valentin Obst <kernel@valentinobst.=
de> wrote:
>
> SAFETY comments should immediately precede the unsafe block they
> justify. Move assignment to `bar` past comment as it is safe.
>
> Signed-off-by: Valentin Obst <kernel@valentinobst.de>
> ---
>  rust/kernel/str.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 843ffeec9b3e..fec5c4314758 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -191,9 +191,9 @@ pub fn to_str(&self) -> Result<&str, core::str::Utf8E=
rror> {
>      /// ```
>      /// # use kernel::c_str;
>      /// # use kernel::str::CStr;
> +    /// let bar =3D c_str!("=E3=83=84");
>      /// // SAFETY: String literals are guaranteed to be valid UTF-8
>      /// // by the Rust compiler.
> -    /// let bar =3D c_str!("=E3=83=84");
>      /// assert_eq!(unsafe { bar.as_str_unchecked() }, "=E3=83=84");
>      /// ```
>      #[inline]
> --
> 2.43.0
>
>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

