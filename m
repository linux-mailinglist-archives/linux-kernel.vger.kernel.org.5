Return-Path: <linux-kernel+bounces-33141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A7E836520
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A7E28DDEA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430DD3D396;
	Mon, 22 Jan 2024 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tm/N0MHP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6A420DF0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932559; cv=none; b=uIcSdoRK1mSv88ikzWJeKcjR873/7JLajwJENqpIn3/z+VcrT17dEFU/RjYsulWzhviRRGXk5lHDb1BDFGS2rj+pqvSl84TnReUibwxnX6Qw2jqkxhwsl7l/GkjfykOeIHu1W6D3q8Xv2IIRys+cYW8jyqR1JIpOAia9LwiUlCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932559; c=relaxed/simple;
	bh=znrIct7rUFWksSd+UC6un02EtdkHnndXakyNpVQ9a5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hs7FJG+LsR2LWUbIGczj7JpaMeR7HSLDS3Cj5eymsNcJnNZyfa1Qb7RTk4HJcwGq356FY2UeVNIllOy9Ze7+lnDLpjUbYAcgwZ7sS6kXdOgMvMQzU2uH7anL2tisqHH9D8aCU8tM28lz7v1dlAePTbL1peQLPSVj3JZ1HAtOwro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tm/N0MHP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705932556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=seqmVAFBDnuLvzwL3rN06iKmJlHsjwn1tq37k8ac87U=;
	b=Tm/N0MHP1bRE93JiRT5A9fkwKpBLB4OFKQs8W7npKkfgf2htGYMjWRJSlR8K/PDacSD8SB
	wtPntu6lHNrLR1IeGKZ0LtbA9LTtpuypbe4ty58q3w7zy14VnLe7q+eVezMDOSzu481Mdz
	sIrns0YR2KlliUfXy1ZV4HB5SM2RrCs=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-zdwixl2wNleA2iZVv0LN8Q-1; Mon, 22 Jan 2024 09:09:15 -0500
X-MC-Unique: zdwixl2wNleA2iZVv0LN8Q-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5f874219ff9so42977697b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 06:09:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705932554; x=1706537354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=seqmVAFBDnuLvzwL3rN06iKmJlHsjwn1tq37k8ac87U=;
        b=m06WdKEeCxA72R2uoybkBuKU1Zuz1s387JsSBPIaE7RadUCK/pXq8WrHUnkstkLlkG
         M2uvFVi2l/e7OZI0l258f9fvXK8w4oXV+ZikJOlHbxaTxOT2z7njMJusTGPW0YA0tszm
         fZH6dIf820a3zSAhLxrGU/Zp+UnelNkhOdVn/sXNSGui/0Clw5G1G/HQEdvfqeDVcirX
         7kqnbhG/utTh00vx/gEarqJM8xA8pu54W/2KKwEJD2WkAfSHDTX58PnVJXCEVd6KOAip
         TSGULDSlwZa38sZk3TKMy7WkQmLNJwFnGKuPklsjomnRgMIuyHT/4//rv/cmAsNTcDOS
         Xv7w==
X-Gm-Message-State: AOJu0YyRHfdtLYqXC5x/Oa7AkYCvDb6itPCGxwZ8AwSwSx5rudY9RyTn
	ukm15HEqgxYhdUhCeAWaB/waYzqxdvOLUWkuc4o3HtVZ3wS8pWrwl3UeawgXD1JXs+BB83P+5cU
	0UXN4BOwFMmOAKtGvPVkAWJ/EQvLRRayHeXLQTZzpZVztgxlmiGSbETUmwxREzmFu5LO1TTU5nc
	AbMq/6P0xPvO9jpTv//xPOfp0eeG9B0nnULDzH
X-Received: by 2002:a81:8411:0:b0:5ff:b07b:e534 with SMTP id u17-20020a818411000000b005ffb07be534mr1742477ywf.9.1705932554313;
        Mon, 22 Jan 2024 06:09:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5TYT+m+Db5kWU9mkYv5aX43/bLG4o8DXbKxjOnIgv6IVDOYqnnpHQAvVW5nvty8UP/kaTKK+uoXudOp0V9CI=
X-Received: by 2002:a81:8411:0:b0:5ff:b07b:e534 with SMTP id
 u17-20020a818411000000b005ffb07be534mr1742466ywf.9.1705932554072; Mon, 22 Jan
 2024 06:09:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119131429.172448-1-npache@redhat.com> <20240120203904.8f36140cd2f507b25e9a09a3@linux-foundation.org>
In-Reply-To: <20240120203904.8f36140cd2f507b25e9a09a3@linux-foundation.org>
From: Nico Pache <npache@redhat.com>
Date: Mon, 22 Jan 2024 07:08:48 -0700
Message-ID: <CAA1CXcANbz75MHKkJPEVa8AJBX4g8k7kq8i0ZCe9w_j9Oeg=ZA@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: mm: fix map_hugetlb failure on 64K page
 size systems
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, shuah@kernel.org, donettom@linux.vnet.ibm.com, 
	Christophe Leroy <christophe.leroy@c-s.fr>, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

No, I think it's always been broken-- I don't think the test was
written with 512M huge page sizes in mind.

-- Nico

On Sat, Jan 20, 2024 at 9:39=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri, 19 Jan 2024 06:14:29 -0700 Nico Pache <npache@redhat.com> wrote:
>
> > On systems with 64k page size and 512M huge page sizes, the allocation
> > and test succeeds but errors out at the munmap. As the comment states,
> > munmap will failure if its not HUGEPAGE aligned. This is due to the
> > length of the mapping being 1/2 the size of the hugepage causing the
> > munmap to not be hugepage aligned. Fix this by making the mapping lengt=
h
> > the full hugepage if the hugepage is larger than the length of the
> > mapping.
>
> Is
>
> Fixes: fa7b9a805c79 ("tools/selftest/vm: allow choosing mem size and page=
 size in map_hugetlb")
>
> a suitable Fixes: target for this?
>
> > --- a/tools/testing/selftests/mm/map_hugetlb.c
> > +++ b/tools/testing/selftests/mm/map_hugetlb.c
> > @@ -15,6 +15,7 @@
> >  #include <unistd.h>
> >  #include <sys/mman.h>
> >  #include <fcntl.h>
> > +#include "vm_util.h"
> >
> >  #define LENGTH (256UL*1024*1024)
> >  #define PROTECTION (PROT_READ | PROT_WRITE)
> > @@ -58,10 +59,16 @@ int main(int argc, char **argv)
> >  {
> >       void *addr;
> >       int ret;
> > +     size_t hugepage_size;
> >       size_t length =3D LENGTH;
> >       int flags =3D FLAGS;
> >       int shift =3D 0;
> >
> > +     hugepage_size =3D default_huge_page_size();
> > +     /* munmap with fail if the length is not page aligned */
> > +     if (hugepage_size > length)
> > +             length =3D hugepage_size;
> > +
> >       if (argc > 1)
> >               length =3D atol(argv[1]) << 20;
> >       if (argc > 2) {
> > --
> > 2.43.0
>


