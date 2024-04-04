Return-Path: <linux-kernel+bounces-132120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D76D5898FDD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650071F24934
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4125813B29C;
	Thu,  4 Apr 2024 21:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AtatSxH2"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6529213AA56
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712264705; cv=none; b=DzqhvHXEgoRQni0xmBhzQQ7Y9J8LMXu3PmhvYg+rD1YiDZYazHsw1DkPyxK5Eo5JsJBhXMvyqBiiHTrLPg6oXlo0C/eJufMvrawWUEzAS2k54Rk7S8RYIDdzq/ATnDoHYQgsU87GPngJzTeK24+ZqqSrT8B1QTMD4WNIgQy9MSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712264705; c=relaxed/simple;
	bh=V1bvfCjUMNTcwsT2lBKJF4J897CJP70t3WLaAcvFFS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=diUWVtLglRapBXXiy357upci1Q1F5mj4lUJwpTUSKSqYelAs2FimXqG2VTD2EVu/XN7jw3UY8/TxQX6F7L3sVa1Y4GQpnA/JM3wEdMJdlnOSBShrOi+pjIe46B+8mWw/J3apPnniY1mtA3tbtR6oFDAUnQoonVjFS8Asd6JYGIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AtatSxH2; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-614b02f8ed6so22803737b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 14:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712264702; x=1712869502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BEwoI7vaLN7STH+6B1HZ1H40SSE9uFhmcRIVexkA4A=;
        b=AtatSxH203Xl7YiKt6KexIweNl8GOt/BQpYTCl7iyhPDGvCTmPrpoRCl3yyV7Wycer
         jctaGuvQ9qY5AlB0BvxhAaCXVdswkm1QiilvuDypgsOCf4Y3IybqSyoTpYf+fKtD3HhH
         nqxVtk8R7xert+llPIj/KkS78YN4ZZxU6ttdLAnyaiAIe6VbXDRyM205xIWgTExM+mbG
         XyTMofKGK/cEQQYCyDz3LnHBKbcWT5+tua+L49kfR3Zr04pPXNv5dsEL6Hspvxx8MHrm
         Z3H8wL8uZoIXnVI/w+sdevS/WXvAIF/V3jPmjbuVgqXOBcpXOPMh8kc3xvNbvh1OMpL7
         Yluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712264702; x=1712869502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BEwoI7vaLN7STH+6B1HZ1H40SSE9uFhmcRIVexkA4A=;
        b=kpOcspiPedLyBNV+obTe3F9rwx7QQlayJm1i54udnJPspG0kFpuc/26aWVYIya0ZNN
         PVBUZrzi2PR+izOPFhD+/puBoVv71UbR0KSCaxEwutFjQzs5qUztV2QtcOlEJx+rix1w
         c9Z2ZZgABZUyBzGyFcjERsylEGALFEgAG4ZLZBmKUdXNpStvAI2uWnkqc5UhzhvBjPTG
         a6VvTTlBJGKTKpH4nJArl2oP15PC33jA5rSwnkz2ncBwHCBZ43X2ey4o0XIoKs5QLyxc
         /dEDHUsXT+BtogQqu1CQ592tdbdbR5XPVkQaRHkx6WMMAtoUOsjarqV0B16ocs4AbUOa
         NplQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvxZvy9ESVg5ub3kDgBkQv6thy8iCUW/dExstHNOb+3ekjtNO8MEF6iYeymDXIzrQhPJ6Rb9WJmXjBWWIXDvtZ9bywL7SikJUZfmrd
X-Gm-Message-State: AOJu0Ywdr/u6WiqZpkFa4tI+qH8m8usqi16lrG6AWh4ovbvmamKpsrPk
	9hLokaosewWKmzHVpeu9uC7g4UCvFjlgb0rAlYgsMTXM6qyH5gBNAyWEGXb/M+2gYi7D+bEoHb8
	vQut559n5gTrCYt3MHm84cG5F7lsM72YcGU1ZLA==
