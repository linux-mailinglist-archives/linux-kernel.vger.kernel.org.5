Return-Path: <linux-kernel+bounces-73063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3738E85BCFD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22BF1F238DE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB876A03E;
	Tue, 20 Feb 2024 13:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1nBzoJkl"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300366A02C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 13:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708435056; cv=none; b=TlZ5LvwPaZpPadScvnnOrPpwRZQOcTzUNXrIti3iQT/PQS+LQKyofDrduvxVhJQiW9Y47FZ7KBiDY8mQ1WPoiuLTl+i2ws1IoVmxx+B24cWbgfSgfQfGBv338Z6RZMhGjCGZaOzoVlLOu5y8xwNLCdO/H2etY4AjjO/QN+gMVjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708435056; c=relaxed/simple;
	bh=qL9esCSTsbD1GdZPqIOF52zqtukaAoOtfw37L/iCfIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmqueYlR9NzH5w1lmFw72q8BJxIUgy5TslhytS4YT7wh189+EBiPT/M0OAr9BXGVvXbMOJsazJUqbx/GANwe7LRYyr2aIDb6RM21HlKEJvLAS90P2vLIZXqhqDD8P+JT+9Dawja2/RSyxL3XN5khBJEhhUsZOA2ELjFJIdCjxW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1nBzoJkl; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-21edca2a89dso1079168fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 05:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708435054; x=1709039854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qL9esCSTsbD1GdZPqIOF52zqtukaAoOtfw37L/iCfIE=;
        b=1nBzoJklVG6MRZ57Q47qkUkFL5A4A6xZjHblZrbhHHANcgwrWVUvkB3ahdzzJUFTTj
         +wAZXnsFU50xZu+MfJAnZzgL6dNZCiXbjXJY3f6vyc6Yyxd2dGKwgXIm5UnhzT6KnJlV
         5V/Wlkz5E0r+6OQbUGqnuSOZEk2Q5xchVNsYQhBxEbIbZD9iQ1NHXQGr38yiCeWhEM1Y
         36KQffCLZgJK7W6WwsReGF/CNDx9tj2PnW7aSziuCDpplv6IykxcSR6gf7OsB0CW1C64
         rmcFxSBAXy9tj2VxMPRnxyoG8rS3ztZ5LzxdJnmo30jgXnwq1ZuesWZ4JVC/vFZjH6Lv
         CuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708435054; x=1709039854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qL9esCSTsbD1GdZPqIOF52zqtukaAoOtfw37L/iCfIE=;
        b=CKqpVxUaoYJo3gznRC+MsXsbrHl+OQyiC2Sw26G8zrg50GIMhH1giFrSCi9j8du6MO
         U+DuVFNzepNY1oIIIw2yAj/CXRWec1/fossHBl4dKt4ipZecKHDk5fv4WZxFHeUIiiet
         6PrnBryoMl8JwZ8eWmNvcqCE2VN+md4BJSZkYuiUbGFVYV/Ur2Lix+3RoQ0071IZY1iR
         s8xfaOwuXIVnDqTWXI7RtoKZemkocM5Y+uQWsBLZiJJzO5I9g5pzE6BQrsBXaQeSOnA7
         N0j3jWsLftaPB/qb62WZScnUm3L83+afYokHj0P4T6/RBzJr4zPUkTc6p2Rg9l6YvalW
         XdCA==
X-Forwarded-Encrypted: i=1; AJvYcCUm1wA1XAOpvbgc/N9IE/opW72JNR9sziDbZQia9klHVEvRvT87G4ZhY20QCjMyx6/xmrY77IGa0aSfdYZ+nrStmnv/S8Bli5AhFszk
X-Gm-Message-State: AOJu0YznKiirezB7rG3WLBk+TSzuhlATTTjVTrvp9xyKqU83SY7plif0
	LKB1dcjm+2q7Pc1yBqDYWo+/o+Fvve4D2pmJVmrdmAelygoWp4GRw4xOSfAalp8ebZGL1zI7QqQ
	pybNdb89O86IIG9E8fDy9pTVycnMJR9nN+WAQ
X-Google-Smtp-Source: AGHT+IE0KzursJtPq+abIWMqtK5O1+xQJm+xa2/64BP3Y6r6RrQUFND+hye5sxQmu0NqoMrH5fj/TKGMGYpHWYzYVPM=
X-Received: by 2002:a05:6870:4195:b0:21f:662:7f4 with SMTP id
 y21-20020a056870419500b0021f066207f4mr3540551oac.32.1708435053990; Tue, 20
 Feb 2024 05:17:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219163915.2705-1-dakr@redhat.com> <20240220093541.280140-1-aliceryhl@google.com>
 <e543b270-dea7-477a-b83d-62129d4ac708@redhat.com>
In-Reply-To: <e543b270-dea7-477a-b83d-62129d4ac708@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 20 Feb 2024 14:17:22 +0100
Message-ID: <CAH5fLggXiXGA_UWCxqqLhMpXe1kepDv2vMG+1jLGaDSzdRHvSw@mail.gmail.com>
Subject: Re: [PATCH v4] rust: str: add {make,to}_{upper,lower}case() to CString
To: Danilo Krummrich <dakr@redhat.com>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, benno.lossin@proton.me, 
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	linux-kernel@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 1:02=E2=80=AFPM Danilo Krummrich <dakr@redhat.com> =
wrote:
>
> On 2/20/24 10:35, Alice Ryhl wrote:
> >> Add functions to convert a CString to upper- / lowercase, either
> >> in-place or by creating a copy of the original CString.
> >>
> >> Naming followes the one from the Rust stdlib, where functions starting
> >> with 'to' create a copy and functions starting with 'make' perform an
> >> in-place conversion.
> >>
> >> This is required by the Nova project (GSP only Rust successor of
> >> Nouveau) to convert stringified enum values (representing different GP=
U
> >> chipsets) to strings in order to generate the corresponding firmware
> >> paths. See also [1].
> >>
> >> [1] https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General=
/topic/String.20manipulation.20in.20kernel.20Rust
> >>
> >> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> >
> > This looks good to me, so you may add my
> >
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
> Thanks for reviewing this patch.
>
> >
> > However, it looks like this patch has some clippy warnings that need to
> > be fixed before it can be merged.
>
> It seems that those warnings are treated as fatal even, although, given t=
he
> rationale for these warnings, I'm not even sure those should be warnings =
at
> all.

The build currently succeeds with zero warnings. That's a very useful
property, and I would not like to give it up.

You could submit a patch to silence these specific warnings. The
clippy::explicit_auto_deref warning is not one I care for, but I would
object to silencing clippy::needless_return. Using return statements
when you are not doing an early-return really is extremely unidiomatic
Rust.

Ultimately, I think there is a lot of value of just applying the code
formatters and linters and following them to zero warnings. It ensures
that the Rust code is relatively idiomatic, helps avoid long
unproductive discussions, and makes it easy for me to fix formatting
issues in my own patches (just run clippy and rustfmt on everything,
and it lists only things that are my own fault).

Alice

