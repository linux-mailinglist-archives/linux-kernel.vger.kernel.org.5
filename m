Return-Path: <linux-kernel+bounces-59338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A97184F599
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2261F27BB0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B3B38394;
	Fri,  9 Feb 2024 13:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WwTeX2LR"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34650381B1
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 13:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707483979; cv=none; b=WoHpTCJLCP3t65wXMcEtA6UtE2uuaYlHEXs9wIX1P3zAwPIZudRSKPv3uaMJEXR05y6H9mspHk2XReV8mj45w5EbwXNDKvlNdK+nvhJ6X51VKhi9FThAtGxeCnbz5qzTjFH/wv0pipVmlAYp7XXkry9rS1cdp1SdYRqYzcJjuHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707483979; c=relaxed/simple;
	bh=AEDphcx1FQNsF9qiJV4SSq7U2Kx5za3ZeN44KAWA2FE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oipHgVfRkmjXFaXXILmLhLnCQdKRaPHxhGM5/1lZJNEmbuwVNaOZ+E/WZS2qdFaqLgIiH9sXzBv6v1Q5ZX9+Z+VfVqmPhcGf2zCY/EY+wpMmKaAwxUF5Pa0/AfTnzjBCP6cx6bD65Xzu2e9T2/d4DxbN4UDM5SiwWWW2JDy3BL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WwTeX2LR; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bbbc6e51d0so508242b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 05:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707483977; x=1708088777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXQlm8wYk42FKH3UwHT+zuLEtFefXsoBAX29Ffp/+rM=;
        b=WwTeX2LRlGkAll4d92KQdo6om0ZG1QnnW35qmWGLT5l8SkaRCjReuEmQD0Yir0csNh
         9O2u1XWyGCQbLwHKSIVJjkfVLvz+TCJiq48t2E/yuL8EPifFItx7qTGiiOiLb3WCOACe
         m/cpk236SOUUY962yS6bx+jRf/hXjNEBqPxFTfjU9sdG4Av2i/E60wXDnpsz9KzkRgkr
         eRoKKmUDoyTpMAG1gKNIzB24rtoiQzM3H0RX0X9RZGPVS6UzY/a5JOMkLsIe5S0Quf/R
         uLYtAwiftINrihMpICQ0Mcu+LrDHq9ZXedsaW08oFMuJ7lkBc+UGuvfvtewBHxty0jX5
         OqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707483977; x=1708088777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXQlm8wYk42FKH3UwHT+zuLEtFefXsoBAX29Ffp/+rM=;
        b=OZPi8UDrSDT777JUZGgkE2G7SlaOdoauCjyZZLuleCpv/UMjjZa4fdaiRUJM/2SuZV
         Ul+q8mUzWn/y6jz06ojvh4/GcaVbyEnDCyO5SnZ2S2VVs7YnrrskepTayUwTQ0vMo7R7
         IKgufcOuvrZmxwbQrWU8kPUvU1y+ujvV56LzkKGRaTzPWlxhTlWLxxOzegvTXCqGrfK0
         HzuU/wAuXClJma2RlSHaxpJV78PIhGQxc1L+REtLwNaZvceNCgZnOz5L/s+1zActtC3C
         b01Wk5HYGpnb9HYVcqFou11MhfmzQirh9mq+fqZGc1nduX4remCUgLujgWnOVRm6eLMQ
         J/KQ==
X-Gm-Message-State: AOJu0YwTPkKkGjpA13owW4y497ZmBoSLb7Z9mpk9iCC8nx1K6VoSc9cg
	FkXlV4K2mIqPQIIlwILJrp2UUutUy/t1BCQ8vv1emDNHIs8Ju/I69djIhKwR/W4785RZ8xeBInj
	xXz8JUOFjHWsQgLvySsDAnhRMG2q2N+iXk04P
X-Google-Smtp-Source: AGHT+IHBGxtcRS1vlCmy/DgZiXUssK0zz/bFjoE872mOIvHoPK85pPVC+hWEMgfrO4ToUrj9QAK2sQhOuAm86hlvwP4=
X-Received: by 2002:a05:6808:1b06:b0:3bf:c8cd:460d with SMTP id
 bx6-20020a0568081b0600b003bfc8cd460dmr1728600oib.1.1707483977082; Fri, 09 Feb
 2024 05:06:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205-b4-rbtree-v1-0-995e3eee38c0@google.com> <20240205-b4-rbtree-v1-3-995e3eee38c0@google.com>
In-Reply-To: <20240205-b4-rbtree-v1-3-995e3eee38c0@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 9 Feb 2024 14:06:05 +0100
Message-ID: <CAH5fLgj8eZRbiuG7MgRaDbZHkUVUfSXuUdEqUB4foysds2vk1Q@mail.gmail.com>
Subject: Re: [PATCH 3/6] rust: rbtree: add `RBTreeIterator`
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
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
>
> - Add Iterator implementation (`RBTreeIterator`) for `RBTree`, allowing
>   iteration over (key, value) pairs in key order.
> - Add individual `keys()` and `values()` functions to iterate over keys
>   or values alone.
> - Update doctests to use iteration instead of explicitly getting items.
>
> Iteration is needed by the binder driver to enumerate all values in a
> tree for oneway spam detection [1].
>
> Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-17-0=
8ba9197f637@google.com/ [1]
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Matt Gilbride <mattgilbride@google.com>

I have looked at these bindings many times over the past year. They
look good to me.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

These abstractions have been very heavily exercised by the Rust Binder
driver.

Tested-by: Alice Ryhl <aliceryhl@google.com>