X-Google-Smtp-Source: AGHT+IG6KpWakGj8bl6wl0XaCmeiykXs6HQkS3DMCudH9AT087DNiiXeU48IwUZnyWYEgunzOmtd5Z4JvSn2JDWo2cM=
X-Received: by 2002:a25:bc50:0:b0:dcc:5b7e:ddfe with SMTP id
 d16-20020a25bc50000000b00dcc5b7eddfemr549930ybk.4.1712264702360; Thu, 04 Apr
 2024 14:05:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402001739.2521623-1-horenchuang@bytedance.com>
 <20240402001739.2521623-3-horenchuang@bytedance.com> <20240403180425.00003be0@Huawei.com>
 <CAKPbEqoJZe+HWHhCvBTVSHXffGY2ign3Htp4pfbFb4YVJS_Q2A@mail.gmail.com> <20240404143733.00004594@Huawei.com>
In-Reply-To: <20240404143733.00004594@Huawei.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Thu, 4 Apr 2024 14:04:51 -0700
Message-ID: <CAKPbEqpp-mFv0bnOPtk0hFYVqA5y-e-T3QMWrS19g00Mob6D+g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v10 2/2] memory tier: create CPUless memory
 tiers after obtaining HMAT info
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, Gregory Price <gourry.memverge@gmail.com>, 
	aneesh.kumar@linux.ibm.com, mhocko@suse.com, tj@kernel.org, 
	john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, 
	Vinicius Tavares Petrucci <vtavarespetr@micron.com>, Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
	Alistair Popple <apopple@nvidia.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>, 
	SeongJae Park <sj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linux Memory Management List <linux-mm@kvack.org>, "Ho-Ren (Jack) Chuang" <horenc@vt.edu>, 
	"Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, qemu-devel@nongnu.org, 
	Hao Xiang <hao.xiang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

Thank you! I will fix them and send a V11 soon.

On Thu, Apr 4, 2024 at 6:37=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> <snip>
>
> > > > @@ -858,7 +910,8 @@ static int __init memory_tier_init(void)
> > > >        * For now we can have 4 faster memory tiers with smaller adi=
stance
> > > >        * than default DRAM tier.
> > > >        */
> > > > -     default_dram_type =3D alloc_memory_type(MEMTIER_ADISTANCE_DRA=
M);
> > > > +     default_dram_type =3D mt_find_alloc_memory_type(MEMTIER_ADIST=
ANCE_DRAM,
> > > > +                                                                  =
   &default_memory_types);
> > >
> > > Unusual indenting.  Align with just after (
> > >
> >
> > Aligning with "(" will exceed 100 columns. Would that be acceptable?
> I think we are talking cross purposes.
>
>         default_dram_type =3D mt_find_alloc_memory_type(MEMTIER_ADISTANCE=
_DRAM,
>                                                       &default_memory_typ=
es);
>
> Is what I was suggesting.
>

Oh, now I see. Thanks!

> >
> > > >       if (IS_ERR(default_dram_type))
> > > >               panic("%s() failed to allocate default DRAM tier\n", =
__func__);
> > > >
> > > > @@ -868,6 +921,14 @@ static int __init memory_tier_init(void)
> > > >        * types assigned.
> > > >        */
> > > >       for_each_node_state(node, N_MEMORY) {
> > > > +             if (!node_state(node, N_CPU))
> > > > +                     /*
> > > > +                      * Defer memory tier initialization on CPUles=
s numa nodes.
> > > > +                      * These will be initialized after firmware a=
nd devices are
> > >
> > > I think this wraps at just over 80 chars.  Seems silly to wrap so tig=
htly and not
> > > quite fit under 80. (this is about 83 chars.
> > >
> >
> > I can fix this.
> > I have a question. From my patch, this is <80 chars. However,
> > in an email, this is >80 chars. Does that mean we need to
> > count the number of chars in an email, not in a patch? Or if I
> > missed something? like vim configuration or?
>
> 3 tabs + 1 space + the text from * (58)
> =3D 24 + 1 + 58 =3D 83
>
> Advantage of using claws email for kernel stuff is it has a nice per char=
acter
> ruler at the top of the window.
>
> I wonder if you have a different tab indent size?  The kernel uses 8
> characters.  It might explain the few other odd indents if perhaps
> you have it at 4 in your editor?
>
> https://www.kernel.org/doc/html/v4.10/process/coding-style.html
>

Got it. I was using tab=3D4. I will change to 8. Thanks!

> Jonathan
>
> >
> > > > +                      * initialized.
> > > > +                      */
> > > > +                     continue;
> > > > +
> > > >               memtier =3D set_node_memory_tier(node);
> > > >               if (IS_ERR(memtier))
> > > >                       /*
> > >
> >
> >
>


--=20
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB

