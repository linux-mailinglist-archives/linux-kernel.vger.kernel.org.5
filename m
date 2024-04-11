Return-Path: <linux-kernel+bounces-139654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 207BD8A05D5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3421F23B2B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20168651AE;
	Thu, 11 Apr 2024 02:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="A2Sv4TKH"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CAC633FE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 02:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712802526; cv=none; b=fQL5DC6GHk9ZsLhsvAH+ZWITz206O5kfpkl6L/7nltoAdj1kATbfA106/8lwTOaBdiIf8f4D4923fsvuvmmw5cN961cwZHIh93PIZmQwuGcWtLZOMUvmn6h21J5Rd/y2g4oyOoqvrLtpmom9GJBtxlY8omCCLIIg+MBOdRK32m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712802526; c=relaxed/simple;
	bh=RZa5VrCYalte+N2warzKW3IpmB8jtSkkbR424BNjE4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RsPiGysumyqfUxQlDDFdtAHdN3XCYt+tU6AMmGGNfQK2ilkeQjqR7lZlp1199yow23/TLEBhWfWLfP81YVoXChCYndSAZrY8M6uQjmVDrRGjNcJqFPrpWZVAzIqo4iDXJgXrWUy11xP9AKudMFcbFyJWm+tc/OGExZRPqpiff0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=A2Sv4TKH; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-22edb0ca19bso3765928fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 19:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712802523; x=1713407323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZa5VrCYalte+N2warzKW3IpmB8jtSkkbR424BNjE4g=;
        b=A2Sv4TKHEpQAsrYbvV9YvOU/2YrhW7lolHRQkYojj45+eDCqJKjhhv0lxNAo+KFuLL
         jeE1fs8bFmxl+KDMdR/RVYEQ3UgeWw6Ce6uwfujy3312IH+meoANBDL02iaFkrDQwN+K
         tGCKdRvmoaZnJ4pPRbPUpXL955mwET7pMGB1rqbUGefX/3CIDjeKQCnKYd2l2w14vLgd
         Xl6H1p8tSFh5zBaDtRPXo0vkrZ14YoXDn9m1brRXghqYO677yvsyc3ItLK70/6ygqamc
         Yd5sbgqYTeW90kWmPvSBaavyO0RwcKg26234SAHL1u4MyaYHKS3EcWEbQiPnlSbAv1Pa
         ebKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712802523; x=1713407323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZa5VrCYalte+N2warzKW3IpmB8jtSkkbR424BNjE4g=;
        b=G9Kcub6suUmttWHDxwUb4jbPL5iO2c0vILhwDyOFSYPeFWSGCrHNH4ePv2Euh2Ta3q
         WPUxoDz6qYHKTjxxXUcWa7KbQr1Xqs/4N0+CqtXhghj+nUrJszIWPlPAO5YHaCv7zZ+2
         bVl2OQcF0S6BXh0kLCC0S/Y+4514uQEj2SjKabgSdwUl+z8wNG/vDNIQcyYTVXVge5v9
         cfHM2dU8KGOAkAKcVdzrcA+tzmm/wNVyzzyAxZc81Eit+RilDmCW95T3B9R025Mb2Ufz
         uhaG0mUQSP8HW0k6NnZlVCmUXNiWp0GRi1HWZ1knTtuFhDbGV4eyo3DdCIfgFB7X0Pn2
         RCbA==
X-Forwarded-Encrypted: i=1; AJvYcCV3RM/l1uwry07/4YN76q0oBsBzKp6H/WHtjTYP1glwlLhkFSzeDPutTgA5rIGOyEU40pBY8hwOfknHHjbSeFmt2LX4u/sz4ivrwEoh
X-Gm-Message-State: AOJu0Yx259GMvS4HSV2a3jWv8Bjk/uj+KGtTPYd7UWpL/hFReG3V4moX
	fbNy7G4ZdjhzvG87mGb0PV5ieCAzOPOIYIxzBEX2OfMubwKR94UD5KaUwFMkvovmN7qyjJ9mW09
	N7pBqcz8xIzMsU9kyAbACke10cyTVAQSXWWLmgQ==
