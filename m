Return-Path: <linux-kernel+bounces-117187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B8188A869
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F1D1C3CBAE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BC013B5B7;
	Mon, 25 Mar 2024 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTC8vqQC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F1513C818
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711375026; cv=none; b=e0RLZl9amVV+tt2IFojf09p/cDzYc1LwhNescciU0bxZW0MrwwYUkbqSrqtgkxRHlpaspOGzhHHv6dgQWTxG455KCAj3yxidFT6u4sdRtJgFdniqsZnj4BO9G7fUKdROZTpwo0DWpjM+a647nf9lSgugm2R7XHtgSEIkrXGPSKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711375026; c=relaxed/simple;
	bh=Su0oRSDMDN6WKCvVoRZlpj1EX7RmBmcvnQ0SRJYHWr0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EctW7nzMVdkMx/BmlrP5qZmt5AIVuKlkXXeDdjN6VsyKF2CC+KNcDpeP1IJ9Jkno9PzIqih8iv6L1upawEP/FlIkusJOEP1ZyxEE1CRdU3gU1puu8ZlyRhN+/sO46tQ+dq8hnn38ROkKu2A5d5wpnEM6KSh89N2n4Hqws6afR9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YTC8vqQC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711375024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Su0oRSDMDN6WKCvVoRZlpj1EX7RmBmcvnQ0SRJYHWr0=;
	b=YTC8vqQCaNQSIfmGxmaRo+XhG8hbqvkA1bRpoON52j6bDZd5yhMfuVs4MNxtDN3TBcNf1n
	NQeNkeDCI0L75PsZ8upu+Yo6AKT7hF3Wokh8e0+uZ36fDGEM84bQJkoySzWEw5BPLnO4N2
	JACjb1RDN+B0qI34sVFz1XXM5UIi26Q=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-4J10UIQgMLqNnifSLyDomw-1; Mon, 25 Mar 2024 09:57:02 -0400
X-MC-Unique: 4J10UIQgMLqNnifSLyDomw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d6c5548f93so5086011fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 06:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711375021; x=1711979821;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Su0oRSDMDN6WKCvVoRZlpj1EX7RmBmcvnQ0SRJYHWr0=;
        b=AOM/CK+nBVorrj4/Af2Os2lugLKOgsCDJKu0Kjk61Pt3OSa2kMXfFkp0fps0jWiHSw
         xkrFa4Ync4j3vdb81fTyBteBtqDVzMA4m8Mwler1D6Qz6rDiwNMLk22DDi5pFENBB2Xo
         H5VaMBt6Fle/EUcKW9JI6xX27hwSqcSRh6QVm7GQY08zif3ZAWXJtPGOHuo/ePVn9K8u
         TUrjkIxG0tTsJvzIzKpEHhuILoyUUaouRCGWsTTZs/eho7jJwdVYkTD28T0ty3jkzEt5
         IrP6qMWWSyrONvUM8YMDSbMEnbH3ix5Unm+ghLxI7e5da0t9JPlK5kLHsaqb2+7n+ryc
         FQIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlO2IO0nse8f356GBpemJoYviIg6We2VIJAOAKx8WqLJlc6BaYYBHpJKo+cM+nzBrAIAHgun1AeVJkfOC4SXmNblsItjDC14OSKs/Z
X-Gm-Message-State: AOJu0YxOGsDAi2vFkToZ6McK+zKTaZvOncj1yfTDWol3DlSj9DGcr6pJ
	ziyoaVLR77Uu6jongjFAy5rZrrfFcaiDQTyfevX71R7De3lkRhmXuaLdklE7AU1KiqQWJ38damr
	Dnxl/cHsJ3eRN8dcpG3dDT+L6WDMR1nnpGm7HdAW5I3XH3oK83Qr9fs8hdEe3xw==
X-Received: by 2002:a2e:88d0:0:b0:2d4:78b4:e568 with SMTP id a16-20020a2e88d0000000b002d478b4e568mr4341975ljk.1.1711375021344;
        Mon, 25 Mar 2024 06:57:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsEsxChr4oIHfPIiuFPvTM+72aemZNo0G3gI+fLGhTYtrb+QS9VpjMdi/YbUXjC7EP1XZSIg==
X-Received: by 2002:a2e:88d0:0:b0:2d4:78b4:e568 with SMTP id a16-20020a2e88d0000000b002d478b4e568mr4341961ljk.1.1711375020848;
        Mon, 25 Mar 2024 06:57:00 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id n3-20020a05600c4f8300b00414887d9329sm4600055wmq.46.2024.03.25.06.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 06:57:00 -0700 (PDT)
Message-ID: <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
From: Philipp Stanner <pstanner@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Kent Overstreet
	 <kent.overstreet@linux.dev>
Cc: Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 llvm@lists.linux.dev,  Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary
 Guo <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Alan
 Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>,
 Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>,
 "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>,
 Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes
 <joel@joelfernandes.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, kent.overstreet@gmail.com,  Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com, Mark Rutland
 <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Date: Mon, 25 Mar 2024 14:56:58 +0100
In-Reply-To: <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
	 <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
	 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
	 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
	 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-03-22 at 17:36 -0700, Linus Torvalds wrote:
> On Fri, 22 Mar 2024 at 17:21, Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >=20
> > Besides that there's cross arch support to think about - it's hard
> > to
> > imagine us ever ditching our own atomics.
>=20
> > [... SNIP ...]
> >=20
> > I was thinking about something more incremental - just an optional
> > mode
> > where our atomics were C atomics underneath. It'd probably give the
> > compiler people a much more effective way to test their stuff than
> > anything they have now.
>=20
> I suspect it might be painful, and some compiler people would throw
> their hands up in horror, because the C++ atomics model is based
> fairly solidly on atomic types, and the kernel memory model is much
> more fluid.
>=20
> Boqun already mentioned the "mixing access sizes", which is actually
> quite fundamental in the kernel, where we play lots of games with
> that
> (typically around locking, where you find patterns line unlock
> writing
> a zero to a single byte, even though the whole lock data structure is
> a word). And sometimes the access size games are very explicit (eg
> lib/lockref.c).
>=20
> But it actually goes deeper than that. While we do have "atomic_t"
> etc
> for arithmetic atomics, and that probably would map fairly well to
> C++
> atomics, in other cases we simply base our atomics not on _types_,
> but
> on code.
>=20
> IOW, we do things like "cmpxchg()", and the target of that atomic
> access is just a regular data structure field.
>=20
> It's kind of like our "volatile" usage. If you read the C (and C++)
> standards, you'll find that you should use "volatile" on data types.
> That's almost *never* what the kernel does. The kernel uses
> "volatile"
> in _code_ (ie READ_ONCE() etc), and uses it by casting etc.
>=20
> Compiler people don't tend to really like those kinds of things.

Just for my understanding: Why don't they like it?

I guess since compiler people have to support volatile pointers
anyways, temporarily casting something to such a volatile pointer
shouldn't be a problem either =E2=80=93 so they don't dislike it because it=
's
more difficult to implement, but because it's more difficult to verify
for correctness?


P.

>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Linus
>=20


