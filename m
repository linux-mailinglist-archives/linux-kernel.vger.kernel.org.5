Return-Path: <linux-kernel+bounces-149455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9A18A9150
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736F51C20EC9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49124F20E;
	Thu, 18 Apr 2024 02:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TtaGEZGN"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED605244
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 02:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713408773; cv=none; b=IPVebfb19chIhldH8DTIoyNDzeD82p78xgIKl2gf1dkt3L7WJ2iSXxqgsDShdXKA1RD0rbFR1JyxppHKSpGxBmsjPsfgkIrtbauQ6v1vdPBbzsZXxYmr9q/yPU3knoKuz0FxVL5x6xsbzf4xvA16XXUFIZhLHVMwNA2kOHZ22OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713408773; c=relaxed/simple;
	bh=Jnfaax+VThd3d1Rfm6iO+DeB5E6TecW6JeFhA8ggWIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=reqm+MGy3srGsV8aqoL3QQ85c23kNkgWRMvSel9dCeamyKadJ7a0jkfhNrMW+puP+/yay1o6qvqIzwsFODFhcDRpoKpHDF2Vly4XjlBB+yeD0eQ1RPT2Tey11ePuR/76XsaiipXIJUSfYy/JmpMhzEHSUQRCfkPRBPBOMxjCprg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TtaGEZGN; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2330f85c2ebso289612fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 19:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713408770; x=1714013570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KAnRFRHACv8tVuZ6WXGHdutSp2eDzczfpAG5G+ekeo=;
        b=TtaGEZGN0MftTRasoNS0qtdKpH6dRDnI1sGIG8XFaWyzDYNYJnZnsTJjMv2TtDo0TP
         b9CznFt8TSCwjBF6t7dMq09DLt9nix3J2E+nsnvwilJ2MN/7LED45MyUEL2MId9mCQD8
         BZn1HPRLnY6J0Wv2ET+goprrm6tcWFtdqdzB+fSdFfbhKabuJJkdeOaZi0kFALDa4wJn
         Q4tHVoeqMtda0ciaHbEMF5vZLBnMnYLZMGs/+/kEDum/aiCfp5FhrSNa/9AR/iy8d4Lw
         gN2o334RkP6UAtZM9KCJqX8dN6EhKe1Cl22iBJ7HqE+9sSjREREisb9K5zloSoyXaj/4
         Xg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713408770; x=1714013570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KAnRFRHACv8tVuZ6WXGHdutSp2eDzczfpAG5G+ekeo=;
        b=iQ/Yh2B1gMtfiCQ8JuNysIqgXV8tXJw9z+k82iTSm3upw/RuEEbpZ0sME5wvKkKYDS
         /zO5eGNyKGc0L1us8rMNKEFIH0r25ej4FJv6UhdgReyztBwhKu753VKurJSJHq+xQxF5
         lqop1TNl4CeIdUcE8ZpArfhzTrHjLl7FEJECUIvW/+T432K5B+IlKwB+58mp5ZMsoEOT
         gZ8RyKW6+T1KWJqmMCm+6HpDRez/w3mWkUJ1zFHyDimnfulVcUGEcvG9DzaJDlIm1oxc
         XAWCOiVjytXu8NrV5850oFntDiaTj8vBalcX5OgGUHVtEvRj8E/qpg5JXveGBWurLIaw
         Pojg==
X-Forwarded-Encrypted: i=1; AJvYcCUnCbl7SVKNhZugGmcRdYJhfXftgkdO8715w4UD+EPfSZvh8y6zEpQeB8ZKtQTNMZOtWX5aTSAGY+0nG3BgoeKyxKcQqWVIremw+pAs
X-Gm-Message-State: AOJu0YzZzS0l9PpjwMbN8+CMJSgIWJbNumZxjbSeVTc/wB7iOFoVGliF
	nWE5PZFDmlv+8BgOFX4PWYeWJ2pxMxx9GazOdPBbk02p6OgAaZkns6ek9vC+lHEVgop+IfrlvOk
	tG0gCjy5XwLOssuSs81i9Jzlf1u8kr3yZt6E+EQ==
X-Google-Smtp-Source: AGHT+IEz1qXw0zEwY0hM3OQNuvnvteufmwQVzsfsyl68XIgc+AN5q25yfuZ+0bnJM0H06GgffoXYWnRbvoWwM1qazsY=
X-Received: by 2002:a05:6870:4724:b0:22e:15d2:6773 with SMTP id
 b36-20020a056870472400b0022e15d26773mr1921626oaq.32.1713408770492; Wed, 17
 Apr 2024 19:52:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416031438.7637-1-cuiyunhui@bytedance.com>
 <20240416031438.7637-2-cuiyunhui@bytedance.com> <9f36bedd-1a68-43a9-826d-ce56caf01c52@arm.com>
 <CAEEQ3w=W+xLGP3WsyAQmRNaHm1xVRtqcGJ+t0TnZvJdCTR4v6w@mail.gmail.com> <260d9932-bf51-43ac-8490-99c39f5e9258@arm.com>
