Return-Path: <linux-kernel+bounces-29752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0A18312F3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B08D1C214DB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543F29476;
	Thu, 18 Jan 2024 07:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yTrpxJnG"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209A19449
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 07:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705561554; cv=none; b=mFBWo6FQ3HOr9dscF2mrI7CkwQcsOaOvIjTb0kpMukz+xZk3kBO3xs2ndmdfpLKmGE2/AQjPxyP6eCPcshQp9XuDRK2hF50mX3MwYoXJojZ8bUeUbNBA6lH19SmfOIVDk9zMPf2JHFwGCDy0Er5/CyCXCgdWODoocgRvT2JsCF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705561554; c=relaxed/simple;
	bh=DPJ0nzLo1zKFRAGy41myENWDTx7/OqY/I6L34JXTi8Q=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=fHQlslkEcjwabWANTUV3Kf+AehDNVG9upOs1otOailMkH+FiFt/Bgla8rcMtwlwm0sTmNILyH037+dHusl2eW0p0Ohk/HRnB7/ow72FS9KW22qJ5HF9d1PRdzY8wSVXw0Wd+bJtb5X8dOzrTIPZHVZQdNG+LTcdo+5i2mB9jVig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yTrpxJnG; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a271a28aeb4so1279922966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 23:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705561551; x=1706166351; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DPJ0nzLo1zKFRAGy41myENWDTx7/OqY/I6L34JXTi8Q=;
        b=yTrpxJnGQ1Ypw07vvMuh3KmyBr87VCCQqRl8gWUcd3eGdNHSN0F9AF2ivoepYlFHnc
         4ZhGGzjEtRa+tW1YiqiXpd7Fx3cdEDJEW6e1i+1F1w37RsYzAXDbZRLthrX9Lsi59Z7p
         N+5Nnmbvkyn+Bswp+N5LMs+8+6sKLacSFo+JUWJSXC3FWo/BjP26fLGkkUlF+spXKJBR
         SG2bpz65QvxjJXYM9ECpyEyaJz2ELPVrKheL2CetaM7YEcOWOd/8wVw7TIK3jjmQw74P
         IZvgssQFujv9bYRo07alcRz/dMov7FzZqcyKRiDrhT85WT1aIwuLQfyPGjEGVQUqF1t9
         kfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705561551; x=1706166351;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DPJ0nzLo1zKFRAGy41myENWDTx7/OqY/I6L34JXTi8Q=;
        b=w96Z0iVXRTJ4/LQtxRVws9BAzTSH7jhq4gMaKn4lIUnZUVVJ1G6vlvtVRmC+bzGjzR
         hPsVTn+aTiNLW4LE3PrdzRve3e3d9HlLGwp0c1TZOYXuRQhQN4j9hAhKMmuby9zbT9YM
         Scin3Lp4Lu7jolKpxMh0q9G8XhuD77MUp05RTG4qYjR+/PqbyRa33AHjnTBESEnBPZF1
         7oVfSOTa25NLWXuTn2T84GQjekFRoS+0m7qscmjuJWmY/NDLTCE219lFfXM6f11YGvwS
         Y09tCH4+TfeQM7xkE5dAniLzMxABIcu3Fb0WgjTrzMNhYokaUNJLhOFxATQY4yQRDvJE
         FyJQ==
X-Gm-Message-State: AOJu0Yy12GrJMpIRTbLevconpVlUq5WeDc1ul9ZPxuaiI0/A6j1Anfmk
	OW3oB5ZBNJ7BTD+RVQnsozhpH2JRkK2+FmtH1ewVlFwiJGubQzSEYD5FNRRrcntSMrJKds6Nai7
	ISt6PTrKVpIcfzYcBXQykFteILuJnPGaSOEKE
X-Google-Smtp-Source: AGHT+IE9/fsEQD7Yub4zY6FfrEq/SpKL5lA8WYU864Nzw+QpeOCHeTy7cI3Pm4K/2H0Vk2RNMWD7c77k/n3TgblEB70=
X-Received: by 2002:a17:906:3498:b0:a2c:c556:bff5 with SMTP id
 g24-20020a170906349800b00a2cc556bff5mr165577ejb.108.1705561551262; Wed, 17
 Jan 2024 23:05:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
 <CAJD7tkbQb5nAQdhHXELQsUWs8KhwnoOZ7C8Eu2o7tCYSKeY9Ug@mail.gmail.com> <CANeU7Q=mphnSfiZRwFhqFTy56d2ifa5Pz-aa1h3O1PXUo_cu=Q@mail.gmail.com>
In-Reply-To: <CANeU7Q=mphnSfiZRwFhqFTy56d2ifa5Pz-aa1h3O1PXUo_cu=Q@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 17 Jan 2024 23:05:15 -0800
Message-ID: <CAJD7tkaTZz9-rtYab+pvf31dprjMLstnHeXk6HZ_0C-8Np=06A@mail.gmail.com>
Subject: Re: [PATCH 0/2] RFC: zswap tree use xarray instead of RB tree
To: Christopher Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, =?UTF-8?B?V2VpIFh177+8?= <weixugc@google.com>, 
	Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>, 
	Chun-Tse Shao <ctshao@google.com>, =?UTF-8?Q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Barry Song <v-songbaohua@oppo.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

The name changes from Chris to Christopher are confusing :D

>
> I think it makes the review easier. The code adding and removing does
> not have much overlap. Combining it to a single patch does not save
> patch size. Having the assert check would be useful for some bisecting
> to narrow down which step causing the problem. I am fine with squash
> it to one patch as well.

I think having two patches is unnecessarily noisy, and we add some
debug code in this patch that we remove in the next patch anyway.
Let's see what others think, but personally I prefer a single patch.

> >
> > >
> > > I expect to merge the zswap rb tree spin lock with the xarray
> > > lock in the follow up changes.
> >
> > Shouldn't this simply be changing uses of tree->lock to use
> > xa_{lock/unlock}? We also need to make sure we don't try to lock the
> > tree when operating on the xarray if the caller is already holding the
> > lock, but this seems to be straightforward enough to be done as part
> > of this patch or this series at least.
> >
> > Am I missing something?
>
> Currently the zswap entry refcount is protected by the zswap tree spin
> lock as well. Can't remove the tree spin lock without changing the
> refcount code. I think the zswap search entry should just return the
> entry with refcount atomic increase, inside the RCU read() or xarray
> lock. The previous zswap code does the find_and_get entry() which is
> closer to what I want.

I think this can be done in an RCU read section surrounding xa_load()
and the refcount increment. Didn't look closely to check how much
complexity this adds to manage refcounts with RCU, but I think there
should be a lot of examples all around the kernel.

IIUC, there are no performance benefits from this conversion until we
remove the tree spinlock, right?

