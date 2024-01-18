Return-Path: <linux-kernel+bounces-29606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE4C8310B6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C992D1F24DEE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8480F211C;
	Thu, 18 Jan 2024 01:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="iXNFcAb1"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908FD186E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 01:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705539969; cv=none; b=exxdqe7q4odslO3lNeKR1jE31ExQXC+iAymKBzKu2XW20OIQIf3FqT2WdrJMqh4FQf0OqmfQY6A6KqSXw+33c3MZ223MJQ17HO2Rd7R7PqZzugSRru3k4OST8NhPKHuwcCkOaFWfrcHeIB2SZ6jZ2uAqmtIEtp45nay5IMMHxcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705539969; c=relaxed/simple;
	bh=Esad9FEWSOrIwHYIcn+c5ne4heeaiNe7xF33zHox1NE=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=bhbAQCl2Plkj66L82A0cJUVe3vmMUVarDHpRQ6naBOcX+cqhlZJAHjISkVXdnBCcZGkRfWixmyaY8yNuRpD5MdU9lSUTMiAPW0Z2W5ro9YLtTsti8JjjNlkSLj8Pi2MZ2Wh7r+aZ20xzcER+wbWBwUELgFiL+gwtqtMo1vXayig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=iXNFcAb1; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5ff7a098ab8so7125447b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 17:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1705539966; x=1706144766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xX+fGMnDm2Xckac8xPFbwtgUlcl2qN7KhbYjVoA1KTI=;
        b=iXNFcAb1pZZsWX3+w9fdIEXOxgDE3SMuvX5Np1TlVWM2XAO8gy/XGBhRt9S7Aof4Sf
         bt+JjnMnPbuDTM3oV8VlQio/Smgf8TgY3KokbBjYeFbVXwMt1eA8sFQwy3P453pBMZ6Y
         uS2d3PfTRbveZwIRdoF5LRQLV2xAgvf9/UvRwn/v7rq0J2X9gL+BJO/YC4bKIBaAJadR
         df2PPck8gHseSwCoichKGhdylXLDBnHuDN1/kbNOrb88KI+wzSzjcSH6X2SFaAbyJ43J
         Z+tiyQZMgsjA/YDQvGYbpVDM/znORrUCm3hr8DLL3G21YHIPDi3h+1iSKDFFzeuN7srY
         Pirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705539966; x=1706144766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xX+fGMnDm2Xckac8xPFbwtgUlcl2qN7KhbYjVoA1KTI=;
        b=jScZbEDhHEVkvJvTPiHfH9k9xamN3dE2x5fuNpHKJH5FcGdClGU+2qFWqErD+bs7/e
         weh8AcoqtJgYoKBkG2G+RP0RgjSTT7Ne5xNwKD5CI6YaOhgf8CiFIZOkJLKaMr7IVJJt
         jh53ILRc5NXljtSsqtrSdM/UPBM8D4tbDuWeKJs8Dqxtbn3EMi8t5cPqvWEeRoDqY4Wf
         TGUj5ll2ndi9BfORUh8+Zmy0+jBbNEnnZiEec1x6e3xonT1dNP1v22THrK0C254D8CB3
         Xxn9srgD1g/0TpCXzJB3tuIFpj44mbfBuVhM002iTq/qO92mb8RPKtJgjkLkYh6l2Fs1
         fgCA==
X-Gm-Message-State: AOJu0YwBHPGNLg4OmLSHKAlgheicS4JtnIK4JYbrDwrFjaPSsgrbZ1MU
	tuYLw+GbGditjOLxJNJ/b7OGTVaCBrUKm4qsxwcIVGkUz8ABEUvnDhrs2wEaLKYJOuckngz5bn+
	k3sdTxjfDLQ/lDvgRkA/keHUwBYVlFBsg3kJZYQ==
X-Google-Smtp-Source: AGHT+IH0C7gdhIIVi7xi75yyYBE/eMR53bYPk32XKllL8/0pTaR1nntBeMq1b6hWhIeBNuY2QvY2RiB6cwPrMYuw8AQ=
X-Received: by 2002:a0d:e20a:0:b0:5f6:cfc3:f5a3 with SMTP id
 l10-20020a0de20a000000b005f6cfc3f5a3mr100002ywe.50.1705539966543; Wed, 17 Jan
 2024 17:06:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116160141.165951-1-kernel@valentinobst.de> <20240116220634.168103-1-kernel@valentinobst.de>
