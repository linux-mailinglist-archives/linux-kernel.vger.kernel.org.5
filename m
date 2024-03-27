Return-Path: <linux-kernel+bounces-120565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80D588D967
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81274295525
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C13374F5;
	Wed, 27 Mar 2024 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndxC4xuS"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AA8374EA
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529077; cv=none; b=USC7T7mrbulPGfADa9f7UgVL42Jc3FaDxJxHwWaSU4jhOskTKFHvprb6VosE7/hqW+Epqpnpfzj7allbbtFFstliZ4v6LO8A7L/3eeQLBjJeP5Br8+fqFMYGw3lEbEASqSsbxCoZNDU0x2Ggf+fiwpVY+LDS0zzsLA5f7kNlVcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529077; c=relaxed/simple;
	bh=4uz5bnic2oxtmsWA5BAWklU8JqMmbVCcFFbha4bBLzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELm4Zo+mVbwbBXCxf7YXorHV2JAajnvGzyfaq/LkBF0h7Bq1rTrRpjmj9KPlKPveat6+Nz5nS3u1cWP13JldpE/TJHN9RVRJuSJlKDFxp4trQKON82Uy/mbtmEyS7Q4Rrn/lYYgtk0gB8BoBwrDhxcEoK5wWARHxn55rlEwhDo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndxC4xuS; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d6ee6c9945so9619901fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 01:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711529072; x=1712133872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uz5bnic2oxtmsWA5BAWklU8JqMmbVCcFFbha4bBLzM=;
        b=ndxC4xuS9hNHxdToCGDvOtd5YJJ/JsJ2pM9dVkMdNP68emNG/MtmQ5RtrlY+Bki9XQ
         hIC6kyrZkr3mxuDkk5CaVIGyFaDwjBW0x5IDxEEUc7leOqbJu9jzeSMHDz/nt4hKmcxs
         5D/9UAjgKWaKfJEFFXUOQa3iaUDtVbh1FUEzqZPGl20TxoKDCLO5AQyLIDJRS6Stmj8t
         RomY5BOyc5hCOm0cRoqR06PTr8py1Hl5Z1hIk1bzg998AVBhckrKWkgpR/Y0OaImYvQ1
         l9oebf+dncAekojGdLF9uiZmRxyqDtXgy7OiZHa24VQ9ReOmizidzteSr2BAsg2bIRmS
         ZBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711529072; x=1712133872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uz5bnic2oxtmsWA5BAWklU8JqMmbVCcFFbha4bBLzM=;
        b=Vj856zOyBvIjWAWbYqD1S8yAlu0x+b3XtVN/8p0Ow1lieiPn9nXNbEvDzPFe+Y5pDv
         ArSmTc3TMTez56Qw/BIUT4qixaE0GRhlr+zn3DKDmo8zttHp6ZuRi5VqAb3Vd6RJdh5j
         K4ET6n2mygvqCihIAHxWtGgvgOwCPBmi+cXUynxy+gRq3/7aQhnROuV0xxlfepwpbUSF
         A6xl+gIAh/m0DTNjMCXfPB00imXqeTbSg60Aew/GoR8JHC7AfJig2ZbmIv48CsvOwvXC
         Jg7d2Sss7rjD8GcEdysgExTpKabBR1BtaWzhwrpdw9g7gGfvDmLP6C5jReLd3Jg/iSUH
         2Yzg==
X-Forwarded-Encrypted: i=1; AJvYcCVxN/XPQDMF5pgJUL1EgmlMAVMTG0971uPoEZUW/blU+49n6ukjeM2e8KNAajT29Vxzkx4K8p8c9XpbLRFlG/rWBWwX837+yZPg0DXR
X-Gm-Message-State: AOJu0YwtSE2Z73zCBzXOZplI39Y6zpHbtvU0PEz6LBKl9WpzPg9puF6q
	CpVWlwfanrHeY3VW3LJvlh3gbgo6Ops3JlJKZ2qvePICcbEw/RrIPeorBcPArEhWt26ZvJY9/yg
	L71mZcMfGlEks4wCC7jNkak/jdx0=
X-Google-Smtp-Source: AGHT+IGWv/UtqTfqgA9rB7SSbcnXfmff9m4vwCHsdDmAIZSbhaetzgTCgXdXF0d7/hfmT/mG2l+A/SmbSPiv0ac4z3I=
X-Received: by 2002:a2e:3c0f:0:b0:2d4:7870:3b50 with SMTP id
 j15-20020a2e3c0f000000b002d478703b50mr2236382lja.24.1711529071985; Wed, 27
 Mar 2024 01:44:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326185032.72159-1-ryncsn@gmail.com> <20240326185032.72159-11-ryncsn@gmail.com>
 <CAGsJ_4yLAYUGYzWJwe9_LmqOcCzrz8-UKhdRDjTzgVQF7Z-xZA@mail.gmail.com>
In-Reply-To: <CAGsJ_4yLAYUGYzWJwe9_LmqOcCzrz8-UKhdRDjTzgVQF7Z-xZA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 27 Mar 2024 16:44:14 +0800
Message-ID: <CAMgjq7DOd16kyRngkz2RKQKf71QErAnmZy+PAsWp76V+qwykQA@mail.gmail.com>
Subject: Re: [RFC PATCH 10/10] mm/swap: optimize synchronous swapin
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mm@kvack.org, "Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>, 
	Minchan Kim <minchan@kernel.org>, Barry Song <v-songbaohua@oppo.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Yu Zhao <yuzhao@google.com>, SeongJae Park <sj@kernel.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 4:09=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Wed, Mar 27, 2024 at 8:06=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Interestingly the major performance overhead of synchronous is actually
> > from the workingset nodes update, that's because synchronous swap in
> > keeps adding single folios into a xa_node, making the node no longer
> > a shadow node and have to be removed from shadow_nodes, then remove
> > the folio very shortly and making the node a shadow node again,
> > so it has to add back to the shadow_nodes.
>
> Hi Kairui,
>
> Thank you for clarifying this. I'm unsure how it relates to SWP_SYNCHRONO=
US_IO.
> Does this observation apply universally to all instances where
> __swap_count(entry)
> =3D=3D 1, even on devices not using SYNCHRONOUS_IO?

Hi Barry

I was testing using zero pages on ZRAM so the performance issue is
much more obvious.

For non SYNCHRONOUS_IO devices, they don't drop swap cache immediately
unless swap is half full, so a shadow node will be removed from
shadow_nodes on first swapin, but usually won't be added/removed
repeatedly.

I think the logic that "never drop swapcache even if swap count is 1",
then suddenly switch to "always drop swap cache when swap count is 1"
when swap is half full is not a good solution... Maybe some generic
optimization can be applied for that part too.

