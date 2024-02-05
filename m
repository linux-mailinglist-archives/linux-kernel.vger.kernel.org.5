Return-Path: <linux-kernel+bounces-54016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A428C84A945
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13F52B28B3B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20BB1DA4C;
	Mon,  5 Feb 2024 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="exyIA6j2"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6E31DA37
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707171869; cv=none; b=Gh04rsGM2jpDDmjZT3BXI214XCwuO9ek2QGuwHgh9Gw8Z0WJyxMdlUK6INCSkUa0e5SwJ/p5R4XTFc9jFp2Bn9VKIbVId2YUuqyNeXvsVL3gcLn/JfAF8xgl66pRYKMyW1sGrrDArGVQMYsMFH0fum7t8HHHG6HY9M39x2jcyTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707171869; c=relaxed/simple;
	bh=ZrnXtFKNo7DqcRc5LJERAqUuIv19bdc/Qa6WrZVBydw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=YJaou5/7N1FVnkXzrxSEhmyFyDe5VAIY8lWiSWdnspItkJlF8jyMRFnFZFCrTC3FyILgYHd1ETDRblyFhA+Yle1ysnjClb2zA2SuOW2gNfih81atFx7lzWENWFqg4iKFWbpB9I3H2PIUr0WhsK7k1+VeerXGHcczii5U5oyoJtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=exyIA6j2; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33b45befbbbso95155f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 14:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707171865; x=1707776665; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PU8nezW/KDwZaT+7b+MCWSrRoGQq7aEXwFDNWTCaMDQ=;
        b=exyIA6j2Bo2Bv5IPQyvmVV92nexBJobNwZGW50NQv6h9owpsscoav8Do6mRI6EvKFR
         ZdLEO5vB3rO4TpMUEBZVyNZjam02LZIqXw8Pr9hfjr/m8/oIdXzR1VSyeqq2f0ZhfhBI
         V5XlkN1ugclwbJAuvKTD46XSBYotWL1mFuZCWTFADXxJeaEHQBcKSoSPitdYrifuctjP
         tKsTF2rIaZN+oa2Zs1rCPGG7tPbzhmGlhuc7CO7znOuFV/QdWsSLFo2Nfb+A6hRydIFk
         MsTgSn0rIJH0aGY/ziHk8RO2zusPylL7nOO6FEtt9o9UVGReFqlGvoSX78eQ6KFsJDeC
         Gibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707171865; x=1707776665;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PU8nezW/KDwZaT+7b+MCWSrRoGQq7aEXwFDNWTCaMDQ=;
        b=ilNTEANTYvdlQk3AjnmZFKhA2UfYvkfXaFnCVWnWxv/DgIfovS9DGzKIhmKm6fHtvO
         DSZS76ucUpn55I1qNhHS1F3kf86lBC2KDLwFNi9aV17cpV168s4hLh+mfglk41FbhxEB
         UYA5/ym7axHNnh3etbQNKVN6KIhxt580fF6rp559fxL3U8Hy1FHVg3S5ZfpeAD7jo9Pb
         eD7Xa3cH4S0Xy/Bk8zFF8Gb1esqI3gCyp9jFwI4hh/dpPn6G7/GQ4a8u2oafiZYMZPcm
         OcM4tYLRCJplFZU3KVOKCFK8lUi+qUgsfWPszU7Dxb5d4Csr/tqCI9/4eBf75yBy3z/s
         pJLQ==
X-Gm-Message-State: AOJu0YwsqGyjka3e7wfAVmsHOYqooF8N5vBU9DjDuHEMmKDJnfFBS7XD
	CUbppDUXoRAhfE2phXsMi2O6QIvQsWaMTdeew7YN0jgUnYbtWOwVIbhN93invrvqanXOq0h92jC
	hz7Dw2wfLUXvj6CsKkkwK3GIc5rBC/LtHYC/3
