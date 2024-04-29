Return-Path: <linux-kernel+bounces-161742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7379F8B5087
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A86F2827E3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 05:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB45DF71;
	Mon, 29 Apr 2024 05:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hB7rhtam"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ED4DF42
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 05:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714367403; cv=none; b=Mhrz+8orFJiFVgnIuGGSyikpSK5VkApsbECmiTlXLUy7aJW2hCSxQJwnoODKql1x/Ay5ENrbXmYsOhK9JzmKdSVN2cBaIIksJl4hRszpDQA5Tau5zMfzls1lpMUo1LT+GLHs2dsP4xGsdncmdE0yMk4a4SjrJO9a6VDi7nYtr2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714367403; c=relaxed/simple;
	bh=uDXiZfQhRsyw1ft6MX0V67niOKlXGrJmWIAmhFCeVsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QdQXUCVbSZU+KfCNyxKI7y6HMrw7ooNcoSVV4H7spuiJbcwes1T6//t6HBxvofiusSmIOrY+m76pgdUQB8byyF+vg/2N0bip4TlterI9J5DlY6Z0bMxqCD7aJruko8xjjXEvkBAaOpWEaRKqMkpDD6UrpbtQvP8lmCQtuI5S3Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hB7rhtam; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so2101282a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 22:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714367401; x=1714972201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPfeZpHIqAor5KhZbagcI8P8T5SPnMSuPapyOCbP/Xo=;
        b=hB7rhtamw/9svgCPh/wrjk65gyxLr/r2nvp8tU4z35FyICQKD1dniGsuEYnNcol16+
         plxqU6LCvUCBda1fqlituIek0ZCJW4CtANgigWYSBrmcZ2B3krSuH/EBn0xlxMHP6B4e
         mcCWOmK/ku6CuR5h4wM243TGVjzz1YO4ILBHDXzGeDvy2LS8HMGAN2edNH2MHspIYOyz
         8oOeNrop++Bl9v4/tXyYwGuueGStaOUUoL5JHCHQIU3cllcTrnCN4eJeXrxm1ZyytDyw
         x8MfWsZPhCVxPfZd0U0UbLhEhLrPdh5uFznVMsZsR36boryqtpjHRoGPvqvx8RMZ+rNh
         kubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714367401; x=1714972201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zPfeZpHIqAor5KhZbagcI8P8T5SPnMSuPapyOCbP/Xo=;
        b=TL26kPAmY/pr5aesR17nL0/jgGwcsGkjvwlRUYUAXgAUrMfi1a5LxCw7wr07mmUWag
         eY5wAgTnu+rv6qKaYfe9rtPIy4vfjD0Hs/IsJLkumMTirbDL67E/BbcJovPxXzLHJ8JB
         Gfmu7ohqAEFyQ0LHeSQinShHPQJlLBeVHbHqxEPcs7lzHkoI3XchZxB10GvnD8+mv6oa
         yF6Fu22w8OGm1tyGDhgzEtMpWzC6buWBxYkUojP+YuylES7tvhcDrd3YjDtquEtfUB6P
         66Z6MoPB99ak9S7LmC0/sUd0GcNmpBSYsTF91+0WjZLbaHWwZs2pav8BFGxi0EB9qtcb
         Ny1A==
X-Forwarded-Encrypted: i=1; AJvYcCUDYufO7zn63LCwJhpuX81dqJJhbTTqREjJ11cT6U6MIeOBEb6Dy9H7aYWIiPs2eAnxXNUEyPntmAKZqPe/LnikD3sL5HHgefVsUG2r
X-Gm-Message-State: AOJu0YzrbNyz5jZB1hWaSEV+FKLRU9VOsCjxkHZy3RTqQ9dekf8Cqunz
	Okpjn+Tv9ke2JmK0LpXoj8+/plMtss28ji3zbz5Tn0+NZzEKz9cGmnupKrwCEOsq3ZQKYNM9gpF
	/zrB+MHvnorL0tEtBGoY/+RZBRiE=
X-Google-Smtp-Source: AGHT+IHZP9ujjyfE3gCmyzLzNyoIYQIZE/JAdcqnmQzPoRZZP8xJlGf2zY6G4Vij6uNG/z+sNBCfhtNTwhesx/iJx/Q=
X-Received: by 2002:a05:6a20:968d:b0:1a9:5ba1:3713 with SMTP id
 hp13-20020a056a20968d00b001a95ba13713mr9145913pzc.19.1714367400927; Sun, 28
 Apr 2024 22:10:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319010920.125192-1-21cnbao@gmail.com> <0df6028c-3e7d-461c-85bd-8ba1bf06e2a6@roeck-us.net>
In-Reply-To: <0df6028c-3e7d-461c-85bd-8ba1bf06e2a6@roeck-us.net>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 28 Apr 2024 22:09:49 -0700
Message-ID: <CAMo8BfJTutHPByNZcpjb-2xeUX-Nu2XkjN0DWE6w5xV=zg__Kg@mail.gmail.com>
Subject: Re: [PATCH v2] xtensa: remove redundant flush_dcache_page and
 ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE macros
To: Guenter Roeck <linux@roeck-us.net>
Cc: Barry Song <21cnbao@gmail.com>, chris@zankel.net, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, willy@infradead.org, dennis@kernel.org, 
	alexghiti@rivosinc.com, Barry Song <v-songbaohua@oppo.com>, 
	Huacai Chen <chenhuacai@loongson.cn>, Herbert Xu <herbert@gondor.apana.org.au>, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 27, 2024 at 12:05=E2=80=AFPM Guenter Roeck <linux@roeck-us.net>=
 wrote:
>
> Hi,
>
> On Tue, Mar 19, 2024 at 02:09:20PM +1300, Barry Song wrote:
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
> > robot (Huacai fixed it on LoongArch), then reported by Guenter
> > and me on xtensa.
> >
> > This patch also removes lots of redundant macros which have
> > been defined by asm-generic/cacheflush.h.
> >
> > Cc: Huacai Chen <chenhuacai@loongson.cn>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202403091614.NeUw5zcv-lkp=
@intel.com/
> > Reported-by: Barry Song <v-songbaohua@oppo.com>
> > Closes: https://lore.kernel.org/all/CAGsJ_4yDk1+axbte7FKQEwD7X2oxUCFrEc=
9M5YOS1BobfDFXPA@mail.gmail.com/
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Closes: https://lore.kernel.org/all/aaa8b7d7-5abe-47bf-93f6-40794243647=
2@roeck-us.net/
> > Fixes: 77292bb8ca69 ("crypto: scomp - remove memcpy if sg_nents is 1 an=
d pages are lowmem")
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>
> The mainline kernel still fails to build xtensa:allmodconfig.
>
> Building xtensa:allmodconfig ... failed
> --------------
> Error log:
> crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
> crypto/scompress.c:174:38: error: unused variable 'dst_page' [-Werror=3Du=
nused-variable]
>   174 |                         struct page *dst_page =3D sg_page(req->ds=
t);
>
> This patch fixes the problem. Is there a chance to get it applied to the
> upstream kernel, or should I just stop build testing xtensa:allmodconfig =
?

Applied to my xtensa tree.
I was still hoping to see rationale for why this is a useful warning.

--=20
Thanks.
-- Max

