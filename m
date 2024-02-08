Return-Path: <linux-kernel+bounces-57575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D34B284DAE6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11C6B1C22E76
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DC769D35;
	Thu,  8 Feb 2024 07:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QM2nB+Ml"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D057C6997A
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 07:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707378833; cv=none; b=TVN4C7pujHSpJbzGlWZwTYHkfE/Vs8mXEompm+nUGsCpZY4p5ImppXUzIMWwhUv/GZVhVouXHCZxmGb19QTZlC1piEmUgqk2pk9NtWIVzPMQSrARR4uGs4KkbCB9AWk0/aLv3P2U7u22PX0ff6/4+9t4r8M+G98mQklUPc/y0Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707378833; c=relaxed/simple;
	bh=zr0nXHCLCgbCxf536hCWc47ovVoYrsykHUk2cT9bZpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bvZpU6ketZ7gA9OGc+9Mi4WLFzhOqJjsJ2g1gVxke7rz3UQA/dcgzI51K9FKhlmY2gP5i8G66sHNam8ulff+59i/AsXHUqx63itRn4c2UU1CyNfelgzG6O9hrJAH8o+un2ClnhYxdE8wJqy0s148Cw+aP1yrdwNy3rE3WElZ1Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QM2nB+Ml; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-60486805aa8so17179087b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 23:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707378830; x=1707983630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lTivgtbYP71+Odlu/TAApxufweZalnigwFKImBTxuw=;
        b=QM2nB+Mlhlgobh6k9lMwFemOZEPlu0Qo9pZJkb0S9Ss7eDu/mE9nJRT2R27ef0srg+
         x6catZOGy68HXl+cQXlFf6Ctkpdgk2t0yLB7dpynFxB6xwq6G222vnXyEhFk7gqb4rIt
         rn80VW3Mxa5aI/23CfPy0AdYwJiHFHTjmWW3O87inw4qYEXAsYT1q+SwfORndPZeaIR0
         KvBg1MwtWYA1hYmOYBHiqbnsmjzZpwT28Ib1vRMzP5JE1T0tMb9Jfw5ZBju+S+WfRpF7
         e/+OAc8KKwuaA74nwb/YLtwk1Gl6KEGlYVoep977Xj6AEDS5HTX+2gj7Op9/R+uGG7kI
         XhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707378830; x=1707983630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lTivgtbYP71+Odlu/TAApxufweZalnigwFKImBTxuw=;
        b=CyvsnXQWVymjvJnYyiayQoaOFGZhm7duhiiiw9ClVYu/dTwSVHZKJcelD3/oIwxXVz
         869xKKJPbVULh6F0yPx71VhfcGS5ezZhVHWlyqdcEcgsA65LZuZ6f7T10/jaMEqaQTi5
         RxudFL5Y2w/S/i8etq6fnIg8KCK8Z+AQcDsgNx3Zkuej+A13kKIGKiioUC54knm4IFbY
         N89GxOGVvgPYcdPQnorZtpaqpNkrTo7LXM+gpKSLgeVt8pbcPFT/ge6BIZhHNKcNK+hQ
         1ANgCoJZbIxu6LlnHAYe0s3Uyavw6WVJILohMkfTPvN8HDrlObTNtAS5oNaWK/UoRo3z
         eD1Q==
X-Gm-Message-State: AOJu0YygKnCEOmZSQZFn8mHf5EjUzpfiECh0vT5Dek5WEgyLSgKXPrZA
	AASbRmQcQyVTYb7H0GPT/0XVeUEprdvs9rgcB9xjCXXLg1RbPD0gumdt1AY18ldyK5YLwVPDedm
	S+EQZQSmhgSRUikSDP9Lf1necjn94EOb3w0Qa
X-Google-Smtp-Source: AGHT+IHq5op1lz43rDnEfucwyPkNa34V8pC6FdvL0c34p4k8oyrSf4BDHaIoFEgydIEr6WsetJ75rmQO565ZkVbVhlc=
X-Received: by 2002:a81:b545:0:b0:604:602d:8eb2 with SMTP id
 c5-20020a81b545000000b00604602d8eb2mr7083241ywk.12.1707378829561; Wed, 07 Feb
 2024 23:53:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205072312.2342188-1-howardyen@google.com>
 <ZcDPn5eLvMwpb7N1@smile.fi.intel.com> <ZcJTkQFcVhcGC52Z@smile.fi.intel.com>
In-Reply-To: <ZcJTkQFcVhcGC52Z@smile.fi.intel.com>
From: Howard Yen <howardyen@google.com>
Date: Thu, 8 Feb 2024 15:53:37 +0800
Message-ID: <CAJDAHvYYUcn2HL1QTSG-KA0QcuAOotk5hY4cpuasOu_H=X-V0A@mail.gmail.com>
Subject: Re: [PATCH v2] dma-coherent: add support for multi coherent rmems per dev
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	gregkh@linuxfoundation.org, rafael@kernel.org, broonie@kernel.org, 
	james@equiv.tech, james.clark@arm.com, masahiroy@kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 11:43=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Feb 05, 2024 at 02:08:00PM +0200, Andy Shevchenko wrote:
> > On Mon, Feb 05, 2024 at 07:23:00AM +0000, Howard Yen wrote:
>
> ...
>
> > > @@ -18,15 +18,9 @@ struct dma_coherent_mem {
> > >     unsigned long   *bitmap;
> > >     spinlock_t      spinlock;
> > >     bool            use_dev_dma_pfn_offset;
> > > +   struct list_head        node;
> >
> > Have you run `pahole`? Here I see wasted bytes for nothing.
>
> On top of that one may make container_of() to be no-op, by placing this m=
ember
> to be the first one. But, double check this with bloat-o-meter (that it i=
ndeed
> does better code generation) and on the other hand check if the current f=
irst
> member is not performance critical and having additional pointer arithmet=
ics is
> okay.
>
> > >  };
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

I'm trying to re-org the members as below

from =3D=3D=3D>

struct dma_coherent_mem {
void *                     virt_base;            /*     0     8 */
dma_addr_t                 device_base;          /*     8     8 */
unsigned long              pfn_base;             /*    16     8 */
int                        size;                 /*    24     4 */

/* XXX 4 bytes hole, try to pack */

unsigned long *            bitmap;               /*    32     8 */
spinlock_t                 spinlock;             /*    40     4 */
bool                       use_dev_dma_pfn_offset; /*    44     1 */

/* XXX 3 bytes hole, try to pack */

struct list_head           node;                 /*    48    16 */

/* size: 64, cachelines: 1, members: 8 */
/* sum members: 57, holes: 2, sum holes: 7 */
};


to =3D=3D=3D>

struct dma_coherent_mem {
struct list_head           node;                 /*     0    16 */
void *                     virt_base;            /*    16     8 */
dma_addr_t                 device_base;          /*    24     8 */
unsigned long              pfn_base;             /*    32     8 */
int                        size;                 /*    40     4 */
spinlock_t                 spinlock;             /*    44     4 */
unsigned long *            bitmap;               /*    48     8 */
bool                       use_dev_dma_pfn_offset; /*    56     1 */

/* size: 64, cachelines: 1, members: 8 */
/* padding: 7 */
};

Looks like there is about 7 bytes padding at the end of the structure.
Should I add __attribute__((__packed__)) to not add the padding?

--=20
Regards,

Howard

