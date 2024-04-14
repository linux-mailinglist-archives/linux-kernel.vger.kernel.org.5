Return-Path: <linux-kernel+bounces-143943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE218A3FF2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 04:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F38001C21126
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 02:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E643615E9B;
	Sun, 14 Apr 2024 02:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LJcNZyEl"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D764134C6
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 02:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713062448; cv=none; b=Hfcm7uP9Hu5dTfGMwUUIgcjnNPalm6arRdz63TN8PkcpXINiDLEOCrx5gMBVx2Tm2YlIuXv+qn8CCWNMfWw/2WfdUOYtCKcx9XWxQkeCOJJ0XGTrS8T8oIPDcIsCbR7KS4qr5KT3O22mzgabnq6GAzeE2T2EOqGpMTYT9sRArGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713062448; c=relaxed/simple;
	bh=0Ra2rBygaHTvfTYkSYizmWffraI2B7qG+UW9u4YkyTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmB/Vi8T3O3wVE4c2LmoG0ztrgRJ8+M2qY6pKersMbv3uJwUpeKyqkmnVdtZM5IU7ldrulHygLmhjVOKVa3p1G8rmfnDGUgAbZtS3xoxjJfa8KkGHo1iYVZCoEBYeV678klfD8kCyDM4HsyUOqG/AxY394L7S3NaAqbOGH/y0jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LJcNZyEl; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-23408962585so762823fac.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 19:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713062445; x=1713667245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wg5h8uRNuNN02FjEj+e/nOQiSG+uVSKaRhJ+VyPOQkA=;
        b=LJcNZyElY+lxZOUa6/2/PqerXM1BPLTDrSEGTV4620D4ndO+e24/m8Cw2eVNtmHQKt
         BEoy3dDOUa+9m1uODs6cjGLzv5IeA48roPQtoXQnLK+Jm/xYmlXjwDV38b4gz0J01Eye
         hDvsdMGZqzt7LgsjqAs1ECLowI7JjXAcrHmUsMItdN45yDpdsub1nmaXdPi5rT7rShE7
         nyaYcB/Nj8bfKOn+N6cxifnanRhFuglh/aqfXyjjZC3RjN6mcA3XD53lrdboTNfzCEys
         B7Ytx0MUtui72BLQAu+ZBaLLotTbjIdAy6RoBjz3ryqYfYOUmhMQSz4bSaNYIdpYfM4h
         mcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713062445; x=1713667245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wg5h8uRNuNN02FjEj+e/nOQiSG+uVSKaRhJ+VyPOQkA=;
        b=PIozvbI4hk1pvpr0X1/MNHh6zTmVdvaBF6t6+PyE6L/JbS934Ts9/MxDe5sRpllzbr
         vpX0+GJ7BPnNFfHPgR4IblCzuLrXiWn+Q4gDRITaR1GUmz+YxCR5jcpMKRO2WW+Ja3Ev
         y3MtRW2NvNqdj5X8nC+Yo86/hfaxIeO5YJ/zWKufGbxZtFCi/+DLrmHzQBZ02YOG9Eeo
         GsN//gNuRrhkI9kWeyDg/1sFnZetqDuFmDrq4XNwXeQltWCcl4ODQwBSV+/ioFqtFMOv
         lxB3pcr9/LZLv0pfGZ4+Z2bHyhCFT3snHRIWAjMOmtqZw3hasOAmIIhMXw/UOs2X9w5X
         xCVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9Nw5xSTPiU9yNLt+5wp7GVRJFGJ0wUn3pt+okh27k5vp8q4kwzuOllPji3IxchefujgswUK4Q6mbZyOF6/VY10yHLvasBJAip7NDy
X-Gm-Message-State: AOJu0YwimIHNTQBSyp5uUKkgwSEAPYxt6gPdXJodM++/QX3hi/PA2Mg/
	xJKQddKNDnFCE6jnRk2WqqPjICvGfvPkqkmJI9OAK65k19Eh5xHztGv/uH8Xb+L202t2GUQXfIp
	XsusADmMM1lq3aPOfkULE7BFLhWMMW3iNacHsjQ==
X-Google-Smtp-Source: AGHT+IGG1vbolPF8XedWyN268VhRLxaCyGKWzCADzcv/mukMs/gFqjPg6R/T4v4fW1herfdfnjmDrf4faIvQBZtWKe8=
X-Received: by 2002:a05:6871:322f:b0:21e:9aa5:f3f7 with SMTP id
 mo47-20020a056871322f00b0021e9aa5f3f7mr5658929oac.58.1713062445707; Sat, 13
 Apr 2024 19:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407123829.36474-1-cuiyunhui@bytedance.com>
 <abd135fa-c432-4e37-9792-07a0e17e93d5@arm.com> <CAEEQ3w=+C2J0ZS227-1P-B+pe_NRp_3i4c4CxGssiKqbpXx_qw@mail.gmail.com>
 <2cde00c8-7878-45c0-8621-fca4e70c75e7@arm.com> <ZhlcYRolZwm7UwJu@bogus> <Zhlg67dbl_S1GD0u@bogus>
In-Reply-To: <Zhlg67dbl_S1GD0u@bogus>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Sun, 14 Apr 2024 10:40:34 +0800
Message-ID: <CAEEQ3w=VrQRammHcKBhT=YGPTZ=ktK9PDhLCBM9ODpYMJw_=-Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/2] ACPI: PPTT: Populate cacheinfo
 entirely with PPTT
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>, rafael@kernel.org, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sudeep=EF=BC=8CJeremy=EF=BC=8C

On Sat, Apr 13, 2024 at 12:27=E2=80=AFAM Sudeep Holla <sudeep.holla@arm.com=
> wrote:
>
> On Fri, Apr 12, 2024 at 05:08:01PM +0100, Sudeep Holla wrote:
> > diff --git i/arch/riscv/kernel/cacheinfo.c w/arch/riscv/kernel/cacheinf=
o.c
> > index 09e9b88110d1..92ab73ed5234 100644
> > --- i/arch/riscv/kernel/cacheinfo.c
> > +++ w/arch/riscv/kernel/cacheinfo.c
> > @@ -79,6 +79,27 @@ int populate_cache_leaves(unsigned int cpu)
> >         struct device_node *prev =3D NULL;
> >         int levels =3D 1, level =3D 1;
> >
> > +       if (!acpi_disabled) {
> > +               int ret, fw_levels, split_levels;
> > +
> > +               ret =3D acpi_get_cache_info(cpu, &fw_levels, &split_lev=
els);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               /* must be set, so we can drop num_leaves assignment be=
low */
> > +               this_cpu_ci->num_leaves =3D fw_levels + split_levels;
> > +
> > +               for (idx =3D 0; level <=3D this_cpu_ci->num_levels &&
> > +                    idx < this_cpu_ci->num_leaves; idx++, level++) {
> > +                       if (level <=3D split_levels) {
> > +                               ci_leaf_init(this_leaf++, CACHE_TYPE_DA=
TA, level);
> > +                               ci_leaf_init(this_leaf++, CACHE_TYPE_IN=
ST, level);
> > +                       } else {
> > +                               ci_leaf_init(this_leaf++, CACHE_TYPE_UN=
IFIED, level);
> > +                       }
> > +               }
>
> Ofcourse we need to add here,
>                 return 0;
>
> > +       }
> > +
> >         if (of_property_read_bool(np, "cache-size"))
> >                 ci_leaf_init(this_leaf++, np, CACHE_TYPE_UNIFIED, level=
);
> >         if (of_property_read_bool(np, "i-cache-size"))
> >
>
> --
> Regards,
> Sudeep

With this modification, I tested that I can obtain cacheinfo
correctly. If RISC-V later adds a new register describing the cache,
then we can continue to improve it in populate_cache_leaves().
Thank you for your comments and I will add you as Suggested-by in v2.

Thanks,
Yunhui

