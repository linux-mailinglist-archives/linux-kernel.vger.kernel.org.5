Return-Path: <linux-kernel+bounces-99746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB10E878C8D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA1E281D7A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC531842;
	Tue, 12 Mar 2024 01:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NP5qH1Zo"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6792186A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 01:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710208332; cv=none; b=Fk/WIA2Wc62cjuYzzP7scKO0Mk17+9NkK4Uwe8LX8GmpzhxwFBhvRQzJ3a8KdSm/ajn0Jt4t8ONJyHfL6MQmHKGiOteXt8rBnGvJTlmI2OOgsKqHlk6wKl+RFRCoIQyzCgJBG6yuemNmDAcK69ckgmOQcKO0qkeqkvUVxZEH/iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710208332; c=relaxed/simple;
	bh=/C4SK9kXKYQNf45av5o3S1f5YGsmIoxCw5/QDyf3ePc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rajauX+NqbVY1Cf0YqKL/f29uRK8W4yj6l1SYyScNR32G7RramuzTg7adpG2Rpem9AMAhxx3UkgIw6Zkz1YKCdu4nt8CVwaPmL9fmO7g7DASng+ChxAtaEIf2H2pydJ66ixMX7ZAilEkaYTJAeDbq8/IyJMn6TlNuY0fUVJxoFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NP5qH1Zo; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-221a9e5484aso2370231fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 18:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710208330; x=1710813130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUDWC2eUrOZ8C2ynRVAXHz0uE0sUzoNBRorpvOY+r94=;
        b=NP5qH1ZoB9V5VQktagSRfQuQwZeJ81GHkvE1Dl+hzsqQN5JOJZ43jZuyzNJxK2e6gN
         jUmnWDvMgFtsOw4jFH7eOJyZ9dvbBy8gE34AWlAB0gcOnlexOatUleWyeC+/QcQdM+TZ
         IDWFAhkn3pXBAcqQbHpXI+ymNIaVQLtUiHZhxzi5t8Q13Ue+vS1PsZ2KDZxW2mWDJbfG
         mPUULS9ydtxI4gurY2C2ui2IZdWWv849oVZRkHogyUPqV9zUOGy39URW72ZUGPk98IfH
         El2rwwxgujngkZcGplSEDFYmTPDl2MHKt1ME6xP2lXWUn8Dqs0R8sDg2aEO3RNXUHNB1
         4yKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710208330; x=1710813130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUDWC2eUrOZ8C2ynRVAXHz0uE0sUzoNBRorpvOY+r94=;
        b=HSSMtmDyiAKXgKHtAhjQFkPoSEv4mFd1d6kbjEUSczmVlpdt5y3iV4TcY3U3ITzK6L
         gJM+A3c/RV/LwVJDrzin/798mp/1YZGkKXL+8oVpxdSx7ebRvx/llEz001TVS8KpIvZh
         gkx5vG9KpE8SOav6hinpot7FmkKEpsF2jeYT7XHK+a1Pi6TFAOgIWP2QRFVy18KrBb3Y
         5Oy+EnYVCW6th3H26HcZO3TGxK3PCkWU4ndnW9DnbyuKrK8vwkdOboM4pdYIFXSPF9jj
         OuHYfkJAGvWDkHMpS7ekeCgY5AQ1eWcLuQTLyh0/eZI4PERiXQN5rPP6ZbjNbcOqRdQy
         xQLw==
X-Forwarded-Encrypted: i=1; AJvYcCXBTT7/NVJ3dwTwlotTl6jLNMlMFfX5rfryXQ+0qX6526FqoSTKvnhSxDT38pRljj/N0t1drLWpEVhjYtoCz4vN/DAhmS1R0OBbzgb9
X-Gm-Message-State: AOJu0YyLnU2CRNXwnEdH62xuM8PHIYZLv89fTEqZz5BQvSpG61NHGwCK
	FR2NsAu8Y5UYM0r1Y2xRQp8Wkt7PohNXNNgJu3xqVaJmI16QxA8Q29AaePtUtMHqbKXeGlS2uDG
	uYJIk7IymHEeiluvUrUT4rY0hEzP2dzYhHLqwfg==
X-Google-Smtp-Source: AGHT+IEw/i3iZ/moT3hoOqVkA0QyZhJITAge4gritgZJGaa4ZUoskcP4axQtqW/tHQZK40PRLKgUppucovxI/Ur0GZ0=
X-Received: by 2002:a05:6870:d182:b0:220:f92f:5bf7 with SMTP id
 a2-20020a056870d18200b00220f92f5bf7mr8145573oac.50.1710208329733; Mon, 11 Mar
 2024 18:52:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229232211.161961-1-samuel.holland@sifive.com>
 <20240229232211.161961-9-samuel.holland@sifive.com> <CAEEQ3w=8dVxO=qtW6_-SChLJ5No+7nGgf+1fXz0wSeBhb0Kk0A@mail.gmail.com>
 <100d5414-11fa-4c47-9c35-51f5fad2d6e6@sifive.com>
