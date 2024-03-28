Return-Path: <linux-kernel+bounces-122322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C53688F533
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5D861F26797
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0278F286AC;
	Thu, 28 Mar 2024 02:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cR2BhQah"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65252032A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711592511; cv=none; b=SvFoEDXZBnILOMb1H7O6s4DwxIxbkF6ZBXcS3lpEDKAq4x5Aki/b/y5ocaWqPHD423LK4bYB1CPYxFBy+8v0WMjLkNem6JhP25EhvyH+LkplUFYVbRNHOU4zR1DtgOczlhLnGQDl3xG9wq5DXXVG3blr1FQEdDdTgw21NsBz+wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711592511; c=relaxed/simple;
	bh=uECoXQdsUgj0Fwe4NLIdKWkK5Nblyt6SUH1Fth5WvQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SlnVBZ5YvvTvjf2xiL1UvyjpWamcB5jCVZu1FDWsqPx7h0HFsVZIrUIG7moS28CDfuCnzWBpZT4LkqPj8x+eQBObIcnSp1oqVWIslwS/AbdWTFsmorVgVsXDoYfMbIvu/ObMAKHEhxLv5nT7fOan/oguTNROOl5G2qTJfWj6ASg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cR2BhQah; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a4d3b82e53so630281eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 19:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711592508; x=1712197308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yt1qJ/aapzEk7b+bqj1PXxdFxkUP6vsNQasniKK4Xiw=;
        b=cR2BhQahFXTobjMVzGdeY9SQL0ECzc5ftoPYS3ZsAsfU49pw5VHt54LNrGILLsACog
         HZE+4YAhhfjhmaC9r4O0JDNcNyjRrLWMDxJP0oQRF60enQrf4nZlBGKwsM+VH09BTsNe
         ZxhNDf/KKZEbT9K/vAxPwjeO/ZmYy6y+9BEhgpRiMm0epAnJ82PDFmu411sZImDiIyAV
         0ehiOYWi6UjmiMV6E+wycic8pKwf/Ymck34nttLpndyvEUAqdbyaC6wMki1TRWQ5mx5u
         7GDncZ/C1g/SOf2GMr5je+LlbtfUj7ZvZBNWCQJGqTIuqKQ4woh+ytxLpmGWW2ot5bFU
         FXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711592508; x=1712197308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yt1qJ/aapzEk7b+bqj1PXxdFxkUP6vsNQasniKK4Xiw=;
        b=JQgtKSyJn4d5YNB2ne+8o/K0FpAe30iaUoNTuj0t7K3pt8HpzYPGnnwE0hMsxK2S3D
         MaSq8QayGADPwXLZb6zNsQPzE0x8eFfmTSyGYC+z4fRud56iEJJ38LQ4MhGXNGGiALmr
         TQyzlIKILNPi7yjfPAxwtaRvxg3iwx/mugTX9Ggw3YE4nV4AEhcBKb+Go9ZfSgTmHfzQ
         Xqc4I5AAIaYNFEDJllnetS9o+jIn8Lknl05/t4DI2KIFjLBxzJzxWbyWfiauLXR4IGnu
         k/SMWyihtAsupo6B+DMonpxhN8wxP8I0gwi3q1OXNFOY3xSaQHSQUhncgSuqFPoK9u2m
         9esw==
X-Forwarded-Encrypted: i=1; AJvYcCWQiayn0xwFk+i3zxTbC+T2b6NKdSe9/XBHign5X65ae9vXBNk9g9JoJs7HNY30qIUW4a1DtHxqqJ+UB5ZtoYW5HE41UTNR4zCiu9DZ
X-Gm-Message-State: AOJu0Yys+LX3oNu5AeBf7HYZg+PCndpWD/Uc8F511jaLmnZ1eUAWeGNz
	GEhqxG6SEmHz8OMDs/i5O34uhTOZDNKMvqI3WiibIH7+EcOtPvbaJSr2BVj9YApDx2bqQiwV6Wk
	Hy5neY/TuBHacpjtz/ZmHrcNMetJ3f17nL64OEQ==
