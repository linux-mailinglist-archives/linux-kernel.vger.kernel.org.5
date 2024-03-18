Return-Path: <linux-kernel+bounces-105600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1821487E138
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 01:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2536E281E8A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 00:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430E3C120;
	Mon, 18 Mar 2024 00:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1Nj6hTu"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2D64C63
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 00:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710721679; cv=none; b=ASCacRAS81OVleUQLGuauqAMvbyrZuBL5Ox4kHYjTWLKmkMi5GqRuMYuQNIjF9/sp6HMfqUDNYeEiz2fgwKid7dtRaVRlvZ2jJ/XtMk3ClXa7J78ErK6iDOal5k4XqABS3vhSAIJRVqaxAOZYJoAL3B3AhT85S0lP0ioySVIOdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710721679; c=relaxed/simple;
	bh=3yDSAwIFbySv3JmaN6hmK5jPysilhvZsLdYo9LyvPIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VeCJkI7zWRVvDfbyb5P2SDE1s5N/sHbXNxlZ/Daba09aaOmViNW+sCmGYO2x/96ROvm+38LcQvrwdeiVDEktFr/3hwNftvBd9P1nD/npMqIzQTqJVDW4T3n4Vv33Z6j7TM4oNQ3eMWX9jHeX2w5TlyQ54iNP10Pta2Rx4oJRt40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1Nj6hTu; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-476665f067fso1100544137.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 17:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710721677; x=1711326477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Qt7u+PWqpqCiGmiH10iOB2sx5m0iKrXs+EtR3m51rw=;
        b=b1Nj6hTuyBMesAhKH6pBfwzNvoWQwyeKfojziNRkuYBa8RuS3H3lE1s2uiWXRaXpo+
         2HloAORUsu/5QTjVP4EBTyepCoKQ0Oi72b62FzhMRCqSbZVZMTgOXeVDGHhq83MLMYPA
         yW6QiwULKJjywPEIHwiOfHzAiLxFWQS4fg1SRNOQ0mSbBsrfZXkjGZgzvKFaUOdjpd+B
         dv8t5cS5ujLU2N29hbW+uRBjv4+YJ2gn85L1CRTPCnuksIgfb8/jI6b+5fETOV/H2VJj
         iLN3lphjSwt98t9VOWb4wnUzHNF+p0N4NmgAeWbn5UeTmkEatUXNLRqgqGkNs/esvtue
         edDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710721677; x=1711326477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Qt7u+PWqpqCiGmiH10iOB2sx5m0iKrXs+EtR3m51rw=;
        b=AdaE53HC4U6ipGK3mygOvgGvWntJlSCiUVw+1pEGrS/03PU5eq9LRm1vi/cmcQU9Y+
         ZQo8D21nzSEjVF4GjesRUpE2FIABOOF4wqD8lMiB8DbQ/nb7zZJBE5KBmjWVN8eBhUir
         mqDxDhU4fBdEVL7L96SO3CQKQyelgigov0h7ONfAsskmBZQRIMN/py10X7w4bp3DaW2t
         qTrPB+737qAZIbf56Ub76M4+Af1+etVRi79et/EAynTUCuxIwOzH+vhbyFeCalGQBf1T
         5vfjaGOMoB/pHi+E62T6QGKpQunG7HXWWCQmk6OJp55Zy2qpGDqKHvoPwh04JQZpIKxk
         WaHw==
X-Forwarded-Encrypted: i=1; AJvYcCUOFpsHIokCUxS8mxt7q8B57diKOA/gDgw6SbY2XMwOjsRthEHgPg9xVJhwHjphzYMJxnxfFGgOuddPVaDVj/b1IGfnveWQ3zmpG1Na
X-Gm-Message-State: AOJu0YyhS1bB1318HFzmZDsmdZo0zCP1/5nwT2biePxCORn1L3ki/jUt
	DFBuHpGdjDRgpJRhO7antgfyC8nYtFsQkjsw1kUAey9oFws5+Z421zHRMjW7PpjaBBDbsdZ6ivh
	CBGdczh1g5cDfZby42wUyo0e5wBA=
