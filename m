Return-Path: <linux-kernel+bounces-102615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0633487B498
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88879285E8A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698345C90A;
	Wed, 13 Mar 2024 22:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="YUSkiYsX"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0431C5B697
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710370166; cv=none; b=bUhMHL7j+5rwxHnWPZL2PzUGlAjPI/XiubtV/Wvq+ZIBLnT1YbPJYNVTJH/hGMiGsT4nbAofRlvq/O1OXfaGZydDb0+mSVymTi1W074vxsVKkLYRDLtIdiTKNDrWuiFpb7IJwwyCAsqHzr40EtfA6PBUzqd/ahxpPLDd/4yPWLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710370166; c=relaxed/simple;
	bh=kQPlLLYuK9rGDu9iFj4vfuJRTUe5t6j7sL0t/2BVD8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1D24Z3HhUV7DX0QAIzd8XUGTVV0E5pNKsMqcGOm8jWCRVZBIl8swMtSMNLWGg3GqE3dbQB65pA3moH+eYSOML/09S1m89GwM00hvBqSpecy9CTCTSOoZP0kXDmbf0qEWiQ+GFAYLkeF32O8ODN0bkGkHi+RqdH/2DenBrnffJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=YUSkiYsX; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7c8ceb9fb0fso9246839f.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 15:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710370164; x=1710974964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQPlLLYuK9rGDu9iFj4vfuJRTUe5t6j7sL0t/2BVD8s=;
        b=YUSkiYsX75yXbpkLyU0s1DSqpWR70wHwYofCL2Ef9DY9vHKnF7L2TyoE1eK4wyiVPr
         paqeTp6C8YXQ8RrVXL6X6SLafnuiO63o+9813Wdvccz8hiI0GCsdGRTkyU+UOQVXEfRe
         4vdXmj7jaNA7DXZUrx31oszHLz9sp+dVnaTce4AYTEvzLrXu1QAVIaoFwDc+TpR3NQxb
         fQrCMcABTrEunJOFQbj7ZdZOxIxkOAMICMPRqSmbSxqlTHBjbyIlJECQqgaiPACBFag7
         LfH9Q2NV8Mo0JnJBQxgaueL+BYEK9g3jsvags1HHVjbm+3UopXkDY6Q47UhcwXDPpujC
         ztPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710370164; x=1710974964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQPlLLYuK9rGDu9iFj4vfuJRTUe5t6j7sL0t/2BVD8s=;
        b=ZUMGu82PbrXRvgxtE2Fl9GOWYqYmgav8i2Mxgj9uw6EIl/3hJ1CmgPT+BveXyIgwqc
         03VH8VdR/88/id1MnjXS4KmgRlmjorKM6eW/x4SGy96i7ol/dtUYoCXB1oS3ZbhEv3qe
         Um5vKQ794RPFHoxFx5t+k7263tdFMrQAX0lhO/FMQR+lIvaqAy9g9AL8OdDxm8eNdxmb
         k2DflqxmCfpqlIh4d8sJJrm0Mj7JHTkvnYzyVr6ZYkgK5/Ea9eGjkJz7btiRuq1XL/FR
         78/Ki5n3dhB4sbJ0hchxkcLurfWmw2/KKj6R0x8PJIHNRNs5ygYZdSxBVyCypaLZ4YvN
         9MxA==
X-Forwarded-Encrypted: i=1; AJvYcCXvrBADjwJr+O8Lqlczov/zmA1A7jx6k9T+6DzbOQYRHS1UyTLVgYwd6drtKHEcKHa16mftbxIckt0b8HHkG2/QGIOtVyj26SkvVQq1
X-Gm-Message-State: AOJu0YysHFGWX/PxVwnLTWhyedZNZ8ZJzP2SQvTyDONEnrLNw0hgbk1/
	XlaDXuBkD61jjjJCPyrqD47tlk8jRk1497VpCDOY25a2h6aUk4wX3hE3CEEAcXSUGQwKSOnJpGS
	d46GiloKB4xzCS92FyOPWO3GnyVRSZYnTSUVJm1E9Yqv6iD0sonA=
