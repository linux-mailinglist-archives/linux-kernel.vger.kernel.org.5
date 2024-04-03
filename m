Return-Path: <linux-kernel+bounces-129451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B82E896B00
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887111F23A7D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA004135A5F;
	Wed,  3 Apr 2024 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="1q8H9D3R"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EC554725
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 09:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712137648; cv=none; b=hJVR6tGpKZH5wczKUG2CJmJQtRrHF51E5D+T8cpDfL3mBAeB8I4PM1R3jaiLOTpxJHudh/43qHPQiMT31zz9MFPOWvR1o6Q/qc3V95XW2s0m3GP8W87Ewijb9PaXKHKm2dZRM++PL48UtYOodxG6ady5l3hm0OnFbbx66NlENPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712137648; c=relaxed/simple;
	bh=GRfag88koxETtlzSVNB41LuzJOoQ5upi+5Ad5sKRA7g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZQ9nv0+LCQ4Spvx3mXzrLMsX/mylQ5spGRMWO6dKSLzbDIFjwfb42OqET6Ke5bpQ8qFTin+RXH1b9xYNJpa5znk1cpIgJHxJtnqty+xIP9Bpe8url9nRxE/GTLEMedEqrnZ5ZOlqQUNCzqt3PjEgS8fZt4BmLR1aWE1hc72XUBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=1q8H9D3R; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513e25afabaso6836249e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 02:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1712137644; x=1712742444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38SEkdXIN7qI57DkSuG7SyOZVG7UjoZz3fx+kBnmeVk=;
        b=1q8H9D3RzPDHhPPW4oaXaZvc7oz9L7SA26PXsYzg9aJb7w0nJs77TmQf4sne7GpRyp
         8f+2IRi+bET4fzqdjNgBWX0GF1cY/6++n4eXh1B+TUSb8r3SPA8Qy+7gCGRQmZVdXCqv
         Gt/DNTfEPvAsm6LrazzTyVsYRu9vjYBJ+qOjCmby6PCkvP8p2TMILUxCQRBSF3Y6T7+y
         DX4pHS3CEzoR2K+i6bATZ8xtk/z9I7RIZ3PApLsQX8+f3ouPxW9KVR0QvLNcWJ0hP+Ki
         UikiKhmT1iwwy64yKoByLHAcGOTjYBPJqOq1B4bB1f3ca1VKViCSSEY2ROa4HoI5ehfD
         HoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712137644; x=1712742444;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=38SEkdXIN7qI57DkSuG7SyOZVG7UjoZz3fx+kBnmeVk=;
        b=NwaSwqJW6bV3BpoJvKbyhpPAW00dqAOwTXdVjp4LDhzo59vVurkB2V1NxSIKOM5tRr
         KCwCbpXhbfpe9fSgjLmSmuySEl8Ow83C8cjDBi8rQD2KLrh7s+q2mxs7WTsWXQbrvRvk
         OJjeF4AwiqV5LKDztnde61I4Vst6xg2506hFD/tNwzbjoLebrYBcHvj5/ud2hnxuEbOE
         JVO97XJe4V3ziYwujatcwhcfe3RMhsgjgotKSviXsHedguMzaK8b9TVTKjEnwZ1nwmGU
         QJPJDoBQE4jD01lh32xB0fon4v0Gvm6cUTnUMUbARKdjgh9blf+Jg4/lY1GXKFY35ir7
         5LcA==
X-Forwarded-Encrypted: i=1; AJvYcCXcgSgEnOLGwAQqYjTh/mMDh8dwGbn9oOW6cFU522fjpqwGuh0g9U0zzOwVb85gpQvdnEnBZVrRe+5ItB/CcVPMjpC9jb8GWliJwhFT
X-Gm-Message-State: AOJu0YxRCKpHnR3PQAXg1Qm/RUdpaw26OfCXHCN7J7IoOEf3dsve7JSq
	feIIINO8QzzbZGpDaniKgllUOtXZNPoZSgZdG1Uafkt/ZDIeyCjzdKrr9QYlU7E=
X-Google-Smtp-Source: AGHT+IF/utXEsQEWDyjGiPzaJJWG210MR6/6WD7WsBEga3lRMhAkUP0TtaJbNUiFtWdGFRhMNlrSRg==
X-Received: by 2002:a05:6512:480b:b0:516:26ca:c1fe with SMTP id eo11-20020a056512480b00b0051626cac1femr7053161lfb.8.1712137643891;
        Wed, 03 Apr 2024 02:47:23 -0700 (PDT)
