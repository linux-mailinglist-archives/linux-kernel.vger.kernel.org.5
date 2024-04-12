Return-Path: <linux-kernel+bounces-142169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2380C8A2869
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45B2B1C228CF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F255F4DA0C;
	Fri, 12 Apr 2024 07:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYTBrWPt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2A44CB35
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907812; cv=none; b=ggOaTYjMR2pLSZlCD8IizK6px0j0LGSx3B8Be5lvXbvba0B9aWf4TY7ayQjHiVohEEuFFkUi2phCgj5s41OBtR8BKZw6y7i4bsLB2SlSLFCcCrhMuWch1I2hpj6dLOVX3oyHVSqecgS7LYTShx2pwNl+M6X4nflfeJmayT1qXnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907812; c=relaxed/simple;
	bh=qc0S/CJU4kowJo7WTVvoeKMKqd4touOpNFtnd9qaJws=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JyvGRbTlYPP7HjxKHonFjO0yCONussfwzuXICsjAZe4kjRiiWoQ7FfLnF/R+B6LxorapzcXA/7DaDC13bfVXg67q0NWgrtaCLvZgt6iPiCEsadGH/7LryBem7kA7Mv4AqDNOrYAzyBj/Th/wf1vfM4X8LGi/xMrnYhoekzbBXl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hYTBrWPt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712907809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qc0S/CJU4kowJo7WTVvoeKMKqd4touOpNFtnd9qaJws=;
	b=hYTBrWPtfLWyTXk4TaF9tGAZVcWseXZYAxzDxuXaTzxDhWK0LP2Y0637awCab389WDNhnp
	RL7oSdWlM2u4gYlRiExfNv7+1V+VY4npvpxViH4m67e8WLubW1P8iDPA3fBR36ZjhnfWIY
	kPY5AKoAnioQQ6KbLFjS0tZJ0tLWdzI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-kgQeTWf2MP6OhfiWb_-JiA-1; Fri, 12 Apr 2024 03:43:28 -0400
X-MC-Unique: kgQeTWf2MP6OhfiWb_-JiA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-69a01201ca0so3251916d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 00:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712907808; x=1713512608;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qc0S/CJU4kowJo7WTVvoeKMKqd4touOpNFtnd9qaJws=;
        b=fNN9p8D93BI07qwe172obOZZD8HzqhOsmAFoRzQjBphEKxZhXift2mptvnhJ2XdduZ
         V0+TY9akNjyomUNEPnTmbWYI8f4B8OphAWkYuRM+Xjb0PGxZ/7hgSyl+TxO1ft8veR4O
         4HN6fJDy1MO8665tl44q+5qWkY4y8xQP6O+/VbCZEbJ/X5o7uUZS/b8b3U6omppQOB/R
         ospAyaPAKxfny0VmQnWUPJg7LNjfyEOKIgO6kziEry9v1kvePYCA4k+5Qd55WHcmRa4V
         u4/ZGIPJmoLzsTbQRdhGlWSPZXU4BMrkNMKXzALnhPxOx4+EzA5tUShYrNg8fGrxFA95
         XWQA==
X-Forwarded-Encrypted: i=1; AJvYcCV4s3aVRp9/eQaMsKlK+54OMO7YuEBnSX0yqGEP56OznCF8KlcLoPtVVWORjOP9ZfrfAa+wYH2YoldqyUJiX9/8QDKe48K8INsrijjB
X-Gm-Message-State: AOJu0YyfI61f+KvsaXnb68vo6NtaIKXq2WrvC8yreScSFoRi+59doT0d
	X016ai8KfuQ7GyrstMxv+qmKdehn2MrHwcqsMMeTdwhG3X1sFOdVtSSTGR64M/O2w2B+xi7UTRR
	sfG8936TTFLbJdr2O3Cnt0tldWiMbnSBddDlX47/rWYd7ROZ9kL6XtNDsK6J0pA==
