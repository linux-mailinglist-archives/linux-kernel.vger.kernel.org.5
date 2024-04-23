Return-Path: <linux-kernel+bounces-154630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA768ADE9E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1051F23697
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9D1481D1;
	Tue, 23 Apr 2024 07:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p5g5M1/X"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F102946522
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 07:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713858811; cv=none; b=TQkuz3cpAQ7LUvwtJPdem0PRUTQReYOKN730q0loikw0HxWlx3hBroitxlsnVuFml4csFMq53+FIPj7x26Wl1Sb6M0QZ4QuT9r87/r0q4ukRjlXAbxewxrCi8tPnckhnvFoeY4wY4Oy+rKKYZbeyFEzO/hJqitQ6sCQlW9E2a9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713858811; c=relaxed/simple;
	bh=2uRvhIeBa7+qSWT0hhZnPL7Y55HU9vEDWEPpAdr2fHE=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=gx7UgMbtMLekl7wMo10HHwAUfF+oCwoyr+9PhhsUuKSRTUYAq29TNp89fZSNJgfKvdym8d81R9TAyNZXOHWF071uP5bJDFzpSGa4ELPCg9GbUEd4zDQVkN6E8gx9ZvqxgfP08o1K0owHMaCyRi26msaVM9kXVQyNeXGi3qY0Nhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p5g5M1/X; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713858807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjYIax7W2T2XC/0OrrkmBtCx2ko2ZCZN2ZtWHto1d7Y=;
	b=p5g5M1/XsEW7m/OL6Z0aOouGOrbnunRC+/rMqiD9Nj7fj+3x/IHod3cl1rRXE9b2Vz+moQ
	yIl5LP6231Hbpbb9vEHhea+RyvvvugTUuBQ5pj1kseX+E6255ZyXqa1sCcQPNBaxNJ1aU9
	pN67PtoralP8LZsc6GhxRuOmMkfipmM=
Date: Tue, 23 Apr 2024 07:53:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <3c452d5db5b3d5879160ab62a9e0ac4481a6298a@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] mm/rmap: remove unnecessary page_table_lock
To: "David Hildenbrand" <david@redhat.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <b848c431-deca-42e4-925c-673b3fa1f251@redhat.com>
References: <20240422105212.1485788-1-yajun.deng@linux.dev>
 <b848c431-deca-42e4-925c-673b3fa1f251@redhat.com>
X-Migadu-Flow: FLOW_OUT

April 22, 2024 at 7:24 PM, "David Hildenbrand" <david@redhat.com> wrote:



>=20
>=20On 22.04.24 12:52, Yajun Deng wrote:
>=20
>=20>=20
>=20> page_table_lock is a lock that for page table, we won't change page
> >=20
>=20>  table in __anon_vma_prepare(). As we can see, it works well in
> >=20
>=20>  anon_vma_clone(). They do the same operation.
> >=20
>=20
> We are reusing mm->page_table_lock to serialize, not the *actual* low-l=
evel page table locks that really protect PTEs.
>=20
>=20With that locking gone, there would be nothing protection vma->anon_v=
ma.
>=20
>=20Note that anon_vma_clone() is likely called with the mmap_lock held i=
n write mode, which is not the case for __anon_vma_prepare() ...

Yes, anon_vma_clone() is called with the mmap_lock held. I added mmap_ass=
ert_write_locked(dst->vm_mm) to prove it.
I added mmap_assert_write_locked(vma->vm_mm) in __anon_vma_prepare() at t=
he same time, it shows __anon_vma_prepare()
is also called with the mmap_lock held too.

>=20
>=20I think this change is wrong.
>=20
>=20-- Cheers,
>=20
>=20David / dhildenb
>

