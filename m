Return-Path: <linux-kernel+bounces-121579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B4288EA4B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8688AB2D224
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBAA12DDAF;
	Wed, 27 Mar 2024 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZrQJifP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C754F890
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555089; cv=none; b=bTzGGsdQj5Nh1IDtijLjPshC9C44NiCxh1AIysNPXcCFQo2DnDdgWMfNn9Fq5v5P8BdjHgB7gYzFMPpGvQbVE1PJMllJ0bFDpjCn4dlJUu2/7Xu2o55dyBvrV072AWRJXTKaSaL9t7gOdKpU/0uD5nhbCh0VLSiRYRJenfQWj2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555089; c=relaxed/simple;
	bh=HNMz2aWlmehG41cOCB1cvONMDtg23aN/Dbw96CBAx9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IfdiUevo0iAJGwEST6wfd/yAE3bpZfPoXT14tw9hVYvZnZ0skmLnkM5IIG5DkkoWSPjlCoZGJQhxbz0lPoBlD8OovJII9A5CB5fYMwt6mAi3vUVunwxUqy/TuSAxAOs9NOAKRomPKlSeLDjOGL1DdZNO1Fu1730pG+V4IQK3DeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZrQJifP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0639EC433F1
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711555089;
	bh=HNMz2aWlmehG41cOCB1cvONMDtg23aN/Dbw96CBAx9A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NZrQJifPMMyA5hKKh2Hcx2KLYYuoN3aDm6QSEyeDB1ejV87RlOVGLGpBQRwofEp/N
	 +tu0Xx20i4GFn+2n3RD6tMPVl1MlPKgpBbNtKz4MjIvm4cxHP7nZc1F/eo776Fwu92
	 iVjw0N+VKKmGriQiKcC+r7m3m7VuzrB5Xxkcjy2QHXCFpLIJkUmwi6vXXppdP7cpIQ
	 MxH804AdTe4RKY7YN3lxgO1PchQ6Po6SYWITYrDaY5q01htVPJwFg0HxI6bpxT8mqE
	 P2cTPhXROouH1Doee82D8xPjUU+LSw5Cf4Tnf6NkEk2JAL675denshpeljWN3Cr/wJ
	 SWl6Su/blIbXA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-515b3077d09so2603105e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:58:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYoYgqybgsR7C1jVEs8nWH5HDvm4rbNV/njy52bS5Ex/ldlt1+m0JW+96WUZ/iD+vYRZ8gRN7HARKPIKi5vykRzDq4Q/LGlfvatUKA
X-Gm-Message-State: AOJu0YzOu4m5AXO16bZfhaP+Yser3e+wVmWRqw9B1N3ZKtj5XmOhKl6o
	C84F0+7dil+FeBs8TOBAhKo0FCh3SvYvSK2DRMDvNkTXVtrt81w9O3s4+7qZbczATsd50Vno48N
	Fo1DAOLNCJWmVJCi5m6K7PLMHano=
X-Google-Smtp-Source: AGHT+IG/Uw55ZKqvrsoFxvPLi09AXqfe8sO16NwSTCXvP//bM3HxdO+WBuC3WtWfxiMdd4VNsdhmX4/G5C+3gtcciTw=
X-Received: by 2002:ac2:4d9a:0:b0:515:95cd:68a9 with SMTP id
 g26-20020ac24d9a000000b0051595cd68a9mr1435049lfe.24.1711555087376; Wed, 27
 Mar 2024 08:58:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326101448.3453626-1-ryan.roberts@arm.com>
 <CAMj1kXEEi2ZXs+1qwR97zod5Z+TerPKcKZBN8LGZ5XTRV0_-rg@mail.gmail.com>
 <e1078fe2-0b0b-48c6-8d24-3b2e835201b1@arm.com> <CAMj1kXGtNYce5cOwUc+X5ceyxLGzD1xUEx7JRXqg7+4XQMAORw@mail.gmail.com>
 <7f69758c-b849-48ca-b279-569469183e91@arm.com>
In-Reply-To: <7f69758c-b849-48ca-b279-569469183e91@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 27 Mar 2024 17:57:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGVNWrm6=sWixL3PiXr1DQN_buvm1YxQW2+zALgd3b-hA@mail.gmail.com>
Message-ID: <CAMj1kXGVNWrm6=sWixL3PiXr1DQN_buvm1YxQW2+zALgd3b-hA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Speed up boot with faster linear map creation
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, David Hildenbrand <david@redhat.com>, 
	Donald Dutile <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Mar 2024 at 17:01, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> On 27/03/2024 13:36, Ard Biesheuvel wrote:
> > On Wed, 27 Mar 2024 at 12:43, Ryan Roberts <ryan.roberts@arm.com> wrote:
> >>
> >> On 27/03/2024 10:09, Ard Biesheuvel wrote:
..
> >
> > I think a mix of the fixmap approach with a 1:1 map could work here:
> > - use TTBR0 to create a temp 1:1 map of DRAM
> > - map page tables lazily as they are allocated but using a coarse mapping
> > - avoid all TLB maintenance except at the end when tearing down the 1:1 mapping.
>
> Yes that could work I think. So to make sure I've understood:
>
>  - create a 1:1 map for all of DRAM using block and cont mappings where possible
>      - use memblock_phys_alloc_*() to allocate pgtable memory
>      - access via fixmap (should be minimal due to block mappings)

Yes but you'd only need the fixmap for pages that are not in the 1:1
map yet, so after an initial ramp up you wouldn't need it at all,
assuming locality of memblock allocations and the use of PMD mappings.
The only tricky thing here is ensuring that we are not mapping memory
that we shouldn't be touching.

>  - install it in TTBR0
>  - create all the swapper mappings as normal (no block or cont mappings)
>      - use memblock_phys_alloc_*() to alloc pgtable memory
>      - phys address is also virtual address due to installed 1:1 map
>  - Remove 1:1 map from TTBR0
>  - memblock_phys_free() all the memory associated with 1:1 map
>

Indeed.

> That sounds doable on top of the first 2 patches in this series - I'll have a
> crack. The only missing piece is depth-first 1:1 map traversal to free the
> tables. I'm guessing something already exists that I can repurpose?
>

Not that I am aware of, but that doesn't sound too complicated.

