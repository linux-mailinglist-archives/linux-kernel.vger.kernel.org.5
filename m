Return-Path: <linux-kernel+bounces-163284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFB48B683A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4749B1C2195E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C80F9CD;
	Tue, 30 Apr 2024 03:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dZcj1YtF"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D530C8480
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 03:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714446989; cv=none; b=t6hTuGK/3qvWZUEPRCJWN7l4fPtIHkPqa2paSpFkj9PrgKS458aD73AbPUzWm1kulPCCMMj72X3XM37hE2mRgQ777ZJtfdyXu8wllklouYqbJZ/vT4jmAxBfb7bwabMFPq3E8XYamGkAKW4x4GNukaspbxhiiFjl7NQLTRkAEFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714446989; c=relaxed/simple;
	bh=J9Uks/wSVBDMZDqvqL821ZvLl/AHfaZ2zTTwqy+dauc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aiYRlNKYIBNKYVXEBzLurSdFg9uqpvzBpHzJzDePWgzx73Ysp2ojuoPeWyYVwZxItDlwsj8UeYjO0O0T7Df/0QAvemyldwFTgxULB6snuECvAZESRM/AJOdKMJnDkOEToEeBjgbxUnkW9QnMIVYQziN7V87UK2dm9X8NdVMLr1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dZcj1YtF; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6ee3042cb98so1060761a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1714446987; x=1715051787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewLuAUPPP39X0HCkRHtN2NHvevZusHejI+aydV0tNX4=;
        b=dZcj1YtFnMMluykz4azkZGm9/O7ZO7Q5DPepNAohogxeowhN4VBCqIe+qz789KDMU9
         +ry426yB4YDDXoOlqvjbCkmiK/n5ODyq7nhWkxrSKvwilm/FTIL4kmkGt2NFEaWlKk9J
         R9wJkjNwADkJQPNb/5SeC1Gqv+tTS9FVRHFxh/ryki7uuW3N1++2+MtO8x+kvuRXwxvK
         05ZWMl/yy9NOIIgGKliQIuxIwBpyQvNBY23zxS5B8YDqqof/WkFvt6FohflLkeJ/hVPy
         7ReQ1vpO3c/bci5tQpDAOA+bNgJZQS7pEQg0tmumsq8oZlMvoi3x+x7/xMKeNASZ8SKG
         OOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714446987; x=1715051787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewLuAUPPP39X0HCkRHtN2NHvevZusHejI+aydV0tNX4=;
        b=BiuqqYHhy4tvApbOpayP6Gb1aV/3QlydC0oHfAazxhkCAxAgZofYd7tmVDVNS82O8b
         6w9a8dWu3Sop+YBpCzqQ+klUiUkS2g/Q5sRbvh+ZMn8t8l6yGNboJfj46dYAjFXvsy4t
         eJ4LwpFg1IBgtCN9uvv5eIvuCHxOejD8fXornlMKMMu8hXjdZaG4Zuw1vzaOKoIKNI+y
         MrTt245clqWXI5v6qm+TdQ14Y7KgLmFKxUTdHbx8luI+7DlsaslRwRNZXVFn0Xk1iOU9
         mGJ3VZypgHqoV5A2r6ikU2zVAxnAeziUcgeAzUuvt/i7Z3xbB+ePLZopku2DA4DauuMx
         XE2A==
X-Forwarded-Encrypted: i=1; AJvYcCVV3cn/Itpin7UqUXw+MoPutsALHgzkV+6L6CAw8vdztEfuiQJgVJrjWKtd4KlInFqSOZ+VQHCrIv1c44XNdfMHuipS3o36djOoMh/7
X-Gm-Message-State: AOJu0YyYC57dFSodCf+2NCCm39+l46SVkAUWH/z/hpZafvWdLBiwOAmB
	yT+l1/PGSDTUlaHDoWcX2zrznFCj8jLy3DuWkp/SUC+AU0KdW7tOqqB6O3qEkKO/6e8oSwN8d8Q
	6eoJQOvx0t8XAaGsYQoJv3eL2rc2YQR7GszqtjA==
