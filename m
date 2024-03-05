Return-Path: <linux-kernel+bounces-91747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D271E8715FF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9DA51C20DD7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B3041775;
	Tue,  5 Mar 2024 06:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ONVtEDtZ"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F4B405FD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 06:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709621270; cv=none; b=ap6A4YvpauiTNRDueHRiIvzs1QlEQjskFc/boiV+9PPrKpMxHif6YCd15I7JTrhz08MUPHjwhvO80iCrGpPAnB3LE4Ql14/KmC6AGX2DZUUgfQ4c/jVloU/LpSUlQykAEezX7T+wQi7YUChsu5HFaVwfMnDsEHtw7x6kmdMaya0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709621270; c=relaxed/simple;
	bh=O4yVRud/9+8a7tAKirWeQ09Db+zegMJkuUhSNXLZlLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1tqYNUKaIgE6MZL4TvlRw24lM4lZBhYFJym3FJt1wzqdJma9JVru3YNfKBE//kMX0E0nn4QLvBjXcxuAC7MjkU0Dn8YYZl8/D4ufH32mG5suG0FfN+k3Gr/6j1F0Cudyjbw279YO+8J3ynB+G3DB+G4+oDnAQ8ldqWmYZ1S5g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ONVtEDtZ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42ef8193ae6so128601cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 22:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709621267; x=1710226067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2isqh14d05L6zoJqPkxhn5o+6H4cX5aRd/OEiiiX0AM=;
        b=ONVtEDtZdzGnMJI+zo6Oxb19tlK2LZZG1OtKEJjSDJAbbkfK8OghKuvZmaFYcvu/aw
         00nQIKJ0STugS5NGNpDi52ueOHzrs0jBU6LCJZnjeg0F7K0+0hojasrLKyBPdrzICwgb
         a7CQp8m9NJelj/uwWRMVpwDOVjY/erQQLQTrJH84wDptjLL3dF7q19YffDMjCh+T19bI
         EvCnvg71oWAhY/fcuW69km/FZ0iiWilN4rGQACnmQHkDKyYdodgWzEgOjV+132sCYSlc
         HmvoSu6vEIhJCXZeWKPcRT680jedt7PLqjL8biSxsTx3nLognxntH+qptoTxnKN8WKzF
         bMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709621267; x=1710226067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2isqh14d05L6zoJqPkxhn5o+6H4cX5aRd/OEiiiX0AM=;
        b=dP5K1wED4Fz2SM3zOd1+ZUvdSY+L7QhxHfk4mL1EzAIIPLZtu2hAXy5dNUPl2mMYQZ
         /7TTqb7Q5y3cUCofyQh7ZJJ6hU9BBzElyxWO+Isb8SPgUVMEalADwijCTF/Yhnmvgxg+
         HquY68dv9qKEoGNHYIJbTvkZo21FH/G8lIctndKjC3+o1EAXMVVZdExDPF2Wl1FJdbE5
         t7yw1nXdpm/8fmLRetRSV2Pzy2gupdtejmKizKfmfBwM3L3kZGzIS8EFH61Ef+PeWV8O
         m8uGxGq3JrVnfu+EwQfU3GLspnWZ3Vnimd5mYTQhdkTKmMCY+28jmIEAKlZR0likabws
         RXVw==
X-Forwarded-Encrypted: i=1; AJvYcCV0QfG2ogRxCMCzWQsU6OYk2uuKnMynLE48l3nIykB13LWVbCiZsHiNwVlZVhV/AgAxMktMHh0Knq7+Hm628Qk60YGBLqoqtOrdk3we
X-Gm-Message-State: AOJu0Ywqw2vQ65VUMsfYNz+LCfGC+VZ+nmLiTrEWmyPYhEl3KBIoIfKN
	mIKNXA42nw48+/1SMe+3wsaPhXv8aHImOjA5xSJ7rCrGgT0EkQ2GptlIfgVmpyt+TL+x7E/6sX6
	3YYUHipAhem40ZTtyL65+q82GW/zeN2a6SikF