In-Reply-To: <260d9932-bf51-43ac-8490-99c39f5e9258@arm.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 18 Apr 2024 10:52:39 +0800
Message-ID: <CAEEQ3w=TZ8M6x0twDOcZ5iZ9O4L=bJNGFGKafZX1=e-Q8ALjYA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 2/3] riscv: cacheinfo: initialize
 cacheinfo's level and type from ACPI PPTT
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, bhelgaas@google.com, 
	james.morse@arm.com, jhugo@codeaurora.org, john.garry@huawei.com, 
	Jonathan.Cameron@huawei.com, pierre.gondois@arm.com, sudeep.holla@arm.com, 
	tiantao6@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeremy,

On Wed, Apr 17, 2024 at 10:00=E2=80=AFPM Jeremy Linton <jeremy.linton@arm.c=
om> wrote:
>
> Hi,
>
> On 4/16/24 22:15, yunhui cui wrote:
> > Hi Jeremy,
> >
> > On Wed, Apr 17, 2024 at 4:04=E2=80=AFAM Jeremy Linton <jeremy.linton@ar=
m.com> wrote:
> >>
> >> Hi,
> >>
> >>
> >> On 4/15/24 22:14, Yunhui Cui wrote:
> >>> Before cacheinfo can be built correctly, we need to initialize level
> >>> and type. Since RSIC-V currently does not have a register group that
> >>> describes cache-related attributes like ARM64, we cannot obtain them
> >>> directly, so now we obtain cache leaves from the ACPI PPTT table
> >>> (acpi_get_cache_info()) and set the cache type through split_levels.
> >>>
> >>> Suggested-by: Jeremy Linton <jeremy.linton@arm.com>
> >>> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> >>> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> >>> ---
> >>>    arch/riscv/kernel/cacheinfo.c | 20 ++++++++++++++++++++
> >>>    1 file changed, 20 insertions(+)
> >>>
> >>> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cachei=
nfo.c
> >>> index 30a6878287ad..dc5fb70362f1 100644
> >>> --- a/arch/riscv/kernel/cacheinfo.c
> >>> +++ b/arch/riscv/kernel/cacheinfo.c
> >>> @@ -6,6 +6,7 @@
> >>>    #include <linux/cpu.h>
> >>>    #include <linux/of.h>
> >>>    #include <asm/cacheinfo.h>
> >>> +#include <linux/acpi.h>
> >>>
> >>>    static struct riscv_cacheinfo_ops *rv_cache_ops;
> >>>
> >>> @@ -78,6 +79,25 @@ int populate_cache_leaves(unsigned int cpu)
> >>>        struct device_node *prev =3D NULL;
> >>>        int levels =3D 1, level =3D 1;
> >>>
> >>> +     if (!acpi_disabled) {
> >>> +             int ret, idx, fw_levels, split_levels;
> >>> +
> >>> +             ret =3D acpi_get_cache_info(cpu, &fw_levels, &split_lev=
els);
> >>> +             if (ret)
> >>> +                     return ret;
> >>> +
> >>> +             for (idx =3D 0; level <=3D this_cpu_ci->num_levels &&
> >>> +                  idx < this_cpu_ci->num_leaves; idx++, level++) {
> >>
> >> AFAIK the purpose of idx here it to assure that the number of cache
> >> leaves is not overflowing. But right below we are utilizing two of the=
m
> >> at once, so this check isn't correct. OTOH, since its allocated as
> >> levels + split_levels I don't think its actually possible for this to
> >> cause a problem. Might be worthwhile to just hoist it before the loop
> >> and revalidate the total leaves about to be utilized.
> >>
>
> I think I was suggesting something along the lines of:
>
> BUG_ON((split_levels > fw_levels) || (split_levels + fw_levels >
> this_cpu_ci->num_leaves));
>
> Then removing idx entirely. ex:
Okay, I'll follow yours and update v4.


> for (; level <=3D this_cpu_ci->num_levels; level++)
> ...
> >
> > Do you mean to modify the logic as follows to make it more complete?
> Sure that is one way to do it, but then you need to probably repeat the
> idx check:
> > for (idx =3D 0; level <=3D this_cpu_ci->num_levels &&
> >        idx < this_cpu_ci->num_leaves; level++) {
> >          if (level <=3D split_levels) {
> >                 ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
> >                 idx++;
> if (idx >=3D this_cpu_ci->num_leaves) break;
> >                 ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
> >                 idx++;
> >         } else {
> >                 ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
> >                 idx++;
> >        }
> > }
>
>
>

Thanks,
Yunhui

