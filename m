Return-Path: <linux-kernel+bounces-82870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBF6868AD7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883571F21C58
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350D3130AD3;
	Tue, 27 Feb 2024 08:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="p3MkRpx5"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD687B3D3
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709022988; cv=none; b=HWPYb76hs92WcATLRgnfkekg82sBYWTS2WRdRntxlBzHKxDWbvU2GXLzK6SeDnZQrpH2jchRq79iiQexUu1nmYmfoJO0ZI4tEySKsFhtmNj26rsIZ4z88tZ4tYt0CNZ1UlHh9QD/rWx4afiIViuopuAkFQimCGXhh9GaMYIZ52g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709022988; c=relaxed/simple;
	bh=tBm5IIGFhkgiqabszftedxFLBNT4N4zs7aN7ZnS5cF0=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=pfiBgV69CzBUO2NAfy6m9NPhLt3CzynwyQNi6p6CUXPm1wYHqzyA8rGC5ueyclPnrd6XTAtEUAKzG0jA9nce18kpWjLxHlYUZdf745JW4EPYLoXunVXHyfsJW5W5blgos0iTvPskIxeu0ZCt89nTeNH+arSPbpqx5KBoAsVg5ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=p3MkRpx5; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3e8c1e4aa7so388869466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1709022984; x=1709627784; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=tBm5IIGFhkgiqabszftedxFLBNT4N4zs7aN7ZnS5cF0=;
        b=p3MkRpx5VREXJOooask2Br8TOUkyDZYl/l0UMQyjnwqe4Ky7hzSk7soSnuZaNmnGFP
         TOGRx1rW8rZwuXgnvAUF16AifvepYlW5SiFjiz9gUWXZkbw4O+5OrRrs8yRwYLdGD1Ax
         oDseHewatyh8+ZG0iwtA6vdcC28bCXguxcsTHWXMv1+WgQP0NFgd6UMInRNBLODDNCJi
         yazVQHrbPIWFm6YUyn0ypsmjwZrLGUUnNquVAYHg6vVABS3ddMFP/T1W1GTe/NIjyFA/
         juU7cnmPfdTDXEH700c+XXWIOefma1P0YwG3sFiKCUDqEllPSXwG5Ed0ZiX7L96WPvUT
         6G9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709022984; x=1709627784;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBm5IIGFhkgiqabszftedxFLBNT4N4zs7aN7ZnS5cF0=;
        b=RguamruRBwifhaGp5fHxxWT3tMOfg6ZYZEF87ZhI/PWv8vqVC4LpaQhsK6TYlNcyu8
         ZWeHjOZz9n4J5WgpE9Vk9/caXd/Vh0rTAHNQ6/eVYKCz6Gud+UsSd8ZU3Ou9gMgBKwcO
         J6QGSXhB3RM8cshyu+ZD52SrUCtgOKDNJL78zEyHKX3MusXpsBxxpPjbNZJ6ZgiUPKVM
         Y5B4pCLgccJFdYXDsW9t/pznqCF2kHtleraioFjU4mOgKT+DbEhX01yZsfWwx92IuRHK
         SwYAyhZFIgfQal6hTSIO6o9glNEme7uPM0D6di5j6rwujD6cGCuOP9/weA8Xf3KgobQl
         Ifbg==
X-Forwarded-Encrypted: i=1; AJvYcCXqpKMiQLJVWYnKuqk8f+dikrr1mEgbIniZy47owlCqpxJAVyUGBV2vsC9vr9JcE5L5NWap8hrNlhpFYaCOCakoTZs76WELryaRuTyP
X-Gm-Message-State: AOJu0YyQwla0atOWOL4RbQFICALh63FsX7YJd5Z4sYdR/60rtkxAiC4y
	UXSybf/aB52kjEbVcQAclE9Qt+Csu+NxbnevF5wrWVTIffynviYSXh931d7e380=
X-Google-Smtp-Source: AGHT+IEmSlqSqeopobEyVgC92+uCi8Y34RHVrtsYAkNKK7bVxD/WCyfc9qMKmBQUExQLWATnFTHthg==
X-Received: by 2002:a17:906:c7d4:b0:a43:20c0:6f7a with SMTP id dc20-20020a170906c7d400b00a4320c06f7amr4112372ejb.48.1709022984519;
        Tue, 27 Feb 2024 00:36:24 -0800 (PST)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id hu11-20020a170907a08b00b00a3fcbd4eb2esm532864ejc.1.2024.02.27.00.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 00:36:24 -0800 (PST)
References: <20240208-alice-mm-v2-0-d821250204a6@google.com>
 <20240208-alice-mm-v2-4-d821250204a6@google.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Andreas Hindborg <nmi@metaspace.dk>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Kees
 Cook <keescook@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew
 Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=
 <arve@android.com>, Todd Kjos
 <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes
 <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren
 Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 4/4] rust: add abstraction for `struct page`
Date: Tue, 27 Feb 2024 09:32:27 +0100
In-reply-to: <20240208-alice-mm-v2-4-d821250204a6@google.com>
Message-ID: <87h6hu9udb.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi Alice,

Alice Ryhl <aliceryhl@google.com> writes:

> Adds a new struct called `Page` that wraps a pointer to `struct page`.
> This struct is assumed to hold ownership over the page, so that Rust
> code can allocate and manage pages directly.

<cut>

> +/// A bitwise shift for the page size.
> +pub const PAGE_SHIFT: usize = bindings::PAGE_SHIFT as usize;
> +/// The number of bytes in a page.
> +pub const PAGE_SIZE: usize = 1 << PAGE_SHIFT;

For consistency, could we get page size from bindings as well? The folio
patches already do this [1].

BR Andreas


[1] https://lore.kernel.org/rust-for-linux/20231018122518.128049-10-wedsonaf@gmail.com/

