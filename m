Return-Path: <linux-kernel+bounces-41206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 756D783ED65
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 14:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81F11C21E93
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 13:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7A12576A;
	Sat, 27 Jan 2024 13:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4lLGmLt"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C0F945A;
	Sat, 27 Jan 2024 13:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706363212; cv=none; b=K9U+a+LD3TrAPxeWsrB2+/cIeSd3jZJH2hKsfC37aaTuXUlJyK3UUfZxe/xDgPLfkn1gIdw2+Tq62oCYbIWsY/sigc9tz2uHZVNAo5kFYnZK8R9qwUjFpsPW+NJAZCnv8S8VnUSUfNewqM58osgsMA/Zi0QnKK3kplgIlpmXZpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706363212; c=relaxed/simple;
	bh=j7l3zAsK78DoVXLg6iPo3Iy7at8rxO0NoQr3L4U6WXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QFd8YlBvFrdtbLPrAMmUrc35QngJsQcC4tNVbSpDz4dMEzxxz/i20XZg3fYX0mqGcgqCQKZZaQXWwRULIMJlhaXOf71co2N6Ca5j+AKSgTsJ/EG8cwx8Oz9pc9nL+sbMt65u/6AjQSjH3XruNeNd97sL++oKuJCBLgY2kkkUc+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4lLGmLt; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-603c5d7997aso256467b3.1;
        Sat, 27 Jan 2024 05:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706363210; x=1706968010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7l3zAsK78DoVXLg6iPo3Iy7at8rxO0NoQr3L4U6WXQ=;
        b=G4lLGmLt+8tIUu3seRozH8eeI2hwU9AYmBHqs8YIPNuMx7oF47ee9XmlBPavPkVSMZ
         tO3lR0i2IdMuUtLiMJwXVxOaBTr/9ro6DNB8FBafYpFc0oXyCqMC4GSijbDc20V/grx7
         RZ7Nh+AZIcI9dlwDqqQUd9fIXjrL1fYlPEy1xfLd2QhgyVpO21s8vJjOKtKAmoV1S7rI
         ntD52yxQd42e4eK1fyJQgf60Fw0F8TKBAOdqWbBprjOmeCUKmqTS8eD9VLBjFZSBryFg
         6viE09cNQKeeXjklHAN6+8HSk77YatBOr1M0ORMsi2UpeoO7+Xr1G9nz8HwunYqJLH/b
         1V/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706363210; x=1706968010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7l3zAsK78DoVXLg6iPo3Iy7at8rxO0NoQr3L4U6WXQ=;
        b=TpDBfZpBR4Cv7ohKo6Y8MqmW+iZ8V6A4f7NiVFxjI2BPQMhNJFgnzAixxe9p6sBAvn
         RL6RbVq10lm87h2e0ibzMEUQd2j4tjRy2uk69cfaEElkzusHWYGadqIuRYNNsaaT278q
         Qgz7jqaL4BdNLNCuAuM8A0gFw+4ZfjycMIX7jeMivKhPQEK7WSeAoIdFaD8J6jlmHcD1
         VHuzzNVnLryVptG4AYnPyKENfSO0dLnykXIK1cOZUzR6mP0XDHktPcn7lXaYKE5qp7rO
         VzApM4a3X+qRtyWyH09WPk+v+P3mHuX4qkcuovYwLh2Ufz3ISIZrzCknJPA2SWzz+Ffn
         nJIg==
X-Gm-Message-State: AOJu0YwkIXcbS2PSKuqdxhT73UPFQvAjZSBSrWdR8yQGH0Mu5QvsARnG
	IlyE6ax23M2By3uyV7CYq5sqXOxonFJfJsCUGCKuemVecoRTlMKUD5hQIeaNxFY+AISbsOh/RlO
	Sq8FNJl8mu+AB7SOq04INOZ7wfP8=
X-Google-Smtp-Source: AGHT+IFJhLQKZrKheOpp5g5ZHWB5tU803FXCdkL1IkQzwwg5UM6oxYDf7ckc24PT/Pj4gwSFC+muNtf44ryFkoh0xeA=
X-Received: by 2002:a81:8411:0:b0:602:d19d:7853 with SMTP id
 u17-20020a818411000000b00602d19d7853mr1231429ywf.38.1706363210302; Sat, 27
 Jan 2024 05:46:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72nnph7LS1fLRtHz8NJ91PWXPaUnm0EuoV3wrbvK398AnA@mail.gmail.com>
 <20230608-spiritism-gonad-5f5aff4c3a24@wendy> <20240117-swiftly-parasail-618d62972d6e@spud>
 <CANiq72mVKCOAuK4Qe+8AHmpkFwyJsVfx8AqB7ccGi3DYpSSWcw@mail.gmail.com>
 <20240118-implode-delirium-eefdd86e170e@spud> <CANiq72nx1s_nyvPW86jL7eiOxROr18LfOJqNtw8L42CP+gkhRg@mail.gmail.com>
 <20240125-bucked-payroll-47f82077b262@wendy> <CANiq72k7n0aZrifRRU08N8qLkNe+2EZwijZy5sM7M56n2xYHgQ@mail.gmail.com>
 <20240125-lazy-thrower-744aacc6632a@wendy> <CANiq72kb+_utZrYHtoKZQtQazikmkjpVUHpTBcaANizduMF5QQ@mail.gmail.com>
 <20240126-eccentric-jaywalker-3560e2151a92@spud>
In-Reply-To: <20240126-eccentric-jaywalker-3560e2151a92@spud>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 27 Jan 2024 14:46:38 +0100
Message-ID: <CANiq72nu2NXUWYanHZd5EXgX4P_v673EWn6SCRW60Es9naraQQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] RISC-V: enable rust
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, linux-riscv@lists.infradead.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Matthew Maurer <mmaurer@google.com>, Ramon de C Valle <rcvalle@google.com>, 
	Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 11:01=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> Is that even needed? We already have ARCH_SUPPORTS_CFI_CLANG and AFAIU
> rust supports it if clang does, so a second option is superfluous?

From a quick look, I don't see it enabled in any RISC-V built-in
target in `rustc` yet.

It may also still be the case that KCFI needs some tweaks for, say,
RISC-V, before the flag actually works, i.e. we couldn't just test the
flag in that case -- Ramon: how likely is it that RISC-V would work if
KCFI works for aarch64 and x86_64?

> I'm reading back what I wrote, and I must have been trying to get out
> the door or something because none of it really makes that much sense.
> Of course an unknown option should be detectable at build time and not
> be a silent breakage. Maybe I should have written the patch for this
> before sending the mail rather than writing the mail based on what was
> in my head.

No worries, it happens. I probably added to the confusion when I
replied with the "testing the unstable flag".

Cheers,
Miguel

