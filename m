Return-Path: <linux-kernel+bounces-75918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D138085F09E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487E71F23FC4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BE54C8A;
	Thu, 22 Feb 2024 04:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApqBBhuw"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547ED10E6
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 04:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708577971; cv=none; b=VjUi9qNNkSmxqWUQRjRE2vNu8kz1ioJ2tbtojd7+B8GyGKHXEIFkcKurVWgekJPC2I54G6cONBUwRZppnr3h4pl/Y6AhqGXJoDNmbFdgUSF46OA3Hg00/Ny0OvVgMcte8gPbQILV5sKRfqC+Dj9jIFch4dKANsfQHuPVJloeVLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708577971; c=relaxed/simple;
	bh=xb5j3rMpRU0U/dIrHB7A5hAvoVs23sihVv6Dnf6rKhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZEpeKHCyWbAP1nlDEbq6CN02daaQEpjtbXXORbRzQ3kRVSexQc8uUnZ/6ZMRZhZpn4nMaB4BWdGwAP056ai0NL0ttZRs8Bq4+Y8YjruVrMXiNqjjefyM/Y7zL6izRvJIAHXqm0tVdmXoZDvM7VXb2KyyoV+Jy40nO+Xvk6dWMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApqBBhuw; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-299354e5f01so367392a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 20:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708577969; x=1709182769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkvwPtt3vD/n6d+IDaM+WjaFdZ1PP/IynudLBP9yWlE=;
        b=ApqBBhuwfYWiWIwVHCVpkHm5PG3rrty/mDOpVg0rnFwHOLmDZMAwS6PiZz5j/Yutzi
         vo7KRkJNKPAOkJxWBmVg8L3iMLYKxhc68juMF/O/sM2LTao92VbdLIfrmaeKkwqda2Nh
         gv9RTM0yynZsXIGqUTo6kwgU7Mnml6TsKVqGmEa/dFSw8DrYiDa3jwhlzuK52sO1wDGu
         OSoTkjCloA5zCE7kb6stm2BfNFajTW9Rre7Ik/6aS46Z0eFV5Bqx1INvQKT7ekiVdEMz
         wPUEmbvOSWV4jr1GAoC2CYlZGtXO/z5jDCSfH/5fPq6HeCuvmIFpfNv4akl69DqGfZEI
         LH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708577969; x=1709182769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkvwPtt3vD/n6d+IDaM+WjaFdZ1PP/IynudLBP9yWlE=;
        b=JllYthv9usaw7eRC3XGvXwiyo4reOVdu1/XXTotheMKRXwjPzG0z/kFOJBKlmbGfBd
         kkcD6hC20E0ywdDMscjLd1ItXqVatMGjpPiOwA6VkzrT/5TCHbc4FmoAdnlu1ksxc/fo
         OVKlU3cqwyWJ7DxLijLaR/4WHXiwp5jq5iamIOJO+C622CnMrY0vsZIGCywjpf4XYXCf
         iQFJe4OhTjEX56qWPoQLNKY7lEMgMiZIjY1I7VHIl36kaQOktexBiT1nLLAsTuP0jT7r
         6NsAsIKfhuW5oEHBesAA1PD2Ng+2GiuQplUBjc4F4C1bbctnaQXX7m/KGf+s7frOKkdB
         yL0A==
X-Forwarded-Encrypted: i=1; AJvYcCWvUIumMObd2nCTk3EMTEEd4GkepG7wQBAQseVUS7dUWwiAbc+xUa0JyimUyXckFLDagP6IoFDpagB1edIcSB1WUutb7EWC2Ur5Ua4y
X-Gm-Message-State: AOJu0YzAvFWxblzxORfFys27TVgG9wKt8cZkZu8euPGMVJQgpItse40E
	FjS0huR97h/bp25j8Glg9lhnGhwpzotpzxQhX7tWm0a1WsSUXeaYD06LXCnkrsaW081eTKdtkwn
	X1Oco8hG8H7W3T3fEvXM/bSmpBqJlTlePhbRPew==
X-Google-Smtp-Source: AGHT+IE2r6fgOyQvmaDw1cKHhqb06G1oPjJg/8fbYws7sp0FnDpl72YTOZ+KEtI9+4Jt61052etc6ASLIhnIYBi8YF4=
X-Received: by 2002:a17:90a:4887:b0:299:b35e:84a with SMTP id
 b7-20020a17090a488700b00299b35e084amr2352567pjh.13.1708577969479; Wed, 21 Feb
 2024 20:59:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221174333.700197-1-tj@kernel.org> <CAJhGHyCJS7Pb_5dwTQtcZ25yOVzxFULJEYT4o3id_3xdj32EYA@mail.gmail.com>
