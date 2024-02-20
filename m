Return-Path: <linux-kernel+bounces-73390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EA885C1D7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381771C241B1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D30C77630;
	Tue, 20 Feb 2024 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENDhiE27"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D281768FA;
	Tue, 20 Feb 2024 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708448046; cv=none; b=Aayks7Z4qcrCSxWZyVOGfh5IwenrYmd5TIfZG+vXBXYkyZL/ediyf3KRTU/E/WhiZ14CmvLggkVjQyh42t89TdQZi0yy4oyXdHI/345dXEyWaaW/8r8go+Rl+fYyjIMd9dxH5sZuSnVasIsTjXwDdrCGeoiKve75uzxrDUPR3W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708448046; c=relaxed/simple;
	bh=DAfyiOwXCICyTswYOmrcxT3Fh32GfqIV3qr5gjysxz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FjI9ZcrByKU7fyxBhvOxif03uZFmIJyR8Uac5QX5ru5zIylyZx/DmWtlwQtpN8o1x2FhyaNCW4cHQhPd/vewLpKt66gg2lVSHX2YHb9Supp0+rsgPsyGGCgaPvjUY0zb2xeCIAaQMi/ZQVYqBFLK/jlCfM/hoiuQlOJ1aP+N8Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENDhiE27; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6da9c834646so5040613b3a.3;
        Tue, 20 Feb 2024 08:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708448045; x=1709052845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thSXP4QAfzp8Sa+ElHHleWbXN7SpoUL9JZxQQKwtxXA=;
        b=ENDhiE27ppOamfitNJh9CS2+UWy143wM/EC+kRle6Hpx+N6UhiIHdsPQIxhJgOlcZP
         M6D8duEVGsbZWm6NpiykyV5mC83gehAAYSjGMA4ElsNWanQx1Y5S3W16gDhwzYeNaWud
         sVvOSO9SOLXQ8CKHlHk1Ed/9rxI/pKnAW8k0th0Pw4b9pbYQF/V0nBojqTRLOBHZk4o3
         qmxgUSJ500h+Emeee4MwkOMfaLukhg3iRd5LArooruQ89j/CxfiOhwqQi4cF7RIyD9WM
         2L197d0XlGDJIljPIXH4J910DH/34oRIUItNl6XdfLRJqfCqoNEhS5L3Hbin29pxKrgI
         XKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708448045; x=1709052845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thSXP4QAfzp8Sa+ElHHleWbXN7SpoUL9JZxQQKwtxXA=;
        b=QUo/5PI7dvnrHcorHP09MjA3Yx3qRfxaoNM96HZJggPhJ94L677fEd1G0Nw9xYythh
         mYcCmQlwJR2gs70A3RwLwXWoxzGbheulwufIRyxWxOGuCirwRsd+OzJb7SyIVnhi6Xuy
         hn9jKNmJmMLeCpUtSTDQlpb2Vr2zbpYp7zUXpjKi/2YlcnyF/vKahCgbcVXdvTeK1bNN
         ql7VdKzo3CwJHS61m+j7ugrbxiOwr2A6/r+Y9Yx4FeUVdPsQW+pcwbD77Cr1f24zMgS8
         EGzbNQHuu58Ea8QEq2rUPDk63eEEHQjj6pynb48aIaEHHnWozFTzqoEwO3qQ2YQ7EuXf
         1hkw==
X-Forwarded-Encrypted: i=1; AJvYcCU8UcXtQoeiB9BG+YRwlearrxANf9ozzw4u5+iptbCIBwgMeYPPQDQQ4p6JxRpvbS6syGlgSz9XmhkEHqR5N4uU6z731ljUUgG8Rza6NTQwVTqCtxI2E5FSm4KqCafj2HhjuKWN7fCx1W3VLNs=
X-Gm-Message-State: AOJu0YwlAc2kzAvf70r+TltnKwRXxqkQF98uQMXluXIv8tGElEzkApu2
	Km3Xa795N/bkE4uKwQyU7l0APfXisIaveTmdtRbVcw3gUurLFQkmFpTIbK0SB4rpX5+Nvfu2xJl
	8DI5G+Aazpe/AqUfh0X/5VJ8f7Q8TB6+B
