Return-Path: <linux-kernel+bounces-153846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7C48AD41A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 358E5B23148
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864C715445B;
	Mon, 22 Apr 2024 18:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Icr2fym4"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814B31DFFB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 18:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811153; cv=none; b=Pfjj1MnvOLT4SnQIvlrziVx7smaUGwWXmMnFLBHpNhDYbUAfhO1/f/swur6zV873n9i7qns9ujtHUezyEV9+mTQO/KJPBdzPlz+lwacV8p8QluzxltJTqTX/F5OCgt4umghC/xaNIW9U8Lf6RQz9ny1cGKfHbK8wCXf9gz4PPu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811153; c=relaxed/simple;
	bh=nBrxHq3iXKjXVxAiTEH3avv4YKJ6lj757YoguXkdy5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HossSsLAsNGJ1YJcaSRh9djMEmZ4mtzKStMloLRgF3rViGhyE9Yv2Onqxhq6SRHwxxziQTMmK9lwvHxaj40mMnyNKQpqYT6b+ILD7sVjWoVZdMPp6U0kFS00KgJRjGUgxwink7YCTqquU836GSmM8ga7RfmpXSWNevt0GZ1Ice8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Icr2fym4; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e44f82ff9cso17475ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 11:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713811152; x=1714415952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBrxHq3iXKjXVxAiTEH3avv4YKJ6lj757YoguXkdy5k=;
        b=Icr2fym4OEI1uR0UhTZDD4NhP6FdSSBy1haTNiclJ1DUekgd1Jaj1cxHWzIeEnR1oI
         JxC8EQRsMflITxu7/wVYqjmQiZU3rrXjwg93QbLOEU8DyZGTCDV/vyaRtKVrRdpy20DD
         N390qt+n94CaYadjcUPwcPeBo+le9uxik7yaAtgXJE88n+/Xd4SvAeuwCL0tLvDuqqrn
         BFZWAGFcc6z1ccRFqOJgo5xI6Cb+S0z/T9Xgsl+xoubiUKjMLaKEYtUxuo+gcdXIavzV
         9tkEXu+LQf82f1yRhEAq+EtryYkr/6ze33LGmRjJhvtomj60g27oisKKYdIvESDO/Yf+
         Zvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713811152; x=1714415952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBrxHq3iXKjXVxAiTEH3avv4YKJ6lj757YoguXkdy5k=;
        b=Rl5uAfhHBp0yHAnBmuHEoXebomVWjzGgFHn0NvLcoLS5ZJSSKYe1yY64lBRqgJ0qdC
         +d+XZmBC5eeS++Ha083jyKvd2+sfabNl+o1qLRZauHSRRxDSJlXX8uI8T5aUi9IP85SN
         sR++4cXjYix32ALrEH23ZvapvgsmUA/aLA7U9NS6mblPbvQpNkTcGNXNLESXRV4i+y3Y
         KJyktK0udNoC0yuKXDEy4YqrrxLBCo1oeyCEEDlOXCSrGJVxo2qSxhAXYtWbDMpJhHMt
         JaOsFi4I56keltVOeatH0vOqGF24GNjMK2AUy/otRWRJ46ItloJvTdlS/BIznQhcVar7
         Exlg==
X-Forwarded-Encrypted: i=1; AJvYcCVcEUaFk062DxPRYchim8b8zDAiwvqUjJzKGEONIQGTMpPOfjGLdeNoSBGaNe8e077Ttiq7MEHPZ7YxOTkb5IIu0QAKOKsUbzKX0nJK
X-Gm-Message-State: AOJu0Yx2VvhHVqDMqkeebq5upBue2Wdu/59zqi+btVqIigxNfzo6fqX9
	MKl7Iw8pybW1QilxFpKcOuHnU8SumrsLUIvf+LPbLZSxd2Zu++2XNQi8z7qWhtAp0P2Ed0sNtuA
	iHD+4GqbM2Gi8M9AEkfaAzXr0XUD19J62260y
X-Google-Smtp-Source: AGHT+IFgpc3nbNODui60eunbNCUPikJAHk3lvPuBSWlrk1TzM3AoCr/DWPlh8L5JH96YXsEj3pLV8PDbCdtu5CnE/Z8=
X-Received: by 2002:a17:902:fc4f:b0:1e8:88b2:17cd with SMTP id
 me15-20020a170902fc4f00b001e888b217cdmr29412plb.12.1713811151575; Mon, 22 Apr
 2024 11:39:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321165106.31602-1-james.morse@arm.com> <ed23454e-16df-48e9-a344-a6d8baf902a5@intel.com>
 <ZiE8/oXyjBef2qTy@e133380.arm.com> <acce93e6-4c8e-472d-a2bc-5cbad2950661@intel.com>
 <94c3bfd0-e221-46c7-86c4-f0545e66f17d@amd.com> <4cf859be-294f-4db3-948c-a96b5457a10d@intel.com>
In-Reply-To: <4cf859be-294f-4db3-948c-a96b5457a10d@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Mon, 22 Apr 2024 11:39:00 -0700
Message-ID: <CALPaoCi6cd8=Kc6ozDok=s6koxvOH-vTDmaCxbichk_72e6auw@mail.gmail.com>
Subject: Re: [PATCH v1 00/31] x86/resctrl: Move the resctrl filesystem code to /fs/resctrl
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: babu.moger@amd.com, Dave Martin <Dave.Martin@arm.com>, 
	James Morse <james.morse@arm.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, 
	shameerali.kolothum.thodi@huawei.com, 
	D Scott Phillips OS <scott@os.amperecomputing.com>, carl@os.amperecomputing.com, 
	lcherian@marvell.com, bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com, 
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>, 
	Xin Hao <xhao@linux.alibaba.com>, dfustini@baylibre.com, amitsinght@marvell.com, 
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Mon, Apr 22, 2024 at 9:01=E2=80=AFAM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> Hi Babu and Dave,
>
> On 4/22/2024 6:51 AM, Moger, Babu wrote:
> > On 4/19/24 23:06, Reinette Chatre wrote:
> >>
> >> [1] https://lore.kernel.org/lkml/cover.1711674410.git.babu.moger@amd.c=
om/
> >
> > Do you have any more feedback on this series. I have few feedbacks from
> > Peter. I was planning to work on v4 of this series.
> >
>
> Babu: It is difficult to start drilling into the implementation before th=
ere
> is agreement on the interface. One reason you went through the effort of
> the first few iterations was to accommodate Arm's use cases as we underst=
and
> it, but we need to hear from Arm if we are on the right track here.
> I do hope that we will hear something in the next couple of weeks.
>
> Dave: Could you please check in if the interface introduced [1] is someth=
ing
> of interest to Arm? If it is not, we can proceed with the implementation =
without
> trying to consider how Arm may use/need such an interface. If it is, coul=
d you
> please let us know when we can expect feedback from Arm?

Because MPAM implementations typically expose an MSC for each DRAM
channel, there is an alternate strategy we can use for the monitor
scalability problem:

When a single DRAM MSC does not provide enough monitors to track all
of the supported PARTID x PMG combinations simultaneously, the DRAM
MSCs collectively may provide a sufficient number of monitors.
Therefore, as long as the distribution of traffic among the DRAM
channels is uniform (or predictably non-uniform), it's possible to
estimate the total bandwidth with sufficient accuracy.

-Peter

