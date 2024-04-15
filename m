Return-Path: <linux-kernel+bounces-144730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6639A8A49D4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE08285C7A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9153D374C4;
	Mon, 15 Apr 2024 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="b+yWIR7q"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01B72E636
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168665; cv=none; b=i7x6+s2JR2JqEhrKQ5tllC6heqbalUIlKYhWPH1oO4CVDphLslBvVnkyA/Cqo8f3++/uR+/Qhs3RZV9CXZ/F8+J09V588dDdM47HlZ7EZ1FGvE8TxN6HOz7XjccAstNtXmmpyRqEnzgw8jq351uHWi97RD4OxPC+zHeg7VUbLxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168665; c=relaxed/simple;
	bh=zv5YTVuVpK0uEb+PQ488dEDxv7U+R1SjCDPDwfMdrbU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m30QnEmEVp4wBspukxaxmtQdhOR/QNwCi7chIK0Ixuvx6aaxBeCqMMPZjKHJ+S1xZQ4Nl1J9PKg/GBIaJAH00F9FQ6Ci/NkDXhplv8xMqBB+5n2qkscvKLR4/6JejnffDmkOC+nKAyx9330ZRDES/9MaIaAgtaQkaV9y1Ku5D/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=b+yWIR7q; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a523524e5baso328932266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 01:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1713168662; x=1713773462; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zv5YTVuVpK0uEb+PQ488dEDxv7U+R1SjCDPDwfMdrbU=;
        b=b+yWIR7qrhztk9PDFeg4HD0WDU8cpOkhXfWO2X+7AW+IgjUBmLXYTm/RwDZIo6K781
         gkkpr+YclzYNsspFgE+ySapVkstXCcdvr3FScTjdapvNroko9huhSy8qeekJ0GtCa0b/
         F5pRiXN9jwNeQZWcK4LrMegomBVa1VGXfSPTawx6P/8nOS5fTTyp+FFSjNx7bL4TRAG2
         WJzrVzBUnc8Ogy2zJgyI+Hsj/BnfBJ7Vd4tYebmjSkSn28yP6pPZMzwup28JgqP96sRZ
         4nipp1bGEIL+VjU4PTMu0q/4cZq7g3xC5kTDD5GIwCQ6KGkbmkdM6HXOUgURHSbfLCkB
         BCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713168662; x=1713773462;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zv5YTVuVpK0uEb+PQ488dEDxv7U+R1SjCDPDwfMdrbU=;
        b=qCTseQwM8Wu+B6xqseBOGMMNZrDcE3mDa6SXo3K8n+wNKg88l6V2dWenYx92+2dhKz
         TDXwFHKdtaPZjyeW7lRNzt4sr0QShjkCYpbmXpjP9EWXaLaij1+PmKwMvPqLOO6aIsPh
         RsQd+WBuMLHt2v+y40NCLlJIWsPs7PD2WifdY2F9PiU+adzzk2yjSlDcGzO3luwCeNTa
         WbVG40tdPtNhJ/4CpzkQeiwwjPTetlZk76do/F+8zZ2rzi+q8SIiqHo+5RGTDKnR3V2K
         0fKkgiSFtfjgelkJtcdTKUUtE7QY7VigvRpAF8ht3z7IK1X6TrjB9Li6eie5uTWrSVIE
         0EjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhLycODZsq6PM+oyzsg7KbDFSNm8t5/U91aeiu4DCj0Y0JmbnsF4wcujcOWyL/z5/a8UEQfsFKLcIO/oI3HumELQ7ZPDXuS/r7zMB7
X-Gm-Message-State: AOJu0YzXDOv5JP59H1IVkNTpHWnoeqk24fJw8DKr8mItqh7BrhAoNe8v
	e/CT1nRAqOBNnpITA6NmZtEVgVUvnHxP4z5m0xa6NWZakCMZyBON4PeUYFPGMsw=
X-Google-Smtp-Source: AGHT+IEmro/z4RIN6GSVHudfugd2GkdsT2hNxezDpNHADO1XqkCrWaYgEi/s3syKd6RfY4DayBQjlA==
X-Received: by 2002:a17:906:590b:b0:a52:42ee:4e10 with SMTP id h11-20020a170906590b00b00a5242ee4e10mr5567894ejq.8.1713168661716;
        Mon, 15 Apr 2024 01:11:01 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id 15-20020a170906300f00b00a521e5856f6sm5122991ejz.51.2024.04.15.01.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 01:11:01 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Matthew Wilcox <willy@infradead.org>,
  Al Viro <viro@zeniv.linux.org.uk>,  Andrew Morton
 <akpm@linux-foundation.org>,  Kees Cook <keescook@chromium.org>,  Alex
 Gaynor <alex.gaynor@gmail.com>,  Wedson Almeida Filho
 <wedsonaf@gmail.com>,  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>,  Benno
 Lossin <benno.lossin@proton.me>,  Andreas Hindborg
 <a.hindborg@samsung.com>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?=
 <arve@android.com>,  Todd
 Kjos <tkjos@android.com>,  Martijn Coenen <maco@android.com>,  Joel
 Fernandes <joel@joelfernandes.org>,  Carlos Llamas <cmllamas@google.com>,
  Suren Baghdasaryan <surenb@google.com>,  Arnd Bergmann <arnd@arndb.de>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  rust-for-linux@vger.kernel.org,  Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v5 4/4] rust: add abstraction for `struct page`
In-Reply-To: <20240415-alice-mm-v5-4-6f55e4d8ef51@google.com> (Alice Ryhl's
	message of "Mon, 15 Apr 2024 07:13:56 +0000")
References: <20240415-alice-mm-v5-0-6f55e4d8ef51@google.com>
	<20240415-alice-mm-v5-4-6f55e4d8ef51@google.com>
User-Agent: mu4e 1.12.2; emacs 29.3
Date: Mon, 15 Apr 2024 10:10:48 +0200
Message-ID: <87il0jm4fr.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alice Ryhl <aliceryhl@google.com> writes:

> Adds a new struct called `Page` that wraps a pointer to `struct page`.
> This struct is assumed to hold ownership over the page, so that Rust
> code can allocate and manage pages directly.
>
> The page type has various methods for reading and writing into the page.
> These methods will temporarily map the page to allow the operation. All
> of these methods use a helper that takes an offset and length, performs
> bounds checks, and returns a pointer to the given offset in the page.
>
> This patch only adds support for pages of order zero, as that is all
> Rust Binder needs. However, it is written to make it easy to add support
> for higher-order pages in the future. To do that, you would add a const
> generic parameter to `Page` that specifies the order. Most of the
> methods do not need to be adjusted, as the logic for dealing with
> mapping multiple pages at once can be isolated to just the
> `with_pointer_into_page` method.
>
> Rust Binder needs to manage pages directly as that is how transactions
> are delivered: Each process has an mmap'd region for incoming
> transactions. When an incoming transaction arrives, the Binder driver
> will choose a region in the mmap, allocate and map the relevant pages
> manually, and copy the incoming transaction directly into the page. This
> architecture allows the driver to copy transactions directly from the
> address space of one process to another, without an intermediate copy
> to a kernel buffer.
>
> This code is based on Wedson's page abstractions from the old rust
> branch, but it has been modified by Alice by removing the incomplete
> support for higher-order pages, by introducing the `with_*` helpers
> to consolidate the bounds checking logic into a single place, and by
> introducing gfp flags.
>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>


