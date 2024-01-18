Return-Path: <linux-kernel+bounces-29750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC658312ED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED269B242E4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632F4B666;
	Thu, 18 Jan 2024 07:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="FQvRgXNV"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF24B645
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 07:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705561372; cv=none; b=oMXcJ6hs6Z5RqD0aItQ8X0hGYfrahada+6WH0l6+NW92o9kbAlCypHYvkv1HfrLZj0VWjMMOHNiTS5qBaHN0zZb23OaO8CtgvJ6Z5+zDj92TKNJ+Lb2sF2TMxvbHXM/lB93AnD0THGmmQrHEMRsI4GAQkeEy/AcnaC8neB9DUrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705561372; c=relaxed/simple;
	bh=pycnk6WaUVoeJgbhdniZV1H9VrizOLFDvu1eykpqBBY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=I364ejWJkUyQ2p7GYir5ifF3YSWs9pbW7sn9ofy4foEVRPfxgnTik+5KbtOO1mqh32XxiWZ4CwNs07eTd8w3j8RedB+Z2XZ+BtyH5ZLb86+4/3GfBf+YnLC2SlvwIcLw/p8ouFLr8Kx1Fs5uR6COuzFH7uuHS84+kHGmW7d2Z2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FQvRgXNV; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a28cc85e6b5so1409736566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 23:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705561369; x=1706166169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nbjh7lj3LaK3dDhh9thIiUGNa0deGp3ufaKLo6GVy8c=;
        b=FQvRgXNVfHOFVE16UeNT0h0FQU6nwNQLurmAe6QLgi2ZeEQrSP+oiVNbgPHitKEfW0
         FMNIjbNgZpG3Vn003sCkszV84mFt1rDIZXsmg2B065Pf4ftLBZra0APu4KMTWhI4S30c
         CNRLZbV7JUAyJjn6djc5YwghI5opN4TZHs+0YVajJQ4CCpxa87M5vTabreQ2YWBe9PTz
         qdDyx3zJKqvArI8STnkMMah/1cXxJibZ/5un70RYCjXbF6hhNfvf3pnXAyJM7J2qLhMd
         AJcpd3IJkthdwVcpAhNkgWuo7skL5rXs6ayZ9ropTBbA6UqzNI2Y+xU5ICVooRbhhd0s
         +j5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705561369; x=1706166169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nbjh7lj3LaK3dDhh9thIiUGNa0deGp3ufaKLo6GVy8c=;
        b=F6ny4aJG6qnwoO74nnqypFdr1qhpIGeUCkRLcDnEQoEYQYjwLQxvJy9l2F2axFPwYs
         Qww4+XO3pv3vv8T5TJNw0eeBVcLw5Mq+P3TOad/CcTMMN1Mxu1zRRnPrlxxacnXnLQqC
         3YESjvjQ6eCjwGAPe2r88bqyKxl8Ny2H6QLO5Dym4ps9l3WzsSHni/eBTZpHaL46R7LU
         HX+Flb5VJjTGN+fHO74E7R4E6tWzw2J8+lGMQenbuc19ivl2nZA1OTKF89w5SV0YiOyf
         i/qUOh9NRU9MfAJ8geCTyNOdme/dJ47NJ2oxkQKFH8VstKYr2zGSjgQZErHeXjEyIzbW
         XsLQ==
X-Gm-Message-State: AOJu0YyegFl8s+OKswqWRikU/T0VY05v/ptA9/1KV/e7z5oFKe091DmG
	i1+zsC2KDRaVg5vSqlZ39hhyz1LGzDKA4DHo4je1uYDwtBKL7BjWGKxx/10Iqh9HYX+8ORM6qjN
	M9QvMpzF9AoRmgvbUpUe7Z9CV0PCAHwxXBiqTbqSOfZUVS6OkRg==