X-Google-Smtp-Source: AGHT+IHmPQVc505MdGAGxqA5acadtkePUJKzVkLTjW5NfvEQ1pquN8eiiEGYTM+kG5NzjrE0qjzqF+bieBlOlA2t0t0=
X-Received: by 2002:a5d:4d06:0:b0:33b:4020:8710 with SMTP id
 z6-20020a5d4d06000000b0033b40208710mr186536wrt.61.1707171865396; Mon, 05 Feb
 2024 14:24:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129193512.123145-1-lokeshgidra@google.com>
 <20240129193512.123145-4-lokeshgidra@google.com> <20240129203626.uq5tdic4z5qua5qy@revolver>
 <CAJuCfpFS=h8h1Tgn55Hv+cr9bUFFoUvejiFQsHGN5yT7utpDMg@mail.gmail.com>
 <CA+EESO5r+b7QPYM5po--rxQBa9EPi4x1EZ96rEzso288dbpuow@mail.gmail.com>
 <20240130025803.2go3xekza5qubxgz@revolver> <CA+EESO4+ExV-2oo0rFNpw0sL+_tWZ_MH_rUh-wvssN0y_hr+LA@mail.gmail.com>
 <20240131214104.rgw3x5vuap43xubi@revolver> <CAJuCfpFB6Udm0pkTwJCOtvrn9+=g05oFgL-dUnEkEO0cGmyvOw@mail.gmail.com>
 <CA+EESO7ri47BaecbesP8dZCjeAk60+=Fcdc8xc5mbeA4UrYmqQ@mail.gmail.com> <20240205220022.a4qy7xlv6jpcsnh7@revolver>
In-Reply-To: <20240205220022.a4qy7xlv6jpcsnh7@revolver>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Mon, 5 Feb 2024 14:24:13 -0800
Message-ID: <CA+EESO6iXDAkH0hRcJf70aqASKG1eHWq2rJvLHafCtx-1pGAhw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] userfaultfd: use per-vma locks in userfaultfd operations
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lokesh Gidra <lokeshgidra@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 2:00=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracle=
com> wrote:
>
> * Lokesh Gidra <lokeshgidra@google.com> [240205 16:55]:
> ...
>
> > > > > We can take care of anon_vma as well here right? I can take a boo=
l
> > > > > parameter ('prepare_anon' or something) and then:
> > > > >
> > > > >            if (vma) {
> > > > >                     if (prepare_anon && vma_is_anonymous(vma)) &&
> > > > > !anon_vma_prepare(vma)) {
> > > > >                                       vma =3D ERR_PTR(-ENOMEM);
> > > > >                                       goto out_unlock;
> > > > >                    }
> > > > > >                 vma_aquire_read_lock(vma);
> > > > >            }
> > > > > out_unlock:
> > > > > >         mmap_read_unlock(mm);
> > > > > >         return vma;
> > > > > > }
> > > >
> > > > Do you need this?  I didn't think this was happening in the code as
> > > > written?  If you need it I would suggest making it happen always an=
d
> > > > ditch the flag until a user needs this variant, but document what's
> > > > going on in here or even have a better name.
> > >
> > > I think yes, you do need this. I can see calls to anon_vma_prepare()
> > > under mmap_read_lock() protection in both mfill_atomic_hugetlb() and
> > > in mfill_atomic(). This means, just like in the pagefault path, we
> > > modify vma->anon_vma under mmap_read_lock protection which guarantees
> > > that adjacent VMAs won't change. This is important because
> > > __anon_vma_prepare() uses find_mergeable_anon_vma() that needs the
> > > neighboring VMAs to be stable. Per-VMA lock guarantees stability of
> > > the VMA we locked but not of its neighbors, therefore holding per-VMA
> > > lock while calling anon_vma_prepare() is not enough. The solution
> > > Lokesh suggests would call anon_vma_prepare() under mmap_read_lock an=
d
> > > therefore would avoid the issue.
> > >
>
> ...
>
> > anon_vma_prepare() is also called in validate_move_areas() via move_pag=
es().
>
> Probably worth doing it unconditionally and have a comment as to why it
> is necessary.
>
The src_vma (in case of move_pages()) doesn't need to have it.

The only reason I'm not inclined to make it unconditional is what if
some future user of lock_vma() doesn't need it for their purpose? Why
allocate anon_vma in that case.

> Does this avoid your locking workaround?

Not sure which workaround you are referring to. I am almost done
implementing your suggestion. Very soon will share the next version of
the patch-set.
>
> Thanks,
> Liam

