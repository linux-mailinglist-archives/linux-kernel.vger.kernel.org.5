Return-Path: <linux-kernel+bounces-59336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C6A84F594
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626501F26F54
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D1137700;
	Fri,  9 Feb 2024 13:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yifm7DTn"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F157033CC2
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707483872; cv=none; b=g52HH/8Gxr6GrFSQXSqGu3Uft31qcsHeqGCkdXydVATgm63V8M/+oESYxn5MHQKIMpBez/Fyz5tsan/VhzTYMAz+8621Esg0PbH3dCsMXPwy0fk5BacdCjctvWBeQnlEioPlPYHI6+yPtPJM00FE9zYjns4QJUdhSWhByaRZ1YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707483872; c=relaxed/simple;
	bh=0Rdy9TOamec05pHu6p+gQ/++fRDx1JB9FW/7My45fbg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ART7hUHcwA5QGC+ImpXHxz3K70Y+gI3kQHHAKFpsN4h4tpKt0zFjqz8lvGqJEShdx1dQyBwSI79iVecOk7fsgYAN0giMJHJ6G44Sh0C7aHVpAwG57+10VAgBLdL5uw4NvW0H8XAKOQDjcb1mlH69O0mxKVFgViEj8aiXw+6Lf3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yifm7DTn; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f0fd486b9aso16031817b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 05:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707483870; x=1708088670; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=insYPbe2LWIxwJ7By9R9UOr7vJ7uLjEBVu84zB6ipQ8=;
        b=Yifm7DTnagXdwgLqfrsGAj78OVsC7ItsUWKq68n9MjWaX+NG6NNnLBBElL7dkbsnRk
         aisXwN3gOJ589jtkW8bSCqyoQZTNaBYs0G0iUPGT8MMHI6A82i73hVIYbDsHQ6swG2e5
         iBg5R5WAEtlfgJd22Zx471ibNrb2T10B4MqMcz9GGDKMxYZfnsYxxiv1zTb0eckfgKnM
         W/7lj+qfmDuVGMOIOry4bIrY0SusoZ+xMV6I6q9C1sXkQiJ8O1XHXRVBebMrXdY/WlGF
         oqx+vPuu+505bxQMrwJ28FtSulfaZmsIFpvYEz2OuYKx0yWmtU/pmBdb22k4HePybc2t
         XAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707483870; x=1708088670;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=insYPbe2LWIxwJ7By9R9UOr7vJ7uLjEBVu84zB6ipQ8=;
        b=fpabUb5U9Q/Go78jf+O3SIMzFdhb1ZWFJYK6qnutbNEwM5Z+PLXNXz3yN6sMI4bfqA
         oLewX/VFETdFjg7Cgb24HWAhhcF9PD81xi2keACKXAx/5yjQwsj31TjP9UfVdW5fJnkl
         Cg2LsNeNh1Gi9IutcJi6gDQW8ZLu/AvUtBM+lN2Hl6cV5r+xShz6Whvl+Y1q4QK25AAf
         +NPQFxM2n0sePHjm1gjr+SWRFPGzaMgGZkCyLHg5roHyuLbD6ex8e1pw5WXGwtyRO99A
         AjI9SjjvhX/sExMAUVtBOMzgNbrM9rSFDIZEDHJXNqCIHoAqt2tbjDQyvwKXxivOWtXR
         4wjA==
X-Forwarded-Encrypted: i=1; AJvYcCUl69GDcvX5AxYm/ycu2MwjYfBbRgbvRePh87CWauljZ9JeUxYW9KWn5nNI0pUNW3HvAiIWGZjgXEOKZXd2BaIdeffVTIGZP7cL/SdB
X-Gm-Message-State: AOJu0YwxxcU+uWhJ3pyRNUHotMLTyTiZmtlNgjJPLnHuAs3ux8pCGjwx
	PMDGZWucBPL/dcirvGaIz0qrghzuOam3bHkU4r/ff3F9KKssR66QGPXYO8uhYhhOmm5lyUqnzhJ
	SncXMvxkAxp1oDg==
X-Google-Smtp-Source: AGHT+IEppdw1Za5zeZOND5rjDh9jVmoIbkOr1Ng4ciXyJrTBAjx/lSHwBXtrOJheycOWEzUqBlgzI09j1f3i2kw=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a81:8491:0:b0:604:9b73:ee86 with SMTP id
 u139-20020a818491000000b006049b73ee86mr180790ywf.4.1707483870075; Fri, 09 Feb
 2024 05:04:30 -0800 (PST)
Date: Fri,  9 Feb 2024 13:04:26 +0000
In-Reply-To: <20240205-b4-rbtree-v1-2-995e3eee38c0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240205-b4-rbtree-v1-2-995e3eee38c0@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209130426.1791631-1-aliceryhl@google.com>
Subject: Re: [PATCH 2/6] rust: rbtree: add red-black tree implementation
 backed by the C version
From: Alice Ryhl <aliceryhl@google.com>
To: mattgilbride@google.com
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, 
	arve@android.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, brauner@kernel.org, cmllamas@google.com, 
	dave@stgolabs.net, gary@garyguo.net, gregkh@linuxfoundation.org, 
	joel@joelfernandes.org, linux-kernel@vger.kernel.org, maco@android.com, 
	michel@lespinasse.org, ojeda@kernel.org, rob@landley.net, 
	rust-for-linux@vger.kernel.org, surenb@google.com, tkjos@android.com, 
	wedsonaf@gmail.com
Content-Type: text/plain; charset="utf-8"

> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> The rust rbtree exposes a map-like interface over keys and values,
> backed by the kernel red-black tree implementation. Values can be
> inserted, deleted, and retrieved from a `RBTree` by key.
> 
> This base abstraction is used by binder to store key/value
> pairs and perform lookups, for example the patch
> "[PATCH RFC 03/20] rust_binder: add threading support"
> in the binder RFC [1].
> 
> Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-3-08ba9197f637@google.com/ [1]
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Matt Gilbride <mattgilbride@google.com>

I have looked at these bindings many times over the past year. They
look good to me, modulo a few nits included in this email.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

These abstractions have been very heavily exercised by the Rust Binder
driver.

Tested-by: Alice Ryhl <aliceryhl@google.com>

> +//! Red-black trees.
> +//!
> +//! C header: [`include/linux/rbtree.h`](../../../../include/linux/rbtree.h)
> +//!
> +//! Reference: <https://www.kernel.org/doc/html/latest/core-api/rbtree.html>

We changed these links, so it should say this instead:

[`include/linux/rbtree.h`](srctree/include/linux/rbtree.h)

> +    /// Allocates memory for a node to be eventually initialised and inserted into the tree via a
> +    /// call to [`RBTree::insert`].
> +    pub fn try_reserve_node() -> Result<RBTreeNodeReservation<K, V>> {
> +        Ok(RBTreeNodeReservation {
> +            node: Box::try_new(MaybeUninit::uninit())?,
> +        })
> +    }

This can be:

	use crate::prelude::*;
	use core::convert::Infallible;
	
	Ok(RBTreeNodeReservation {
	    node: Box::init::<Infallible>(crate::init::uninit())?,
	})

It might be slightly more verbose, but guarantees that we don't allocate
space for the value on the stack.

Alice

