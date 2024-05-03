Return-Path: <linux-kernel+bounces-168149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50498BB44D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7BB31C21604
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5334158D60;
	Fri,  3 May 2024 19:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="2oFPrmCc"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A15A158A04
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 19:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714765463; cv=none; b=jzymy5ArPk0xd6uDKPBAhSD1tUnpIq2WJNitRDqB8vODoYnty8HhsrTxCe8n9Nkkv9OX9+WiDd+6aRtZQvTPSFbqamAdLDQf+e2blvgSnxBi3gSxS1D79MyHA21ZhwtCHImPisLP4QuEsd98MoN1zTXnfEFY1HmFnLxnZtIiEyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714765463; c=relaxed/simple;
	bh=0NLlSbUWjtfkSNMe90tPQL2xSqgQxt8SNfb42yWTU8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGj43Y6+nDU1qy33hFRLD2Of3T72dwraw/orhwU09mSf/av9toxro38+OrwZNVGxWunUbBJfBMwOPvaR063NwRN+7okHzUuDz+ZFF978sU3Od/CBF2qrwe0cPnHWL/iuuoKZzQoRsdB36l9luXSTIdEU8gOr7JPswoydqfi+/Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=2oFPrmCc; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d3907ff128so12827a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 12:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714765461; x=1715370261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGjDpzqhZQyAQMKyqH+Z7WQdcPMW4kVzNIgeNLfdaAY=;
        b=2oFPrmCcjzasyoCpy5AhnCPSBFINufmdYubjfIa/ZpLhV9vXxe8Ab0fmp1qlLA17GO
         N4wUO8m1SF1FI5xDq7sPKJTdsQ5clYcPEWZZCrWDTMWkIou3dNxyeULIUnTkVbWE620S
         8EjzELyznOoBaMQglczLqTy9ZMByUIwdyQwXVuFM0KyvqCb6nEVfaaOj+xMqjK+uSmOV
         VHOp/0s600qSUKASTlwUzDP9u4nsInS/qdtzhnW40vLkks4NHtU4yhIKGx9fm9V52h8i
         Ri0TKS6cMttWgjfe/4yC/lGe6d24MONCPSVfjglG+F4ZyFtcMgbpKCBuy3F4+Mrx3CPt
         5e0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714765461; x=1715370261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGjDpzqhZQyAQMKyqH+Z7WQdcPMW4kVzNIgeNLfdaAY=;
        b=eH71HYY6Yl36iMixrtGV5NTT9jsxlyFENkYtS/UUaTgaVqIKSOhqFY7Z1+c+9+cISr
         vt1LLpxi0TtUWUp/XGCRU1zHmkxEiAamIMzozZ0sFAVl92dDNqwgVcZ76yrTSn3LYIuZ
         WQamCzIOIP06LDmG2RS1RC6XSjXoFvLGDcD/BAIqbIC46NDjp8J6oldtQT+ImLh1IJN4
         FtLchqDSOnP2IS+w3vbiptytuEeqMrIuOXOdiTj+KbTmtfGoKR4+C0jRalhOOn6g8ovE
         +IrgDI4j5ZfWDgMcs1zX5qLtJUxZTXTGBGvQ17R9PKMo9bq7iZr4ivnNECe1adoIK0hF
         foLA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ0ktL3mRnbePQ3q09j4Cq+cJuTXxt4MEbelKdp0GKcixzU31ylqw7xDovMFM/j6LF6n9EUcme0+oj1h6EcYm08to6tBQO8m/cU0gM
X-Gm-Message-State: AOJu0Yx4p51t387ymxZKIEbMYSvUNlmoMywlCJ4FQ8DYwsBUCDb/5/tD
	Qeb3mdLZAg+DMRw7gbcUoCbnVa9lAI/V9HiD3tmevba7j/liDUioAmYCq1D7FJ0kAOVaPPtLev2
	EzEwxZ7P+BWQOEEHBeQ24zNCdmkm60EKZPSos+Q==
X-Google-Smtp-Source: AGHT+IHresXDj8zjJo2L5u68znPjhx0ovrbhxu+59NRfgJ//aE/UKF6ubHAqLADqE7qY9hVfIpPoveM7rHNL5OQZ3Ao=
X-Received: by 2002:a17:90b:354e:b0:2b4:33ee:25a1 with SMTP id
 lt14-20020a17090b354e00b002b433ee25a1mr3442632pjb.26.1714765460928; Fri, 03
 May 2024 12:44:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714494653.git.tjeznach@rivosinc.com> <b83f81c04d1f3885d860b1eec03761fe63a33183.1714494653.git.tjeznach@rivosinc.com>
 <20240501145621.GD1723318@ziepe.ca> <CAH2o1u63GjMnYrfa8W-c1hdp+TAA0R-FyxXM4dEiFF+KEGWwbA@mail.gmail.com>
 <20240503181059.GC901876@ziepe.ca>