X-Google-Smtp-Source: AGHT+IEpTpDOEFpl781QIzwL1OSIgfOz8xQaKP1fzK3tIs7/SmlB6dYuX3/oXifYUhhn/nzwkSXVJ6GySFAH0BOpg+s=
X-Received: by 2002:a05:622a:1985:b0:42e:e0da:343d with SMTP id
 u5-20020a05622a198500b0042ee0da343dmr123630qtc.10.1709621267471; Mon, 04 Mar
 2024 22:47:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229105204.720717-1-herve.codina@bootlin.com>
 <20240229105204.720717-3-herve.codina@bootlin.com> <acb69aa8c1a4c4e9849123ef538b9646a71507a0.camel@gmail.com>
 <20240304152202.GA222088-robh@kernel.org> <20240304174933.7ad023f9@bootlin.com>
In-Reply-To: <20240304174933.7ad023f9@bootlin.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 4 Mar 2024 22:47:09 -0800
Message-ID: <CAGETcx-tmyJA30GtdU_dO9tWFoK+rO5tm-On4tPR7oQotnMkqQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] of: overlay: Synchronize of_overlay_remove() with
 the devlink removals
To: Herve Codina <herve.codina@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, 
	Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 8:49=E2=80=AFAM Herve Codina <herve.codina@bootlin.c=
om> wrote:
>
> Hi Rob,
>
> On Mon, 4 Mar 2024 09:22:02 -0600
> Rob Herring <robh@kernel.org> wrote:
>
> ...
>
> > > > @@ -853,6 +854,14 @@ static void free_overlay_changeset(struct
> > > > overlay_changeset *ovcs)
> > > >  {
> > > >   int i;
> > > >
> > > > + /*
> > > > +  * Wait for any ongoing device link removals before removing some=
 of
> > > > +  * nodes. Drop the global lock while waiting
> > > > +  */
> > > > + mutex_unlock(&of_mutex);
> > > > + device_link_wait_removal();
> > > > + mutex_lock(&of_mutex);
> > >
> > > I'm still not convinced we need to drop the lock. What happens if som=
eone else
> > > grabs the lock while we are in device_link_wait_removal()? Can we gua=
rantee that
> > > we can't screw things badly?
> >
> > It is also just ugly because it's the callers of
> > free_overlay_changeset() that hold the lock and now we're releasing it
> > behind their back.
> >
> > As device_link_wait_removal() is called before we touch anything, can't
> > it be called before we take the lock? And do we need to call it if
> > applying the overlay fails?

Rob,

This[1] scenario Luca reported seems like a reason for the
device_link_wait_removal() to be where Herve put it. That example
seems reasonable.

[1] - https://lore.kernel.org/all/20231220181627.341e8789@booty/

> >
>
> Indeed, having device_link_wait_removal() is not needed when applying the
> overlay fails.
>
> I can call device_link_wait_removal() from the caller of_overlay_remove()
> but not before the lock is taken.
> We need to call it between __of_changeset_revert_notify() and
> free_overlay_changeset() and so, the lock is taken.
>
> This lead to the following sequence:
> --- 8< ---
> int of_overlay_remove(int *ovcs_id)
> {
>         ...
>         mutex_lock(&of_mutex);
>         ...
>
>         ret =3D __of_changeset_revert_notify(&ovcs->cset);
>         ...
>
>         ret_tmp =3D overlay_notify(ovcs, OF_OVERLAY_POST_REMOVE);
>         ...
>
>         mutex_unlock(&of_mutex);
>         device_link_wait_removal();
>         mutex_lock(&of_mutex);
>
>         free_overlay_changeset(ovcs);
>         ...
>         mutex_unlock(&of_mutex);
>         ...
> }
> --- 8< ---
>
> In this sequence, the question is:
> Do we need to release the mutex lock while device_link_wait_removal() is
> called ?

In general I hate these kinds of sequences that release a lock and
then grab it again quickly. It's not always a bug, but my personal
take on that is 90% of these introduce a bug.

Drop the unlock/lock and we'll deal a deadlock if we actually hit one.
I'm also fairly certain that device_link_wait_removal() can't trigger
something else that can cause an OF overlay change while we are in the
middle of one. And like Rob said, I'm not sure this unlock/lock is a
good solution for that anyway.

Please CC me on the next series. And I'm glad folks convinced you to
use flush_workqueue(). As I said in the older series, I think
drain_workqueue() will actually break device links.

-Saravana


-Saravana

