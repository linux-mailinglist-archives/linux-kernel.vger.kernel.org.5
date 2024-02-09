Return-Path: <linux-kernel+bounces-59341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC1584F59D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572882826FB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99383C482;
	Fri,  9 Feb 2024 13:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Spi1Q4Jn"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A916C3C461
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 13:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707484065; cv=none; b=hxpKrATFSrNbPCMKnE5hF96uEWwLn1ERNMWfD8Jpla/sA86Cu619LfL5YzXtI/2bSs60mLwXQbBl4HRW4hzukqyWc5Xu76/n2nOySQI4kka7aCZcWVkMpx3wk/hWQJsCrJSK8ni/K3isuooSuuinaElXnixA+g9tWxbaTMHX63k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707484065; c=relaxed/simple;
	bh=2Rw/g85sJGphAZrvH5ci9NlrmUd7mEl1/NsrSKYc4qU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXTS44ypyq5zWqukxa7FRP0TGjjl8tkC+0xGr/oRPuie6ZQmjsRzGMuzQTJi11rYInuNAUzqRmUTOpdJfs+t7GBCSJknn0qoC97vIfeyOnNoBKpTaBVaIIkKg+AguR1HX6OJPR4nvs1IOwRFgFT422MRTfANqgvQ255MKGog3bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Spi1Q4Jn; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-68cc2a389a9so6804686d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 05:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707484062; x=1708088862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Rw/g85sJGphAZrvH5ci9NlrmUd7mEl1/NsrSKYc4qU=;
        b=Spi1Q4JnB3TMfs8OlpWnbKVGkG5Qb26lsBwFQQqJKc+jlmzZ6kdetGTb9+vPuPk/ut
         Nx0bsfaC6+qMn/ynA9S137Thizl+cYyJ3pEl0xb59q5SZp4CzoqxJH15X16DygqWBfGI
         rn0w7JqofcZyhi05bA5P6UlaYfb49EJUw8nIDE7TLJQYcpbviQobD0dNar0RwB78laLp
         72HiKY5eOhrzicF6DAiuUTnVWvCfvP61YQQuY4Ju3u8fogZf4H+iOam1QeVyWDmpbX5b
         QfaeNHaJd8xkvkNBcjCbIaWNA8X/8NyPOFSule7ym/Gs91+mjzej0b16mH4lzVr8QgiK
         KZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707484062; x=1708088862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Rw/g85sJGphAZrvH5ci9NlrmUd7mEl1/NsrSKYc4qU=;
        b=bzQnjYTPWM6eWrJ0Z4CFm+fUpEz+K4/rqoNk4sED0FioC1rX8Dk0yF6RH95aAdMOzb
         WslXmgbFyxJspkeUbvmdVc44OzOOjgUbUufFsfyZACkmyU0oq0ZbpHvh5pPcWTONeVSS
         stpVOpkx8pqRO7o45MUGhkTaH4NFdc/Y15wxx24HVU4d+8mWO9eHG8Sje5ThQFBmsSGq
         HEUkLRxnz0BtEOQrzAzqUoLT4ddzqUYg1mcF4huLJsQgeJqoBLqZhOYaCz8AOKE+u/w1
         l3jy7f/pAEPDUd1f35T1w1jJPPa/nHGnCsOQlJKX6vRUv97Nf/rxIyBDnX/vwNXf6HXD
         tp7A==
X-Gm-Message-State: AOJu0YxB+abg33akCza7FX1doZUdbHpAOABcrNA+YFHANEtWCgsoLnAB
	CYCeas6SYcI0ymH2/3WEeI6b4xAmS5CNO9AOrUEXHJSSP/pafCHHAh1uysthLGD3nWnFhOqqSx3
	l17sB31JEYB8i6koDJ6cmTblSKqr0qmkGl/wd
X-Google-Smtp-Source: AGHT+IGQKINrMd7voH8M4WrH1YHEgveky+mPQz8IVaL/+16Aec7hAUy8tYleTebsXC9uGt2KmEm7Kyf4/F9j1uSvWhM=
X-Received: by 2002:a0c:cd03:0:b0:68c:7302:8974 with SMTP id
 b3-20020a0ccd03000000b0068c73028974mr1030374qvm.30.1707484062427; Fri, 09 Feb
 2024 05:07:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205-b4-rbtree-v1-0-995e3eee38c0@google.com> <20240205-b4-rbtree-v1-6-995e3eee38c0@google.com>
In-Reply-To: <20240205-b4-rbtree-v1-6-995e3eee38c0@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 9 Feb 2024 14:07:31 +0100
Message-ID: <CAH5fLgh9D5vVOCp+OQFqkCzeBBXJSbBn33_aJB6NR3=Yads_0g@mail.gmail.com>
Subject: Re: [PATCH 6/6] rust: rbtree: add `RBTree::entry`
To: mattgilbride@google.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>, Rob Landley <rob@landley.net>, 
	Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 4:50=E2=80=AFPM <mattgilbride@google.com> wrote:
>
> From: Alice Ryhl <aliceryhl@google.com>
>
> This mirrors the entry API [1] from the Rust standard library on
> `RBTree`. This API can be used to access the entry at a specific key and
> make modifications depending on whether the key is vacant or occupied.
> This API is useful because it can often be used to avoid traversing the
> tree multiple times.
>
> This is used by binder to look up and conditionally access or insert a
> value, depending on whether it is there or not [2].
>
> Link: https://doc.rust-lang.org/stable/std/collections/btree_map/enum.Ent=
ry.html [1]
> Link: https://android-review.googlesource.com/c/kernel/common/+/2849906 [=
2]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Matt Gilbride <mattgilbride@google.com>

I wrote this patch, so I will not review it, but I have used it in
Rust Binder, so:

Tested-by: Alice Ryhl <aliceryhl@google.com>

