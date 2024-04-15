Return-Path: <linux-kernel+bounces-145024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CB78A4E6C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5C77B20946
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A5C67C53;
	Mon, 15 Apr 2024 12:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ereQHwXE"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A0D5B666
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713182634; cv=none; b=aA8JFIz1uB4Hp1rSXr3hPVlxtMkCBfsIsznvePiveRHjJ+QPEIIVBCQu2rEOApoiiCWdi7zimYoUSlKhhh+Urr521apqh3Gl7rYJsHt8clhCmf7Pb0pdFsvvyzi1aiZsVeIE9Pyhag04Fb4s9m64WzOV3Gbe5wRP/cRtNssvtSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713182634; c=relaxed/simple;
	bh=XUdYqSmwVovBEI2SpQ5+Es9BsdYiZplIxqYD7Dd9rUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OH6bzndXzO2x6BWlXj8YPG/k1qeATSQw5BA/nyJ0+BI3K/+JwmAnChsjXvncmUGp7DRiAoAaUIjiYtaQ+Dpg6sZyysvudy24ijTuQ0gxzuIS/rxwkFYpPheIT1uQxy6FddezTsiiEsUfxqFLB2Tj5ybWUaSg24CP/fMiHIsZ2u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ereQHwXE; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2331bef249eso1302662fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 05:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713182630; x=1713787430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUM9SS9JNPHB2GD0yvR5K/5tFBuL0BhdH0M+pWpbQJA=;
        b=ereQHwXEWrlqFaVW5w9wnlvTObVZGGEY4MEJIa0J9co40F022QSKULc5iNhC+GDEzy
         KMUgMTSTdPI6gNpsaOwb/siNe1/NXhdDmuyzmU1V98y6D04rtgxQNFnbxQzYn8Y01Sm0
         srpCZWI2rSZNWDAveRsWQH5jMNDZcYw2uSvHcRvxpwYsDw2GrQtsEFcVSyDLqj4UIQX2
         /Z/DbBwa9mkRpTabX+WdPfXmKn/IqjcHa94wwsn5jv3Iex/ZM/y/Nbl7vwcA+T9j2WcH
         89TDkSF9HO8I3Aj9/5fjIRgJ0/u6J36bvE0ATdtuZqEX8SE3P7RT94ZGIu5Qrdud/Koi
         HAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713182630; x=1713787430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUM9SS9JNPHB2GD0yvR5K/5tFBuL0BhdH0M+pWpbQJA=;
        b=Ity/PzD1hFe8/G7y2CFhaE8b/5mN6nhTowSNo8/iPNGD872hRw51euHjKP9EmMHO0G
         iDiW1EXsd5zJ0u7/uPrYwj3pVOBeTi3mh2r3M7NHB2vHaF1a2U3y+CDacfVtjA2kQ04K
         ITsN6hTERhUiBmuJTPCbfNcixXBNfSQaduOjow9Aarex7YmTy8+EdIXjgJBiIKb6nlPH
         Soihq8CmQzhoP+KieiYro0+MDAdBwLVY9GGyj6AsBykigtc64NJG4y6MTwrc41OE1qlG
         //StVqrloN0K0nLkEnHvyxcdemaKDRJ0V5aZUqjR2KD0ToAKxnbBa1IDGpA4F7LqNRRK
         dwAw==
X-Forwarded-Encrypted: i=1; AJvYcCVbjk0aKKKRfn2jLmh/bqqzvQrOmQ8puhLyA4fjdGlPmQ9lca6GreS8c+TR+Y1X+LfbGnlbv7/7Piu6m6yD4TfU9FDrZcWrEMCTy83/
X-Gm-Message-State: AOJu0YxZou6Y5vwHrusJZrIFZW9UM4Vo8ZvIxeb+Rwgn9N4UNHHskqer
	kuTjTsTQmJ0JBfMh4ptJxRCVnU1k3wKCSMiefvwsOCxKBro3GPyCs+sQKCTfZmu6ORgmUuy00Hs
	lNcGBqNO7DNVp7mer3GGlE13EE/v4SdBdOy2AgQ==