In-Reply-To: <CAJhGHyCJS7Pb_5dwTQtcZ25yOVzxFULJEYT4o3id_3xdj32EYA@mail.gmail.com>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Thu, 22 Feb 2024 12:59:17 +0800
Message-ID: <CAJhGHyB-i-1S3ToYYKtri0Zz1ERikctGQHSjr=tbkD-WXHJe8g@mail.gmail.com>
Subject: Re: [PATCHSET v2 wq/6.10] workqueue: Implement disable/enable_work()
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, 
	allen.lkml@gmail.com, kernel-team@meta.com, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello

On Thu, Feb 22, 2024 at 11:33=E2=80=AFAM Lai Jiangshan <jiangshanlai@gmail.=
com> wrote:
>
> Hello, Tejun
>
> +cc tglx
>
> On Thu, Feb 22, 2024 at 1:43=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> > 4cb1ef64609f ("workqueue: Implement BH workqueues to eventually replace
> > tasklets") implemented workqueues that execute work items in the BH con=
text
> > with the goal of eventually replacing tasklet.
> >
> > While the existing workqueue API covers the basic queueing and cancelin=
g
> > operations, tasklet also has tasklet_disable*() which blocks the execut=
ion
> > of the tasklet until it's re-enabled with tasklet_enable(). The interfa=
ce if
> > fairly widely used and workqueue currently doesn't have a counterpart.
> >
> > This patchset implements disable/enable_work() and the delayed_work
> > counterparts to address the gap. The ability to block future executions=
 is
> > something which some users asked for in the past, and, while not essent=
ial
> > as the caller can and often has to shutdown the queuer anyway, it's a n=
ice
> > convenience to have. Also, timer grew a similar feature recently with
> > timer_shutdown().
> >
>
> From the last patch:
> > - tasklet_disable_nosync()      -> disable_work()
> > - tasklet_disable[_in_atomic]() -> disable_work_sync()
>
> I think it is a misuse-prone conversion.
>
> A developer familiar with tasklet_disable() might happily use disable_wor=
k()
> and, to her/his surprise, leave the running works unsynced.
>
> And tasklet_disable_nosync() is used at only 3 places while tasklet_disab=
le()
> is used a lot.  I think the shorter name for the most common cases is bet=
ter.
>
> Moreover, IMHO the unsynchronized variants of tasklet/work disabling func=
tions
> never have a strong scenario. I think it should be discouraged.
>
> Although it will be inconsistent with the name of cancel_work[_sync](),
> I still suggest:
> tasklet_disable_nosync() -> disable_work_nosync()
> tasklet_disable() -> disable_work().
>
> Even cancel_work_sync() is used a lot more than cancel_work(), so I
> also suggest rename cancel_work() to cancel_work_nosync() and leave
> cancel_work_sync() unchanged (at least for a while).
>
> [changed topic:]
>
> I feel uncomfortable with tasklet_disable_in_atomic() implicitly
> being implemented in disable_work_sync().
>
> I think it is a revert of the commit ca5f62511895 ("tasklets: Provide
> tasklet_disable_in_atomic()") in which tglx discouraged the usage of
> tasklet_disable_in_atomic() and marked it "error prone".
>
> And even tasklet_disable_in_atomic() is implemented in disable_work_sync(=
),
> I prefer to sleepable-wait than spinning-wait when disable_work_sync() is
> called in a sleepable context for BH work item.
>
> All the above is just my feeling, not reasoning, nor rejection of the pat=
ches.
>

I think it would be better if the tasklet developers were CCed in this patc=
hset.

Intended API conversions, along with their rationale and any possible
changes to semantics, can be included in the cover letter too.

> - tasklet_setup/init()          -> INIT_WORK()
> - tasklet_schedule()            -> queue_work(system_bh_wq, ...)
> - tasklet_hi_schedule()         -> queue_work(system_bh_highpri_wq, ...)
> - tasklet_disable_nosync()      -> disable_work()
> - tasklet_disable[_in_atomic]() -> disable_work_sync()
> - tasklet_enable()              -> enable_work() + queue_work()
> - tasklet_kill()                -> cancel_work_sync()
>
> Note that unlike tasklet_enable(), enable_work() doesn't queue the work i=
tem
> automatically according to whether the work item was queued while disable=
d.
> While the caller can track this separately, unconditionally scheduling th=
e
> work item after enable_work() returns %true should work for most users.
>

unconditionally re-scheduling the work item isn't correct to me which might
queue a work unexpectedly.

tasklet_enable() should be changed to return true if and only if when
the disable count reached 0 and the disabling (action and status)
have prevented a queuing request.

To record whether the disabling prevented a queuing request, an extra bit
in the work->data has to be employed for it.

Thanks
Lai

