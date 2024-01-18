Return-Path: <linux-kernel+bounces-29590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E10831087
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2972C1C2201A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B992E15AE;
	Thu, 18 Jan 2024 00:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="UQO9N6PS"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E50630
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 00:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705537898; cv=none; b=Ck3cZQ4faIoTJQ++lvikqB//+fWyoYL0MmwAO6sH0AtU6iQ4zk9Rr0nYyyPCu6uq+81EGvHVQ/dzm/f3WmO1Q1C1Rlp2CZsR8raIwkFgSzfPQakMCK+vThmRbH6St0iO8QZ8rpxEs7O7ixp2VVyJGpJUu+a/G6zNbvfji6QFuuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705537898; c=relaxed/simple;
	bh=HHHN+21b1s5ZsZlwFfsA33inEbYD5JArBhhzvCwxMs8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=lu9a7QpHbUo7Toh8GB8CnVA5PyYRWbYMGetVrKsZ0LjrVAvDsT7YEN63yErF1SPwdE+h2cpEOPQAlNx+qR/42NnM+C0WryxpUP2z+XSPA889vtxqmZlwTpGWRN4d5XPem6oTOQDce6TsSNYTz+f5gafhbEbRZCwutI0xRjSe6GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=UQO9N6PS; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5ff7a8b5e61so7293747b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1705537895; x=1706142695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMCjVbbEOX7lRW66KzLOgIpoqKdWLZHzBrkMjFZb0Aw=;
        b=UQO9N6PS+ZFBa8mNGVgKWtS3lKJrLUbT9gC2zXEfTnKSl2nZ7nv30gPvvF7LSbRTVw
         hYCDME+QyndX+EP3vkyFfYGJcqJ9cx2J6oM2m5cb7xg3BICFVTRUaJkL8RUvsBixgUce
         nHq3Fn2L2XVFdfyn2SZrZysVeyqgMB+eY8gSuBN9r45s7HCAZf9ZhX72RiQCZfJMu+XL
         ptr++YshhE6rAtXuw0Mnbs/vRpDF0nUwnz/1xTwxjvT0md45eNE/OcZAABC/xiX7IMn1
         xTbQo67L/YUVvToo/HCZQiChsg00H4duTNVKTvmlrUWoXpibnGFMSUbIUkx47zcpvS3p
         tDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705537895; x=1706142695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMCjVbbEOX7lRW66KzLOgIpoqKdWLZHzBrkMjFZb0Aw=;
        b=iCGZkBrSwwqQYdulz2LgjxpLkvfiaikXkKUf9je+gycgKEEIa1NdpKIyWHY1x3xNqJ
         h0rx0H6zV14B/0UWA/iXS+ek9raE495ZEN95DGn7bNhT/6OwhtvSvkcQw/jRidq8ZnHg
         crsPel55SUh2S/h4fGBoRYUO0b2o11Qu2uoaTMn5/RQxNjVKhDU0nZF5lZ09HqgWajyT
         kpQCxxTq0T/2O98uxARVg/qw4ZItSGKWVZO5MV+F3P2Wx42JzBDe+SnghohCGipUFMRS
         lghxHWYkz77XHof1igvqpQaMVPB41v0OE7Ki8GjGBK38wwThTt1f4DecN/p8/E0g7yWo
         u48g==
X-Gm-Message-State: AOJu0YxESJNDjCOqI8VPbtJ3hz0vrdbOIVuM+pcnWJ19Ml260hTBor/E
	4DM0TO9ryDQiFtupNTYlnKt3IOTW00KV+GeXkiFaP9ImnrVGMtHH8wpiUbCO1dQnZDh+DXDJcJS
	n9GANpYUOJUnggN0Rozb0m/3tJI7+kU/uEdR0Ig==
X-Google-Smtp-Source: AGHT+IFXAWJujkNhfsG1Z48yZUPTeX3COlLwUJNjKT7WOkOYn+1ZVbAZuNOBpx7XPhvfh1bqCcUaTGZ4it3QtQrPQV0=
X-Received: by 2002:a81:6d09:0:b0:5ed:90e1:8bf4 with SMTP id
 i9-20020a816d09000000b005ed90e18bf4mr56966ywc.47.1705537895688; Wed, 17 Jan
 2024 16:31:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116160141.165951-1-kernel@valentinobst.de> <20240116160141.165951-3-kernel@valentinobst.de>
In-Reply-To: <20240116160141.165951-3-kernel@valentinobst.de>
From: Trevor Gross <tmgross@umich.edu>
Date: Wed, 17 Jan 2024 19:31:24 -0500
Message-ID: <CALNs47vgfs+cFhYsTZU_RE5WxFZ4euMAhuKESJE6m7PFy0JTzQ@mail.gmail.com>
Subject: Re: [PATCH 02/13] rust: error: move unsafe block into function call
To: Valentin Obst <kernel@valentinobst.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 11:05=E2=80=AFAM Valentin Obst <kernel@valentinobst=
de> wrote:
>
> The `from_err_ptr` function is safe. There is no need for the call to it
> to be inside the unsafe block.
>
> Signed-off-by: Valentin Obst <kernel@valentinobst.de>
> ---
>  rust/kernel/error.rs | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 4f0c1edd63b7..6f6676bc0eb9 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -265,12 +265,7 @@ pub fn to_result(err: core::ffi::c_int) -> Result {
>  ///     index: u32,
>  /// ) -> Result<*mut core::ffi::c_void> {
>  ///     // SAFETY: FFI call.
> -///     unsafe {
> -///         from_err_ptr(bindings::devm_platform_ioremap_resource(
> -///             pdev.to_ptr(),
> -///             index,
> -///         ))
> -///     }
> +///     from_err_ptr(unsafe { bindings::devm_platform_ioremap_resource(p=
dev.to_ptr(), index) })
>  /// }
>  /// ```
>  // TODO: Remove `dead_code` marker once an in-kernel client is available=
.
> --
> 2.43.0
>
>

If you're up for it, that safety comment could also be improved. Something =
like

    // SAFETY: `pdev` points to a valid platform device

But that is noncritical.

Reviewed-by: Trevor Gross <tmgross@umich.edu>

