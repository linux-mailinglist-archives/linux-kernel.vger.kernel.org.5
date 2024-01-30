Return-Path: <linux-kernel+bounces-43877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE411841A53
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 044121C221AB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C763717D;
	Tue, 30 Jan 2024 03:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ip+gW+Ve"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB5F37152
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706584725; cv=none; b=j6W25ZRx3YA4IH6r4robG/FZNzzPPqZsGlNjiSrUAopUgR6Eb2KLAME7SmFxoEl8tjDn+yPL3pq7LICzb40dvSLZ9ulc2i6FPLGtU6ICSp8filGRuhcLX63iqn/nFqqRZ5RX535A6jYvEZd3CiENV7tSdblMGMUnE7u/PMDGfSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706584725; c=relaxed/simple;
	bh=0tsSKt6lkSZda2RgWTGSLfUCs4NSgTk8YkR/HGv8Ilk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUQXXDkJjy5pdHU7K2FFoGFAdmid+8I5eIt+FF4RSz7jiweduvSOR0Rm3lo1MWtq04G/pVqWbOIkrqiNFS06zXQx7mCN6qX6qSsMcJQFZ+1VOKO11z+7qQ9v2QHr1qTm4LO3KM86vpZGhsIrHMptij1Pzo0WaRz2N1Yxp3KG78Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ip+gW+Ve; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-21481a3de56so2171630fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706584722; x=1707189522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tsSKt6lkSZda2RgWTGSLfUCs4NSgTk8YkR/HGv8Ilk=;
        b=ip+gW+VehydOV4dOHQmDcA6UUjN+VsPQK3HEwYsoOuEroOvBVXvzaU05PYVqILfhqj
         +591zuJkxzFd7dc/DeSkEq1+yEVVWTrpVjHrvehw6H4Cstf/wXvJe8qecS7zn4CcRjDY
         QylOxKJo9xujWDY2l63QHNTl6p8tdgcpJeMwfLN8UWgaFF4ifJymF8/z70Ti3zQbkPT1
         ZoTX6S4oIL+PRYrRmT1wfEGoZk+xzsN3IgvISeICQiDWjqrLvy1YAPauV8mQ8Ky4B72n
         szviH/NuytP/WkPATw1HlbHZO5eSUELv5chLO2DzbubZAuPoth+M8JSCqIn3bkbX0Kvs
         vopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706584722; x=1707189522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tsSKt6lkSZda2RgWTGSLfUCs4NSgTk8YkR/HGv8Ilk=;
        b=EShDq02KLhLsM98r8/PqO3f2n9w9zupye+RqlmySD1xLIaPsiQvf4p+ukbzVsN9Ax4
         LXavA9wApr+wu2BBQveMohPE+w6Mi5Vg/4R8ct6ARmeDazH+JdQ3cVOMIyXOcqnLBOaH
         zfRk4KGgHcoiD+m42MMkMRZCSKJF6Deleve946nSUcTP26YbJF/0mNLhbHBkYLye8RQn
         WZWnhVbxun61jPHnBkiSu7WIgiG1KvVk7mmBRgH/yLNJ5Mn5D+WKok/z+RhSoTKiRP97
         UddmAoC38Dxk91afpMg28iFOjO1sP0Jr9N9HKBI7Zm/0tIj7vQOzMIxCLBUedJTaZ953
         KJHQ==
X-Gm-Message-State: AOJu0Ywku9OvJr0VRlbn2CSLY+aRiP29ygkunjJYfcjZmcSx5GqW0jD3
	kBvc5oU0kXvMPPjDPJg+ofhMBFA0Y8kEcZl2hwiAJBhjQeWFeyFP/7vl91AffOG4L6JbEvzhFJa
	Q6j/zwepB8T1TgAcxRlgsJzCIks18/sFA7NvPxg==
