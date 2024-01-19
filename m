Return-Path: <linux-kernel+bounces-31175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C572832A23
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B00D31C23155
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B4A524BE;
	Fri, 19 Jan 2024 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OuUH4I/E"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D263C680
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705669944; cv=none; b=Xr7ZLfCWOhJi6EqzIHC1xQuvJHXWQoup9zAjZTdp4VbEiuMj/r8/5KjPoYqSoIDinP5MdmMo3hV6QwSOwh3j/ZTUi+4ZO2BGKadAizDatf1K42shOXMYJkrod531ZVg6ToQwOGgQqFgYoM5AQ8VRXkjespFOKHp/urFkZbkhr7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705669944; c=relaxed/simple;
	bh=Ib20zY68P2ii/G09SSPsak2hYrVP9F1ZwDcarzVgh9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4KReerHGPTWdoruiM/usqgNHwHviGtPjBBW5SBf0fps//AKYNtiXkXVh2ntGHDz8Jdj/8Y7FlqUJ51g1TPL6+NLUVe8NjxXDAIG+lr5pSOKR1dU1oO/8JLqOInGgNaLd9E8w59WiXZBa5K35ZISIkLgUoOEszVcHSMa1oGdYAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OuUH4I/E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705669941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vi/ghrBJ2abck4Wwi0h7DJOTr7ObAnQ+55jlxgP3HjA=;
	b=OuUH4I/ElixPlLjwG0toH+dcDBtPYPdQ2h+bZSbS7NLVtPUq5bZuPE6LGFWVAu6KwU6b0D
	GO4+xD+hQe5H3v8SpzkQFgVtyCHoCV/YNkBNQXHYaLYk/x1fA+cBIqDdzeAGRtN+xYr6bc
	artYrVSH6fwOYafBDEy0z4wJA+YAgY4=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-IVlo97J6N0i4a8b_XZ-HPA-1; Fri, 19 Jan 2024 08:12:20 -0500
X-MC-Unique: IVlo97J6N0i4a8b_XZ-HPA-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-5ffa2bb4810so3804817b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 05:12:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705669939; x=1706274739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vi/ghrBJ2abck4Wwi0h7DJOTr7ObAnQ+55jlxgP3HjA=;
        b=DTkpEAz25c92u9Tt9x8YTS+5HSUaoQY1xH3nv7pBWvrXl+qi7LwdENtUSND8dL3+IF
         xTJvtE5Q8wLBb7SqwASg8Q69iQInwKy07S31n/hZXCXqSQPtOm15q5WOgxU5ajt2UJAb
         pCv/pbZwW4makKqRqSQjrUY+rkTlGSHWrRuHgCRMwOgAlwV+uXOIEvq24vpl/hpCkIxI
         qUVE8M/lq5DDFo/kIglk3FYgvFH9pAkUMkP82PVoeud/L4xWqmkSqMNtDYWVW1iQRFTY
         WjnJKjHkyiAcwklAHXsF9AGJjlqb4JMp1gj+6PQWIAIORffjqRLuJwrtWz/ty+p77eGU
         C8Fw==
X-Gm-Message-State: AOJu0Yyh2D3q9cNUrv7PVMw8g0Z1qR/QtKIvpkWnQMBK/QmipzrvS9jS
	MyOAH7rt0dpWsybjOyGZusd7eHYIdYh8XcaLJmn130t19MXRORqFspnZrdwcjMJ0MOVS4zPml0D
	BhW4Vvll8zV+phEoR2s0R/47L6tipbUb6ztXFxBMiuhoiQlCbzjNFJZT35c8mdNoBfez9hGU0Ij
	6mgnBmm84q9b21A8jkS04KGM2svAAilM6noJMlfmH9JN51
X-Received: by 2002:a0d:c645:0:b0:5ff:a425:d64c with SMTP id i66-20020a0dc645000000b005ffa425d64cmr315875ywd.81.1705669939706;
        Fri, 19 Jan 2024 05:12:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWU7V9Q1CXIQM2Ccn6r6qwMKr0viLEcFyZjGJWi2COiELrL6Ao+cdsiwQaNT8Dcq5w8OWMxHAZin/mrp2Jjac=
X-Received: by 2002:a0d:c645:0:b0:5ff:a425:d64c with SMTP id
 i66-20020a0dc645000000b005ffa425d64cmr315869ywd.81.1705669939501; Fri, 19 Jan
 2024 05:12:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119125753.152354-1-npache@redhat.com>
In-Reply-To: <20240119125753.152354-1-npache@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Fri, 19 Jan 2024 06:11:53 -0700
Message-ID: <CAA1CXcD55JLQfpW8OzzfHsyaVX5cJHO-y7v8miRyL1t3fnejqg@mail.gmail.com>
Subject: Re: [PATCH] selftests: mm: fix map_hugetlb failure on 64K page size systems
To: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org
Cc: akpm@linux-foundation.org, shuah@kernel.org, donettom@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

NACK.

I accidentally sent an older version of this patch. Following up with V2.

On Fri, Jan 19, 2024 at 5:58=E2=80=AFAM Nico Pache <npache@redhat.com> wrot=
e:
>
> On systems with 64k page size and 512M huge page sizes, the allocation
> and test succeeds but errors out at the munmap. As the comment states,
> munmap will failure if its not HUGEPAGE aligned. This is due to the
> length of the mapping being 1/2 the size of the hugepage causing the
> munmap to not be hugepage aligned. Fix this by making the mapping length
> the full hugepage if the hugepage is larger than the length of the
> mapping.
>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  tools/testing/selftests/mm/map_hugetlb.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/testing/selftests/mm/map_hugetlb.c b/tools/testing/sel=
ftests/mm/map_hugetlb.c
> index 193281560b61..dcb8095fcd45 100644
> --- a/tools/testing/selftests/mm/map_hugetlb.c
> +++ b/tools/testing/selftests/mm/map_hugetlb.c
> @@ -58,10 +58,16 @@ int main(int argc, char **argv)
>  {
>         void *addr;
>         int ret;
> +       size_t maplength;
>         size_t length =3D LENGTH;
>         int flags =3D FLAGS;
>         int shift =3D 0;
>
> +       maplength =3D default_huge_page_size();
> +       /* mmap with fail if the length is not page */
> +       if (maplength > length)
> +               length =3D maplength;
> +
>         if (argc > 1)
>                 length =3D atol(argv[1]) << 20;
>         if (argc > 2) {
> --
> 2.43.0
>


