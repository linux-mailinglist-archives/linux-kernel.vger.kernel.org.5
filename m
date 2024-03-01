Return-Path: <linux-kernel+bounces-88256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BA086DF48
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C164C1C215DA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6ED41C70;
	Fri,  1 Mar 2024 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uQ1Q7qdp"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6578316FF46
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709289244; cv=none; b=qMydEzf/+bZOrfYVXNbj7o40NHvdLADYdLcSpBfJZhsRPatD8bqJ4/hbEmmoqV/nQi86nz0EJZ+eHfF4A6pJxkAcYFLsctK7nmGAL4Cl7Ftk7IIrUGkHvNcqoqi9cL3v9Lm9bXlwDO8rXzYaRyT8Cnc9B0zr9r2YTz19kks/etI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709289244; c=relaxed/simple;
	bh=Ry8/2w0QVEHlwgRVzjogopViWIZq1zbn4ZZBHItPozo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L451s85pCoqqTS+oLa7ZM5yeiRhImWRIz37BecRoZkyL/eRRrDRrYz93UQWCgcRQqzIwN/nTaRLm3iJ4IX0G+RbilOwcp16bN9YhYpTGQM4/tyPhjAm7/X+wPM6PAOL9dqTDx2B96u/mdCswWacKR6pmfuIzS8gd3H0FKr1C3C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uQ1Q7qdp; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcdb210cb6aso2089567276.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 02:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709289241; x=1709894041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ry8/2w0QVEHlwgRVzjogopViWIZq1zbn4ZZBHItPozo=;
        b=uQ1Q7qdpg7Y+zkac/17XmSrG7/sop4upvYPJUVjyv5/PuhYFwszcKEECpTVKYyL1/V
         UzfhdpqfnhAt8UWzihNgsr7Ya9tc3EfYUBuSrQRL1zQOeZVI0jMqJEorPxhjYtVvrAS/
         1JS7xp8nCqY6w6L80UdnynM/LI58MDv6AXH9bHyXpqZsV/2OQmhXLzcxaHk26yDdcx8d
         kmZk5WAKqdHJtQx8xqOa/3V0nbFDB8FQJwZA3HyB2pJ7iTn7sq1WcXYTaqFIHsYLKxVC
         3nj9Kb7HcmNJ1DYcA6OUoolWG22ebzX1ZhlQV1Qlv/0d5ECEGp2rX7vx6bGx1+TKlPzg
         iTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709289241; x=1709894041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ry8/2w0QVEHlwgRVzjogopViWIZq1zbn4ZZBHItPozo=;
        b=GGpdk47QPICOzlf6CPO0PZQBg5orvUWocGbn7mIasWC3tTgLUA8J+xRxHt8hOlsR61
         n9u54q/Bijp1pwjxUdcMJ5vTBeFZTn37HBquerA2HOsWHuZkLe100qt3Wn9fS7KWuV16
         VgYUPeNgAlkIsvhFTzks2GOF6b5sdy9rgBq/P7ehvR9eEvUWzJx8SoueByz/6zu10BMj
         gBB9pE84efvr4ANU0t8yq9ni8jkhsTHm6FQBOUDaJ/O6bDOKsR+b/8J84s3UtskJBG3l
         kq1YQyrDtZt9NUrqLKeLuIZQ7h3h9SIXi2NYp8tEWtQXoRqF6yj6dxMhAsT2+NvPCm2k
         XXmw==
X-Forwarded-Encrypted: i=1; AJvYcCXhDWm1h+C665Ixu00w1xCKNO/TGJ6/B+iKa1aig7hqQFnYcXUvfBehGkPVAiyRBPHdWSFPbfs/MnQD87eHjU0LiRxNwdrz3AH9Gbuc
X-Gm-Message-State: AOJu0YxAzGUGG3g2cSYwx7ub8SRKZRfpmjvmFDu4k2oqn3E/l6yaRfX0
	t8/IE1CICTp43JIoAVA3KgpidRyig0Dz2TeSQVcme33qvy7JvNswbjV1Qug+cZvk6Acb4Hfhk2F
	uJ4LZ6aN4m0xzEknDmoOIqOomW4pDT9/He/1JYQ==
X-Google-Smtp-Source: AGHT+IGERyzwl5JHRolGFpVOmFvjkUTfdY15E+u1KDaBF4OJqM+rOB0z84Izn+7q9uLfFLp6OZE9sWxK0P9ekG0WUOI=
X-Received: by 2002:a25:b988:0:b0:dcd:26a8:7f84 with SMTP id
 r8-20020a25b988000000b00dcd26a87f84mr883337ybg.47.1709289241487; Fri, 01 Mar
 2024 02:34:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240213051332epcas1p1f45d02dc34d1b95ea5608ab779d6b6cc@epcas1p1.samsung.com>
 <20240213051716.6596-1-sh043.lee@samsung.com> <CAPDyKFrjZ4jRHAfXsvrEvezuHTxbA3SAniF8CuObyLuW=AUoeA@mail.gmail.com>
 <000001da5faa$d34e1600$79ea4200$@samsung.com> <CAPDyKFpOLU3nsQuXLRdK2KAaQqX=Vwe0+A3jZc7pP4XaMG7Wug@mail.gmail.com>
 <000001da6075$754d6ee0$5fe84ca0$@samsung.com>
