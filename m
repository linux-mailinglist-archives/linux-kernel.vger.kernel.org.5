Return-Path: <linux-kernel+bounces-151056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616FC8AA86A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C9301C210B6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A2C219F9;
	Fri, 19 Apr 2024 06:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="M/tcyPTn"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75ACBA2B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 06:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713508073; cv=none; b=Y+G4iV6hWdcbJxxpZMnc4hp+3wiDz3hNv/W33kgT96/jIXvfWQSKjlNQXkGqnvv0Wb6qbOeWWS1VX0QcJJGm9e/U7qnEbvXpI5uM5UNvKKLOTNkXZT16xeLvRdBOrLdyp8/BfY3tlYtmEcnPqsp/pVNBket2sN1TgWgIQTvLwNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713508073; c=relaxed/simple;
	bh=PMENbycWR80LGlHz52du/Cq3m/a213RCoUDFiAYhtY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GntnAtselgkhz2fFwLAFCGKkooFUDc1f/e49mqT5XYQFuXfslJH5I4Cyks0ZNchBlwzyyqAK78Y6DkU34/wolBWOnMtTsbYbe+a5WpRuffeQtedl/6fafCqeztfMBZinEcGv831UIvRbuU8m2TbOAlTkxOGZcgOXxdvM0XuDs2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=M/tcyPTn; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5aa20adda1dso1131566eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 23:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713508071; x=1714112871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6YFkKyn5/BuCOc0JMepcoAMu+9H+aV4NIJoWyR8Zmo=;
        b=M/tcyPTnE5ZD/PbrQ+fOniKs7YhuPzwDTJTfLseLzb94xmgWvJVRORDzf4rpbqdGq/
         /GrcmqlgRnRKQ6eHKzM4LDZbMTQov/Gi1EwEpigFnCarVoAmzfvtSccx97rhb6M6vPCj
         1fb0VTpTfV05UEdOiyiovSskdopJ18PYX/4ubrauC6uTZau4LVMq/KQV0B+NSBvDkwP4
         /TH2IlYYskJBBe4mjtM+qJEXXhL0PTtjnzPhTjljnqWufeb4AC5n9EkBI1jHQIslSENV
         5/NUm3mXI5d3O4/lJN1SF4VljL+mjMJ8rS746MynWLdiKyNEZGm2SsO58ad5/AgbFmEn
         UbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713508071; x=1714112871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6YFkKyn5/BuCOc0JMepcoAMu+9H+aV4NIJoWyR8Zmo=;
        b=hKEBNktZlWN83P8MwfgN1sEpZc9Ji7J4V3+yAtiAKRRaltEZYI6zQZoo1GCiZSdvJu
         WyOXJVlyRRTQ9rTLvA+9IhB1IR0/KfODjUlUwqzDQEtGA78xyp62ESEE0Tx68Qw8Eq20
         ABOsgmAmP3GKnqPDFU6AumDMvHc0DFh7sKuBiPUd3WJbCRvsCNPQ47PFqzwAwzQ6DQVf
         yqp5SSj29Ni9yIPapmDP8wV2wn1+xPP79IQ+JCt5oAVAo/i+ShxhLpUeeHwCm1joG9ws
         a/KhjPdS6SIXf6XN9AhEhvw5o8RMfOoTpBHOzhG8D55masEWwR9bBBhZNE8Yc3RL9pvX
         4eww==
X-Forwarded-Encrypted: i=1; AJvYcCWHZd8zAiDTN6kiQc6jXUR3wkgoZY1c4fuVUoptgCQXVBdWQxRA1o1XP+G061i9zmGN5jgTwkXu0kTIWqss/XJcWnYBj5qI+yRzyLDF
X-Gm-Message-State: AOJu0Yw7E5+HQsiUTxY3YHhOZNlQZAGOzlkM0vwoCmuMUEKiSD6bo2+x
	ILp24c2uaRlbK3wPz9wdYK3Hya6iik42uDfn7+fXG5TvN6vsKi6TBVEswhdzrOsPk0kUJYXms4H
	75eQGo9LYRAyRHw9qPt7wHZDg0SrFbQ+mHVl/rA==
X-Google-Smtp-Source: AGHT+IGf8SONi2t4Gq3O9Mc0MZ15L3EcbK72rX/+CNgR7DC3KTPhm36jDoIozEgIKj5ptE6BCWlUi4kFxG6WxMLgMps=
X-Received: by 2002:a05:6870:b14c:b0:22e:a7a1:6e56 with SMTP id
 a12-20020a056870b14c00b0022ea7a16e56mr1339830oal.29.1713508071026; Thu, 18
 Apr 2024 23:27:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418034330.84721-1-cuiyunhui@bytedance.com>
 <20240418034330.84721-2-cuiyunhui@bytedance.com> <20240418084144.go3zk5yycsg6e2k2@bogus>
In-Reply-To: <20240418084144.go3zk5yycsg6e2k2@bogus>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 19 Apr 2024 14:27:39 +0800
Message-ID: <CAEEQ3wm-t1DM+5d4ugr+dM+g4oBLwpOtLM=C2f=NAfOF_u0bUw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 2/3] riscv: cacheinfo: initialize
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

Hi palmer,

On Thu, Apr 18, 2024 at 4:42=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Thu, Apr 18, 2024 at 11:43:29AM +0800, Yunhui Cui wrote:
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
> >  arch/riscv/kernel/cacheinfo.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinf=
o.c
> > index 30a6878287ad..e47a1e6bd3fe 100644
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
> > @@ -78,6 +79,27 @@ int populate_cache_leaves(unsigned int cpu)
> >       struct device_node *prev =3D NULL;
> >       int levels =3D 1, level =3D 1;
> >
> > +     if (!acpi_disabled) {
> > +             int ret, fw_levels, split_levels;
> > +
> > +             ret =3D acpi_get_cache_info(cpu, &fw_levels, &split_level=
s);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             BUG_ON((split_levels > fw_levels) ||
> > +                    (split_levels + fw_levels > this_cpu_ci->num_leave=
s));
> > +
> > +             for (; level <=3D this_cpu_ci->num_levels; level++) {
> > +                     if (level <=3D split_levels) {
> > +                             ci_leaf_init(this_leaf++, CACHE_TYPE_DATA=
, level);
> > +                             ci_leaf_init(this_leaf++, CACHE_TYPE_INST=
, level);
> > +                     } else {
> > +                             ci_leaf_init(this_leaf++, CACHE_TYPE_UNIF=
IED, level);
> > +                     }
> > +             }
> > +             return 0;
> > +     }
> > +
>
> Much better, so my review still stands =F0=9F=98=84
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>
> >       if (of_property_read_bool(np, "cache-size"))
> >               ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
> >       if (of_property_read_bool(np, "i-cache-size"))
> > --
> > 2.20.1
> >
>
> --
> Regards,
> Sudeep

Do you have any comments about this patch series?

Thanks,
Yunhui

