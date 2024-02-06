Return-Path: <linux-kernel+bounces-54195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C878884AC1E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1701F2490A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9584356B6E;
	Tue,  6 Feb 2024 02:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="DEYBXZwN"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF4F56B68
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 02:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707185912; cv=none; b=k8Sx5YM4xmP8pxyheu3ND7fuL8opumm7sPqmOY+EMSyHPfiiomKn0+WQE5FigBUd/P35RGz/+xfG/clAYDtJWR6KCi4cTgfotPygfcRTyQabW3yNfep1W/32yFc1HpPwpkF3gx0KVmlp2t3wJ1zNcYh/bRZmtBU0GrRfPQN01UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707185912; c=relaxed/simple;
	bh=gZkw2d6GEVsCKvdSDVLYHTC96kmhi9x5abFW4GTX54w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p8JODsBpQdVikeMUfh1XlsP6mZXw46Wnxk62S2g/XVbHwgu4IFZdF2cezA2+ecWBCOmGl/rJYIH2zS9JU/z1WGS8lkyUrvPTZF4+qKLVA9MpvPD7C5STZcqiynE4hXSuKTmElCnOL40Gal1z7imwTQD+eE+JsonR1j9UOFLSHUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=DEYBXZwN; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60406da718aso51192767b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 18:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1707185910; x=1707790710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZkw2d6GEVsCKvdSDVLYHTC96kmhi9x5abFW4GTX54w=;
        b=DEYBXZwNmfJ7lMCZ7Uu1FQPNRue751FezuY1O97slzyj3kLCRwSOS7FAWwx4cluFIC
         keL25Fchygu0p6oiT4YFQ6eAUsHJ4Cv6LHA+ADhbfaSf6Gl3YfIDOgv91bYTLE18lDXj
         AnFHBi/EtzitM/BRfXHQH30PYlBiv89O0Lgh0nGeQKQzVAjIfdS8rQGZrKUYzYIxMBU/
         W3xKCn1cvX/hbQ91ilPRgaeta+HCIrzfzQQWrS0N2gRGD6qFy03R3N1ZfiJ/0fsVmDRW
         7xrIARYrREbZYd3arC0x99GtxCFTJ7EeRXzWE0QKIS6obVwQ0sGlPJnMG/CZRnxYrjch
         hcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707185910; x=1707790710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZkw2d6GEVsCKvdSDVLYHTC96kmhi9x5abFW4GTX54w=;
        b=cXlbIAOuMV6xMl3uUWT72EpLq0Ld9jr/yrCG3w08optuua+OzFrTq6T/jx7bPDXZOK
         j9sXFZO+6SG1ysx+vnOV/gkpYVkgoGGQ82eBRdQW3oZYmmFJWZECfd/IvdkMHtu3Chwa
         CnKeCpQOqDRCq9vPaASH0VsodzXBIR+Magr8WqmiPGAMaLTRMEYNcWjm9OCGMH6f8SWu
         6Ersx1oOjCZTmPLLwQcgP/XaUZJjOK5VssTD7htVe3mPrZ4vDg/WUJSi4QnUBTI7NGXu
         dKYKTt+dfmxj7H7sB3zObBCjSCGwXgWro5kgUOEjo9iuZYjOYyK/1x6gGQy7PC9Sd13t
         FLTg==
X-Gm-Message-State: AOJu0YzXTotVkAmwUTLl87ysdC0UOxMfL3AL5uhGO8mNOroWGRDy88Qf
	tcT7Hw2JyGHXqa1tKCPY4yf0SW/X8aCIxcrcBiR4yX9X9A4UskcZr+nKYuURJHaqwE2HAYqZ44g
	g+jOyX8Tbu97gQA7gmFi2ET4wPFYglQ2TnwRzMg==
X-Google-Smtp-Source: AGHT+IFZqDHvvmCo/0VYZMxcZsnzywrmE/o8Pirfqy6QTFEOvP66oRP6OMJ9bMGs8gYJXJdFmWKwyb76YELKJy3YiO0=
X-Received: by 2002:a81:aa46:0:b0:5f4:a5ab:4105 with SMTP id
 z6-20020a81aa46000000b005f4a5ab4105mr373824ywk.8.1707185909958; Mon, 05 Feb
 2024 18:18:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202-alice-file-v4-0-fc9c2080663b@google.com> <20240202-alice-file-v4-2-fc9c2080663b@google.com>
In-Reply-To: <20240202-alice-file-v4-2-fc9c2080663b@google.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Mon, 5 Feb 2024 21:18:18 -0500
Message-ID: <CALNs47vEo1ghfrCZh0=XB2u2vkRAoTAqp=FLpJLb3BEw63FEMw@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] rust: task: add `Task::current_raw`
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 5:56=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> Introduces a safe function for getting a raw pointer to the current
> task.
>
> When writing bindings that need to access the current task, it is often
> more convenient to call a method that directly returns a raw pointer
> than to use the existing `Task::current` method. However, the only way
> to do that is `bindings::get_current()` which is unsafe since it calls
> into C. By introducing `Task::current_raw()`, it becomes possible to
> obtain a pointer to the current task without using unsafe.
>
> Link: https://lore.kernel.org/all/CAH5fLgjT48X-zYtidv31mox3C4_Ogoo_2cBOCm=
X0Ang3tAgGHA@mail.gmail.com/
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

Reviewed-by: Trevor Gross <tmgross@umich.edu>