In-Reply-To: <000001da6075$754d6ee0$5fe84ca0$@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 1 Mar 2024 11:33:25 +0100
Message-ID: <CAPDyKFoaNFox5iuyh_veP203JYipa8Nt36Z1Y1J6CUJSCLhx_g@mail.gmail.com>
Subject: Re: [PATCH] mmc: sd: Add a variable to check a faulty device
To: =?UTF-8?B?7J207Iq57Z2s?= <sh043.lee@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	gregkh@linuxfoundation.org, avri.altman@wdc.com, grant.jung@samsung.com, 
	jt77.jang@samsung.com, dh0421.hwang@samsung.com, junwoo80.lee@samsung.com, 
	jangsub.yi@samsung.com, cw9316.lee@samsung.com, sh8267.baek@samsung.com, 
	wkon.kim@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Feb 2024 at 02:14, =EC=9D=B4=EC=8A=B9=ED=9D=AC <sh043.lee@samsun=
g.com> wrote:
>
> > -----Original Message-----
> > > > On Tue, 13 Feb 2024 at 06:13, Seunghui Lee <sh043.lee@samsung.com>
> > wrote:
> > > > >
> > > > > In mobile devices, suspend/resume situations are frequent.
> > > > > In the case of a defective SD card in which initialization fails,
> > > > > unnecessary initialization time is consumed for each resume.
> > > > > A field is needed to check that SD card initialization has failed
> > > > > on the host. It could be used to remove unnecessary initializatio=
n.
> > > >
> > > > It's not clear to me, under what circumstance you want to optimize =
for.
> > > >
> > > > Is the SD card ever getting properly initialized during boot?
> > > >
> > > > Kind regards
> > > > Uffe
> > > >
> > > We receive a lot of reports about SD card issues in the market.
> > > There was no problem with the first time at the time of use, and ther=
e
> > are many cases where people recognize that it is not recognized later o=
n.
> > In most cases, this is a problem with the SD card itself.
> >
> > Right. Thanks for clarifying.
> >
> > A follow up question from me is then, do you know more exactly *why* th=
e
> > SD cards encounter problems?
> >
> > In the past people have told me that powering on/off an SD card during
> > system suspend/resume, too frequently, could damage the card. For non-
> > removable cards, the card stays powered-off even after a system resume,
> > but instead gets powered-on (and re-initialized) when there is a new
> > request for it.
> >
> > In other words, if the problem is related to too frequent powering on/o=
ff
> > the card, my advice would be to test with having the card set non-
> > removable (the DT property for this is "non-removable"), to see if that
> > can help. If that solves the problem, we can work towards another commo=
n
> > solution instead.
> >
>
> I understand your focus on finding the root cause of the problem.
> However, unlike internal storage, there is a limit to analyzing cards tha=
t have problems in the market.
> This is because there are many different SD card manufacturers and many m=
anufacturers leave it to OEMs.

I understand that this isn't an easy task, but for sure it should be
doable. There are plenty of less robust SD cards out there, let's just
try to find one and see if we can break it. :-)

>
> For deferred resume, a responsiveness problem occurs on the user side on =
mobile devices.
> The response time of the initializing SD card initialization in the appli=
cation seems to be slow.
> Currently, it seems to be a good structure for the first initialization a=
t runtime resume.

You are correct - an initial latency for the *first* I/O request will
be added. On the other hand, if the SD card remains unused after a
system resume, there should be some energy to save, as the card would
then remain powered-off.

Moreover, if we also can avoid breaking the SD card, I'm sure it would
be worth it.

>
> Regarding non-removable,
> We will test if we are given an opportunity to further analyze the cards =
occurring in the market.
> However, SD card detection is also used as a wakeup source and must be in=
serted/removed so I'll consider it for testing purposes.

Yes, I understand that part. A proper solution needs to take care of
removable cards, of course. The suggestion to set the slot as
non-removable, was just to try to understand if that would solve the
problem of breaking SD cards.

If the card-detect irq, can be configured as a wakeup source, I think
we should be able to distinguish - if we need to do a power-on
(re-init) of the SD card during system resume or if we can avoid it.

I try to get some time to put together a patch for this, no promises
for when, but I will keep you posted.

[...]

Kind regards
Uffe

