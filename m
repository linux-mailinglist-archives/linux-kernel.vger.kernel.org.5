Return-Path: <linux-kernel+bounces-142892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 913FD8A31B7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C292F1C22693
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D9C1474C8;
	Fri, 12 Apr 2024 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpWWGjpD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9FE7580A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934054; cv=none; b=JW+BPoNJiGCgpRsF4DTy3NlBj1/tGUy4hfpW7WSbBTcHLCskr3f+4JNiM8ba0IlonEUH1bTvNok026xf9WcFfuzsI2gjqtdTdoO/PH6DAT4NvwZ325VbqMiy0kBphtj/snnv5et1MnvEYMsMb6aET7HDjJebCCkDdHLXon03J7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934054; c=relaxed/simple;
	bh=1MuMi1vh0lrfs6h1GE5QwkvsnWjbzX6TLFMvjeXdZRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VybPYII6aViQ1mJ54PlRMSJwuhIAemX+H6UrNP7h3bul1y8lVFfBU2re/iWfUzpBtWjSraY9YrMiCOIDycJshIP3qS2XA/1INus5aw4Qx1JkVSQkNivM631BuObQTpcmNjwyurVDFL6yIN9gzby6+QxXntO+zzIo3RKPbqHJKvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpWWGjpD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E665C113CC
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 15:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712934054;
	bh=1MuMi1vh0lrfs6h1GE5QwkvsnWjbzX6TLFMvjeXdZRY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fpWWGjpDoc6m1ip0RX/5GESYrEud/pEarsCr75sn1Nj3Vj1qVkv9Y/V80t5nZUXe8
	 81PyJcrYlzWSCgalJCgiJ3dy1VhfePUAiXX/MJ84q8AugoY2ulCYkW7L05681BuDKH
	 JMqS6oEYihx+/u5gF3P9cIIj6CC8857bHy/OonoNh8bWZnL0mRuR9KEv1K25pUHkRQ
	 w9QZZn2oO+BN5MeykrOMY08M5EIBsH7Zy44sx6BSEjGJSNEDT12WgsqvWqXhHrbBfN
	 nSv+CmII2bB4QIko5WTClrKYfYMp25YyRTab3MRsFmh+GPa+2CnvdYB6uraXiHLUsu
	 EiQfx3942CuOQ==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d88a869ce6so11144581fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:00:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDhkv01Zt2Rw7DdeD5lX8lgc/8SsM77HEVPLlIhrOYmHZMbmnl0wxoPCzYbhh8RRvtTgNY2oUho/RwTyVdlXTXulT6Ar1Drj2fxRGa
X-Gm-Message-State: AOJu0YzWl+elDBajbAKdSQ0tKgN9eqvJIggduni6b0Y6JV9D/BhFxbZt
	G46W++Gc6aSz3yx2eTeB28ap+yeXb1Xxjy9tBCODj+5NU3Am9WamiArsPae/PKKVgS1vCNXgoUb
	JvoANVVCnOOiodnhIwiyRNn+l+R0=
X-Google-Smtp-Source: AGHT+IHxTx16v9tPM61RkUoRAR5d5paORO7ps+olhcTMJQkAAoySPzUCT3jXV44xr0okZQ1iF/Gasyxmb6mogZMJDEg=
X-Received: by 2002:a2e:9984:0:b0:2d7:17e0:ff56 with SMTP id
 w4-20020a2e9984000000b002d717e0ff56mr2255453lji.18.1712934052562; Fri, 12 Apr
 2024 08:00:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412131908.433043-1-ryan.roberts@arm.com>
In-Reply-To: <20240412131908.433043-1-ryan.roberts@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 12 Apr 2024 17:00:41 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEo_t4hgm=jax-0soCCoq6ev-FqMMjU5iXqn06mpUH6+g@mail.gmail.com>
Message-ID: <CAMj1kXEo_t4hgm=jax-0soCCoq6ev-FqMMjU5iXqn06mpUH6+g@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Speed up boot with faster linear map creation
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, David Hildenbrand <david@redhat.com>, 
	Donald Dutile <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Apr 2024 at 15:19, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> Hi All,
>
> It turns out that creating the linear map can take a significant proportion of
> the total boot time, especially when rodata=full. And most of the time is spent
> waiting on superfluous tlb invalidation and memory barriers. This series reworks
> the kernel pgtable generation code to significantly reduce the number of those
> TLBIs, ISBs and DSBs. See each patch for details.
>
> The below shows the execution time of map_mem() across a couple of different
> systems with different RAM configurations. We measure after applying each patch
> and show the improvement relative to base (v6.9-rc2):
>
>                | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere Altra
>                | VM, 16G     | VM, 64G     | VM, 256G    | Metal, 512G
> ---------------|-------------|-------------|-------------|-------------
>                |   ms    (%) |   ms    (%) |   ms    (%) |    ms    (%)
> ---------------|-------------|-------------|-------------|-------------
> base           |  168   (0%) | 2198   (0%) | 8644   (0%) | 17447   (0%)
> no-cont-remap  |   78 (-53%) |  435 (-80%) | 1723 (-80%) |  3779 (-78%)
> batch-barriers |   11 (-93%) |  161 (-93%) |  656 (-92%) |  1654 (-91%)
> no-alloc-remap |   10 (-94%) |  104 (-95%) |  438 (-95%) |  1223 (-93%)
>
> This series applies on top of v6.9-rc2. All mm selftests pass. I've compile and
> boot tested various PAGE_SIZE and VA size configs.
..
>
> Ryan Roberts (3):
>   arm64: mm: Don't remap pgtables per-cont(pte|pmd) block
>   arm64: mm: Batch dsb and isb when populating pgtables
>   arm64: mm: Don't remap pgtables for allocate vs populate
>

For the series,

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