X-Google-Smtp-Source: AGHT+IEnApZiO6fO+ZztjhLKw2ACObTpDVhy9g1oXuXUYkA9KkWANrP+yAqwJY4XdWOHjz7JDnisD2oN/bRT8QaUxTo=
X-Received: by 2002:a05:6870:a18f:b0:218:3f78:a279 with SMTP id
 a15-20020a056870a18f00b002183f78a279mr7918052oaf.45.1706584722255; Mon, 29
 Jan 2024 19:18:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125062044.63344-1-cuiyunhui@bytedance.com>
 <ZbdYijWK1PnHXn47@xhacker> <CAEEQ3wnSN8dLh3FcmHq5yPwQRdjLQa_VjcuTH+7YYZLOqCzaCQ@mail.gmail.com>
 <ZbdyLJ24I2fa6oNb@xhacker> <CAEEQ3w=gpSTxzxTzh-zHbP37P8s5eVCzG6RZndBXF-U+mNrziw@mail.gmail.com>
 <ZbeRgRBhvNnnTd8h@xhacker>
In-Reply-To: <ZbeRgRBhvNnnTd8h@xhacker>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 30 Jan 2024 11:18:31 +0800
Message-ID: <CAEEQ3wmoQ=f9OWu5FsuinFDRUtGE6kFk6xac-diYD664Mt_VFg@mail.gmail.com>
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


On Mon, Jan 29, 2024 at 8:05=E2=80=AFPM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> On Mon, Jan 29, 2024 at 07:02:10PM +0800, yunhui cui wrote:
> > Hi Jisheng,
> >
> > On Mon, Jan 29, 2024 at 5:51=E2=80=AFPM Jisheng Zhang <jszhang@kernel.o=
rg> wrote:
> > >
> > > On Mon, Jan 29, 2024 at 04:26:57PM +0800, yunhui cui wrote:
> > > > Hi Jisheng,
> > > >
> > > > On Mon, Jan 29, 2024 at 4:02=E2=80=AFPM Jisheng Zhang <jszhang@kern=
el.org> wrote:
> > > > >
> > > > > On Thu, Jan 25, 2024 at 02:20:44PM +0800, Yunhui Cui wrote:
> > > > > > Add support for flush_tlb_range() to improve TLB performance fo=
r
> > > > > > UP systems. In order to avoid the mutual inclusion of tlbflush.=
h
> > > > > > and hugetlb.h, the UP part is also implemented in tlbflush.c.
> > > > >
> > > > > Hi Yunhui,
> > > > >
> > > > > IIRC, Samuel sent similar patch series a few weeks ago.
> > > > >
> > > > > https://lore.kernel.org/linux-riscv/20240102220134.3229156-1-samu=
el.holland@sifive.com/
> > > > >
> > > > > After that series, do you still need this patch?
> > > >
> > > > Thank you for your reminder. I didn't find it before I mailed my
> > > > patch. I just looked at the content of this patch. I understand tha=
t
> > > > my patch is needed. For a single core, a more concise TLB flush log=
ic
> > > > is needed, and it is helpful to improve performance.
> > >
> > > Currently, riscv UP flush_tlb_range still use flush all TLB entries,
> > > obviously it's is a big hammer, this is what your patch is trying to
> > > optimize. I'm not sure whether I understand your code correctly or no=
t.
> > > Let me know if I misunderstand your code.
> > >
> > > After patch5 of the Samuel's series, __flush_tlb_range is unified for
> > > SMP and UP, so that UP can also benefit from recent improvements, suc=
h
> > > as range flush rather than all.
> >
> > In my opinion, UP does not need to combine some SMP if... else,
> > on_each_cpu(...) logic, which is also a manifestation of performance
>
> Hi Yunhui,
>
> IIRC, the compiler will optimise out the unnecessary logic under UP, I
> may misread the code. But if no, indeed, there's improvement room.
> However, even in this case, IMHO, it's better if you can base on
> Samuel's series.
> Anyway, the optimization(range tlb entries rather than *all* entries unde=
r
> UP case) you want to do has been implemented. While I'm not sure whether
> we can rely on the compiler to optimize out all unnecessary logics.

Okay, let's see if there are any necessary optimizations based on
Samuel's series.

Thanks,
Yunhui

