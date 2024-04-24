Return-Path: <linux-kernel+bounces-156198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816DF8AFF18
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D1C1C223E6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E441448D4;
	Wed, 24 Apr 2024 03:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ld+syGfV"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C13613D619
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 03:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713927899; cv=none; b=DuEk4aOk8UC88V1CGNan4kxiVhVJI5YplhCEDF9btzbmbg9MH7YOSo/k+bckxzqXxSRWtXAlEDbTx+L/8o3w8DekooRhIMt4fzEOtmfz5Mo2v7KjxZNeZbIchtn8gtKPZXcv9M/SiRAwS+Xk/DvfukvaGSjBrTqvyi7xsyOx81w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713927899; c=relaxed/simple;
	bh=R1jmTxIBV5+sVaAK4eRBOf1ydKoXFUJi+Y0I1HTFRhg=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=CCkk0CvMWwulHzgKuPnPr5XDGLnPoH/PssGRWIDb1pvU5+qFvQ4uW3v7LNMiWVQoMf/B/cN+NHM4+SDBy7dIYBXD0H3bVYfum/Pp6BeUO+lyGRc+8lZYrGzFnpBMF8rV/Q5R4iDG7+nJDRMzGh20ynySr3IWYyaDnNXh30rd8eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ld+syGfV; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713927894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Q8EGvUA4lu8esD47DBLZ4CU9GgawJRaGEeylxgCNGE=;
	b=ld+syGfVgjrpi0pZbQafZs11J2riKDoHegikuLS+sp6Foh/YO2ebEa+OCB0K9SmN6kVKRe
	SAD5AEzXDi2tyRZW/7usHayuh76Ffo2zU/GItL6dmC+cznmpf0TbbIaPlk0AFAqZD7xNyP
	kIJLd+IEOfE/2HD8/zJmX3u/FaKvEVQ=
Date: Wed, 24 Apr 2024 03:04:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <e9c442bef63af1fab9f7630b41803aebf3c2b079@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] mm/rmap: remove unnecessary page_table_lock
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: "David Hildenbrand" <david@redhat.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <3v6xmyzmnw6go45riwlu7qv4c4phiexpqxldnlbgwsjhppe4oi@xdcqm4xupl4k>
References: <20240422105212.1485788-1-yajun.deng@linux.dev>
 <b848c431-deca-42e4-925c-673b3fa1f251@redhat.com>
 <3c452d5db5b3d5879160ab62a9e0ac4481a6298a@linux.dev>
 <fd7fde90-21ea-4617-be17-ba387b44feaf@redhat.com>
 <b6ea1fb5bc6c06d2855e41b4034656b0a76b58f5@linux.dev>
 <3v6xmyzmnw6go45riwlu7qv4c4phiexpqxldnlbgwsjhppe4oi@xdcqm4xupl4k>
X-Migadu-Flow: FLOW_OUT

April 24, 2024 at 1:11 AM, "Liam R. Howlett" <Liam.Howlett@oracle.com> wr=
ote:



>=20
>=20* Yajun Deng <yajun.deng@linux.dev> [240423 04:35]:
>=20
>=20>=20
>=20> April 23, 2024 at 4:18 PM, "David Hildenbrand" <david@redhat.com> w=
rote:
> >=20
>=20>=20=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>  On 23.04.24 09:53, Yajun Deng wrote:
> >=20
>=20>=20=20
>=20>=20
>=20>  >=20
>=20>=20
>=20>  > April 22, 2024 at 7:24 PM, "David Hildenbrand" <david@redhat.com=
> wrote:
> >=20
>=20>  >=20
>=20>=20
>=20>  > > >>
> >=20
>=20>  >=20
>=20>=20
>=20>  > >=20
>=20>=20
>=20>  > > On 22.04.24 12:52, Yajun Deng wrote:
> >=20
>=20>  > >=20
>=20>=20
>=20>  >=20
>=20>=20
>=20>  > page_table_lock is a lock that for page table, we won't change p=
age
> >=20
>=20>  >=20
>=20>=20
>=20>  > table in __anon_vma_prepare(). As we can see, it works well in
> >=20
>=20>  >=20
>=20>=20
>=20>  > anon_vma_clone(). They do the same operation.
> >=20
>=20>  >=20
>=20>=20
>=20>  > >=20
>=20>=20
>=20>  > > We are reusing mm->page_table_lock to serialize, not the *actu=
al* low-level page table locks that really protect PTEs.
> >=20
>=20>  > >=20
>=20>=20
>=20>  > > With that locking gone, there would be nothing protection vma-=
>anon_vma.
> >=20
>=20>  > >=20
>=20>=20
>=20>  > > Note that anon_vma_clone() is likely called with the mmap_lock=
 held in write mode, which is not the case for __anon_vma_prepare() ...
> >=20
>=20>  > >=20
>=20>=20
>=20>  >=20
>=20>=20
>=20>  > Yes, anon_vma_clone() is called with the mmap_lock held. I added=
 mmap_assert_write_locked(dst->vm_mm) to prove it.
> >=20
>=20>  >=20
>=20>=20
>=20>  > I added mmap_assert_write_locked(vma->vm_mm) in __anon_vma_prepa=
re() at the same time, it shows __anon_vma_prepare()
> >=20
>=20>  >=20
>=20>=20
>=20>  > is also called with the mmap_lock held too.
> >=20
>=20>  >=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>  Make sure you actually have lockdep built in and enabled.
> >=20
>=20>=20=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>  This is my config.
> >=20
>=20>  CONFIG_LOCKDEP=3Dn
> >=20
>=20>  CONFIG_DEBUG_VM=3Dy
> >=20
>=20>=20=20
>=20>=20
>=20>  I did another test.
> >=20
>=20>  I put mmap_assert_write_locked(mm) before 'set_bit(MMF_OOM_SKIP, &=
mm->flags)' in mmap.c, it's outside the lock.
> >=20
>=20>  It will crash when on boot. I think mmap_assert_write_locked() wor=
ks.
> >=20
>=20
> If you are changing locks, then please test with lockdep on.
>=20

It's=20my fault. It shows a warning with lockdep on.

> >=20
>=20> __anon_vma_prepare() is for example called from do_anonymous_page()=
 where we might only hold the mmap_lock in read mode (or not at all IIRC =
with VMA in read mode).
> >=20
>=20
> Consider two concurrent readers getting to this function with the same
>=20
>=20vma. There is no mergeable anon vma, so both create a new anon_vma.
>=20
>=20You take the anon_vma lock to parallelize the linking to the vma - bu=
t
>=20
>=20they are different locks because they are both new anon_vma structs
>=20
>=20allocated by concurrent readers.
>=20
>=20You now need a lock that you know cannot allow this to happen. Lookin=
g
>=20
>=20at the top of mm/rmap.c and see which one works. The next in line is
>=20
>=20the page table lock, so that one is used here.
>=20
>=20What if we reverse the locks? We can deadlock.
>=20
>=20What if we don't take the anon_vma lock? We can have two writers to t=
he
>=20
>=20anon_vma.
>=20
>=20Thanks,
>=20
>=20Liam
>