X-Google-Smtp-Source: AGHT+IGL+36/5FAhSNT/qMIqi+3odc/2fts2wJ2UrUZ5w9uMu+P7IO7ZtKqknoIWdATGMtiRodslssOipgwfCl+ZbgU=
X-Received: by 2002:a05:6870:41cf:b0:22e:b2b4:f00b with SMTP id
 z15-20020a05687041cf00b0022eb2b4f00bmr4754613oac.39.1712802523483; Wed, 10
 Apr 2024 19:28:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407123829.36474-1-cuiyunhui@bytedance.com> <abd135fa-c432-4e37-9792-07a0e17e93d5@arm.com>
In-Reply-To: <abd135fa-c432-4e37-9792-07a0e17e93d5@arm.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 11 Apr 2024 10:28:32 +0800
Message-ID: <CAEEQ3w=+C2J0ZS227-1P-B+pe_NRp_3i4c4CxGssiKqbpXx_qw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/2] ACPI: PPTT: Populate cacheinfo
 entirely with PPTT
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeremy,

On Wed, Apr 10, 2024 at 9:30=E2=80=AFAM Jeremy Linton <jeremy.linton@arm.co=
m> wrote:
>
> Hi,
>
>
> First thanks for working on this.
>
> On 4/7/24 07:38, Yunhui Cui wrote:
> > When the type and level information of this_leaf cannot be obtained
> > from arch, cacheinfo is completely filled in with the content of PPTT.
>
> I started reviewing this, based on what I understood to be the need to
> generate the topology entirely from the PPTT. But, it was raising more
> questions than answers because the PPTT is far too flexable in its
> ability to represent cache hierachies that arn't logically useful. For
> example multiple I or D caches at the same level, or I or D caches
> higher in the topology than unified ones.
>
> At least for arm64 (and I think others) there is an understood
> simplification that there will be N levels of split I/D caches and M
> unified levels. And from that, the number of cache leaves are computed
> and allocated, and then we go in and largly skip PPTT cache nodes which
> don't make sense in view of a generic topology like that. (see the
> comment in cacheinfo.c:506)
>
> Both of those pieces of information are available in
> acpi_get_cache_info(). The missing part is marking those N levels of I/D
> cache as such.
>
> Looking at this code I don't really see all the error/allocation
> logic/etc that assures the cache leaf indexing is allocated correctly
> which worries me, although admidditly I could be missing something
> important.
>
> In summary, did you consider just allocating matching I/D caches from
> the number of split levels in acpi_get_cache_info() then removing or
> invalidating the ones that don't have matching PPTT entries after
> running cache_setup_acpi()? Thats a fairly trivial change AFAIK if the
> decision is based on the lack of a cache_id or just changing the
> this_leaf->type =3D CACHE_TYPE_UNIFIED assignment to the correct type and
> assuring left over CACHE_TYPE_NOCACHE entries are removed. I think much
> of the "significant work" is likely fixed for that to work. Just
> tweaking detect_cache_level()/get_cache_type() to set
> CACHE_TYPE_SEPERATE if the level is less than the acpi_get_cache_info()
> split_level value probably also does the majority of what you need
> outside of having unequal counts of I and D caches.
>
> There are probably other choices as well, thoughts?
>

First, I think the current state of the ACPI PPTT specification meets
the requirements and is logically complete. Otherwise, the PPTT
specification needs to be updated, right?
Our discussion is best focused on the existing and usual case, even on
ARM64, which is as you say "N-level separated I/D cache, M-level
unified".

And then, the problem we have now is that the RISC-V architecture does
not have a set of registers to describe the cache level and type like
ARM64 does, so we need to fully trust the contents of the PPTT table.
Please check the patch:
https://patchwork.kernel.org/project/linux-riscv/patch/20240407123829.36474=
-2-cuiyunhui@bytedance.com/
.

Judging from this requirement, can you help review this patch? Thanks.


Thanks,
Yunhui

