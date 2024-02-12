Return-Path: <linux-kernel+bounces-62220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16A5851D31
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56346284B55
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CF347A40;
	Mon, 12 Feb 2024 18:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O5t8mlbD"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DAB4776F
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763487; cv=none; b=DZTGoh/RbQ+AFyOzPsCRnC182Y6FAk8QhuQ0YClV1sy92VjxocnVeCiKrbKw7SohVCbTPZ6ZKVMBi/4MtBahck7H+yt8OWLYOGHMKqgoUdGIJHUKh2AcARu5kH1I6jeIiwZu464FEu4+OK95c3cp3zgcvznvBGipxYG/sBwO+Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763487; c=relaxed/simple;
	bh=NIxDKLA8cfy0iQFxJSdSV8c8EqUx+hRLVZGKl2b9lPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g3xtqJ9WYOPijKNR0BxQPncXUuoT7AKxHRhgQGywvWqqNfyN5ArPTD1YxtyOYnEs/xzrwBA0ZezOAqpEIWMRTP9SHt7+5DthYCNMrR9lcSb9/e1MsSLTvRpFM5eMSLzcfwN/RiR5tBvXNxeEtAcoNOqQI/NsYYr94n2BeERzKOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O5t8mlbD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40f0218476aso4755e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707763484; x=1708368284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awleO4UbaLWotLxN2WegZSolmgUNeBekfvMVRlHYfJY=;
        b=O5t8mlbDSP68JbFlQfTDb1OWOi9bkBiDKVWwe8YFdI0UhCExo/C8sCsasUfqm3F1vF
         wlOmwKNxgCjHQQPfRU8JDBiMWfo/lfe3nQgm/tbvA0fJGrixHWMNC1F5ionQlk7dZr2U
         i4zDQmuZru5mK0JjMvbT4ZOz3HPqzr4kQlDQcxKjS5a98IpEOBnpRtvBGUjIfR+BBPW2
         sWXbxzyBvQUcfZFrEesxOVS3ktrAWydErTmZZjIc3vJL/dA+5SDw9hf7dxUqdy7WLlsk
         l+JOcjm43X2diDlJP2GGcHD+l8JGGEG1C2vMjKP1jvmbnDjnAnuhFxZSIdGKBoTdKmEO
         CHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707763484; x=1708368284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awleO4UbaLWotLxN2WegZSolmgUNeBekfvMVRlHYfJY=;
        b=Js0SY3sncM7iepvSwIfIuORoPO0ce3ExrtRL4zGXeIHPaestVcRkDXInmECdIlcShG
         Cnb5eo80BU1jmFuA87lRYyGtsDv1KvmmRVGcQt1y5egZPwzIN/N9Exw4V1Qe9bE3JAT1
         f74FAHChh8tSKNtUj1/uTNGZ6WrFkqDXG9OouSQpEs7BUdVJBgpBTv7tZbLXKlHbaRaU
         pOhBx57lEzcKAC3D+bP+GrLNb46iunvzQS2ovtQ9ARGVbVMTdl9cC77pYyG1HXxTnfN6
         VW4erlB55w6DhoOLAMl0j10KSABAi5Qs8wlMia5lOTye+biTuHqo5d26w9By24gS85Ss
         /j5w==
X-Gm-Message-State: AOJu0YzbF0xaf7yMulAdV79cpuU2nOeEjwjcqfVukVL07lLQ5mDauias
	5Lful6N2xIOz4CNUB2DkM+jhLxkp3e4UKK1dmdUUdhcs2h2fi3R6e5hoGPobM1qrReoVSm9Ou0F
	2ywhHfBjYzqwRbC3RKa/Tyr9BTZb6Wl3VqGlu
X-Google-Smtp-Source: AGHT+IENP53VWALBr0STyXawCM5pf9m4nMO4OZUSg9qhAJyD+ZItym9RSlBRbLX6pXQojaovw/gacAZk/E5wIwrlVF4=
X-Received: by 2002:a05:600c:601c:b0:410:daa5:66f0 with SMTP id
 az28-20020a05600c601c00b00410daa566f0mr179825wmb.6.1707763483681; Mon, 12 Feb
 2024 10:44:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212163510.859822-1-zi.yan@sent.com>
In-Reply-To: <20240212163510.859822-1-zi.yan@sent.com>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 12 Feb 2024 11:44:07 -0700
Message-ID: <CAOUHufa5c9592Vc=S=-Bdc4jy0HVRi2SGJkOQEqj6+CGP_uWxg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Enable >0 order folio memory compaction
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	"Huang, Ying" <ying.huang@intel.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	David Hildenbrand <david@redhat.com>, "Yin, Fengwei" <fengwei.yin@intel.com>, 
	Vlastimil Babka <vbabka@suse.cz>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Mel Gorman <mgorman@techsingularity.net>, 
	Rohan Puri <rohan.puri15@gmail.com>, Mcgrof Chamberlain <mcgrof@kernel.org>, 
	Adam Manzanares <a.manzanares@samsung.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 9:35=E2=80=AFAM Zi Yan <zi.yan@sent.com> wrote:
>
> From: Zi Yan <ziy@nvidia.com>
>
> Hi all,
>
> This patchset enables >0 order folio memory compaction, which is one of
> the prerequisitions for large folio support[1]. It is on top of
> mm-everything-2024-02-10-00-56.
>
> I am aware of that split free pages is necessary for folio
> migration in compaction, since if >0 order free pages are never split
> and no order-0 free page is scanned, compaction will end prematurely due
> to migration returns -ENOMEM. Free page split becomes a must instead of
> an optimization.
>
> lkp ncompare results (on a 8-CPU (Intel Xeon E5-2650 v4 @2.20GHz) 16G VM)
> for default LRU (-no-mglru) and CONFIG_LRU_GEN are shown at the bottom,
> copied from V3[4], since V4 is only a code refactoring of V3.
> In sum, most of vm-scalability applications do not see performance
> change, and the others see ~4% to ~26% performance boost under default LR=
U
> and ~2% to ~6% performance boost under CONFIG_LRU_GEN.

Suren has been testing 64KB THP on Android and seeing regressions
under memory pressure (a significant portion of client devices are
always under memory pressure). Hopefully this series will help.

I threw this series into some stress tests we have with both 64KB and
2MB THP enabled and didn't see any obvious problems.

Tested-by: Yu Zhao <yuzhao@google.com>

> Overview
> =3D=3D=3D
>
> To support >0 order folio compaction, the patchset changes how free pages=
 used
> for migration are kept during compaction. Free pages used to be split int=
o
> order-0 pages that are post allocation processed (i.e., PageBuddy flag cl=
eared,
> page order stored in page->private is zeroed, and page reference is set t=
o 1).
> Now all free pages are kept in a MAX_ORDER+1 array of page lists based
> on their order without post allocation process. When migrate_pages() asks=
 for
> a new page, one of the free pages, based on the requested page order, is
> then processed and given out.

And THP <2MB would need this feature (spell it out).



> vm-scalability results on CONFIG_LRU_GEN
> =3D=3D=3D
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/qemu-vm/mmap-xread-seq-mt/vm-scalability
>
> commit:
>   6.8.0-rc1-mm-everything-2024-01-29-07-19+
>   6.8.0-rc1-split-folio-in-compaction+
>   6.8.0-rc1-folio-migration-in-compaction+
>   6.8.0-rc1-folio-migration-free-page-split+
>
> 6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration-i =
6.8.0-rc1-folio-migration-f
> ---------------- --------------------------- --------------------------- =
---------------------------
>          %stddev     %change         %stddev     %change         %stddev =
    %change         %stddev
>              \          |                \          |                \   =
       |                \
>   15107616            +3.2%   15590339            +1.3%   15297619       =
     +3.0%   15567998        vm-scalability.throughput
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/qemu-vm/mmap-pread-seq/vm-scalability
>
> commit:
>   6.8.0-rc1-mm-everything-2024-01-29-07-19+
>   6.8.0-rc1-split-folio-in-compaction+
>   6.8.0-rc1-folio-migration-in-compaction+
>   6.8.0-rc1-folio-migration-free-page-split+
>
> 6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration-i =
6.8.0-rc1-folio-migration-f
> ---------------- --------------------------- --------------------------- =
---------------------------
>          %stddev     %change         %stddev     %change         %stddev =
    %change         %stddev
>              \          |                \          |                \   =
       |                \
>   12611785            +1.8%   12832919            +0.9%   12724223       =
     +1.6%   12812682        vm-scalability.throughput
>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/qemu-vm/lru-file-readtwice/vm-scalability
>
> commit:
>   6.8.0-rc1-mm-everything-2024-01-29-07-19+
>   6.8.0-rc1-split-folio-in-compaction+
>   6.8.0-rc1-folio-migration-in-compaction+
>   6.8.0-rc1-folio-migration-free-page-split+
>
> 6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration-i =
6.8.0-rc1-folio-migration-f
> ---------------- --------------------------- --------------------------- =
---------------------------
>          %stddev     %change         %stddev     %change         %stddev =
    %change         %stddev
>              \          |                \          |                \   =
       |                \
>    9833393            +5.7%   10390190            +3.0%   10126606       =
     +5.9%   10408804        vm-scalability.throughput
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/qemu-vm/lru-file-mmap-read/vm-scalability
>
> commit:
>   6.8.0-rc1-mm-everything-2024-01-29-07-19+
>   6.8.0-rc1-split-folio-in-compaction+
>   6.8.0-rc1-folio-migration-in-compaction+
>   6.8.0-rc1-folio-migration-free-page-split+
>
> 6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration-i =
6.8.0-rc1-folio-migration-f
> ---------------- --------------------------- --------------------------- =
---------------------------
>          %stddev     %change         %stddev     %change         %stddev =
    %change         %stddev
>              \          |                \          |                \   =
       |                \