X-Google-Smtp-Source: AGHT+IFXOCrsKZFskYsH/UIu/PL4WgJ1hIa7+Er8K1Ylf7x/E0yJYgJ9ghoUUYiH9SJjC/yJ/eXvEQ1HEE65wc1z/Ec=
X-Received: by 2002:a17:907:7890:b0:a28:fcbd:cabc with SMTP id
 ku16-20020a170907789000b00a28fcbdcabcmr129710ejc.41.1705561369103; Wed, 17
 Jan 2024 23:02:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
 <CAJD7tkbQb5nAQdhHXELQsUWs8KhwnoOZ7C8Eu2o7tCYSKeY9Ug@mail.gmail.com>
 <CAJD7tkb7GmMARE9ueyOCZz9wBbANhofUOHnen+b28sxE9tDy1A@mail.gmail.com> <7f52ad78-e10b-438a-b380-49451bf6f64f@bytedance.com>
In-Reply-To: <7f52ad78-e10b-438a-b380-49451bf6f64f@bytedance.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 17 Jan 2024 23:02:11 -0800
Message-ID: <CAJD7tkaeBTforGTQ8ia_6-1fd5hf-zwkBcd_kW8Bk=zdO+Qnvw@mail.gmail.com>
Subject: Re: [PATCH 0/2] RFC: zswap tree use xarray instead of RB tree
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	=?UTF-8?B?V2VpIFh177+8?= <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Greg Thelen <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>, 
	=?UTF-8?Q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Barry Song <v-songbaohua@oppo.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 10:57=E2=80=AFPM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> Hi Yosry and Chris,
>
> On 2024/1/18 14:39, Yosry Ahmed wrote:
> > On Wed, Jan 17, 2024 at 10:01=E2=80=AFPM Yosry Ahmed <yosryahmed@google=
com> wrote:
> >>
> >> That's a long CC list for sure :)
> >>
> >> On Wed, Jan 17, 2024 at 7:06=E2=80=AFPM Chris Li <chrisl@kernel.org> w=
rote:
> >>>
> >>> The RB tree shows some contribution to the swap fault
> >>> long tail latency due to two factors:
> >>> 1) RB tree requires re-balance from time to time.
> >>> 2) The zswap RB tree has a tree level spin lock protecting
> >>> the tree access.
> >>>
> >>> The swap cache is using xarray. The break down the swap
> >>> cache access does not have the similar long time as zswap
> >>> RB tree.
> >>
> >> I think the comparison to the swap cache may not be valid as the swap
> >> cache has many trees per swapfile, while zswap has a single tree.
> >>
> >>>
> >>> Moving the zswap entry to xarray enable read side
> >>> take read RCU lock only.
> >>
> >> Nice.
> >>
> >>>
> >>> The first patch adds the xarray alongside the RB tree.
> >>> There is some debug check asserting the xarray agrees with
> >>> the RB tree results.
> >>>
> >>> The second patch removes the zwap RB tree.
> >>
> >> The breakdown looks like something that would be a development step,
> >> but for patch submission I think it makes more sense to have a single
> >> patch replacing the rbtree with an xarray.
> >>
> >>>
> >>> I expect to merge the zswap rb tree spin lock with the xarray
> >>> lock in the follow up changes.
> >>
> >> Shouldn't this simply be changing uses of tree->lock to use
> >> xa_{lock/unlock}? We also need to make sure we don't try to lock the
> >> tree when operating on the xarray if the caller is already holding the
> >> lock, but this seems to be straightforward enough to be done as part
> >> of this patch or this series at least.
> >>
> >> Am I missing something?
> >
> > Also, I assume we will only see performance improvements after the
> > tree lock in its current form is removed so that we get loads
> > protected only by RCU. Can we get some performance numbers to see how
> > the latency improves with the xarray under contention (unless
> > Chengming is already planning on testing this for his multi-tree
> > patches).
>
> I just give it a try, the same test of kernel build in tmpfs with zswap
> shrinker enabled, all based on the latest mm/mm-stable branch.
>
>                     mm-stable           zswap-split-tree    zswap-xarray
> real                1m10.442s           1m4.157s            1m9.962s
> user                17m48.232s          17m41.477s          17m45.887s
> sys                 8m13.517s           5m2.226s            7m59.305s
>
> Looks like the contention of concurrency is still there, I haven't
> look into the code yet, will review it later.

I think that's expected with the current version because the tree
spin_lock is still there and we are still doing lookups with a
spinlock.

