Return-Path: <linux-kernel+bounces-87615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB13586D684
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06D21B20F82
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAAC74BEB;
	Thu, 29 Feb 2024 22:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YtANYdoW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CE16D522
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 22:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709244255; cv=none; b=Ny/VwX41cAzY2K8pmFjlpjKLOoGULJpPNUCS7Ov8DlK+VfnbbQsJI/pDN18Qm3qwWRjcKJjTQ0F8dREE7nNHjnqfXpcqj/emPb4YUChSS5wALS+YT3SC5ipQctGY+bHi90wJvdgEqdQWKjiW8yg0D5LJhb8McwNIkO0/TDGTwgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709244255; c=relaxed/simple;
	bh=5ubYRa2KwnGmMmdBlB9FaAnD69udRueK67E102lJcvs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TWXj6MaG29/bc+sxuSxI1dvI7RLl42Z4ugLjskwwLB436NnvMeKK1J4jT2mLj+e7LGBvk1miEsZHawtqnGfFZAEbYxY93m8z/aTOEWxwTA0GfKlJU9rr6iVa9+mWk3BL45C1RlmnvpfR9fXfYupDBrz4K+u3CApPOaIHESzu49s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YtANYdoW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709244252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aNG3+S9v1/vdCmBpDlDkhTu4/UoEKRmapR+0MWUUhG4=;
	b=YtANYdoWfgBhOcrJmwgGVTm+gltPRuVJ2uAB1HqnfEkCJ9EIOpTNmC6IObHuH0Alswquuv
	YLEQMyc2pvP3Iog2oy7DbSzRkbxIV3KAwPOjThFw4VproE+x0ILbiPBa7KY0Hm5Jl84YnV
	8Qg87aukywiP1Ppxiy2Y1Wvp41BEDCM=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-VCctzu4UP7Ci7gdLDGOgiA-1; Thu, 29 Feb 2024 17:04:11 -0500
X-MC-Unique: VCctzu4UP7Ci7gdLDGOgiA-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c784b01313so193457239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:04:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709244249; x=1709849049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aNG3+S9v1/vdCmBpDlDkhTu4/UoEKRmapR+0MWUUhG4=;
        b=nGh+MEuu3rNEpq6jtYN4894yH69w2HQowM1z0yHyAv8ozVM3ft/V04O0Nu/8BdbSXM
         Ux9hsbTkq6v/hW8jLsdQrD31GSwTlCRFzqSQLyYs7lInRLYSDWmSag4MUhQNAIHatrRu
         kRAvwb9WYIDJoKjL3TzD98EK2RV/1PcIGPPC15Nlaitn9w/SgWneqbsRG3NViWlHX4ZD
         hw+9VnVXD8fnjrLSbQBF6WRqlrU+d/84G2QPv/XYb/KeP8RUBEroNdGqF2H4cBEtghWo
         Pd4/TOq8KwsyqPRs4KNm6RXrSZ6Be5E4gtVP92m8RF/Cky4yp9rwTL89FuL6UU1DPycU
         NSOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzRXOyn0r/I87zjbna0A8El3hPQUSKp2NQmlruCO6i2MiBuGG/+5o9i2So9iBcpqQcNxJihLr0puuuflb98NkTIprJDR4xu0bpHYxi
X-Gm-Message-State: AOJu0YzxZH6roLCR7ihjvPulzYcKDM2ss3xsa87DIUWRH4yZTBn9L78A
	y25rSNcnLFA/1V/Fh2ELtsQga4jX+ujNH+Rj39I4HJ26QvL0pcI7vhxeVJnyMrgSJ0Vbf/C9JcB
	yMjLLk3CB3YUnl1lOPSDwg79mtGJA5wjuePXHTcU/WsODqvpiU73FtFBkyQhn+g==