>    7034709 =C2=B1  3%      +2.9%    7241429            +3.2%    7256680 =
=C2=B1  2%      +3.9%    7308375        vm-scalability.throughput
>
>
>
> vm-scalability results on default LRU (with -no-mglru suffix)
> =3D=3D=3D
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/qemu-vm/mmap-xread-seq-mt/vm-scalability
>
> commit:
>   6.8.0-rc1-mm-everything-2024-01-29-07-19-no-mglru+
>   6.8.0-rc1-split-folio-in-compaction-no-mglru+
>   6.8.0-rc1-folio-migration-in-compaction-no-mglru+
>   6.8.0-rc1-folio-migration-free-page-split-no-mglru+
>
> 6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration-i =
6.8.0-rc1-folio-migration-f
> ---------------- --------------------------- --------------------------- =
---------------------------
>          %stddev     %change         %stddev     %change         %stddev =
    %change         %stddev
>              \          |                \          |                \   =
       |                \
>   14401491            +3.7%   14940270            +2.4%   14748626       =
     +4.0%   14975716        vm-scalability.throughput
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/qemu-vm/mmap-pread-seq/vm-scalability
>
> commit:
>   6.8.0-rc1-mm-everything-2024-01-29-07-19-no-mglru+
>   6.8.0-rc1-split-folio-in-compaction-no-mglru+
>   6.8.0-rc1-folio-migration-in-compaction-no-mglru+
>   6.8.0-rc1-folio-migration-free-page-split-no-mglru+
>
> 6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration-i =
6.8.0-rc1-folio-migration-f
> ---------------- --------------------------- --------------------------- =
---------------------------
>          %stddev     %change         %stddev     %change         %stddev =
    %change         %stddev
>              \          |                \          |                \   =
       |                \
>   11407497            +5.1%   11989632            -0.5%   11349272       =
     +4.8%   11957423        vm-scalability.throughput
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/qemu-vm/mmap-pread-seq-mt/vm-scalability
>
> commit:
>   6.8.0-rc1-mm-everything-2024-01-29-07-19-no-mglru+
>   6.8.0-rc1-split-folio-in-compaction-no-mglru+
>   6.8.0-rc1-folio-migration-in-compaction-no-mglru+
>   6.8.0-rc1-folio-migration-free-page-split-no-mglru+
>
> 6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration-i =
6.8.0-rc1-folio-migration-f
> ---------------- --------------------------- --------------------------- =
---------------------------
>          %stddev     %change         %stddev     %change         %stddev =
    %change         %stddev
>              \          |                \          |                \   =
       |                \
>   11348474            +3.3%   11719453            -1.2%   11208759       =
     +3.7%   11771926        vm-scalability.throughput
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/qemu-vm/lru-file-readtwice/vm-scalability
>
> commit:
>   6.8.0-rc1-mm-everything-2024-01-29-07-19-no-mglru+
>   6.8.0-rc1-split-folio-in-compaction-no-mglru+
>   6.8.0-rc1-folio-migration-in-compaction-no-mglru+
>   6.8.0-rc1-folio-migration-free-page-split-no-mglru+
>
> 6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration-i =
6.8.0-rc1-folio-migration-f
> ---------------- --------------------------- --------------------------- =
---------------------------
>          %stddev     %change         %stddev     %change         %stddev =
    %change         %stddev
>              \          |                \          |                \   =
       |                \
>    8065614 =C2=B1  3%      +7.7%    8686626 =C2=B1  2%      +5.0%    8467=
577 =C2=B1  4%     +11.8%    9016077 =C2=B1  2%  vm-scalability.throughput
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>   gcc-13/defconfig/debian/300s/qemu-vm/lru-file-mmap-read/vm-scalability
>
> commit:
>   6.8.0-rc1-mm-everything-2024-01-29-07-19-no-mglru+
>   6.8.0-rc1-split-folio-in-compaction-no-mglru+
>   6.8.0-rc1-folio-migration-in-compaction-no-mglru+
>   6.8.0-rc1-folio-migration-free-page-split-no-mglru+
>
> 6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration-i =
6.8.0-rc1-folio-migration-f
> ---------------- --------------------------- --------------------------- =
---------------------------
>          %stddev     %change         %stddev     %change         %stddev =
    %change         %stddev
>              \          |                \          |                \   =
       |                \
>    6438422 =C2=B1  2%     +27.5%    8206734 =C2=B1  2%     +10.6%    7118=
390           +26.2%    8127192 =C2=B1  4%  vm-scalability.throughput

Thanks for the data! Based on the above:

Test case                          default   MGLRU     Change
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
mmap-xread-seq-mt/vm-scalability   14975716  15567998  +4%
mmap-pread-seq/vm-scalability      11957423  12812682  +7%
mmap-pread-seq-mt/vm-scalability   11771926  unavail   N/A
lru-file-readtwice/vm-scalability  9016077   10408804  +15%
lru-file-mmap-read/vm-scalability  8127192   7308375   -10%

So it seems that MGLRU regressed for the last test. I'll find someone
on our team to take a look.