In-Reply-To: <20240503181059.GC901876@ziepe.ca>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Fri, 3 May 2024 12:44:09 -0700
Message-ID: <CAH2o1u7av8zMucB2sKxBOZtd1eqEC4Qmgin=8VQ03pWbQdZUUg@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] iommu/riscv: Paging domain support
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 11:11=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Fri, May 03, 2024 at 10:44:14AM -0700, Tomasz Jeznach wrote:
> > > > +     list_for_each_entry_rcu(bond, &domain->bonds, list) {
> > > > +             if (bond->dev =3D=3D dev) {
> > > > +                     list_del_rcu(&bond->list);
> > > > +                     found =3D bond;
> > > > +             }
> > > > +     }
> > > > +     spin_unlock_irqrestore(&domain->lock, flags);
> > > > +
> > > > +     /* Release and wait for all read-rcu critical sections have c=
ompleted. */
> > > > +     kfree_rcu(found, rcu);
> > > > +     synchronize_rcu();
> > >
> > > Please no, synchronize_rcu() on a path like this is not so
> > > reasonable.. Also you don't need kfree_rcu() if you write it like thi=
s.
> > >
> > > This still looks better to do what I said before, put the iommu not
> > > the dev in the bond struct.
> > >
> > >
> >
> > I was trying not to duplicate data in bond struct and use whatever is
> > available to be referenced from dev pointer (eg iommu / ids / private
> > iommu dev data).
>
> I'm not sure that is a valuable goal considering the RCU
> complexity.. But I suppose it would be a bit of a hassle to replicate
> the ids list into bond structurs. Maybe something to do when you get
> to ATS since you'll probably want to replicate the ATS RIDs. (see what
> Intel did, which I think is pretty good)
>
> > If I'm reading core iommu code correctly, device pointer and iommu
> > pointers should be valid between _probe_device and _release_device
> > calls. I've moved synchronize_rcu out of the domain attach path to
> > _release_device, LMK if that would be ok for now.  I'll have a
> > second another to rework other patches to avoid storing dev pointers
> > at all.
>
> Yes, that seems better.. I'm happier to see device hot-unplug be slow
> than un attach
>
> There is another issue with the RCU that I haven't wrapped my head
> around..
>
> Technically we can have concurrent map/unmap/invalidation along side
> device attach/detach. Does the invalidation under RCU work correctly?
>
> For detach I think yes:
>
>    Inv CPU                                   Detach CPU
>
>   write io_pte                               Update device descriptor
>   rcu_read_lock
>     list_for_each
>       <make invalidation command>            <make description inv cmd>
>       dma_wmb()                              dma_wmb()
>       <doorbell>                             <cmd doorbell>
>   rcu_read_unlock
>                                              list_del_rcu()
>                                              <wipe ASID>
>
> In this case I think we never miss an invalidation, the list_del is
> always after the HW has been fully fenced, so I don't think we can
> have any issue. Maybe a suprious invalidation if the ASID gets
> re-used, but who cares.
>
> Attach is different..
>
>    Inv CPU                                   Attach CPU
>
>   write io_pte
>   rcu_read_lock
>     list_for_each // empty
>                                              list_add_rcu()
>                                              Update device descriptor
>                                              <make description inv cmd>
>                                              dma_wmb()
>                                              <cmd doorbell>
>   rcu_read_unlock
>
> As above shows we can "miss" an invalidation. The issue is narrow, the
> io_pte could still be sitting in write buffers in "Inv CPU" and not
> yet globally visiable. "Attach CPU" could get the device descriptor
> installed in the IOMMU and the IOMMU could walk an io_pte that is in
> the old state. Effectively this is because there is no release/acquire
> barrier passing the io_pte store from the Inv CPU to the Attach CPU to th=
e
> IOMMU.
>
> It seems like it should be solvable somehow:
>  1) Inv CPU releases all the io ptes
>  2) Attach CPU acquires the io ptes before updating the DDT
>  3) Inv CPU acquires the RCU list in such a way that either attach
>     CPU will acquire the io_pte or inv CPU will acquire the RCU list.
>  4) Either invalidation works or we release the new iopte to the SMMU
>     and don't need it.
>
> But #3 is a really weird statement. smb_mb() on both sides may do the
> job??
>

Actual attach sequence is slightly different.

 Inv CPU                            Attach CPU

 write io_pte
  rcu_read_lock
    list_for_each // empty
                                    list_add_rcu()
                                    IOTLB.INVAL(PSCID)
                                    <make description inv cmd>
                                    dma_wmb()
                                    <cmd doorbell>
 rcu_read_unlock

I've tried to cover this case with riscv_iommu_iotlb_inval() called
before the attached domain is visible to the device. This is something
to optimize to avoid invalidating the whole PSCID if the domain was
already attached to the same IOMMU, but I'd leave it for a separate
patch series.

> > > The number of radix levels is a tunable alot of iommus have that we
> > > haven't really exposed to anything else yet.
> >
> > Makes sense. I've left an option to pick mode from MMU for cases where
> > dev/iommu is not known at allocation time (with iommu_domain_alloc()).
> > I'd guess it's reasonable to assume IOMMU supported page modes will
> > match MMU.
>
> Reasonable, but for this case you'd be best to have a global static
> that unifies the capability of all the iommu instances. Then you can
> pick the right thing from the installed iommus, and arguably, that is
> the right thing to do in all cases as we'd slightly prefer domains
> that work everywhere in that edge case.
>

That is a viable option. If you're ok I'll address this as a separate patch=
.
I've been trying to avoid adding more global variables, but it might
not be avoidable.

> Jason

Best,
- Tomasz