In-Reply-To: <20240116220634.168103-1-kernel@valentinobst.de>
From: Trevor Gross <tmgross@umich.edu>
Date: Wed, 17 Jan 2024 20:05:55 -0500
Message-ID: <CALNs47sqzqWzE-5srCq7_ePVx3HGaJ9EkwGbbFnqH9xCJXDByw@mail.gmail.com>
Subject: Re: [PATCH 07/13] rust: kernel: unify spelling of refcount in docs
To: Valentin Obst <kernel@valentinobst.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 5:37=E2=80=AFPM Valentin Obst <kernel@valentinobst.=
de> wrote:
>
> Replace instances of 'ref-count[ed]' with 'refcount[ed]' to increase
> consistency within the Rust documentation. The latter form is used more
> widely in the rest of the kernel:
>
> ```console
> $ rg '(\*|//).*?\srefcount(|ed)[\s,.]' | wc -l
> 1605
> $ rg '(\*|//).*?\sref-count(|ed)[\s,.]' | wc -l
> 43
> ```
>
> (numbers are for Commit 052d534373b7)
>
> Signed-off-by: Valentin Obst <kernel@valentinobst.de>
> ---
>  rust/kernel/sync/arc.rs | 8 ++++----
>  rust/kernel/task.rs     | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 77cdbcf7bd2e..6c46b1affca5 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -56,7 +56,7 @@
>  ///     b: u32,
>  /// }
>  ///
> -/// // Create a ref-counted instance of `Example`.
> +/// // Create a refcounted instance of `Example`.
>  /// let obj =3D Arc::try_new(Example { a: 10, b: 20 })?;
>  ///
>  /// // Get a new pointer to `obj` and increment the refcount.
> @@ -510,7 +510,7 @@ fn deref(&self) -> &Self::Target {
>  /// # test().unwrap();
>  /// ```
>  ///
> -/// In the following example we first allocate memory for a ref-counted =
`Example` but we don't
> +/// In the following example we first allocate memory for a refcounted `=
Example` but we don't
>  /// initialise it on allocation. We do initialise it later with a call t=
o [`UniqueArc::write`],
>  /// followed by a conversion to `Arc<Example>`. This is particularly use=
ful when allocation happens
>  /// in one context (e.g., sleepable) and initialisation in another (e.g.=
, atomic):
> @@ -560,7 +560,7 @@ impl<T> UniqueArc<T> {
>      /// Tries to allocate a new [`UniqueArc`] instance.
>      pub fn try_new(value: T) -> Result<Self, AllocError> {
>          Ok(Self {
> -            // INVARIANT: The newly-created object has a ref-count of 1.
> +            // INVARIANT: The newly-created object has a refcount of 1.
>              inner: Arc::try_new(value)?,
>          })
>      }
> @@ -574,7 +574,7 @@ pub fn try_new_uninit() -> Result<UniqueArc<MaybeUnin=
it<T>>, AllocError> {
>              data <- init::uninit::<T, AllocError>(),
>          }? AllocError))?;
>          Ok(UniqueArc {
> -            // INVARIANT: The newly-created object has a ref-count of 1.
> +            // INVARIANT: The newly-created object has a refcount of 1.
>              // SAFETY: The pointer from the `Box` is valid.
>              inner: unsafe { Arc::from_inner(Box::leak(inner).into()) },
>          })
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index 9451932d5d86..818ac51b06b6 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -23,7 +23,7 @@ macro_rules! current {
>  ///
>  /// All instances are valid tasks created by the C portion of the kernel=
.
>  ///
> -/// Instances of this type are always ref-counted, that is, a call to `g=
et_task_struct` ensures
> +/// Instances of this type are always refcounted, that is, a call to `ge=
t_task_struct` ensures
>  /// that the allocation remains valid at least until the matching call t=
o `put_task_struct`.
>  ///
>  /// # Examples
> @@ -147,7 +147,7 @@ pub fn wake_up(&self) {
>      }
>  }
>
> -// SAFETY: The type invariants guarantee that `Task` is always ref-count=
ed.
> +// SAFETY: The type invariants guarantee that `Task` is always refcounte=
d.
>  unsafe impl crate::types::AlwaysRefCounted for Task {
>      fn inc_ref(&self) {
>          // SAFETY: The existence of a shared reference means that the re=
fcount is nonzero.
> --
> 2.43.0
>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