In-Reply-To: <100d5414-11fa-4c47-9c35-51f5fad2d6e6@sifive.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 12 Mar 2024 09:51:58 +0800
Message-ID: <CAEEQ3wkosTxGowYj5oD4WE7-CvZJS2ui8T5mzoGXp4zSRTf-2w@mail.gmail.com>
Subject: Re: [External] [PATCH v5 08/13] riscv: Avoid TLB flush loops when
 affected by SiFive CIP-1200
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Jisheng Zhang <jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

H Samuel,

On Tue, Mar 12, 2024 at 8:36=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Yunhui,
>
> On 2024-02-29 8:48 PM, yunhui cui wrote:
> > Hi Samuel,
> >
> > On Fri, Mar 1, 2024 at 7:22=E2=80=AFAM Samuel Holland <samuel.holland@s=
ifive.com> wrote:
> >>
> >> Since implementations affected by SiFive errata CIP-1200 always use th=
e
> >> global variant of the sfence.vma instruction, they only need to execut=
e
> >> the instruction once. The range-based loop only hurts performance.
> >>
> >> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> >> ---
> >>
> >> (no changes since v4)
> >>
> >> Changes in v4:
> >>  - Only set tlb_flush_all_threshold when CONFIG_MMU=3Dy.
> >>
> >> Changes in v3:
> >>  - New patch for v3
> >>
> >>  arch/riscv/errata/sifive/errata.c | 5 +++++
> >>  arch/riscv/include/asm/tlbflush.h | 2 ++
> >>  arch/riscv/mm/tlbflush.c          | 2 +-
> >>  3 files changed, 8 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sif=
ive/errata.c
> >> index 3d9a32d791f7..716cfedad3a2 100644
> >> --- a/arch/riscv/errata/sifive/errata.c
> >> +++ b/arch/riscv/errata/sifive/errata.c
> >> @@ -42,6 +42,11 @@ static bool errata_cip_1200_check_func(unsigned lon=
g  arch_id, unsigned long imp
> >>                 return false;
> >>         if ((impid & 0xffffff) > 0x200630 || impid =3D=3D 0x1200626)
> >>                 return false;
> >> +
> >> +#ifdef CONFIG_MMU
> >> +       tlb_flush_all_threshold =3D 0;
> >> +#endif
> >> +
> >>         return true;
> >>  }
> >>
> >> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/as=
m/tlbflush.h
> >> index 463b615d7728..8e329721375b 100644
> >> --- a/arch/riscv/include/asm/tlbflush.h
> >> +++ b/arch/riscv/include/asm/tlbflush.h
> >> @@ -66,6 +66,8 @@ void arch_tlbbatch_add_pending(struct arch_tlbflush_=
unmap_batch *batch,
> >>                                unsigned long uaddr);
> >>  void arch_flush_tlb_batched_pending(struct mm_struct *mm);
> >>  void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
> >> +
> >> +extern unsigned long tlb_flush_all_threshold;
> >>  #else /* CONFIG_MMU */
> >>  #define local_flush_tlb_all()                  do { } while (0)
> >>  #endif /* CONFIG_MMU */
> >> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> >> index 365e0a0e4725..22870f213188 100644
> >> --- a/arch/riscv/mm/tlbflush.c
> >> +++ b/arch/riscv/mm/tlbflush.c
> >> @@ -11,7 +11,7 @@
> >>   * Flush entire TLB if number of entries to be flushed is greater
> >>   * than the threshold below.
> >>   */
> >> -static unsigned long tlb_flush_all_threshold __read_mostly =3D 64;
> >> +unsigned long tlb_flush_all_threshold __read_mostly =3D 64;
> >>
> >>  static void local_flush_tlb_range_threshold_asid(unsigned long start,
> >>                                                  unsigned long size,
> >> --
> >> 2.43.1
> >>
> >
> > If local_flush_tlb_all_asid() is used every time, more PTWs will be
> > generated. Will such modifications definitely improve the overall
> > performance?
>
> This change in this commit specifically applies to older SiFive SoCs with=
 a bug
> making single-page sfence.vma instructions unsafe to use. In this case, a=
 single
> call to local_flush_tlb_all_asid() is optimal, yes.
Would it be more clear to add this content to the git commit
description appropriately?

>
> > Hi Alex, Samuel,
> > The relationship between flush_xx_range_asid() and nr_ptes is
> > basically linear growth (y=3Dkx +b), while flush_all_asid() has nothing
> > to do with nr_ptes (y=3Dc).
> > Some TLBs may do some optimization. The operation of flush all itself
> > requires very few cycles, but there is a certain delay between
> > consecutive flush all.
> > The intersection of the two straight lines is the optimal solution of
> > tlb_flush_all_threshold. In actual situations, continuous
> > flush_all_asid will not occur. One problem caused by flush_all_asid()
> > is that multiple flush entries require PTW, which causes greater
> > latency.
> > Therefore, the value of tlb_flush_all_threshold needs to be considered
> > or quantified. Maybe doing local_flush_tlb_page_asid() based on the
> > actual nr_ptes_in_range would give better overall performance.
> > What do you think?
>
> Yes, this was something Alex brought up when adding this threshold, that =
it
> should be tuned for various scenarios. That still needs to be done. This =
patch
> just covers one specific case where we know the optimal answer due to an =
erratum.
>
> Regards,
> Samuel
>

Thanks,
Yunhui