X-Google-Smtp-Source: AGHT+IF+ysnzqvijegluvjiwQKxRcx13O9ZDpCztSQtH8QXKxsIagGyKK5PKiNKWo1TCoNguxXwOTSWqBx38mQ3RLEE=
X-Received: by 2002:a05:6871:28a9:b0:220:8bd2:cd09 with SMTP id
 bq41-20020a05687128a900b002208bd2cd09mr12160806oac.32.1713182629917; Mon, 15
 Apr 2024 05:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240414025826.64025-1-cuiyunhui@bytedance.com>
 <20240414025826.64025-2-cuiyunhui@bytedance.com> <Zhzo_gWFiURs_geD@bogus>
In-Reply-To: <Zhzo_gWFiURs_geD@bogus>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 15 Apr 2024 20:03:38 +0800
Message-ID: <CAEEQ3wkzvOpahzPuoD7=aMG3srjdyCA21tnh-j9PvY3Qerk_hg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 2/3] riscv: cacheinfo: initialize
 cacheinfo's level and type from ACPI PPTT
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, bhelgaas@google.com, 
	james.morse@arm.com, jhugo@codeaurora.org, jeremy.linton@arm.com, 
	john.garry@huawei.com, Jonathan.Cameron@huawei.com, pierre.gondois@arm.com, 
	tiantao6@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sudeep,

On Mon, Apr 15, 2024 at 4:45=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Sun, Apr 14, 2024 at 10:58:25AM +0800, Yunhui Cui wrote:
> > Before cacheinfo can be built correctly, we need to initialize level
> > and type. Since RSIC-V currently does not have a register group that
> > describes cache-related attributes like ARM64, we cannot obtain them
> > directly, so now we obtain cache leaves from the ACPI PPTT table
> > (acpi_get_cache_info()) and set the cache type through split_levels.
> >
> > Suggested-by: Jeremy Linton <jeremy.linton@arm.com>
> > Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  arch/riscv/kernel/cacheinfo.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinf=
o.c
> > index 30a6878287ad..ece92aa404e3 100644
> > --- a/arch/riscv/kernel/cacheinfo.c
> > +++ b/arch/riscv/kernel/cacheinfo.c
> > @@ -6,6 +6,7 @@
> >  #include <linux/cpu.h>
> >  #include <linux/of.h>
> >  #include <asm/cacheinfo.h>
> > +#include <linux/acpi.h>
> >
> >  static struct riscv_cacheinfo_ops *rv_cache_ops;
> >
> > @@ -78,6 +79,28 @@ int populate_cache_leaves(unsigned int cpu)
> >       struct device_node *prev =3D NULL;
> >       int levels =3D 1, level =3D 1;
> >
> > +     if (!acpi_disabled) {
> > +             int ret, idx, fw_levels, split_levels;
> > +
> > +             ret =3D acpi_get_cache_info(cpu, &fw_levels, &split_level=
s);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             /* must be set, so we can drop num_leaves assignment belo=
w */
>
> I intentionally added this above comment to check and drop the below stat=
ement
> if it is already set. Please check if the value is already set when we ca=
ll
> into this function(which I think is the case).
>
> > +             this_cpu_ci->num_leaves =3D fw_levels + split_levels;

Uh,got it. I understand that there is no need to add this line:
"this_cpu_ci->num_leaves =3D fw_levels + split_levels; " , because in
the Master core first it will:
smp_prepare_cpus
     ->init_cpu_topology
          ->for_each_possible_cpu(cpu) {
                 fetch_cache_info(cpu); //num_leaves and num_levels will be=
 set
Then store_cpu_topology->update_siblings_masks->detect_cache_attributes->po=
pulate_cache_leaves().

Slave core will follow the logic of smp_callin->store_cpu_topology().
It's the same after I tested it, so I plan to remove that line and
update V3, what do you think?

Thanks,
Yunhui

