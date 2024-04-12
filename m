Return-Path: <linux-kernel+bounces-142552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C838A2D0D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A60B1F221B6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FC653818;
	Fri, 12 Apr 2024 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wd3IZ2Td"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3301548E7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712919940; cv=none; b=Fh7NMjVicHmQg6VuGiTx70wc0EFG28zdXjugxBe7cWulUs+nz0EcCxNKtwijIAiNUSzV8pxtrX955BWpmMRa6OnrP5eMDUj/9rK/Fmi+vq9mEbYzap0yr+r8gLg7sxfAo4E8ua43TZiXva9Uk+WgF2WsjDn1c26fQvz34OcYP6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712919940; c=relaxed/simple;
	bh=0IoG0mCZOW0wJmxr2Xu4LuFbvj+6BIcyh7qESx1wVw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1/bfF7cJqGRlrgIHrZUVxNY7OPr/GOHu2WQXBENhmxoqR7c0EaOSSeYaWE1d59ysl5X7I/YqWpU1NWa1q6NjTPAbopUdGpWEQdUzeAn8uG+8uPWejEnEJcQv8tjx5rAw2fuVCwnhl/+x6M50pUK27/d4tEBakQX8FBg8aPnYlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wd3IZ2Td; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-617e6c873f3so8029747b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712919938; x=1713524738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzfOcKUbZNTZgqT86TeCwDD13GWyo5joeRsaFKSBZXU=;
        b=Wd3IZ2TdZoHWnqOmtIbwnLYX4N2UhKNYymjo+ZqN0wiSFdxkSb3X/8uYf+QcwQMZ5t
         8a9zxaZC/hnWr3tEuvuRIBleVOsamljoXiCr3pjhOiBRK0ydO/jznekn7UPAeajOfKys
         bKWYCe29yPj8peAKZg1J3kjh5dbzSUak+3c2li8RIYSX7lvUjbmBCcMN62etyATWWo6S
         VqyNjZPQ9GT5fdbFkGvGik3EivmCkF2ZBUWQD/Oxn2qpcf+hfWlS5OnE0yLlDTYEFOTk
         0Ay9CKyBJcomTkXQua6Dkr+DygF1PBLkhOUa8l45zyTCyWHYaBOStKlNxrb9RnyC/Wkb
         PUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712919938; x=1713524738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzfOcKUbZNTZgqT86TeCwDD13GWyo5joeRsaFKSBZXU=;
        b=kHfcmtFl82/Wy4CgTDdcIXw7Ay+EbxeMbGgt4wq0P80PGNtpM3CHXbJdlJQzh4TApW
         najnYz8pbSP695ESbzXN3baNcZ8SqV8cNZpT+2OwesWd13+g68gPXHyeFNF5Z9S+kUHK
         vhYczCg340YHeu4hK0EhobpRpF4L6FmpyiTMqOdwFOagqcSChzXjC3lywJOiJxyEvlG2
         RgVMHFsdqBNtN7ae6wuvrQzz2yscz5NugDuzHPTvQNDn35K3wYdTLCa0KJYpqLbLrIll
         1AjQrAezGKeZtWmPjp8rualQMia7Wy0RR9Yw8IejqT7/xMAqhVT1bczLloyXEukTnCMh
         wrqw==
X-Forwarded-Encrypted: i=1; AJvYcCUfJ6KnE3VErJoAODBR/zkWBAPZAAfjn0uqDTXS5rGYiO50WN3ubaiSc/vX0fGO/df0S4mx7B+BHkMyNQprndYHyOYQgA5o7CmhU/fs
X-Gm-Message-State: AOJu0YxG5yuOaFPl4HDNtPK9Jk2aGrIRjrJZlVYGvLbqNu1Ea2P1PEBX
	IqDj+7L3LwNR9tEqHI7v4GeTPJBon4655ud0QS/jxUMoWru9ZjzD9SD51YCjIBwboBeAOqpGPhC
	FsahFYlnE8T3pASC1EWVWzwpbv+iwFdv+LN6D
X-Google-Smtp-Source: AGHT+IEBnDnyttWxFfdfXd1lACxwpBaMVWQSGqXihk2W5PNA76nEeDSDYyOMEAi8SbgER2qNscvel2MUuN1FtzPft6w=
X-Received: by 2002:a81:83cb:0:b0:615:7311:8f01 with SMTP id
 t194-20020a8183cb000000b0061573118f01mr1966333ywf.51.1712919937826; Fri, 12
 Apr 2024 04:05:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411205428.537700-1-thorsten.blum@toblux.com>
In-Reply-To: <20240411205428.537700-1-thorsten.blum@toblux.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 12 Apr 2024 13:05:27 +0200
Message-ID: <CAH5fLgjx=z-bDHOD4nNiagzGyAigBaKpu+mRsYvWSF5Qj4p+xA@mail.gmail.com>
Subject: Re: [PATCH] rust: helpers: Fix grammar in comment
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 10:55=E2=80=AFPM Thorsten Blum <thorsten.blum@toblu=
x.com> wrote:
>
> s/directly the bindings/the bindings directly/
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  rust/helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 70e59efd92bc..4c8b7b92a4f4 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -4,7 +4,7 @@
>   * cannot be called either. This file explicitly creates functions ("hel=
pers")
>   * that wrap those so that they can be called from Rust.
>   *
> - * Even though Rust kernel modules should never use directly the binding=
s, some
> + * Even though Rust kernel modules should never use the bindings directl=
y, some
>   * of these helpers need to be exported because Rust generics and inline=
d
>   * functions may not get their code generated in the crate where they ar=
e
>   * defined. Other helpers, called from non-inline functions, may not be

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