X-Received: by 2002:ad4:5bce:0:b0:696:6f95:4421 with SMTP id t14-20020ad45bce000000b006966f954421mr1970845qvt.1.1712907807782;
        Fri, 12 Apr 2024 00:43:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhbJzhAj6YWiTxFFMhWnlebwH14TqL2Kj0GSChQpwNRps3BhQh6ASMCG3Py+7Kp5JK7f0ATg==
X-Received: by 2002:ad4:5bce:0:b0:696:6f95:4421 with SMTP id t14-20020ad45bce000000b006966f954421mr1970825qvt.1.1712907807497;
        Fri, 12 Apr 2024 00:43:27 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id f6-20020a056214164600b0069b10d78445sm1956974qvw.142.2024.04.12.00.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 00:43:27 -0700 (PDT)
Message-ID: <f08c06a4e8361f2cb55cd0dc1fa2bc2b0a046049.camel@redhat.com>
Subject: Re: [PATCH 2/2] rust: time: Use wrapping_sub() for Ktime::sub()
From: Philipp Stanner <pstanner@redhat.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Boqun Feng
	 <boqun.feng@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Miguel Ojeda <ojeda@kernel.org>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>,  Wedson Almeida Filho <wedsonaf@gmail.com>,
 Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com,  Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice
 Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Fri, 12 Apr 2024 09:43:24 +0200
In-Reply-To: <CANiq72nSSAVkynVaAq7bQKoL6N8K2JUXp8AOVvu7vN+siAhk-Q@mail.gmail.com>
References: <20240411230801.1504496-1-boqun.feng@gmail.com>
	 <20240411230801.1504496-3-boqun.feng@gmail.com>
	 <CANiq72nSSAVkynVaAq7bQKoL6N8K2JUXp8AOVvu7vN+siAhk-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-12 at 09:14 +0200, Miguel Ojeda wrote:
> On Fri, Apr 12, 2024 at 1:08=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com>
> wrote:
> >=20
> > Currently since Rust code is compiled with "-Coverflow-checks=3Dy",
> > so a
>=20
> Nit: it is enabled by default, but configurable
> (`CONFIG_RUST_OVERFLOW_CHECKS`).

Is that going to remain enabled by default or what was the plan here?

P.


>=20
> > although overflow detection is nice to have, however this makes
> > `Ktime::sub()` behave differently than `ktime_sub()`, moreover it's
> > not
> > clear that the overflow checking is helpful, since for example, the
> > current binder usage[1] doesn't have the checking.
> >=20
> > Therefore make `Ktime::sub()` have the same semantics as
> > `ktime_sub()`:
> > overflow behaves like 2s-complement wrapping sub.
>=20
> If `ktime_sub()`'s callers rely on wrapping in some cases, then an
> alternative we should consider is having a method for explicitly
> wrapping, like the integers. This would allow callers to decide and
> it
> would make the expected semantics clear since the beginning (which is
> the easiest time to add this kind of thing) for Rust code.
>=20
> Otherwise, I agree we should at least document the preconditions
> clearly.
>=20
> Having said that, I see a `ktime_add_unsafe()` too, which was added
> due to a UBSAN report for `ktime_add()` in commit 979515c56458
> ("time:
> Avoid undefined behaviour in ktime_add_safe()"). There is also a
> private `ktime_add_safe()` too, which is a saturating one.
>=20
> So, given that, can callers actually rely on wrapping for these
> functions, or not? The documentation on the C side could perhaps be
> clarified here (including the mention of UB in `ktime_add_unsafe()` -
> -
> we use `-fno-strict-overflow`) and perhaps using the `wrapping_*()` C
> functions too.
>=20
> In addition, Binder calls `ktime_ms_delta()`, not `ktime_sub()`,
> right? In that case the arguments are called `later` and `earlier`,
> perhaps those have a different expectation even if `ktime_sub()` is
> allowed to overflow and thus it would make sense to check in that
> function only instead? (and document accordingly)
>=20
> Thanks!
>=20
> Cheers,
> Miguel
>=20