X-Received: by 2002:a5e:c80a:0:b0:7c7:b1e4:50b with SMTP id y10-20020a5ec80a000000b007c7b1e4050bmr288976iol.13.1709244249614;
        Thu, 29 Feb 2024 14:04:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEj18l3oxXB3QTSfTU/vUmW9+aA3E/E9I3F9nYwIu/isQya1T/o6ucp9pWRYhN/op7hidf3DQ==
X-Received: by 2002:a5e:c80a:0:b0:7c7:b1e4:50b with SMTP id y10-20020a5ec80a000000b007c7b1e4050bmr288958iol.13.1709244249267;
        Thu, 29 Feb 2024 14:04:09 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id bv11-20020a056638448b00b004713170def2sm512021jab.93.2024.02.29.14.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 14:04:08 -0800 (PST)
Date: Thu, 29 Feb 2024 15:04:06 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Yisheng Xie <ethan.xys@linux.alibaba.com>, akpm@linux-foundation.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] vfio/type1: unpin PageReserved page
Message-ID: <20240229150406.4d41db01.alex.williamson@redhat.com>
In-Reply-To: <20240227132556.17e87767.alex.williamson@redhat.com>
References: <20240226160106.24222-1-ethan.xys@linux.alibaba.com>
	<20240226091438.1fc37957.alex.williamson@redhat.com>
	<e10ace3f-78d3-4843-8028-a0e1cd107c15@linux.alibaba.com>
	<20240226103238.75ad4b24.alex.williamson@redhat.com>
	<abb00aef-378c-481a-a885-327a99aa7b09@redhat.com>
	<20240227132556.17e87767.alex.williamson@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Feb 2024 13:25:56 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Tue, 27 Feb 2024 11:27:08 +0100
> David Hildenbrand <david@redhat.com> wrote:
>=20
> > On 26.02.24 18:32, Alex Williamson wrote: =20
> > > On Tue, 27 Feb 2024 01:14:54 +0800
> > > Yisheng Xie <ethan.xys@linux.alibaba.com> wrote:
> > >    =20
> > >> =E5=9C=A8 2024/2/27 00:14, Alex Williamson =E5=86=99=E9=81=93:   =20
> > >>> On Tue, 27 Feb 2024 00:01:06 +0800
> > >>> Yisheng Xie<ethan.xys@linux.alibaba.com>  wrote:
> > >>>      =20
> > >>>> We meet a warning as following:
> > >>>>    WARNING: CPU: 99 PID: 1766859 at mm/gup.c:209 try_grab_page.par=
t.0+0xe8/0x1b0
> > >>>>    CPU: 99 PID: 1766859 Comm: qemu-kvm Kdump: loaded Tainted: GOE =
 5.10.134-008.2.x86_64 #1   =20
> > >>>                                                                    =
  ^^^^^^^^
> > >>>
> > >>> Does this issue reproduce on mainline?  Thanks,   =20
> > >>
> > >> I have check the code of mainline, the logical seems the same as my
> > >> version.
> > >>
> > >> so I think it can reproduce if i understand correctly.   =20
> > >=20
> > > I obviously can't speak to what's in your 5.10.134-008.2 kernel, but I
> > > do know there's a very similar issue resolved in v6.0 mainline and
> > > included in v5.10.146 of the stable tree.  Please test.  Thanks,   =20
> >=20
> > This commit, to be precise:
> >=20
> > commit 873aefb376bbc0ed1dd2381ea1d6ec88106fdbd4
> > Author: Alex Williamson <alex.williamson@redhat.com>
> > Date:   Mon Aug 29 21:05:40 2022 -0600
> >=20
> >      vfio/type1: Unpin zero pages
> >     =20
> >      There's currently a reference count leak on the zero page.  We inc=
rement
> >      the reference via pin_user_pages_remote(), but the page is later h=
andled
> >      as an invalid/reserved page, therefore it's not accounted against =
the
> >      user and not unpinned by our put_pfn().
> >     =20
> >      Introducing special zero page handling in put_pfn() would resolve =
the
> >      leak, but without accounting of the zero page, a single user could
> >      still create enough mappings to generate a reference count overflo=
w.
> >     =20
> >      The zero page is always resident, so for our purposes there's no r=
eason
> >      to keep it pinned.  Therefore, add a loop to walk pages returned f=
rom
> >      pin_user_pages_remote() and unpin any zero pages.
> >=20
> >=20
> > BUT
> >=20
> > in the meantime, we also have
> >=20
> > commit c8070b78751955e59b42457b974bea4a4fe00187
> > Author: David Howells <dhowells@redhat.com>
> > Date:   Fri May 26 22:41:40 2023 +0100
> >=20
> >      mm: Don't pin ZERO_PAGE in pin_user_pages()
> >     =20
> >      Make pin_user_pages*() leave a ZERO_PAGE unpinned if it extracts a=
 pointer