X-Google-Smtp-Source: AGHT+IHG99wuwIcjHpS0GwtKYujnhS+B0twGqSxjIj1JHxpH1vNKhFeTlUqAlEgTo4AeyHWb0DNzsiayAysEFrf/vSQ=
X-Received: by 2002:a67:fc10:0:b0:476:5b1b:b109 with SMTP id
 o16-20020a67fc10000000b004765b1bb109mr6696501vsq.17.1710721676913; Sun, 17
 Mar 2024 17:27:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313045036.51065-1-21cnbao@gmail.com> <369716bf-0216-4114-b502-a2d2c819ee8c@roeck-us.net>
In-Reply-To: <369716bf-0216-4114-b502-a2d2c819ee8c@roeck-us.net>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 18 Mar 2024 08:27:42 +0800
Message-ID: <CAGsJ_4zVQVCBv4+b=pmd78hsv=LnQoBcC+bDmuL0oM7EOGF4eg@mail.gmail.com>
Subject: Re: [PATCH] xtensa: remove redundant flush_dcache_page and
 ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE macros
To: Guenter Roeck <linux@roeck-us.net>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, chris@zankel.net, 
	jcmvbkbc@gmail.com, willy@infradead.org, alexghiti@rivosinc.com, 
	rppt@kernel.org, dennis@kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Huacai Chen <chenhuacai@loongson.cn>, Herbert Xu <herbert@gondor.apana.org.au>, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 8:16=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On Wed, Mar 13, 2024 at 05:50:36PM +1300, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > xtensa's flush_dcache_page() can be a no-op sometimes. There is a
> > generic implementation for this case in include/asm-generic/
> > cacheflush.h.
> >  #ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
> >  static inline void flush_dcache_page(struct page *page)
> >  {
> >  }
> >
> >  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
> >  #endif
> >
> > So remove the superfluous flush_dcache_page() definition, which also
> > helps silence potential build warnings complaining the page variable
> > passed to flush_dcache_page() is not used.
> >
> >    In file included from crypto/scompress.c:12:
> >    include/crypto/scatterwalk.h: In function 'scatterwalk_pagedone':
> >    include/crypto/scatterwalk.h:76:30: warning: variable 'page' set but=
 not used [-Wunused-but-set-variable]
> >       76 |                 struct page *page;
> >          |                              ^~~~
> >    crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
> > >> crypto/scompress.c:174:38: warning: unused variable 'dst_page' [-Wun=
used-variable]
> >      174 |                         struct page *dst_page =3D sg_page(re=
q->dst);
> >          |
> >
> > The issue was originally reported on LoongArch by kernel test
> > robot. And Huacai fixed it on LoongArch, but I found xtensa
> > obviously has the same issue.
> >
>
> Maybe I am doing something wrong, but this patch doesn't build
> for me.
>
>  CC      arch/xtensa/kernel/asm-offsets.s
> In file included from ./include/linux/highmem.h:8,
>                  from ./include/linux/bvec.h:10,
>                  from ./include/linux/blk_types.h:10,
>                  from ./include/linux/writeback.h:13,
>                  from ./include/linux/memcontrol.h:23,
>                  from ./include/linux/swap.h:9,
>                  from ./include/linux/suspend.h:5,
>                  from arch/xtensa/kernel/asm-offsets.c:24:
> ./include/linux/cacheflush.h:9:5: error: "ARCH_IMPLEMENTS_FLUSH_DCACHE_PA=
GE" is not defined, evaluates to 0 [-Werror=3Dundef]
>     9 | #if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE

is it because xtensa doesn't include this at the end of
arch/xtensa/include/asm/cacheflush.h
while other architectures do?

#include <asm-generic/cacheflush.h>



>
> Guenter

