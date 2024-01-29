Return-Path: <linux-kernel+bounces-42579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34216840364
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66BD41C21CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEA05A7AF;
	Mon, 29 Jan 2024 11:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LaP2dV6I"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D057F56B67
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706526144; cv=none; b=R1B3zxXiLLG+IDT6dBYwzMv7vql2ISXh/HCUsoKkhTSy5MaC79q5NrSZORt/CaUN6r+ueLSpj+20mnQqcH1DuREqO5Yzp6Y9U7TUt6CFck5r4Q5ki+GFIBwbT/GdUUWcBGP328OvasPQPXJywokSDsTBEKkdK8oqPxu7Xh1+aMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706526144; c=relaxed/simple;
	bh=sTJxbxSOrvcrYc8CLPfFyPhV1mIIGJ+doi7MTifU0M0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n3lO3eAwV+XvkyUjFQ6EKX0+JfmKVOocSM5GLhOITWoLSDkNxoBEzsYYUFFfGgYVaCv6H+gWjV+kHz8kYtmPHbBO2MLa5PHq7kKkixcEVSp8NEPoCGJYq9X06KF/CTlN2VuWiEAm9YzeIuM7d3PtUZ2a4ao6ljmPeImJoZ0LQP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LaP2dV6I; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2185a9966bcso702190fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 03:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706526142; x=1707130942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTJxbxSOrvcrYc8CLPfFyPhV1mIIGJ+doi7MTifU0M0=;
        b=LaP2dV6IXWS97Y+VST93GD1q3QnR7g3BywIKvSUohWl4eHy5QPpiXI29/90OlWf+Id
         Sw+sVNkTZWyRszzrww45PDhhRT0A4MEniW2uHQwY+yT2/YXJDzdq2e59IZqdWlaM0N3S
         ZPzGTZNborrMx6NvBsdNOT03RDAqciFz9qG//3cm7fwZnOtIrQkUt2WH4aztgTZXYSnC
         VQ2v1YK5NGBb4eNbehYF4B6temnZ3drY714AmwMm/RbYjE/B00cNu7963sU2RfZ/YT0h
         VcoLecojEm4PKmUp5/jVf2zrRDnALdfp3L2+6iLvNJSWeMPWnUXpPzP65xfOv+CYofvG
         6HJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706526142; x=1707130942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTJxbxSOrvcrYc8CLPfFyPhV1mIIGJ+doi7MTifU0M0=;
        b=UsQ0tHLs5GMUv9AAauodGkTCgu1T4GKXBHQdQNG0O5lBeczEvKKGrDiZh4Frnov9Ra
         tDemvtwPtbI+h3xz3P2ty5cKtS/Jemmps/D4qyNOub2FknrE80LtLLs58sL+0x+WR9d3
         +CXf5VcJhD9PkloMvrNF/X4EjYIYk73fv+FcR71HT3g+jOGpT3NZRBaA7YN/LX9zUaTW
         dDtLK7ab6u+Sf37W8dZ0z5qXOsVq4DXJjx8N7SBLP3UvB+d8NYMzOHyWe6b/NIpUS8da
         g8r2ushJODsHYEMxaNzId7fsviTSxlt6Y3afSKoOBUKaPRRkT6pJZP7YfaC0edXQD3Gu
         5+fw==
X-Gm-Message-State: AOJu0YyCV++ewoHepT9WO2P95iD3SMzQTxtf/ByuekZNryhZrRasaS1B
	ROyLU0mHjohvDrIGFwZDowxxf+8bBccpcXE0zNk4/SWVIN7FbM0OefyRSbLEgNPrn/dx4dow7jd
	uYXthA1/Ww6Hz3/psr13H3Fx4kmEXNweJkejkhw==
X-Google-Smtp-Source: AGHT+IFyB6ujhYtsGwcb5sT9gwnpJFYAxXYY7eiiu37ZZfUtpEHnWyotucxQcOKyU9rF1HwrYKMWvXZazIT3hfyDpvA=
X-Received: by 2002:a05:6870:d611:b0:214:76ce:3877 with SMTP id
 a17-20020a056870d61100b0021476ce3877mr2253435oaq.16.1706526141790; Mon, 29
 Jan 2024 03:02:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125062044.63344-1-cuiyunhui@bytedance.com>
 <ZbdYijWK1PnHXn47@xhacker> <CAEEQ3wnSN8dLh3FcmHq5yPwQRdjLQa_VjcuTH+7YYZLOqCzaCQ@mail.gmail.com>
 <ZbdyLJ24I2fa6oNb@xhacker>
In-Reply-To: <ZbdyLJ24I2fa6oNb@xhacker>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 29 Jan 2024 19:02:10 +0800
Message-ID: <CAEEQ3w=gpSTxzxTzh-zHbP37P8s5eVCzG6RZndBXF-U+mNrziw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] RISC-V: add uniprocessor flush_tlb_range() support
To: Jisheng Zhang <jszhang@kernel.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alexghiti@rivosinc.com, samuel.holland@sifive.com, ajones@ventanamicro.com, 
	mchitale@ventanamicro.com, dylan@andestech.com, 
	sergey.matyukevich@syntacore.com, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	apatel@ventanamicro.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jisheng,

On Mon, Jan 29, 2024 at 5:51=E2=80=AFPM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> On Mon, Jan 29, 2024 at 04:26:57PM +0800, yunhui cui wrote:
> > Hi Jisheng,
> >
> > On Mon, Jan 29, 2024 at 4:02=E2=80=AFPM Jisheng Zhang <jszhang@kernel.o=
rg> wrote:
> > >
> > > On Thu, Jan 25, 2024 at 02:20:44PM +0800, Yunhui Cui wrote:
> > > > Add support for flush_tlb_range() to improve TLB performance for
> > > > UP systems. In order to avoid the mutual inclusion of tlbflush.h
> > > > and hugetlb.h, the UP part is also implemented in tlbflush.c.
> > >
> > > Hi Yunhui,
> > >
> > > IIRC, Samuel sent similar patch series a few weeks ago.
> > >
> > > https://lore.kernel.org/linux-riscv/20240102220134.3229156-1-samuel.h=
olland@sifive.com/
> > >
> > > After that series, do you still need this patch?
> >
> > Thank you for your reminder. I didn't find it before I mailed my
> > patch. I just looked at the content of this patch. I understand that
> > my patch is needed. For a single core, a more concise TLB flush logic
> > is needed, and it is helpful to improve performance.
>
> Currently, riscv UP flush_tlb_range still use flush all TLB entries,
> obviously it's is a big hammer, this is what your patch is trying to
> optimize. I'm not sure whether I understand your code correctly or not.
> Let me know if I misunderstand your code.
>
> After patch5 of the Samuel's series, __flush_tlb_range is unified for
> SMP and UP, so that UP can also benefit from recent improvements, such
> as range flush rather than all.

In my opinion, UP does not need to combine some SMP if... else,
on_each_cpu(...) logic, which is also a manifestation of performance
improvement. what do you think?
Thanks,
Yunhui

