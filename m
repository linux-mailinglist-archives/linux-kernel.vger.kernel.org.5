Return-Path: <linux-kernel+bounces-81028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5CB866F70
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE292B29F5E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA4012BE81;
	Mon, 26 Feb 2024 09:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="AP684ytn"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168FA12B15E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938926; cv=none; b=OC5s2vsO7Z549xePc6C4KabdhjLkYlGwdJs51MVVMRpLZvPxK0/hHKMK74DQBgVd7jJL54cQep9eQiXN90XAlyUf3zVLmaGM6xIjhfLSRR3wOUXF6jsuuL+MlZYpr5i7uSF4iQ66MT8xpsHgZRXqVhS+mld48qByiafWw3tBg1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938926; c=relaxed/simple;
	bh=4JrM6obTNl+TTmD9WbQnog507Wg3xKCRVbWqMRbgJTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDAc3wvVBY2sf4hnQWNKoE2R5oOotqWFSHkDJdHE157M+mKoDvdm96i1Ia1wknkboWZG0Oi/exjvGNWS3op531qjXAJogx4W+jHatt6Ui9DF4/WY6AHg9JplmOQcisbOdM1hX3JgrcgNub5O6t0P3auQiWqhW/6Mrpgr6E7pNPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AP684ytn; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-471e55434e9so536070137.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708938924; x=1709543724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JrM6obTNl+TTmD9WbQnog507Wg3xKCRVbWqMRbgJTg=;
        b=AP684ytn0uruUtZ4O9nQ3FsT63n8lYTu+hq4RM7Mh6B2ZV8zCAiKqCVHzv4R7XcVCv
         KG1yjDVjf1i1FwtdIFEHSepox2EYtC6gyF9Az0LkEXYo29yxMhoFmPLQC+zyyUW4YGTL
         qwS0R6P8TgoVs00BsclAxOEGHBdGw3gqG4OGr4VvbEJeQp1zcixrhcZ9A73ln32hx3/k
         3UqpbFOlQC/Sstrh94Q0i670dmIVIPVn9HVHkmsNCCLSWT9DbKza4tbuYKje1tq8p2Y3
         XYKs55V/0l4TmxcCB1mc9/6oliPl0TuHOuJjWtcJFymJuZPrhB9bE33TzmlVbpUtS9C2
         JH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708938924; x=1709543724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JrM6obTNl+TTmD9WbQnog507Wg3xKCRVbWqMRbgJTg=;
        b=WZySN5Zgi9M4jHjkJC+syz9bL+3XT+P/a0sEjwt+wWp4JFS9sdq6O+wA5RyloyIwwa
         F34q2wTeDODnjIHCxlq1vvEvRqVWvAXZlO/PgHNG6XGvNevEtcSQBPNdA7FGdb3X/95O
         gXJAxpT7+MQNbP7z+I2jn1xyZdYLV7rwcMN5ZUUb9tsdhNvDCc61q6YpGWG9Do+fe8LZ
         tGL26yS3yOhdWi7ZdEP3EJXcVnLe94fJq0FATf14dkIc5aENwRk4zuF93+8s+XTKcsY+
         Dz/EAzEiNrb11TzwAx3khVXNV0Ecw63R5dlPr82L48GnD86stWNJfs7iPno/ETCyGqCG
         uXKg==
X-Forwarded-Encrypted: i=1; AJvYcCUFigsOL/dN3oh3qHm0iS+HpMBZvw/iiV8+lYzAli7hHQa8iUkb/0E+AfIXBDATCMK11GlTMkZl+nXEEzbLydP3M0MKlm4IYFXyNtKK
X-Gm-Message-State: AOJu0YzaTiN0B8YlyXYZyOo+QioCjyucyxQBe/E8LuImvYDGt52W7S5e
	nhtDrno77lZ2w/F/s+Kp2rm34k8ucK3mHlDFZLcFwMXbCmHx8t6ppigIC7SxKdcK8GLn9mTlsoF
	uLfRFOXrBeHYZxqu4o6jSoELjfYjxQ4N5xiCe
X-Google-Smtp-Source: AGHT+IG0UsEDnmHxQRrz745aw4UlqWNyLvLKlXPrUyhs0dx23Srr+KTicp6LvTTAV47/MeSVZ9UVHkCM8Vt6BAMhVZc=
X-Received: by 2002:a67:ee18:0:b0:470:45bc:a78f with SMTP id
 f24-20020a67ee18000000b0047045bca78fmr4607957vsp.15.1708938923903; Mon, 26
 Feb 2024 01:15:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230503090708.2524310-7-nmi@metaspace.dk> <20230503120354.534136-1-aliceryhl@google.com>
 <87y1b7a994.fsf@metaspace.dk>
In-Reply-To: <87y1b7a994.fsf@metaspace.dk>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 26 Feb 2024 10:15:12 +0100
Message-ID: <CAH5fLgjQm72KmKBtcnBEXOtVqd=Gto5UGF7jrekx8f+7QXh_Ag@mail.gmail.com>
Subject: Re: [RFC PATCH 06/11] rust: apply cache line padding for `SpinLock`
To: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
Cc: Damien.LeMoal@wdc.com, alex.gaynor@gmail.com, axboe@kernel.dk, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, gost.dev@samsung.com, hare@suse.de, hch@lst.de, 
	kbusch@kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lsf-pc@lists.linux-foundation.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 10:02=E2=80=AFAM Andreas Hindborg (Samsung)
<nmi@metaspace.dk> wrote:
>
>
> Hi Alice,
>
> Alice Ryhl <aliceryhl@google.com> writes:
>
> > On Wed, 3 May 2023 11:07:03 +0200, Andreas Hindborg <a.hindborg@samsung=
com> wrote:
> >> The kernel `struct spinlock` is 4 bytes on x86 when lockdep is not ena=
bled. The
> >> structure is not padded to fit a cache line. The effect of this for `S=
pinLock`
> >> is that the lock variable and the value protected by the lock will sha=
re a cache
> >> line, depending on the alignment requirements of the protected value. =
Aligning
> >> the lock variable and the protected value to a cache line yields a 20%
> >> performance increase for the Rust null block driver for sequential rea=
ds to
> >> memory backed devices at 6 concurrent readers.
> >>
> >> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> >
> > This applies the cacheline padding to all spinlocks unconditionally.
> > It's not clear to me that we want to do that. Instead, I suggest using
> > `SpinLock<CachePadded<T>>` in the null block driver to opt-in to the
> > cache padding there, and let other drivers choose whether or not they
> > want to cache pad their locks.
>
> I was going to write that this is not going to work because the compiler
> is going to reorder the fields of `Lock` and put the `data` field first,
> followed by the `state` field. But I checked the layout, and it seems
> that I actually get the `state` field first (with an alignment of 4), 60
> bytes of padding, and then the `data` field (with alignment 64).
>
> I am wondering why the compiler is not reordering these fields? Am I
> guaranteed that the fields will not be reordered? Looking at the
> definition of `Lock` there does not seem to be anything that prevents
> rustc from swapping `state` and `data`.

It's because `Lock` has `: ?Sized` on the `T` generic. Fields that
might not be Sized must always be last.

Alice

