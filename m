Return-Path: <linux-kernel+bounces-47539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B1E844F1C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1EDE28BA2B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156AA17BD1;
	Thu,  1 Feb 2024 02:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="EEPzukSa"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689082C686
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 02:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706754248; cv=none; b=Jo8pw+dA3A47e9f7u3ae6Oc6vA5Uq+acccclkRbyLPqNKhTZdVvZxNb4M838q8Px+V2k/rS/wrAhq4dJkhhz4svVZpJVCKcp4iemr+bmz4sZwyBAyY6uCYhpBFrasEM0cLTyXe5w847Rna2g3JF+7S7tFTslyR8cac0HXlpKAGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706754248; c=relaxed/simple;
	bh=fkXFos6L/rV1zWpZDWOfhA322McaQHE9Bg/adiPhBFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eu4DS0HqS1oN8uNK12LowIlKaIsi5uXuzLtZu/AU6HrosmvmhUgSNdV2yzc7mBo+JQuiepdaG79hrR++z3MfBe7nJCL6Si6rQK25c6lI4vSUbOPvzpMufOJyxPyqEy2li5vEuDxAQZx4jNdAbhi31zLE6cVbATEMwVlncN/jLi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=EEPzukSa; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so410270276.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 18:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1706754245; x=1707359045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qv9t+IRz0wmSb4+k+n2HrMuYyzYj5ilzOfW+hmCAer0=;
        b=EEPzukSaLKvrksbqis9HHjVin2117HV2j1or5bagH2+o0t7FatYOKbhF1BaEnBlDtI
         w7B3Qz+RRUAkD5RVoPtOs5UDYj/fqstt/SkU6mvfX98jT2M8GquLJClOv9WBCwo7TMq2
         Dccj4I3K3pVwmWwQUPcZBq4AhAbZ12rrHpupWmAiroO4VWbRlA22Oetcds+UCkgfP3Sj
         z1plVxhFhElNTLMhnquyF/krzK/w3FXmdzqbGLrOel1qnhTWtvJ4N6fEPu3evD+tLIg5
         I3Sxe2A3OYfZU/gT4Fz5x7Z4UodxEjMtzRAfLfGjeEgK965kdTR+C2EdsKcp444dVfpo
         PGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706754245; x=1707359045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qv9t+IRz0wmSb4+k+n2HrMuYyzYj5ilzOfW+hmCAer0=;
        b=YJJ22YKbmkvvT3gdhlEOO8804G9xiRBAMrOzLy972KBSC3Zl/GCaqMQEI+XynvK9aV
         qHHJX+oayUBCcQYL5wdrw3IuZgTgRlOgEPdMBRG/8ONaSyAFedeF4D/hwBrs2gphMsvq
         9Rp3fvb+v2vhuSu+fCsOk4ChPpLo4NPJAqLBCUQYFmHfUzgAbe32Fz2kDFsJA09PZjLb
         sLJNpSQQhLfB+ldbiTaW4B/jTWyVisxlV8PhndQt232pjt/j3++79LU7KAY8Moc5CUQh
         GU0QWY9GCc12hDLW1sgAzkNlKSzr7g5K5LzDPkE7nCp/l6vd8UMPhiegHMsxUujLKROF
         bEvg==
X-Gm-Message-State: AOJu0Yw45Ec44WgSckhYm4xF8ZXy+0YZLWu9dvjMiBVpMsGNJJOjEJMq
	liZiZshVu9g9pCBfi6P4wyZSbnMcnZKNl6UEhH/eJk/4cXc4j0tDq2TkIfhjcr5npGiQsvI0vXd
	Tfd9at+ORLRieEJqxva+uLennq9Gw6QpTwhWHzw==
X-Google-Smtp-Source: AGHT+IGFdlt1xxouZCrqMQsuo4SbJafYi7z8vsV1/H2fVQtIyjxA5hGHOKunnfjVMjM5v9SAOouIHOknc/Hzrdxjy8U=
X-Received: by 2002:a25:1e83:0:b0:dc6:1869:9919 with SMTP id
 e125-20020a251e83000000b00dc618699919mr3203708ybe.41.1706754245121; Wed, 31
 Jan 2024 18:24:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131-doc-fixes-v3-v3-0-0c8af94ed7de@valentinobst.de> <20240131-doc-fixes-v3-v3-2-0c8af94ed7de@valentinobst.de>
In-Reply-To: <20240131-doc-fixes-v3-v3-2-0c8af94ed7de@valentinobst.de>
From: Trevor Gross <tmgross@umich.edu>
Date: Wed, 31 Jan 2024 21:23:48 -0500
Message-ID: <CALNs47t1OME29WyYqv_O8PQ0ZesrXEHtg4xntwQWgL0O6f3L=A@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] rust: error: improve unsafe code in example
To: kernel@valentinobst.de
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 3:24=E2=80=AFPM Valentin Obst via B4 Relay
<devnull+kernel.valentinobst.de@kernel.org> wrote:
>
> From: Valentin Obst <kernel@valentinobst.de>
>
> The `from_err_ptr` function is safe. There is no need for the call to it
> to be inside the unsafe block.
>
> Reword the SAFETY comment to provide a better justification of why the
> FFI call is safe.
>
> Signed-off-by: Valentin Obst <kernel@valentinobst.de>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

> ---
>  rust/kernel/error.rs | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 4f0c1edd63b7..4786d3ee1e92 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -264,13 +264,9 @@ pub fn to_result(err: core::ffi::c_int) -> Result {
>  ///     pdev: &mut PlatformDevice,
>  ///     index: u32,
>  /// ) -> Result<*mut core::ffi::c_void> {
> -///     // SAFETY: FFI call.
> -///     unsafe {
> -///         from_err_ptr(bindings::devm_platform_ioremap_resource(
> -///             pdev.to_ptr(),
> -///             index,
> -///         ))
> -///     }
> +///     // SAFETY: `pdev` points to a valid platform device. There are n=
o safety requirements
> +///     // on `index`.
> +///     from_err_ptr(unsafe { bindings::devm_platform_ioremap_resource(p=
dev.to_ptr(), index) })
>  /// }
>  /// ```
>  // TODO: Remove `dead_code` marker once an in-kernel client is available=
.
>
> --
> 2.43.0
>
>