X-Google-Smtp-Source: AGHT+IEE4G/qpX58EhUm1MonVHMQobSiJgTN5F+R/XDKRvfIgvrnS2HXR6msMnAV4g83xTteuIsqwqymEt+VSwymYE8=
X-Received: by 2002:a81:7105:0:b0:608:13ee:8f3f with SMTP id
 m5-20020a817105000000b0060813ee8f3fmr15835ywc.27.1710369639489; Wed, 13 Mar
 2024 15:40:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220214558.3377482-1-souravpanda@google.com> <20240220214558.3377482-2-souravpanda@google.com>
In-Reply-To: <20240220214558.3377482-2-souravpanda@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 13 Mar 2024 18:40:03 -0400
Message-ID: <CA+CK2bAM4Xe7BT3TFZT-+3qQTFGgkYBiYY=oVkdqMN8gyJg_0g@mail.gmail.com>
Subject: Re: [PATCH v9 1/1] mm: report per-page metadata information
To: Sourav Panda <souravpanda@google.com>
Cc: corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org, 
	akpm@linux-foundation.org, mike.kravetz@oracle.com, muchun.song@linux.dev, 
	rppt@kernel.org, david@redhat.com, rdunlap@infradead.org, 
	chenlinxuan@uniontech.com, yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com, 
	bhelgaas@google.com, ivan@cloudflare.com, yosryahmed@google.com, 
	hannes@cmpxchg.org, shakeelb@google.com, kirill.shutemov@linux.intel.com, 
	wangkefeng.wang@huawei.com, adobriyan@gmail.com, vbabka@suse.cz, 
	Liam.Howlett@oracle.com, surenb@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, weixugc@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 4:46=E2=80=AFPM Sourav Panda <souravpanda@google.co=
m> wrote:
>
> Adds two new per-node fields, namely nr_memmap and nr_memmap_boot,
> to /sys/devices/system/node/nodeN/vmstat and a global Memmap field
> to /proc/meminfo. This information can be used by users to see how
> much memory is being used by per-page metadata, which can vary
> depending on build configuration, machine architecture, and system
> use.
>
> Per-page metadata is the amount of memory that Linux needs in order to
> manage memory at the page granularity. The majority of such memory is
> used by "struct page" and "page_ext" data structures. In contrast to
> most other memory consumption statistics, per-page metadata might not
> be included in MemTotal. For example, MemTotal does not include memblock
> allocations but includes buddy allocations. In this patch, exported
> field nr_memmap in /sys/devices/system/node/nodeN/vmstat would
> exclusively track buddy allocations while nr_memmap_boot would
> exclusively track memblock allocations. Furthermore, Memmap in
> /proc/meminfo would exclusively track buddy allocations allowing it to
> be compared against MemTotal.
>
> This memory depends on build configurations, machine architectures, and
> the way system is used:
>
> Build configuration may include extra fields into "struct page",
> and enable / disable "page_ext"
> Machine architecture defines base page sizes. For example 4K x86,
> 8K SPARC, 64K ARM64 (optionally), etc. The per-page metadata
> overhead is smaller on machines with larger page sizes.
> System use can change per-page overhead by using vmemmap
> optimizations with hugetlb pages, and emulated pmem devdax pages.
> Also, boot parameters can determine whether page_ext is needed
> to be allocated. This memory can be part of MemTotal or be outside
> MemTotal depending on whether the memory was hot-plugged, booted with,
> or hugetlb memory was returned back to the system.
>
> Utility for userspace:
>
> Application Optimization: Depending on the kernel version and command
> line options, the kernel would relinquish a different number of pages
> (that contain struct pages) when a hugetlb page is reserved (e.g., 0, 6
> or 7 for a 2MB hugepage). The userspace application would want to know
> the exact savings achieved through page metadata deallocation without
> dealing with the intricacies of the kernel.
>
> Observability: Struct page overhead can only be calculated on-paper at
> boot time (e.g., 1.5% machine capacity). Beyond boot once hugepages are
> reserved or memory is hotplugged, the computation becomes complex.
> Per-page metrics will help explain part of the system memory overhead,
> which shall help guide memory optimizations and memory cgroup sizing.
>
> Debugging: Tracking the changes or absolute value in struct pages can
> help detect anomalies as they can be correlated with other metrics in
> the machine (e.g., memtotal, number of huge pages, etc).
>
> page_ext overheads: Some kernel features such as page_owner
> page_table_check that use page_ext can be optionally enabled via kernel
> parameters. Having the total per-page metadata information helps users
> precisely measure impact.
>
> Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Sourav Panda <souravpanda@google.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

