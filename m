Return-Path: <linux-kernel+bounces-163099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 707C88B65AB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109401F225AA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F29194C81;
	Mon, 29 Apr 2024 22:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3AnwW7/q"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CB4194C88
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 22:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714429422; cv=none; b=QUcg+anpQi0tsRFvN0tX4H28VaE5XLYzWcf2oQq3jjgZjT3OWBUyU28n/dlylPAhO05heklTNxb6ciZPvYLxy/KnYvIXZBmYDqT/IpXi0dMmNcjkda/dsCDV6Yk0yc9zOIrI9vwOOxeYms56cE+wG849OV084Rn+vJDLw7CT1RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714429422; c=relaxed/simple;
	bh=C4h5zkEyr8Y64gy7n6dsxrGyhQOLrBN0HPxO6F1zAyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MwWp478Z1KcGFVuCL7N/TYXybqeBm2yxAt3YsfgZuCz1p9+YBV5IkS0aldAu/9VnSz0nOI3xMRGp3VQkaJwlwpBH+eQ8gw+DJg2+gFtgs3aPZf7cs00cmmJW1ZqkfK93LkxB/wcsgoM3TsQ98IFfBCTzQdNJUOE2Z8ssOWihzU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3AnwW7/q; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-de54b28c41eso5675674276.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714429419; x=1715034219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGlufsSMUfGTy8V2I8bIM/xvglG1OuNLwieN2n+XFOw=;
        b=3AnwW7/qt2NY4X4SppN269zumAqVP8dgWSz29q9hDW0TCMbFkJ/3R4R65EGKy+8BRH
         fXU8i4pluLMRCLJGeZxa5lW5ZcOAwwwfThjY6/DZNuPGsJtFZR5jOyIIhl789SYmPspz
         cLzV+rg5gmT8k0AneojDRWu3epgxaB4R7jVQfJDq6AMBJZubjS5OWDRCGl+usQzY4DUv
         eB77sQqf2DfTplW4A10KroHlBazI39fx+Nbae8Noi1ouQVfSUzGEsIqccn4LrhQXgzYH
         YxrnxXXb/KEAu/xCmUd2oZdySD/ObThezgEvCtw1jgjb6GT2HlfnLPJALDJwmD7NW68p
         q/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714429419; x=1715034219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGlufsSMUfGTy8V2I8bIM/xvglG1OuNLwieN2n+XFOw=;
        b=leGKUietEuucWfLJzt+aEVbAYg2oJYqeKewdNh1WG0mKvgj8wPFZxRdACL6dWTQ/t7
         xoZr6lGb4q6HkkxCcOQposLaGYdFl4MgAbOhtqr6cyVGmwJn4lS8pDgmGjPGgNSDcidz
         BMwbFPK3g9TrsCZ5yTfN6GOwTIfnIcMe3ZXhwC/mJj7evjvhy1wfazewhOSEr0y4xa+D
         eSqUPGOB15hBKJBdTLq9vYGE66t6COfxYKI7HcwhLyjb9oRNDrVrC3Qovg7q7fMZQLxW
         RTvIhZaP1la+lQqn5HXOOy7393WJB7i97UiitdKnMwcSWiVBhp9unBebDjzGtzGquhwX
         L3Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWiry29ZhkVOxtXGBg8Rx8grV7XYRVn7JKtp6zf+RRxye2o71UYDtA29ViwipiOOMXA5m6YX9l4BqwY3a4zD1JiIGUr1scpl3ET9e9s
X-Gm-Message-State: AOJu0YwMmDcpzcSy93//dHZMzCmXBhP5NiMvYCt0NX6aNynvrLT3tp0m
	2dwnZTmsc3D2Lh7MujiK/21SXQCDmYDzCQYlr8wcGdVlv6OdE0Bes7k7yhR2THQLG1AhtefjxUP
	p1C8vANacmaIdbHkDt5pGmcn0ujrYJc0EHJ4+
X-Google-Smtp-Source: AGHT+IFcZdV4o2I0NUoP3fsMkexjFVz2+gYRb/Ki6ZR5UaWOT+mDGMiynQRMBiBVixthEiWIHr0px9K7N8duA/KrQCI=
X-Received: by 2002:a05:6902:160d:b0:de5:5647:c87e with SMTP id
 bw13-20020a056902160d00b00de55647c87emr14146085ybb.33.1714429419440; Mon, 29
 Apr 2024 15:23:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427003733.3898961-1-shakeel.butt@linux.dev>
 <20240427003733.3898961-4-shakeel.butt@linux.dev> <CABdmKX0Mo74f-AjY46cyPwd2qSpwmj4CLvYVCEywq_PEsVmd9w@mail.gmail.com>
 <j4dsapl5hu2enzoq5c7y3z2bqksk6fpygkk5t45ok7d5v3gdt2@5ygpjaj2hiva>
In-Reply-To: <j4dsapl5hu2enzoq5c7y3z2bqksk6fpygkk5t45ok7d5v3gdt2@5ygpjaj2hiva>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 29 Apr 2024 15:23:28 -0700
Message-ID: <CABdmKX0OQM65dRK29XCAUrnJt2yv=p7i00Cpc9V9FGuOEfuZ_g@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] memcg: reduce memory for the lruvec and memcg stats
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 1:13=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Mon, Apr 29, 2024 at 10:35:38AM -0700, T.J. Mercier wrote:
> > On Fri, Apr 26, 2024 at 5:37=E2=80=AFPM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> [...]
> > > +
> > > +static const unsigned int memcg_stat_items[] =3D {
> > > +       MEMCG_SWAP,
> > > +       MEMCG_SOCK,
> > > +       MEMCG_PERCPU_B,
> > > +       MEMCG_VMALLOC,
> > > +       MEMCG_KMEM,
> > > +       MEMCG_ZSWAP_B,
> > > +       MEMCG_ZSWAPPED,
> > > +};
> >
> > Unsigned for these? All the values are positive now, but I don't think
> > we'll get a build warning if a negative one ever got added, just a
> > crash or corruption. BUG_ON in init_memcg_stats if a
> > memcg_stat_items[i] < 0?
>
> We are depending on NR_VM_NODE_STAT_ITEMS to tell the number of elements
> for vmstats. So, I think there is an implicit assumption that there are
> no negative enums in enum node_stat_item. So, if we want to verify those
> assumptions then we should be adding such warnings/build-bugs in vmstat
> first.

Ok fair. I guess this if we get C23:

enum node_stat_item : unsigned {