> >      to it from the page tables and make unpin_user_page*() correspondi=
ngly
> >      ignore a ZERO_PAGE when unpinning.  We don't want to risk overrunn=
ing a
> >      zero page's refcount as we're only allowed ~2 million pins on it -
> >      something that userspace can conceivably trigger.
> >     =20
> >      Add a pair of functions to test whether a page or a folio is a ZER=
O_PAGE.
> >=20
> >=20
> > So the unpin_user_page_* won't do anything with the shared zeropage.
> >=20
> > (likely, we could revert 873aefb376bbc0ed1dd2381ea1d6ec88106fdbd4) =20
>=20
>=20
> Yes, according to the commit log it seems like the unpin is now just
> wasted work since v6.5.  Thanks!

I dusted off an old unit test for mapping the zeropage through vfio and
started working on posting a revert for 873aefb376bb but I actually
found that this appears to be resolved even before c8070b787519.  I
bisected it to:

commit 84209e87c6963f928194a890399e24e8ad299db1
Author: David Hildenbrand <david@redhat.com>
Date:   Wed Nov 16 11:26:48 2022 +0100

    mm/gup: reliable R/O long-term pinning in COW mappings
   =20
    We already support reliable R/O pinning of anonymous memory.
    However, assume we end up pinning (R/O long-term) a pagecache page
    or the shared zeropage inside a writable private ("COW") mapping.
    The next write access will trigger a write-fault and replace the
    pinned page by an exclusive anonymous page in the process page
    tables to break COW: the pinned page no longer corresponds to the
    page mapped into the process' page table.=20
    Now that FAULT_FLAG_UNSHARE can break COW on anything mapped into a
    COW mapping, let's properly break COW first before R/O long-term
    pinning something that's not an exclusive anon page inside a COW
    mapping. FAULT_FLAG_UNSHARE will break COW and map an exclusive
    anon page instead that can get pinned safely.
   =20
    With this change, we can stop using FOLL_FORCE|FOLL_WRITE for
    reliable R/O long-term pinning in COW mappings.

[...]

    Note 3: For users that use FOLL_LONGTERM right now without
    FOLL_WRITE, such as VFIO, we'd now no longer pin the shared
    zeropage. Instead, we'd populate exclusive anon pages that we can
    pin. There was a concern that this could affect the memlock limit
    of existing setups.

    For example, a VM running with VFIO could run into the memlock
    limit and fail to run. However, we essentially had the same
    behavior already in commit 17839856fd58 ("gup: document and work
    around "COW can break either way" issue") which got merged into
    some enterprise distros, and there were not any such complaints. So
    most probably, we're fine.

IIUC, c8070b787519 fixes that we can no longer run up the refcount on
the zeropage but with the above we're no longer using the zeropage
anyway.  I also confirm that after your commit above, my unit test that
previously triggered this with a read-only, anonymous mmap generates no
unpin hits in the vfio loop.

Anyway, all that to say that I think we're doubly covered that removing
the heinous workaround in vfio is overdue.  Thanks,

Alex