Received: from localhost ([147.161.155.112])
        by smtp.gmail.com with ESMTPSA id en19-20020a056000421300b0034365152f2asm4259837wrb.97.2024.04.03.02.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 02:47:23 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>,  Christoph Hellwig <hch@lst.de>,  Keith
 Busch <kbusch@kernel.org>,  Damien Le Moal <Damien.LeMoal@wdc.com>,  Bart
 Van Assche <bvanassche@acm.org>,  Hannes Reinecke <hare@suse.de>,
  "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,  Andreas
 Hindborg <a.hindborg@samsung.com>,  Niklas Cassel <Niklas.Cassel@wdc.com>,
  Greg KH <gregkh@linuxfoundation.org>,  Matthew Wilcox
 <willy@infradead.org>,  Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor
 <alex.gaynor@gmail.com>,  Wedson Almeida Filho <wedsonaf@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Alice Ryhl <aliceryhl@google.com>,
  Chaitanya Kulkarni <chaitanyak@nvidia.com>,  Luis Chamberlain
 <mcgrof@kernel.org>,  Yexuan Yang <1182282462@bupt.edu.cn>,  Sergio
 =?utf-8?Q?Gonz=C3=A1lez?= Collado <sergio.collado@gmail.com>,  Joel
 Granados
 <j.granados@samsung.com>,  "Pankaj Raghav (Samsung)"
 <kernel@pankajraghav.com>,  Daniel Gomez <da.gomez@samsung.com>,  open
 list <linux-kernel@vger.kernel.org>,  "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>,  "lsf-pc@lists.linux-foundation.org"
 <lsf-pc@lists.linux-foundation.org>,  "gost.dev@samsung.com"
 <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 4/5] rust: block: add rnull, Rust null_blk
 implementation
In-Reply-To: <1e8a2a1f-abbf-44ba-8344-705a9cbb1627@proton.me> (Benno Lossin's
	message of "Tue, 02 Apr 2024 22:35:32 +0000")
References: <20240313110515.70088-1-nmi@metaspace.dk>
	<20240313110515.70088-5-nmi@metaspace.dk>
	<QqpNcEOxhslSB7-34znxmQK_prPJfe2GT0ejWLesj-Dlse1ueCacbzsJOM0LK3YmgQsUWAR58ZFPPh1MUCliionIXrvLNsOqTS_Ee3bXEuQ=@proton.me>
	<87msqc3p0e.fsf@metaspace.dk>
	<1e8a2a1f-abbf-44ba-8344-705a9cbb1627@proton.me>
User-Agent: mu4e 1.12.2; emacs 29.3
Date: Wed, 03 Apr 2024 11:47:18 +0200
Message-ID: <87edbmsrq1.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Benno Lossin <benno.lossin@proton.me> writes:

[...]

>
>
> So I did some digging and there are multiple things at play. I am going
> to explain the second error first, since that one might be a problem
> with `pin_init`:
> - the `params` extension of the `module!` macro creates constants with
>    snake case names.
> - your `QueueData` struct has the same name as a field.
> - `pin_init!` generates `let $field_name =3D ...` statements for each
>    field you initialize
>
> Now when you define a constant in Rust, you are able to pattern-match
> with that constant, eg:
>
>      const FOO: u8 =3D 0;
>=20=20=20=20=20=20
>      fn main() {
>          match 10 {
>              FOO =3D> println!("foo"),
>              _ =3D> {}
>          }
>      }
>
> So when you do `let FOO =3D x;`, then it interprets `FOO` as the constant.
> This is still true if the constant has a snake case name.
> Since the expression in the `pin_init!` macro has type
> `DropGuard<$field_type>`, we get the error "expected
> `DropGuard<IRQMode>`, found `__rnull_mod_irq_mode`".

Thanks for the analysis!

So in this expanded code:

1   {
2       unsafe { ::core::ptr::write(&raw mut ((*slot).irq_mode), irq_mode) =
};
3   }
4   let irq_mode =3D unsafe {
5       $crate::init::__internal::DropGuard::new(&raw mut ((*slot).irq_mode=
))
6   };

the `irq_mode` on line 2 will refer to the correct thing, but the one on
line 6 will be a pattern match against a constant? That is really
surprising to me. Can we make the let binding in line 6 be `let
irq_mode_pin_init` or something similar?

>
> Now to the first error, this is a problem with the parameter handling of
> `module`. By the same argument above, your let binding in line 104:
>
>      let irq_mode =3D (*irq_mode.read()).try_into()?;
>
> Tries to pattern-match the `irq_mode` constant with the right
> expression. Since you use the `try_into` function, it tries to search
> for a `TryInto` implementation for the type of `irq_mode` which is
> generated by the `module!` macro. The type is named
> __rnull_mod_irq_mode.
>
>
> Now what to do about this. For the second error (the one related to
> `pin_init`), I could create a patch that fixes it by adding the suffix
> `_guard` to those let bindings, preventing the issue. Not sure if we
> need that though, since it will not get rid of the first issue.

I think that is a good idea =F0=9F=91=8D

>
> For the first issue, I think there is no other way than to use a
> different name for either the field or the constant. Since constants are
> usually named using screaming snake case, I think it should be renamed.
> I believe your reason for using a snake case name is that these names
> are used directly as the names for the parameters when loading the
> module and there the convention is to use snake case, right?
> In that case I think we could expect people to write the screaming snake
> case name in rust and have it automatically be lower-cased by the
> `module!` macro when it creates the names that the parameters are shown
> with.

I was thinking about putting the parameters in a separate name space,
but making them screaming snake case is also a good idea. So it would
be `module_parameters::IRQ_MODE` to access the parameter with the name
`irq_mode` exposed towards the user. Developers can always opt in to bringi=
ng
the symbols into scope with a `use`.

Best regards,
Andreas

