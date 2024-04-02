Return-Path: <linux-kernel+bounces-127659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3CF894F05
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BBF71C22547
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C6F59B4D;
	Tue,  2 Apr 2024 09:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EL8c/569"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BB558AB0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712051332; cv=none; b=B+DS9bidfQki3Qz6y7fneaytcPbi3susTbfCA2wQZn/YzKwFFP9Rq7Cs7+WV8EVDq2Jy3OJd6dgSCCYfBMPr35aC14QIhwETInhC2GzfKOmEcAcbh0sh2tLfsEooXiAOdZLPAcWOLPZZY3SKccwm5GRR1Fc3TU/b22xGeGrjCpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712051332; c=relaxed/simple;
	bh=/6opIaW565ST1SlftEf3TIDZp0a8kcSv8D9Tuf8A6MA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bekg89+I00ishBXHLqOEzxXdvTgyRngQDGfqdEYqUie1aQBqq5YZx6gdXZLxsztepwOQxfRjBjGnnNB1gjZZpUQs9ZJ0K0xHQ7G0t72mMZ0bAhkgUQJJEaz+H25BK+MxKTwJlIYOCAnHCbN+li1ZXv6syjY06fkZKYxXIQbn+8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EL8c/569; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7e33b9db07eso1367143241.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 02:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712051329; x=1712656129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4P9MrH43tW9abxwsM09/mfJ8gZJX942gU6DHzH5JkI=;
        b=EL8c/569z9eGhA9F2nUxGHj0W1zpbULWIk1FXWamg8VLMJevbJX7SF2MunvfICT0Y2
         qXc+akhEnvhToARses1yBL3LtT71IhLHcW7MZ6a7qaDdSetRn6fpnDtfNlrTD/5HgGCk
         7YF1l/W24XeWLSxwfxvfKu8y8lgdlREmfsF453+4cY7PjGWwJEk+BoJpn5FXJfETuJv6
         EGvm+Iuj7Ti8WSL5kaR/EpDu0viLFr/OGld+oYvQ5ODmbhJt6NeeHb551WV377aHixoC
         p0tDEeEjcvamW10/ElVpGEQYSTwy0q4bACz0jFGxExBnhbtE8RMOZ5KcZ+xrl+jq76V+
         z6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712051329; x=1712656129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4P9MrH43tW9abxwsM09/mfJ8gZJX942gU6DHzH5JkI=;
        b=ChA1kcgQ4wINiU5WnBf9q1ZVpYXRRo06pTJkzlMlYXq950OxVAjZlFQghDmfn7fWHF
         aWS3sc6Sae3L+XjAPOrYPORVwEDLPlPEJQQwlBRgNvep5qBHoBeg62EK1EIE/lrX9GIp
         ZQW9MqR/LvBIMYu1GgLl481oM8lJcpOXSi40c1MD9tq87qpFwTkcXN1/mV/JzeZ+A22r
         OSkrVSGzpeyuED2nggDcRVoM4mmTc97XxeBjqSs67Lw0aRa7tysjD3Ln5WLnJPowcCuD
         s8VPQ2ORszlRo+aX5O2pEMv4FkwSYcZIDBa4lxGLZPbX8PLavhN29St7sBQ7Hy5+UsOu
         lLcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEkZ9BrT4BWvV8Oevly0UqfoU/lu/MMRE1ke9QpQ3T3kt2/X+r41IEetyVifPpFPjjJhnynRW/bEAwCjcOynTWgWmKMWadtq1sEs+E
X-Gm-Message-State: AOJu0YxNtDEl3U5bkHOtWcZHYnhvTWTXfVMu1wrkBjEWMhgRTTUyx9Jn
	4YZAEgy2f0Q1WUGKIqfNq4t7wOhBlWOXPwRGX78/67dLwVhlgb1dwzGwYXI1/HSKuv+DzFYXJyw
	OUmO83i1kyohVkG6pLhO5aDYHgcC5wPP9tEa1
X-Google-Smtp-Source: AGHT+IEuI/3Rm82F2eFCVLgg9j5UIQnVXaNnxGLIK9710lNnknOhJaLAXY9bxHdptvhHHGoFFNiYjlFvjJefD/9iG+Y=
X-Received: by 2002:a05:6102:2172:b0:478:618e:f0c8 with SMTP id
 i18-20020a056102217200b00478618ef0c8mr6431208vsg.11.1712051329606; Tue, 02
 Apr 2024 02:48:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401212303.537355-1-ojeda@kernel.org> <20240401212303.537355-3-ojeda@kernel.org>
In-Reply-To: <20240401212303.537355-3-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 2 Apr 2024 11:48:39 +0200
Message-ID: <CAH5fLgjS5NeXHTqqgcb5nhC9XZ1qSzh5tWD+fvNUf93_PNGWdg@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: kernel: remove redundant imports
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 11:23=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Rust's `unused_imports` lint covers both unused and redundant imports.
> In the upcoming 1.78.0, the lint detects more cases of redundant imports
> [1], e.g.:
>
>     error: the item `bindings` is imported redundantly
>       --> rust/kernel/print.rs:38:9
>        |
>     38 |     use crate::bindings;
>        |         ^^^^^^^^^^^^^^^ the item `bindings` is already defined b=
y prelude
>
> Most cases are `use crate::bindings`, plus a few other items like `Box`.
> Thus clean them up.
>
> Note that, in the `bindings` case, the message "defined by prelude"
> above means the extern prelude, i.e. the `--extern` flags we pass.
>
> Link: https://github.com/rust-lang/rust/pull/117772 [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