X-Google-Smtp-Source: AGHT+IGIB3AjXTRU+H9bLolIZrAAi6d4If9K4VEl0Xbosr8SkcRaVMlpkouDDXLlmKPR2sU/+svXcMSDvXmtlh6lS+Q=
X-Received: by 2002:aa7:9dca:0:b0:6e4:776:c748 with SMTP id
 g10-20020aa79dca000000b006e40776c748mr9333196pfq.19.1708448044747; Tue, 20
 Feb 2024 08:54:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219163915.2705-1-dakr@redhat.com> <20240220093541.280140-1-aliceryhl@google.com>
 <e543b270-dea7-477a-b83d-62129d4ac708@redhat.com> <CANiq72nVkV3+1rt4Mi+Own6KGAzmvR2jf8fFsp9NBu_gy_ob5g@mail.gmail.com>
 <462aad75-4f03-4f8b-ad58-eef429ed2b34@redhat.com>
In-Reply-To: <462aad75-4f03-4f8b-ad58-eef429ed2b34@redhat.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 20 Feb 2024 17:53:51 +0100
Message-ID: <CANiq72m7-5CuKAKDk=G9sauri_sH0nR2TXi8ye5Eji-qaum3sw@mail.gmail.com>
Subject: Re: [PATCH v4] rust: str: add {make,to}_{upper,lower}case() to CString
To: Danilo Krummrich <dakr@redhat.com>
Cc: Alice Ryhl <aliceryhl@google.com>, a.hindborg@samsung.com, alex.gaynor@gmail.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, linux-kernel@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 4:53=E2=80=AFPM Danilo Krummrich <dakr@redhat.com> =
wrote:
>
> The rational for a convention can't be that it is a convention. Instead
> it should be a convention for an objective reason.

The rationale __for the lint__ is that it is a very established
convention in Rust code.

That is what Clippy is telling you.

You may not agree with the convention (and thus the lint). That is
fine, but it is still a fact that it is the convention, and that is
why I said whoever wrote that Clippy description probably felt that
wording is good enough.

> I'm not saying that we should enforce it otherwise, I just think that we
> should have objective reasons for restrictions.

Again, you seem to be saying we do not have objective reasons.

> However, I also don't see why we should disallow it as long as there is
> no objective reason to do so.

There are objective reasons to do so and we already explained them to you a=
bove:

    https://lore.kernel.org/rust-for-linux/CAH5fLggXiXGA_UWCxqqLhMpXe1kepDv=
2vMG+1jLGaDSzdRHvSw@mail.gmail.com/
    https://lore.kernel.org/rust-for-linux/CANiq72nVkV3+1rt4Mi+Own6KGAzmvR2=
jf8fFsp9NBu_gy_ob5g@mail.gmail.com/

You disagree? Fine, if you can come up with an argument that convinces
us or a good majority of the kernel that uses Rust, then I will
happily apply the patch.

Personally, I don't particularly care (based on style arguments alone)
whether to write `return` or not. But I do care about not wasting time
on litigating particular choices each time somebody does not like one.

> That's actually what the language did already with early-return vs return=
 at
> the end of the function.
>
> I admit that consistent inconsistency is also kinda consistent though. :-=
)
>
> The language has various characteristics, maybe that's why it allows both=
?

Languages may allow a lot of things, but that does not mean we write
the code like IOCCC just because we can.

Nor it does mean that a project should allow every way to write things
either, _especially_ when it is a very widespread convention.

> See above.

I don't see it, sorry. You said you want to be "explicit", but one can
very easily argue you are _not_ being explicit by omitting the
`return` in some cases.

> That's great, although I really don't understand why you think this one i=
s, but
> the other one isn't. What's the difference?

We already told you in this thread several times -- the `return` one
is idiomatic and so on. See the links above.

> I agree, but I also think it should be the other way around. We should ha=
ve good
> examples and an objective rationale for things we restrict.

Why? To me, we should have good examples and an objective rationale
for things where we actually want to deviate from what everybody else
is doing.

Cheers,
Miguel

