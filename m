Return-Path: <linux-kernel+bounces-59340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 871E384F59C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4101C2221E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66D0383B6;
	Fri,  9 Feb 2024 13:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pH8/63oQ"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F93381C4
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 13:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707484022; cv=none; b=oxW3fiEV3V9sCnNFIsyxNYWV3IvnTlvOSArAzGJGnH8BGsBpk6CeILiKNa5qZkpXbvGvj9mct4C2cr8fpMWFynRYy7mz1vTW+KXOJMYmcPrH+pyUwbEp9ui20/IWbYeAW8plSOWIkj/KH/3asTiB3e80ap2k4nm0WNm/WBVgJFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707484022; c=relaxed/simple;
	bh=Osx1MwrfwvLxJy9upXGkHqimngBod33AzJBkO19MTUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENY7iEgcGeRZw9fA0J4edBPZx4BudcI04P3tkLPCyAhvSolCZnrwLlE5W+skT8O2IA6jUZv+FMwLUanfet+H+fVBx2YiUVuVTSsQhvoUVuMSXZewInxysLgHTswlcxwRRZIn+hyrbk8L9yZA1joW4koRJAnYuWCH+mXymzsQpBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pH8/63oQ; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-68cc84a23b1so4114076d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 05:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707484018; x=1708088818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Cdz5dVZvDPVC+BewWJMsgYajolCToKYQ11a6wmFWQw=;
        b=pH8/63oQAOuf0bQOVF4TiePSzwkCQxlIoZ6SJKbtkOMV6VDt4x13pbcmoMTo1qugir
         hiXUn36rs5RlD+LPAMfshLqKXA4MC4wuAgQdM334eAakdnY0wdiCIo80c8UAQqQeAg+q
         keApu+PvPYHRVoJzrxrSiPpqqsd4OqGWSEzKnfgDe5YNZ8Pj8E9bzApwFYD68xEhn6es
         JqmmfULTyMIRrdFIrU5Gde6yiyuXamhx71wkhIcH57dg5xHOFM/r/yGk48aO1qwuzuOM
         oPixXwWjYadQDfOhc1NQooVRbRjrN1KN5853jadffNbjUXBn6Yzw+9EdKp6BeG2x0t8X
         mV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707484018; x=1708088818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Cdz5dVZvDPVC+BewWJMsgYajolCToKYQ11a6wmFWQw=;
        b=YxVbC/lRszWDcmNrAQUNI2Ezg80BDLBKRH6+Co4LGONEraX4ndc6QYPttfNd3KQwtG
         OlHwBO+09tU6J8Afg4paxbKhFtj83u8M55ZEVHOBULWZGgBjukf2bUzKjtPOX+ZUFPwI
         SanI+xnNpYwX5SsGUoXjE14EobSrGSoflSFEQXdTnYx3cU1l1Nol8HxtJGXpMXK1D+3w
         2PND+ktsoTNdriSMJTdSHJ3e4JVmPaJkj8vcUnx0X4slHDIlu1YRB7di60h+fShV6jv0
         0k1PcvDHNSPKDUGTPrNC9wOjx8KDFVg9fsb3X4UvcMTX5kHVxSQRlHGrcqKoE+DHiFdn
         hkgQ==
X-Gm-Message-State: AOJu0YzjQAoSTpTnD38SnjQGyy8s44Lt5A3ImAl6Adjm6S8JqVaBDvO5
	uQRbanPGvbBK61Jy9DD4b4grfmgw4VI7Jug6S0vXHdPuE+dzun9jkeIJJmzrookJTQ7Rjjx+5Aj
	H+d5AxNcDCXuhvRFQpSjKaTuw3KjCWqmgZ9oS
X-Google-Smtp-Source: AGHT+IEQu9dTK0CI14m6+DU5OUbcWbY4tpyQL+7mbuO6ImeovHURd2mrTNbrTKdI9lXOvlKtapUMxXVQ21CWT1is9z0=
X-Received: by 2002:a0c:cc06:0:b0:68c:ab0e:718f with SMTP id
 r6-20020a0ccc06000000b0068cab0e718fmr1475668qvk.48.1707484018052; Fri, 09 Feb
 2024 05:06:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205-b4-rbtree-v1-0-995e3eee38c0@google.com> <20240205-b4-rbtree-v1-5-995e3eee38c0@google.com>
In-Reply-To: <20240205-b4-rbtree-v1-5-995e3eee38c0@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 9 Feb 2024 14:06:47 +0100
Message-ID: <CAH5fLgiRTYmVaGRVU97C+ZHqBxRxp7kmkdRyHT97w4HtWgiZ=g@mail.gmail.com>
Subject: Re: [PATCH 5/6] rust: rbtree: add `RBTreeCursor`
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
> Add a cursor interface to `RBTree`, supporting the following use cases:
> - Inspect the current node pointed to by the cursor, inspect/move to
>   it's neighbors in sort order (bidirectionally).
> - Mutate the tree itself by removing the current node pointed to by the
>   cursor, or one of its neighbors.
>
> Add functions to obtain a cursor to the tree by key:
> - The node with the smallest key
> - The node with the largest key
> - The node matching the given key, or the one with the next larger key
>
> The cursor abstraction is needed by the binder driver to efficiently
> search for nodes and (conditionally) modify them, as well as their
> neighbors [1].
>
> Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-6-08=
ba9197f637@google.com/ [1]
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Matt Gilbride <mattgilbride@google.com>

I have looked at these bindings many times over the past year. They
look good to me.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

These abstractions have been very heavily exercised by the Rust Binder
driver.

Tested-by: Alice Ryhl <aliceryhl@google.com>

