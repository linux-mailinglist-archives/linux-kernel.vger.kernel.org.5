Return-Path: <linux-kernel+bounces-29660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEC883116B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 03:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F354B2514B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D6653BE;
	Thu, 18 Jan 2024 02:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="Ns3Cf314"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6F42F47
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 02:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705544905; cv=none; b=Y4PhpnUmH/sPx31ALgkGm+sE9u62/sRBJkRuikG6JhoGG5UTxgrUDSNyiQyVIma4HD8iQdxi4UJAjFsduUnOwX5BBsc9XeT0Bv7oW3YC6vyjojeia7L/chRvzGtPQC1goUWr9Q4WuwILRujY1iKgi/RDl+1OLInY8e7KXIg3zzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705544905; c=relaxed/simple;
	bh=vzMVQCv3T/Ds0vomolAWglMLN+1T/pY1kyRsxxlrzcI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=Q1oCEB/2XCvpmIIGuI9loaWmVihec012T23IPiNcdh8/GXfzEIvbBaocFtju3SB0QUF3cM3LGOFxAfxhQIKKI43xRXiqXjXkSd/bgionzL5sW/Wc0G6AxkUdHrg6/986VKgUqReD+F2nj0FmzZ1XPHmQy6kaDeLS3EQHnaRix0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=Ns3Cf314; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5f8cf76ef5bso107715667b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 18:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1705544902; x=1706149702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JW7sC/bkjMawlCJ9bPlUHsEwlQsAX4b+0wdwYkzYppA=;
        b=Ns3Cf314Vxdr5tkbiD55CQoAa0ifQcatgHZpg/VSBpQEWML5MoYVIvNVAT/zbTVTUr
         kXBHYdU8SYjAk/fpKIQEhNm+MN46HS80YDlz3s4hBLDMFpw8Oht/GM6ECVnWnbHnE9eq
         UtYmP5EdhmU2kpo8r5Mm4e58soeceR/xmV/X+K4t2Jyv7EtreWWL9JSBKtALgf3yvX4a
         CrqE78UupNLNw5WXqbbGA02S6RWZk/4wbA0qkkP4+8Z9JMLql6YTKpWA5F/xZumzkLM5
         mOOh99VN++y/S1yZVGilanH2gYBVJqNeD2uDbLv1SA4Rzcsy1lq3ydMReJN+ZPEtrMfC
         kpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705544902; x=1706149702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JW7sC/bkjMawlCJ9bPlUHsEwlQsAX4b+0wdwYkzYppA=;
        b=Bw9v76PuRCetcjBJOdu37bwynajuzZfNaTqKiQT8vjd0LRZk/xK8TvzUXN28VREKtA
         1fatl7Zw9pa4v6UU3GEQqQbtkiCEqpn9HJHU4zr3TzJkUaTZ27G8U1tPN9LAaVP2y174
         4qBv9eqxgVSZnA8ZZCHku6nUtUuIvYpq/jUcvEZMXsX08hIzsCkExwzVlFHmzxfHcc0K
         pCzAIZa+5Adj9yOzng4KWAa2pbj+f6I8YtmeCpUHHEojO8mNTY/yAs0WjsGThQNQ+fnb
         aXLVc8nOaFfpUdefQ8+jMwiNcneXGiHEjFPlbjy8GH2Gw+OIVAIKp/pIj6PdL9CGlLBV
         W8tA==
X-Gm-Message-State: AOJu0YzrpkfNlouwKe0iiuw7zsrLiVgWEOawxDo/67do7ep7ZMVT0skm
	1UbETMm8CNNcGlQ+ajlFLl4MRa04+dCfw6EECm1trCsh821midPRKzgOJySG7Uitc7S1Nu4NLaD
	hfjifglMo9m653BaA+GA5wN4AOUrTWvXDxC84xg==
X-Google-Smtp-Source: AGHT+IGmCzygYqkaRruUo3l9kkNYVmleL+EQ7VHjvtDDXT9/VUKhX+dgMVGvAZ6ptmiDbH7L0Ot2nJW2on+sOJYLQaI=
X-Received: by 2002:a0d:ee83:0:b0:5ff:4895:8c0b with SMTP id
 x125-20020a0dee83000000b005ff48958c0bmr152454ywe.40.1705544902038; Wed, 17
 Jan 2024 18:28:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116160141.165951-1-kernel@valentinobst.de> <20240116231118.168882-1-kernel@valentinobst.de>
In-Reply-To: <20240116231118.168882-1-kernel@valentinobst.de>
From: Trevor Gross <tmgross@umich.edu>
Date: Wed, 17 Jan 2024 21:28:10 -0500
Message-ID: <CALNs47v1y6aXBFka6Af1BNykycjNce6Rnjvf0sw4r1vMegFhBw@mail.gmail.com>
Subject: Re: [PATCH 11/13] rust: kernel: add doclinks with html tags
To: Valentin Obst <kernel@valentinobst.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 6:11=E2=80=AFPM Valentin Obst <kernel@valentinobst.=
de> wrote:
>
> Add doclinks to existing documentation. Use html 'code' tags to add
> links to items that cannot be linked with the normal syntax.
>
> The use of html tags is a tradeoff between the readability of the
> documentation's source code and the ergonomics of the generated content.
>
> Signed-off-by: Valentin Obst <kernel@valentinobst.de>
> ---
>  rust/kernel/str.rs       |  7 ++++---
>  rust/kernel/sync/arc.rs  | 24 +++++++++++++-----------
>  rust/kernel/workqueue.rs | 10 +++++-----
>  3 files changed, 22 insertions(+), 19 deletions(-)
>
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index fec5c4314758..f95fd2ba19fb 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -14,7 +14,8 @@
>
>  /// Byte string without UTF-8 validity guarantee.
>  ///
> -/// `BStr` is simply an alias to `[u8]`, but has a more evident semantic=
al meaning.
> +/// `BStr` is simply an alias to <code>[[u8]]</code>, but has a more evi=
dent
> +/// semantical meaning.
>
> [...]
>
>  /// However, when one may need to increment the refcount, it is preferab=
le to use an `ArcBorrow<T>`
> -/// over `&Arc<T>` because the latter results in a double-indirection: a=
 pointer (shared reference)
> -/// to a pointer ([`Arc<T>`]) to the object (`T`). An [`ArcBorrow`] elim=
inates this double
> -/// indirection while still allowing one to increment the refcount and g=
etting an [`Arc<T>`] when/if
> -/// needed.
> +/// over <code>&[`Arc<T>`]</code> because the latter results in a double=
-indirection: a pointer
> +/// (shared reference) to a pointer ([`Arc<T>`]) to the object (`T`). An=
 [`ArcBorrow`] eliminates
> +/// this double indirection while still allowing one to increment the re=
fcount and getting an
> +/// [`Arc<T>`] when/if needed.

Std sometimes does something like this, which links to the slice primitive.

    [`&[u8]`](prim@slice)

What exactly is going on with Arc, is it not getting linked correctly
when it has generics? I don't quite follow what <code> does.

I agree with Martin, we don't need to try too hard to link these types
- slices and numeric types are background knowledge, and it is easy
enough to search for the other types (Arc, Test) if the links don't
work for whatever reason.

If rustdoc just isn't making good choices in certain places or isn't
flexible enough, could you write issues in the Rust repo? Better to
get inconveniences fixed upstream if possible.

- Trevor

