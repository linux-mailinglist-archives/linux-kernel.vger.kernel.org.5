Return-Path: <linux-kernel+bounces-30454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9942D831EEA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BDD71F222AA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333F62D614;
	Thu, 18 Jan 2024 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrloyAPc"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2182D608
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705601016; cv=none; b=eNRHrEZ3+Z2tLtMx10xMIWl1NVdDtjU9RmXfKMvR8v8478whNyyc4fdrgq/IB0D/lAKQ8W6+C45kr8AoHKkUyIpikiS6jI4ip5+Z5GYcbHnDHPpVL5n8/0/hsNh9aq/DWA5GeyRCPbkaSf63kZzSGgOy842e5GIA16B/H6D2zwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705601016; c=relaxed/simple;
	bh=k3+zEx+acyiW+aIEwOmPAastvSc8OT/YMhcjX35Q39A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPrQIzGa5dL1PRo8SLs4vKSwLyrJIw2mSoLWHa5BBkh+W81mLSMXkcKBtsvdXTlC8B7g5vQGCBRoSXkxlb6jqhnB52LobQt+SAG9FzofclcT3/sBWK2YAOt2rmslChOTaY4lxs/IPjQOcA22ilgnyB28YITrqm7iirJl3134O8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrloyAPc; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7ba9c26e14aso22475939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 10:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705601014; x=1706205814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7SPqDiZNgqprY5vPmS7UZy9a1A1Nyd4TfzIR6Gn4ho=;
        b=XrloyAPc2SL8+VJWp4BSv1H3GQM50jt4lthN+Vj2GKVWO647pNaVtnwwfj00Bwj10j
         KGNbJlpRQR//bZgd35aB8W4/Zk0QaQhJF+jvl7ZQ+rDpVUM+yyk0yNjy3UVGXGstlvIN
         zFFDBRtvliDAjaFbr8rhkLIWicoYybADd+S9AoQLhnlpSr0t2TiJ4jWr99mdfWSKov04
         PvBhsuvoLjC8ZVonCaT2+b/muliPuK7xqTSDM1Uoekg3c+hBeE/2nCkiOOQ96FOWp6EE
         9MZV4O7Ki5KrdbLczjNnV42gTDmjR8KriB3nchAZgny4CkNkxyec6MdFnrRvso/d69kk
         8mNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705601014; x=1706205814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7SPqDiZNgqprY5vPmS7UZy9a1A1Nyd4TfzIR6Gn4ho=;
        b=AxzA54VF4Yqs13MmmiKH1ul2YgrkLV4W3kbriEypYj/OCEHay25hOVvUJbRJR6xpP9
         FSDQnc5IjKb/70EpG/eJPX9WU4Vp1ZicF01DZbejxpbF7Eb+5lC6s74DAo1BgbjaBCMq
         hnRE2GIuKYdMq6K/g/mMWXVcPxtCix4PoqkhHcMA39z72RWw3axmAojMv5M4OAlKmwSY
         A1qw+i25xmhq37+RcMOa0SgeST2Q0grv7s5kHmLmN6+8v1cPIL815Kr2PmPHceTSx302
         3I8F9En/tJ3+9sx47BojLHJdMEN4V1Lb3sixS5F329oahfDWbMC5zDkkE1JAI2GLCrWg
         +pnA==
X-Gm-Message-State: AOJu0YwRU9VM2LRTgCNQ6EORdE1WWaXrOvsRuwVUHOMEM2c/IOhUrZ1l
	Ye4N19YGzD08xcHU5mMyUyzy9SS3ysMrite7Hn3IVvT2ELCAUloxmvADqKZVvRbc0VrOykC/LQP
	h0Ns/aQyY4p5XdXhOIzmaIE6/f/E=
X-Google-Smtp-Source: AGHT+IGhXsnEyFiCrp9mBsrGplHaiMUn19opbcjwSMEhhxF6g3m1TVLIydvXadC1YDZ5+aMsdLe6zx+BzI2VcUbO3Bo=
X-Received: by 2002:a05:6602:4f50:b0:7be:c0d4:f567 with SMTP id
 gm16-20020a0566024f5000b007bec0d4f567mr2016987iob.4.1705601014316; Thu, 18
 Jan 2024 10:03:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKEwX=NLe-N6dLvOVErPSL3Vfw6wqHgcUBQoNRLeWkN6chdvLQ@mail.gmail.com>
 <20240116133145.12454-1-debug.penguin32@gmail.com> <CAKEwX=PjraCg_NjP4Tnkbv8uqnVw8yJGh-mbuZC02Gp6HMcDBw@mail.gmail.com>
In-Reply-To: <CAKEwX=PjraCg_NjP4Tnkbv8uqnVw8yJGh-mbuZC02Gp6HMcDBw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 18 Jan 2024 10:03:23 -0800
Message-ID: <CAKEwX=O2gcXEcMwvws=q4_izSdtjw_5oNvec=SekxxMPEOzgbA@mail.gmail.com>
Subject: Re: [PATCH] mm/zswap: Improve with alloc_workqueue() call
To: Ronald Monthero <debug.penguin32@gmail.com>
Cc: sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	akpm@linux-foundation.org, chrisl@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 11:13=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Tue, Jan 16, 2024 at 5:32=E2=80=AFAM Ronald Monthero
> <debug.penguin32@gmail.com> wrote:
>
> + Johannes and Yosry
>
> >
> > The core-api create_workqueue is deprecated, this patch replaces
> > the create_workqueue with alloc_workqueue. The previous
> > implementation workqueue of zswap was a bounded workqueue, this
> > patch uses alloc_workqueue() to create an unbounded workqueue.
> > The WQ_UNBOUND attribute is desirable making the workqueue
> > not localized to a specific cpu so that the scheduler is free
> > to exercise improvisations in any demanding scenarios for
> > offloading cpu time slices for workqueues.
>
> nit: extra space between paragraph would be nice.
>
> > For example if any other workqueues of the same primary cpu
> > had to be served which are WQ_HIGHPRI and WQ_CPU_INTENSIVE.
> > Also Unbound workqueue happens to be more efficient
> > in a system during memory pressure scenarios in comparison
> >  to a bounded workqueue.
> >
> > shrink_wq =3D alloc_workqueue("zswap-shrink",
> >                      WQ_UNBOUND|WQ_MEM_RECLAIM, 1);
> >
> > Overall the change suggested in this patch should be
> > seamless and does not alter the existing behavior,
> > other than the improvisation to be an unbounded workqueue.
> >
> > Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
> > ---
> >  mm/zswap.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 74411dfdad92..64dbe3e944a2 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1620,7 +1620,8 @@ static int zswap_setup(void)
> >                 zswap_enabled =3D false;
> >         }
> >
> > -       shrink_wq =3D create_workqueue("zswap-shrink");
> > +       shrink_wq =3D alloc_workqueue("zswap-shrink",
> > +                       WQ_UNBOUND|WQ_MEM_RECLAIM, 1);
>

[...]

> >         if (!shrink_wq)
> >                 goto fallback_fail;
> >
> > --
> > 2.34.1
> >

FWIW:
Acked-by: Nhat Pham <nphamcs@gmail.com>

