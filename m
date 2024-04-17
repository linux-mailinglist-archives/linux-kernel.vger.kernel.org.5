Return-Path: <linux-kernel+bounces-147885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5598F8A7AF1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA7B284B41
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBC9849C;
	Wed, 17 Apr 2024 03:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bpLLkZr3"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A53E1851
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 03:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713323752; cv=none; b=Ax7+QCk29oOoX+lFRfUbccOiEtAIcSBANEfBtfow/ii0pDsxHCbUhUZqLLvskFw9I5psWJkyC5Te8j4itcLoIT0aoqNIzLpyN5A/Fozu8640YhMIoSPPpnnrGCUpXPDj/Tst6VfLcLwRXNrL/iD/mddK7n4mDbsHDklcjUt7gJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713323752; c=relaxed/simple;
	bh=+YZX28rHLDWuM2x05KKJCYzQLjdwZ0E/VxcDLzfvnyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BtwRxdOndmu84xL9Gg86F+/ClF3NdTiAfXXrDR1dl2jpnjlWBUYkKrvUWiizNf/RPKFolrYIyeCX6QSJVLxGX+QAulWESUW+W8t8eFa+LWGV9qoM8nxCn595PdsvXQnK4MbfULrXnwx8kVNBLoa0jaIMUkX/+/tWZkAm+QA7kKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bpLLkZr3; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-234cbd333f5so224173fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 20:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713323749; x=1713928549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9Z++jv9thhXwuK9ebCXoyfu1FayJyWXQhF4Y4dqH70=;
        b=bpLLkZr3p2CYlMtw9dAVizHtdbctiM+c8x3jiv7A8gq2dgXQLHfvRXDk1MCB8ymUuI
         iG2cHLMcvU18D3adhEbSb69p9CHuotWuKdKo+jPe+v3nt9gddXwzDztS33rXs5HCETk2
         C7bzPYO2s7sVoFOuzaGHuZ9m6IoFwS1DLvRmnR8nnlQNxXslTMdToxFdLDitz5zQqfoH
         O9h+zE+OaTPTRxgsrnEaqGTYa7GUZWsn1UTKVrnYz4mFMDSr8R4LRBAUu+QgU+jn8FLe
         8+Th330Ijjumleviq4xN35USCIO2AFb5l09/PSkADYm0vh6L1RXE8M/tBuLb3Mzmme2V
         QcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713323749; x=1713928549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9Z++jv9thhXwuK9ebCXoyfu1FayJyWXQhF4Y4dqH70=;
        b=EVk7PuexagMbkNMUFpusmgN9D7Og0H0vin7yBQr3+ijt344pLZ11OPwTVC8ZthYGTe
         HaLHe8S9I+uxIt2xcH3cfJLGIoGc7LGpmSvYE95TIk6ugDuRASudDGtk2OyYd57mNBVn
         0gUUGJqlYuNPiw3m+bV1x5p8p9PfR2IaRZaE0tFBk7u1f/GuNSkUR/v7xGoD65SOOQhu
         Kukf6miclwx2B8dRpEunnkMsd9+X1ULUe1anY4oVPtMFv+fxtaWwN0krYo7Y1n9aUJrs
         +8bxhzA/Wcv3oAVEeq4Z2ZBz3yWDDU+ehx0Go5H42ouTOggenm/RhKy0NwGYj0ZWNdfL
         GxvA==
X-Forwarded-Encrypted: i=1; AJvYcCVRQrmUxx0Z9guHm4gZ3xKTS07fUG7Spyvg5Zlj079GdqOfdaf1P4Q/f9U2KplaouOxhh7M6r0r3BqUgFGmpkx4mmy3Ge4Um1jhd8mj
X-Gm-Message-State: AOJu0YweXA9voj4TrTxpZr8XRXHeN4GsQBognUwrcjrxNQg+RjoARG5l
	TZQVP+mO6mOHFkOGkALY++H8oLkfA1dwusHTWtJQYfGOpwiBaWoBkguXRNps/Is/3cc9XIH9qcS
	nP41GDWqpTH1+g/NR6gyV7z7fPt4RrXr/4Kstqw==
X-Google-Smtp-Source: AGHT+IG7+SlzZiYgUQUE9mnnio01KvFFZXX0TXlXW4MiCLJOo1mTdXknFxGrqYT18e/8jaVZSK+07OkTH2bc9Zfj+IE=
X-Received: by 2002:a05:6870:51b:b0:22a:a34a:c995 with SMTP id
 j27-20020a056870051b00b0022aa34ac995mr1355278oao.17.1713323749172; Tue, 16
 Apr 2024 20:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416031438.7637-1-cuiyunhui@bytedance.com>
 <20240416031438.7637-2-cuiyunhui@bytedance.com> <9f36bedd-1a68-43a9-826d-ce56caf01c52@arm.com>
In-Reply-To: <9f36bedd-1a68-43a9-826d-ce56caf01c52@arm.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 17 Apr 2024 11:15:38 +0800
Message-ID: <CAEEQ3w=W+xLGP3WsyAQmRNaHm1xVRtqcGJ+t0TnZvJdCTR4v6w@mail.gmail.com>
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

On Wed, Apr 17, 2024 at 4:04=E2=80=AFAM Jeremy Linton <jeremy.linton@arm.co=
m> wrote:
>
> Hi,
>
>
> On 4/15/24 22:14, Yunhui Cui wrote:
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
> >   arch/riscv/kernel/cacheinfo.c | 20 ++++++++++++++++++++
> >   1 file changed, 20 insertions(+)
> >
> > diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinf=
o.c
> > index 30a6878287ad..dc5fb70362f1 100644
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
> > @@ -78,6 +79,25 @@ int populate_cache_leaves(unsigned int cpu)
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
> > +             for (idx =3D 0; level <=3D this_cpu_ci->num_levels &&
> > +                  idx < this_cpu_ci->num_leaves; idx++, level++) {
>
> AFAIK the purpose of idx here it to assure that the number of cache
> leaves is not overflowing. But right below we are utilizing two of them
> at once, so this check isn't correct. OTOH, since its allocated as
> levels + split_levels I don't think its actually possible for this to
> cause a problem. Might be worthwhile to just hoist it before the loop
> and revalidate the total leaves about to be utilized.
>

Do you mean to modify the logic as follows to make it more complete?
for (idx =3D 0; level <=3D this_cpu_ci->num_levels &&
      idx < this_cpu_ci->num_leaves; level++) {
        if (level <=3D split_levels) {
               ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
               idx++;
               ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
               idx++;
       } else {
               ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
               idx++;
      }
}


Thanks,
Yunhui

