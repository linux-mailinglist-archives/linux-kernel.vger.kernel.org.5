Return-Path: <linux-kernel+bounces-83089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E8B868E49
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4852B265F5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016A31386D9;
	Tue, 27 Feb 2024 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSyrW8bb"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1888C130ADF;
	Tue, 27 Feb 2024 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031847; cv=none; b=hepN/E1cwRJ0CJUHFGU2Gzud1Lk5Zjkiv7U8iIESI09XQKJnzK9rNvpDElpwxumW07735SjiNhfZk7cN2cMV3q0W+Yf3gdHSPQJ2DpvApoZU7zVXaEBDCOtYify4+4j7LlovJThM8ig36q6i/9hkHciPS+fw9kdKf+PxqnXSCGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031847; c=relaxed/simple;
	bh=S994xZS5hVn5DF9xj4V4VbvofR11fVlbVQtqyP9zaRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uXdb2c+8AeW3fbJfhbJoi0qj/yhvgLuyUjruR3/arr6Xs8f62X8CGYRupDOG0irQoYSnc+gNulliLMBOC+g7//TLXvWDzk/wGQ1yxl9TeXjB4PWG2/hteIy/HHH0/SgWRQyLPzfiB+hdDIukVkCnfWJSFiSKi27SrFWSWiAcOf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSyrW8bb; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3e7f7b3d95so466284366b.3;
        Tue, 27 Feb 2024 03:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709031843; x=1709636643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qB49JUidhnyE0DLnYhbcXl+mJdF4zQ+oZKR7iKk8odU=;
        b=bSyrW8bbaKUY5Nzagj3x4z02pruLNlJ3s7jV805GNIhbuD97zlLo0b4ErBfpX2+Dcs
         xRkpvcgWWFGskPaom5ZtslyV9BiGp/MnpnfccLpItALvfXKncgEMc1Zd+I9U0UwNqomF
         QbWSWDU+YolZzyqijaW2XhlKh+38cBsstjwow12MHKD41LASWmL6z8X1/f1q6ZihMhQp
         t0h1ZXX6N3orEiuGxqYZxeasovbeRAgFIbkwqIN20BtEL93ycJAMjRTB2hIrli92ZdtR
         beRRRApKP1Wvv5XbPQg1mekCBQVZSHrPr9oL/ivQoioKUiKzi+b2cdDc50PpLxxhR+UI
         E5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709031843; x=1709636643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qB49JUidhnyE0DLnYhbcXl+mJdF4zQ+oZKR7iKk8odU=;
        b=t6LXRQAM06k4BEMkrRZRXM2cRSVmaF2Vt1mcMilU1fkC5AnfQ6fKvECKxCAesPJpLj
         w/hCx2leKb805dS7ITQ2rDB5jKhnQsWBB+lswF4l3N2HGCwXwDcK29hXbc/nIgOiK31r
         h1KfyePUhi3NQ9mmZunF5U0ld1Hy7Tua1o4+1pv50LSstMioAj5u5ZTnHk4rSskukibm
         lXP1r9WvttujwRafzSvNlIhKGB0Q0MIX9ZJGjxj4OpiHsLcdPd7Qolywh2D05NAndUed
         jFj6qYzeoGGUXUVDe12yvCReoH29imsHLJDTtcCYSYJlMCOIkaMKa6INcr3vIRluOQPm
         w92Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEFWSLW88i0sUqtf5Ez57gNLdXI2vsYldRzSOoMz/H2LgE82/zKT0u9xxom71ry6C/8q7MFFr096NP4/60/mdL3J01NNYDfKJCDU5IUTKPjWDflggsGhNsBMEyizkxVXf9tBLr2yFQHdHJBRhBwL/yYcNZfQEc5BzbGG9451IoD7TNyksWvyC//6w//FQZMwRBrolPUj40Vk2H68ca+7IncfW1
X-Gm-Message-State: AOJu0Yx0qoIu26vdh41tUNd3v01FyufOzNcovTuq7+CePmSzcF3km2S5
	+9FPA8X6kXaDfQyFT8ziWr7leIPW3LFh6Ol1Ze/C8v6z6vNZxy/bn3EK1A295+QrQdbyGSQmMO5
	HqW6SQjv6g+M5y6kGKd2xwf2cbR23p8t+PUM=
X-Google-Smtp-Source: AGHT+IE3mVEu8Iomgte4NRXBGNXbJaWUrcAateWi4bx3mG6CvQy7ZQHn2UaYBVCVJjiMbOFetlQdzCyMIV9Gr/e8tMM=
X-Received: by 2002:a17:906:a049:b0:a43:3670:a2b7 with SMTP id
 bg9-20020a170906a04900b00a433670a2b7mr4449686ejb.44.1709031843264; Tue, 27
 Feb 2024 03:04:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226104653.54877-1-lukas.bulwahn@gmail.com>
 <43df625f-bd32-4dd9-a960-6d0f5c0304c7@infradead.org> <CAMuHMdUD94XuE_7UK3TEWbeZ2eMOPimDi-xoo9+43FhY3O2aDA@mail.gmail.com>
In-Reply-To: <CAMuHMdUD94XuE_7UK3TEWbeZ2eMOPimDi-xoo9+43FhY3O2aDA@mail.gmail.com>
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Tue, 27 Feb 2024 12:03:51 +0100
Message-ID: <CAKXUXMz66AzotSqzVHvXivdwhh0d34_GWqLu-hBgEq46AOOFSg@mail.gmail.com>
Subject: Re: [PATCH] docs: submit-checklist: structure by category
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 9:57=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Randy,
>
> On Tue, Feb 27, 2024 at 1:41=E2=80=AFAM Randy Dunlap <rdunlap@infradead.o=
rg> wrote:
> > >   - Concerning checking with tools, checkpatch probably still makes s=
ense;
> > >     it pointed out in several places. If sparse and checkstack are re=
ally
> > >     the next two tools to point out, I am not so sure about.
> >
> > I doubt that ckeckstack is important since gcc & clang warn us about
> > stack usage.
>
> True, but that would leave you without a tool to get figures when
> there is no excess stack usage detected by the compiler.
>

Geert,

possibly, we can configure the compiler to report/warn on any stack
usage from every invocation and then turn all those warnings into a
readable format or some format that further visualization and analysis
tools can process.

If that works, we can remove the checkstack tool. It is not a
massively large script, but it is certainly written with a very
special purpose. I mean it basically does object-code
reverse-engineering with a magic set of regular expressions in Perl.
If our current compilers can emit the same information, we are
probably better off just using the output from a compiler and
postprocessing that.

Anyways, I think it is worth investigating all that and then see if
the checkstack.pl tool still has a unique functionality, or if there
are other better ways to get this kind of information---well, it is
marked as todo, so anyone is free to pick it up.

Lukas

Lukas