X-Google-Smtp-Source: AGHT+IHQZKM1ZIvOzc0BTAWTiBchrFVz/jaxMvcm4J0YS/D7nzOQrjehDvNXZEDRtLipEVRhqNLnJGXaHB+hLjHZ7EU=
X-Received: by 2002:a05:6871:8912:b0:23c:2554:d8b7 with SMTP id
 ti18-20020a056871891200b0023c2554d8b7mr8543686oab.20.1714446986897; Mon, 29
 Apr 2024 20:16:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418034330.84721-1-cuiyunhui@bytedance.com>
 <20240418034330.84721-2-cuiyunhui@bytedance.com> <d143cd11-26ea-42e3-8f32-700a34b3705e@arm.com>
 <CAEEQ3wkDMuu+jh56YB3G0vY_ENdUjDL6byMsJXd0C9aQu1FZKw@mail.gmail.com>
In-Reply-To: <CAEEQ3wkDMuu+jh56YB3G0vY_ENdUjDL6byMsJXd0C9aQu1FZKw@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 30 Apr 2024 11:16:15 +0800
Message-ID: <CAEEQ3w=FJMzkL3_if1rQcHCUu0C9PVJzL3D3yytNLr-y3YS5nw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 2/3] riscv: cacheinfo: initialize
 cacheinfo's level and type from ACPI PPTT
To: Jeremy Linton <jeremy.linton@arm.com>, Palmer Dabbelt <palmer@rivosinc.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, aou@eecs.berkeley.edu, 
	linux-riscv@lists.infradead.org, bhelgaas@google.com, james.morse@arm.com, 
	john.garry@huawei.com, Jonathan.Cameron@huawei.com, pierre.gondois@arm.com, 
	sudeep.holla@arm.com, tiantao6@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Palmer,

Gentle ping...

On Tue, Apr 23, 2024 at 7:03=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.com=
> wrote:
>
> Hi Palmer,
>
> On Fri, Apr 19, 2024 at 11:29=E2=80=AFPM Jeremy Linton <jeremy.linton@arm=
com> wrote:
> >
> > Hi,
> >
> > On 4/17/24 22:43, Yunhui Cui wrote:
> > > Before cacheinfo can be built correctly, we need to initialize level
> > > and type. Since RSIC-V currently does not have a register group that
> > > describes cache-related attributes like ARM64, we cannot obtain them
> > > directly, so now we obtain cache leaves from the ACPI PPTT table
> > > (acpi_get_cache_info()) and set the cache type through split_levels.
> > >
> > > Suggested-by: Jeremy Linton <jeremy.linton@arm.com>
> > > Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > ---
> > >   arch/riscv/kernel/cacheinfo.c | 22 ++++++++++++++++++++++
> > >   1 file changed, 22 insertions(+)
> > >
> > > diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cachei=
nfo.c
> > > index 30a6878287ad..e47a1e6bd3fe 100644
> > > --- a/arch/riscv/kernel/cacheinfo.c
> > > +++ b/arch/riscv/kernel/cacheinfo.c
> > > @@ -6,6 +6,7 @@
> > >   #include <linux/cpu.h>
> > >   #include <linux/of.h>
> > >   #include <asm/cacheinfo.h>
> > > +#include <linux/acpi.h>
> > >
> > >   static struct riscv_cacheinfo_ops *rv_cache_ops;
> > >
> > > @@ -78,6 +79,27 @@ int populate_cache_leaves(unsigned int cpu)
> > >       struct device_node *prev =3D NULL;
> > >       int levels =3D 1, level =3D 1;
> > >
> > > +     if (!acpi_disabled) {
> > > +             int ret, fw_levels, split_levels;
> > > +
> > > +             ret =3D acpi_get_cache_info(cpu, &fw_levels, &split_lev=
els);
> > > +             if (ret)
> > > +                     return ret;
> > > +
> > > +             BUG_ON((split_levels > fw_levels) ||
> > > +                    (split_levels + fw_levels > this_cpu_ci->num_lea=
ves));
> > > +
> > > +             for (; level <=3D this_cpu_ci->num_levels; level++) {
> > > +                     if (level <=3D split_levels) {
> > > +                             ci_leaf_init(this_leaf++, CACHE_TYPE_DA=
TA, level);
> > > +                             ci_leaf_init(this_leaf++, CACHE_TYPE_IN=
ST, level);
> > > +                     } else {
> > > +                             ci_leaf_init(this_leaf++, CACHE_TYPE_UN=
IFIED, level);
> > > +                     }
> > > +             }
> > > +             return 0;
> > > +     }
> > > +
> > >       if (of_property_read_bool(np, "cache-size"))
> > >               ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
> > >       if (of_property_read_bool(np, "i-cache-size"))
> >
> > Yes, looks good.
> >
> > Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
> >
> >
> >
> > Thanks,
>
> Could you help review this patchset? Thanks.
>
> Thanks,
> Yunhui

Thanks,
Yunhui

