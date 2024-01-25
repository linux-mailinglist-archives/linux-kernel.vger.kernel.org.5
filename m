Return-Path: <linux-kernel+bounces-37882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AC683B6FC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABCF4285459
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43C267C7A;
	Thu, 25 Jan 2024 02:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W1FBNt3P"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BC2139C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 02:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706148281; cv=none; b=iL3A2X3ka/PQMoJ2MEWlcb73eCeg889nCb0LLCrHiAH+QXH+j4bSZXXcI0v0iI/uEnMOC9Bv3FUuHX5beFosNjoPDlZiiXjiWkf/KOKuYTLHHaObYZT7wjsmnfnzWtMmfe+tWWggA7H9/qtccfmVqvNKNPOEhxfVinxOx5hqWTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706148281; c=relaxed/simple;
	bh=x+wQbWdcVMPUodjzXD4SxE6xh1+yMDdy02y2PjiYLDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ZHZBP6G818drvJIMPzujJNdDttjZu4F6HlsqgAkMlNjxECjgRVYbYxQO0pqfk/hn3MDm0q4rtp3mlU5f3eciRCwsFFt3EruvYDBMjISLuNau71syjXPZnirIlDIUOQAnddiRDNJiTJqKurPxl7KhJR2KYb6/s4WWsvSzPABVJZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W1FBNt3P; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2143a96d185so1416149fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 18:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706148279; x=1706753079; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXSbpxldRQwJaZgTsF93EIsC+O+YAl5Fx9J2K59JChI=;
        b=W1FBNt3PElSYMwZujslmnPNk4xLXEy2d8Yx9shFMJ3n2EPg350uOdeJ9It6aF498Un
         uxN+Nozn7NxOuHPQKwjVUVfqWhqsoQ3IpAjTHSNc7ufaAPXKV745Alz9Lubi+0WpdFXA
         HtLNskxWuhqWaxO+CAvWWMGwpjddZN5+2qxYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706148279; x=1706753079;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXSbpxldRQwJaZgTsF93EIsC+O+YAl5Fx9J2K59JChI=;
        b=qfip8OPxrMP1MinoHUwCP05wyF7dIaXZikrzC7tgSAvNfS+Y2/8siAIIbBngp1EzxN
         m2hiz3hNNAe1v4IgY5x0U3oEDz3cwZxz6DLOczlPcSbBMHekSstqZcQcSsUnJPXLwSJH
         SvL1pCTPxOXhThxjnPWiADHQGqJrX2a+R5pDTPj9l4Ai1PFL7UJNMjZpnpUyIP6O9fpq
         7mjyiFlIrnjothyN41u3J+2EjXEhQB+xZL5GrAImQNfTWENSAhg+CPAhoS5fa1dRFgCj
         HIbc0xkt4ujOWvKSMReYtKSIMyEnNUzrDKc0lw0naumPKPc2gQOl08MoaYx0F3LT13df
         P0KQ==
X-Gm-Message-State: AOJu0Yx/1yG/YXmRGXXfHK9/l9U8PNIsxqQZmv+kYeWiYrWbi2qbDqn5
	LpYTi4dsfHYPBHF3P8Plw9/b6oJyPj4TFz7fpqX1JtdTyBe1c6CbeXldCDaTlP4Nm0mJKq29jBB
	EZEIk2qCVEUmi1RtKfwT9lUyndzF2z+e6aTij
X-Google-Smtp-Source: AGHT+IHlTe+z1MODYDADlbQ3RXk9t245ULpG2fW9+wJpOLVUAgr4K32ziK9o41eRX3/hO23gIpgTK9SNAOqnz8yLzS4=
X-Received: by 2002:a05:6871:551:b0:210:b3fe:67a2 with SMTP id
 t17-20020a056871055100b00210b3fe67a2mr140629oal.66.1706148277276; Wed, 24 Jan
 2024 18:04:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122152905.2220849-1-jeffxu@chromium.org> <20240122152905.2220849-3-jeffxu@chromium.org>
 <20240123181457.idckaydk7dt7q2qy@revolver> <CABi2SkX=wKnHmooxXzBnJxxmtfSjvfgYabN1Wh1LxFYjtFoFaQ@mail.gmail.com>
 <20240124200628.ti327diy7arb7byb@revolver> <CABi2SkV1MgPZvxdE52VSTGA7yxnv9-fZYfWe76xFd27cDyy_8w@mail.gmail.com>
In-Reply-To: <CABi2SkV1MgPZvxdE52VSTGA7yxnv9-fZYfWe76xFd27cDyy_8w@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 24 Jan 2024 18:04:24 -0800
Message-ID: <CABi2SkUxDJXEGVa7gTSPMroX6_Mx8f6HEhp_xBM3PDq6nnt7vw@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] mseal: add mseal syscall
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, 
	rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 2:49=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wrote=
:
>
> On Wed, Jan 24, 2024 at 12:06=E2=80=AFPM Liam R. Howlett
> <Liam.Howlett@oracle.com> wrote:
> >
> > > Considering this is the MAP_FIXED case, and maybe that is not used
> > > that often in practice, I think this is acceptable performance-wise,
> > > unless you know another solution to help this.
> >
> > Okay, sure, I haven't been yelled at on the ML for a few weeks.  Here
> > goes:
> >
> > do_mmap() will call get_unmapped_area(), which will return an empty are=
a
> > (no need to check mseal, I hope - or we have larger issues here) or a
> > MAP_FIXED address.
> >
> > do_mmap() will pass the address along to mmap_region()
> >
> > mmap_region() will then call do_vmi_munmap() - which will either remove
> > the VMA(s) in the way, or do nothing... or error.
> >
> > mmap_region() will return -ENOMEM in the case of an error returned from
> > do_vmi_munmap() today.  Change that to return the error code, and let
> > do_vmi_munmap() do the mseal check.  If mseal check fails then the erro=
r
> > is propagated the same way -ENOMEM is propagated today.
> >
> > This relies on the fact that we only really need to check the mseal
> > status of existing VMAs and we can only really map over existing VMAs b=
y
> > first munmapping them.
> >
> > It does move your error return to much later in the call stack, but it
> > removes duplicate work and less code.  Considering this should be a rar=
e
> > event, I don't think that's of concern.
> >
> I think that is a great idea, I will try to implement it and get back
> to you on this.
>
I confirm this works. I will add that in the next version. Thanks for
the suggestion.

-Jeff

