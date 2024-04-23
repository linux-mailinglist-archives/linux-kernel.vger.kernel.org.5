Return-Path: <linux-kernel+bounces-154941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC588AE353
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD441F2245C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6CC76056;
	Tue, 23 Apr 2024 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WxBmPlUb"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470C17641E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870235; cv=none; b=XnHo7S5MxB8AqzvKSpNbujcPndOj2ue0qO4QDyBvdQvVL6WtSO+nUdOcgiEqmj8p83Q2pQRG1U++ysA8NAVyfpX19bMJVE4fe1jR4WrNU2f4wkASBVfPcoYlEdQmeoij2rHbtI7JzRd+Yejux7KnqeLwDhj2D6jl9XzK26IoEmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870235; c=relaxed/simple;
	bh=VWztZ/fe4ofdzcdbmJNDnCpV52mg/oLbJuCfL9gqkkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+SgAnBW+RQp8WGdenNI0LSwR97kVjhR2xierBoZWCnlVg+mcFTSV3qcpy359NxBNkczeu7fGiPzi3+U3R2FSuHPcv2/GcHQDeSZbmwlqY50RxQEcbDXOyruSxVkW4YjPqskM3dfvS/eX0zCJuNaAhcKScQfyqEqL5nS/rNRxT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WxBmPlUb; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-22edec341c2so2674118fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713870231; x=1714475031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcipzruX2A9Yhl78blb5w8gS3iCFD8VtiVRtnpWsvs4=;
        b=WxBmPlUbd23ljUFN/MNBxoXQDqTaM7c8N+NOmaYTneLHGxdpXVSEh1th3iEW7ey/Ah
         VZShX24+GOAU+q18hMmss9uCMD4lgAv2yVlshJWFgZP+86HuG9n9KGLBEaUAZ8kCud/D
         jRToRku32+FCHVk7xN/M4r7Ub0gfSvRRNGcszGYcbeupaE1LzYoZ98znxfG19eovkInP
         Ji6idO7PYimWcMvADFt2JQbx6qzLfYk3c/x0UkVo48ldgq/B04e/Mnow1T9gr2FAKVNK
         Ko3FWzSJeeVVv0+619PmYwFEnjrhAd5LiEgomvgpGba7BGi2b+10hjSEaS1ahqGpWHpJ
         Omqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713870231; x=1714475031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcipzruX2A9Yhl78blb5w8gS3iCFD8VtiVRtnpWsvs4=;
        b=OkTxBMPo91zBjYcfCdqLeOz9iU0P3B3+Zq1rcnfjWkPYBkWHXdcvCzbpR1+fbPaPhJ
         FOPiAzMpo3OmU42ZLNWnLy63g1rZNaxVfLFhkASAcLYaz+I7BhqFTU7+o/L3mSnuFDdC
         4XRxuE24GBkh/yprfPgUQ1bo4y3RVkAYRjuW4zimzr/f6EsHTMA116QHsx7/f/6Z2/et
         7HKm3tk+NDD5Ssbkpiatnv/klXe+6RQlmOD2A2pjgsW863OA+PHqQyamubx81R3jfIbi
         tAwdsUca4jzq+yRsrY7siOGMpT2bgxFzmEVDtDTzyMj1FXhc+BfDwpBtSruaRshP7kM3
         fApw==
X-Forwarded-Encrypted: i=1; AJvYcCXQDs2CBMxhpXeMqXYeQKf0kMeHtKBYgDWTReYCbvB+UrZFDBXAuzkaSIdZJMEwCKJlKK3TU41z13DV/hoUMsnDnZ1wRYxUa6ZL5qnl
X-Gm-Message-State: AOJu0YykZQwGoL/GqKmPAFqWl5OPQ8/Naw0hA2Wt3GyMs+n7U4zfxsRb
	c6yQuroepMAQphTerRLU/EuvrUSuMJY6jc4Ey0s3pT0EnaPR1Z1VCk+4gMeAi4szl1l4ZVAntv5
	nmrdha3Sg75Uj/FsWko4Bmmie0vkrXLCNPFM1RQ==
X-Google-Smtp-Source: AGHT+IFhGsfWfuGFv/LZLhvGKnt4RFHXPxHS5wX4JPzKOB99V9981I2BjbU0RZ8Sg5EH28NR6FPScsajfozyvhNOLIs=
X-Received: by 2002:a05:6870:55d2:b0:21e:a839:d807 with SMTP id
 qk18-20020a05687055d200b0021ea839d807mr16500749oac.54.1713870231186; Tue, 23
 Apr 2024 04:03:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418034330.84721-1-cuiyunhui@bytedance.com>
 <20240418034330.84721-2-cuiyunhui@bytedance.com> <d143cd11-26ea-42e3-8f32-700a34b3705e@arm.com>
In-Reply-To: <d143cd11-26ea-42e3-8f32-700a34b3705e@arm.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 23 Apr 2024 19:03:40 +0800
Message-ID: <CAEEQ3wkDMuu+jh56YB3G0vY_ENdUjDL6byMsJXd0C9aQu1FZKw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 2/3] riscv: cacheinfo: initialize
 cacheinfo's level and type from ACPI PPTT
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, bhelgaas@google.com, 
	james.morse@arm.com, jhugo@codeaurora.org, john.garry@huawei.com, 
	Jonathan.Cameron@huawei.com, pierre.gondois@arm.com, sudeep.holla@arm.com, 
	tiantao6@huawei.com, Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Palmer,

On Fri, Apr 19, 2024 at 11:29=E2=80=AFPM Jeremy Linton <jeremy.linton@arm.c=
om> wrote:
>
> Hi,
>
> On 4/17/24 22:43, Yunhui Cui wrote:
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
> >   arch/riscv/kernel/cacheinfo.c | 22 ++++++++++++++++++++++
> >   1 file changed, 22 insertions(+)
> >
> > diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinf=
o.c
> > index 30a6878287ad..e47a1e6bd3fe 100644
> > --- a/arch/riscv/kernel/cacheinfo.c
> > +++ b/arch/riscv/kernel/cacheinfo.c
> > @@ -6,6 +6,7 @@
> >   #include <linux/cpu.h>
> >   #include <linux/of.h>
> >   #include <asm/cacheinfo.h>
> > +#include <linux/acpi.h>
> >
> >   static struct riscv_cacheinfo_ops *rv_cache_ops;
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
> >       if (of_property_read_bool(np, "cache-size"))
> >               ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
> >       if (of_property_read_bool(np, "i-cache-size"))
>
> Yes, looks good.
>
> Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
>
>
>
> Thanks,

Could you help review this patchset? Thanks.

Thanks,
Yunhui

