Return-Path: <linux-kernel+bounces-154696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874D18ADFD9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94FF1C22705
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E77524A6;
	Tue, 23 Apr 2024 08:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DJ+CfAEc"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F5D320E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861310; cv=none; b=rajDJ9eRw/F5W+R/V5ItpU0t2DFgow4/m1T4lpqZfpolKZlGvz38FBdyCIqQu5t3uRqR3ZCqss/27r/45ctXiupZlXopTbf/6ag5ZtFtqvXmNNEKQc8l+oaLQ3lkZv11qGCu0PsO3Kzhfixo7pZeC0+9L7PzDlwauGz6AccNnF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861310; c=relaxed/simple;
	bh=JvAVTujgcuiw/0tR/hMqo55xPe+4zmGUHWSlxH3z/Bg=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=dr2ThAn+ooLDihL2ytBKhyZRlfkfuXwT3ugkZXpC6pMfcA7kg5zQWtzmpMrZNNQ1mIt8Oxz25AJJyXLv6X75ltGfg4J4LWLXBcnsbvVcbWpI5a0/SoCKs7+l8Pq6ZjMSg0afoEYFs4x/qtbm2xrx0h7pg3J+/qzBzKykzqYfaRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DJ+CfAEc; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713861306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4cVFQdnmZhnHQm7CDK2o2kagEKgCqmKyp5VX7FCc9Es=;
	b=DJ+CfAEcJNuA1bAj859OhU82Ws9DC+hNpzlw2XJHNSNAUzgK1FpRl6IfxcBKbotBqA+/ds
	5iT0VkQyA6COHG7S1ExJ5axG41jighibwYoLxAhZN6Myz6AV/toYbtxYbZZIp3fK7DS3vo
	B8rtbFNiB56JI7l9noA+O1riUaC3LxI=
Date: Tue, 23 Apr 2024 08:35:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <b6ea1fb5bc6c06d2855e41b4034656b0a76b58f5@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] mm/rmap: remove unnecessary page_table_lock
To: "David Hildenbrand" <david@redhat.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <fd7fde90-21ea-4617-be17-ba387b44feaf@redhat.com>
References: <20240422105212.1485788-1-yajun.deng@linux.dev>
 <b848c431-deca-42e4-925c-673b3fa1f251@redhat.com>
 <3c452d5db5b3d5879160ab62a9e0ac4481a6298a@linux.dev>
 <fd7fde90-21ea-4617-be17-ba387b44feaf@redhat.com>
X-Migadu-Flow: FLOW_OUT

April 23, 2024 at 4:18 PM, "David Hildenbrand" <david@redhat.com> wrote:



>=20
>=20On 23.04.24 09:53, Yajun Deng wrote:
>=20
>=20>=20
>=20> April 22, 2024 at 7:24 PM, "David Hildenbrand" <david@redhat.com> w=
rote:
> >=20
>=20>  > >>
> >=20
>=20> >=20
>=20> > On 22.04.24 12:52, Yajun Deng wrote:
> > >=20
>=20>=20
>=20>  page_table_lock is a lock that for page table, we won't change pag=
e
> >=20
>=20>  table in __anon_vma_prepare(). As we can see, it works well in
> >=20
>=20>  anon_vma_clone(). They do the same operation.
> >=20
>=20> >=20
>=20> > We are reusing mm->page_table_lock to serialize, not the *actual*=
 low-level page table locks that really protect PTEs.
> > >=20
>=20> >  With that locking gone, there would be nothing protection vma->a=
non_vma.
> > >=20
>=20> >  Note that anon_vma_clone() is likely called with the mmap_lock h=
eld in write mode, which is not the case for __anon_vma_prepare() ...
> > >=20
>=20>=20
>=20>  Yes, anon_vma_clone() is called with the mmap_lock held. I added m=
map_assert_write_locked(dst->vm_mm) to prove it.
> >=20
>=20>  I added mmap_assert_write_locked(vma->vm_mm) in __anon_vma_prepare=
() at the same time, it shows __anon_vma_prepare()
> >=20
>=20>  is also called with the mmap_lock held too.
> >=20
>=20
> Make sure you actually have lockdep built in and enabled.
>=20

This=20is my config.
CONFIG_LOCKDEP=3Dn
CONFIG_DEBUG_VM=3Dy

I did another test.
I put mmap_assert_write_locked(mm) before 'set_bit(MMF_OOM_SKIP, &mm->fla=
gs)' in mmap.c, it's outside the lock.
It will crash when on boot. I think mmap_assert_write_locked() works.


> __anon_vma_prepare() is for example called from do_anonymous_page() whe=
re we might only hold the mmap_lock in read mode (or not at all IIRC with=
 VMA in read mode).
>=20
>=20-- Cheers,
>=20
>=20David / dhildenb
>

