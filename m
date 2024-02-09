Return-Path: <linux-kernel+bounces-59301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B14584F4D2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D8211C2154B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDC72E85D;
	Fri,  9 Feb 2024 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="00YtOFe9"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FAF2E652
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 11:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707479365; cv=none; b=fsSydS7oZ/09yCwvXq7Tsu9bbrGIhh/eBz4g4mDfDKK/fO/i9ZHAFnK1n3B89LmrU9bzs9zhqqqKBjfW42IIBu1rmzvicaxZgrgHVQX4vWdIWjDafW7n5qGRwvH3uWGVsxwZPmU0VZ2JP5kAVbf91z9drwY8+4hJzefMIybmuCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707479365; c=relaxed/simple;
	bh=yhanlhyHf9vUwAPCSVHqqZzMUqMS696JtJ0CS6AX8Q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=laXWQYkVaTk+95yD+D5SuCPV3D9XdHPmnpslDbAfq1Bzr1t1rlPNdiTkzo9uyQmHo6Ut9w80/FjLl0rLUIPY2YixjZQZMoT7aG15lhGQecNKs2LAwMmCVFAqxaeOcK516KlfyylRQWFWg6ttddysm1SHxukzQ4KFdaVGUbtKI5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=00YtOFe9; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4c01076b9faso377391e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 03:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707479359; x=1708084159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l++3fpOv/6kAkEAKZFY83iwVJR4LI0xsh9dQ+P6yYAk=;
        b=00YtOFe9KCUPwTrp7V68TNfnALSahkWowasBb6FIEJKxH5jML9I1ydKl6G8Qzhfmnz
         2hKmrwW1shDPz6lzFxNTcrh9/MxB/wKKWhU6pd6Pyi3+YUXoXvSllWY6n0Ed2z5PhBry
         fIi0DQ7LgFWeHrI+HB1iDwITmT9QpflKmLnTQqK3EX2DKxA4AhrF+bLFdSVUQwouVdEI
         C8cF95SWS5ws6F7z3H1ItI5VPwZdcaVnyoi/g8mk6sxnuMX6mdq01g7emyp5/UUgieH6
         678sTlROwjfcV62eqZCbsURIPTlCfn7R04R5kqMo4Nyk/1tkuQyM2KWYbzokW7S8CbtQ
         OQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707479359; x=1708084159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l++3fpOv/6kAkEAKZFY83iwVJR4LI0xsh9dQ+P6yYAk=;
        b=WhBRSMvXGPmKUwGUjnnG4qL0sn4/OEmpphb7cF0J/xtMeFuINe8++p0UdS13RgjWRp
         nnWInARaarg+WmP6T5ulI9bani1SZzvsegw18SyoGNS0x/Q4VE/+9wmDYqRCEl/Eb4YA
         i1Eg9kfekaA0MRrLCMlANLX6NqATqfl++n3HnRpsYRAjs6+ZprLVqDRoRVS29UVhm4n5
         hCF4gejf5ZWuLbzJltKYqRv+XSpsoO1YinAEwq8l7fyqblzJP2vUXUSV6/yUt1k7pYWQ
         F9f2PQvRaAk0KwcKC8Ms0PBaEV+0PBBUNN7TL4PdOqvqKOsjed1aaTPtq8D6iWGkZY20
         DYxA==
X-Forwarded-Encrypted: i=1; AJvYcCWxGsJiteU8S8p+adp7rHucEZYbu922N7+dqkToQCq+4we7MGYbbQ81zh4qkyElYvxbVX6cjz402moxT22Rua84t8JnYNTQQKP1L6Mk
X-Gm-Message-State: AOJu0Yz0L3H86b4VBjYZX7QEIS6nm93wLoIDpj4ES1x4cYCxe8niclgz
	lANmMC60CMKFq7SBlf0A/iQ9aS9gN6mzp6FdanE9EUlekwvtLxTn4n5s+ybVyY3TvEIIJekMkEX
	E7izwv/OcEtvTJmR8eZylSyKoAuDWSpTjIG+o
X-Google-Smtp-Source: AGHT+IGeozrhqlsnoi4sKjmwc1iTJHC3DWdheQh5u+tCcxJb1BYvfzzbx2OvfKUcWmt/yMinTt/VeLkRIu4BWCWdkl4=
X-Received: by 2002:a1f:ec01:0:b0:4c0:2ada:2f19 with SMTP id
 k1-20020a1fec01000000b004c02ada2f19mr1210515vkh.15.1707479358796; Fri, 09 Feb
 2024 03:49:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-alice-file-v5-0-a37886783025@google.com> <20240209-alice-file-v5-1-a37886783025@google.com>
In-Reply-To: <20240209-alice-file-v5-1-a37886783025@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 9 Feb 2024 12:49:07 +0100
Message-ID: <CAH5fLgiFzPcOH95tw9MwJmgfgBzE+rWxhk0050OTYmqgprPn5A@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] rust: types: add `NotThreadSafe`
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Trevor Gross <tmgross@umich.edu>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 12:18=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
> +    types::{NotThreadSafe, ScopeGuard, Opaque},

Oops. This one doesn't pass rustfmt. Embarrassing.

I was hoping that this would be the last version. Maybe Miguel can fix
the ordering here when he takes it? (Assuming I don't need to send a
v6.)

It's supposed to be:
types::{NotThreadSafe, Opaque, ScopeGuard},

There shouldn't be any other issues in this patchset.

Alice