X-Google-Smtp-Source: AGHT+IF7mvHjc+uzeHTN+S+gkIbUZbxU6z0DSjgvfA9hDpJa/w883Lt26dgm5e98f7MAdqqDGgZYC4cyC2x9ZkE+D3M=
X-Received: by 2002:a05:6870:e97:b0:222:8961:43fa with SMTP id
 mm23-20020a0568700e9700b00222896143famr445494oab.15.1711592508022; Wed, 27
 Mar 2024 19:21:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327045035.368512-1-samuel.holland@sifive.com>
 <20240327045035.368512-6-samuel.holland@sifive.com> <CAEEQ3wm4SoC6rvv2qtVdP+4ZF1q41EEHUpwnagNgFwxkG5iw_w@mail.gmail.com>
 <e409d77b-0dad-45c2-a507-a8b697ff4702@sifive.com>
In-Reply-To: <e409d77b-0dad-45c2-a507-a8b697ff4702@sifive.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 28 Mar 2024 10:21:37 +0800
Message-ID: <CAEEQ3wksq6Et4n7pKPD_SJdAkmgAPF6G0B7uG4PNUMknc-okyw@mail.gmail.com>
Subject: Re: [External] [PATCH v6 05/13] riscv: Only send remote fences when
 some other CPU is online
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Jisheng Zhang <jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Thu, Mar 28, 2024 at 4:14=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Yunhui,
>
> On 2024-03-27 1:16 AM, yunhui cui wrote:
> > On Wed, Mar 27, 2024 at 12:50=E2=80=AFPM Samuel Holland
> > <samuel.holland@sifive.com> wrote:
> >>
> >> If no other CPU is online, a local cache or TLB flush is sufficient.
> >> These checks can be constant-folded when SMP is disabled.
> >>
> >> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> >> ---
> >>
> >> (no changes since v4)
> >>
> >> Changes in v4:
> >>  - New patch for v4
> >>
> >>  arch/riscv/mm/cacheflush.c | 4 +++-
> >>  arch/riscv/mm/tlbflush.c   | 4 +++-
> >>  2 files changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> >> index d76fc73e594b..f5be1fec8191 100644
> >> --- a/arch/riscv/mm/cacheflush.c
> >> +++ b/arch/riscv/mm/cacheflush.c
> >> @@ -21,7 +21,9 @@ void flush_icache_all(void)
> >>  {
> >>         local_flush_icache_all();
> >>
> >> -       if (riscv_use_sbi_for_rfence())
> >> +       if (num_online_cpus() < 2)
> >> +               return;
> >> +       else if (riscv_use_sbi_for_rfence())
> >>                 sbi_remote_fence_i(NULL);
> >>         else
> >>                 on_each_cpu(ipi_remote_fence_i, NULL, 1);
> >> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> >> index da821315d43e..0901aa47b58f 100644
> >> --- a/arch/riscv/mm/tlbflush.c
> >> +++ b/arch/riscv/mm/tlbflush.c
> >> @@ -79,7 +79,9 @@ static void __ipi_flush_tlb_all(void *info)
> >>
> >>  void flush_tlb_all(void)
> >>  {
> >> -       if (riscv_use_sbi_for_rfence())
> >> +       if (num_online_cpus() < 2)
> >> +               local_flush_tlb_all();
> >> +       else if (riscv_use_sbi_for_rfence())
> >>                 sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE=
, FLUSH_TLB_NO_ASID);
> >>         else
> >>                 on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
> >> --
> >> 2.43.1
> >>
> >
> > From a perceptual point of view, the modification here is not
> > necessary. There is such logic in on_each_cpu(). Can you share your
> > test data?
>
> The logic in on_each_cpu() doesn't apply when riscv_use_sbi_for_rfence() =
is
> true, so we would make unnecessary SBI calls, and cannot be oppimized out=
 when
> CONFIG_SMP=3Dn.

Is it possible to do this:
"sbi_remote_sfence_vma_asid(cpu_online_mask,...); " instead of adding:
"if (num_online_cpus() < 2)" ?

Thanks,
Yunhui

