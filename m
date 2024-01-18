Return-Path: <linux-kernel+bounces-29742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 626558312C7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1912E1F2295E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 06:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CF4B65C;
	Thu, 18 Jan 2024 06:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tLbJWL+A"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0ECB641
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 06:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705560025; cv=none; b=MqSGOJ6vxeyH2X5FVwlUGl3kUkXEOQF5D3cZzcJBGV06orn9sFedRTmNc1n2+s/OvlyJbdbp9Ef/Z6UBtirks/Lr6pfLlyBifjqqsUK1XJHpuXEDJMwFyap6iEOvm4yYFwOPsxAsTNdc6z6kfinj1bYM/XneVc2/2c9n2aRvuwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705560025; c=relaxed/simple;
	bh=Fo8gKI5wcPqBhTE9n7Z17rjeWkfglngA29Ql06ELL7w=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=aRglJkXTNd7NAhtpuIbxJ+cMONTMuriluSBgyfgv1yP294mQj2QCVnTIQj/pkCO4JFSBAAK2sDy+BHLysiibDEI1e6dZP/JTTlnZCNWwzX/Npu8zx0RkAwtyMszhcv+YnnURc/aK891uNiUwbAlbn46g9w1uWcUd0qcCTHhpYuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tLbJWL+A; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2dda9d67ceso456216366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 22:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705560021; x=1706164821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fo8gKI5wcPqBhTE9n7Z17rjeWkfglngA29Ql06ELL7w=;
        b=tLbJWL+AMJctIj7G5NRCj3pGWCsyJxQ38S/ZxFUEKCtdfp1ij+aibIX6mHe9xpPz7S
         XyrBGpUV4/MfCsPKlqscvazrhfyeohs+Mj+98bB58Y4zN79GNPOhDFdOOnN6DMZLXUiz
         UJIp96WFyDQwBtgeDeWyldbUC/mHbtPD+j2ufr51MWLEu3VEVCv4V0kF3TGM6XYDJmdb
         k3w+I8WaOtlg+a//v66EpKwmvw66fHgMLFYkcO7SJRVBxhaAVnqFAI4LlEFugXeSMMVm
         JEhswNjnJ+c1JzpmlUyFf0zubXK3dyOkdndgV9pHzZYPaFpmQS0zYQeUgwR7UosiSseh
         77IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705560021; x=1706164821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fo8gKI5wcPqBhTE9n7Z17rjeWkfglngA29Ql06ELL7w=;
        b=PeN1kQ1fMgnX2LW/EooNN6ieLaJSfQVrxChXCpe+iaFnBXgo4xrnNT4qAgrsdW5lJD
         5fVQVOIzDh8x50X52KLXWtFwmwiWZ5zX0KqDT16O+JMHK+7xmiHWYgQAvKvwzWsIJ1Z8
         MvRAH+wXlR3hqsdAN2FbYGE6u8UrxknM/mI0IEdt2ZXjlNE5XVaJRAGac4oT9zJFC+Wn
         fUhMj8eV3So7mWbckQxGQjlI8/CEqEA3QsNbLUCePke0mPQAvoABL0vaNU8mZa+tqaff
         8Bei1iGmon7TMYhHPto6uNx7Cl+nFxo9BOOWpF8/24IxpSaud0Pi/1QpbG7X5PzdfUUN
         0MEw==
X-Gm-Message-State: AOJu0YwHeiTA7meh3slw56MAmIAxXTXqnp1H9QfcrwVQJmAY1ytPn1s5
	MiFea78SiPDglwYjMto9+Uq9jevdOwOw0NnkxMBaJcPKkAEhne2+FN8auOi7mTPfcpeoY+/L5XL
	RZzDLFEl+eibSYrKxSh60Oo8u5taDpQtttJbs
X-Google-Smtp-Source: AGHT+IGw5du6D82TNqrknpI8JySufWW6DPtTDJUIBduFgdYHIqWd8umiN+b4qNoeZ9g61oVtNH4GmHa39joy5nNJF38=
X-Received: by 2002:a17:906:5916:b0:a28:f6a1:f0c0 with SMTP id
 h22-20020a170906591600b00a28f6a1f0c0mr173495ejq.103.1705560020964; Wed, 17
 Jan 2024 22:40:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org> <CAJD7tkbQb5nAQdhHXELQsUWs8KhwnoOZ7C8Eu2o7tCYSKeY9Ug@mail.gmail.com>
In-Reply-To: <CAJD7tkbQb5nAQdhHXELQsUWs8KhwnoOZ7C8Eu2o7tCYSKeY9Ug@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 17 Jan 2024 22:39:45 -0800
Message-ID: <CAJD7tkb7GmMARE9ueyOCZz9wBbANhofUOHnen+b28sxE9tDy1A@mail.gmail.com>
Subject: Re: [PATCH 0/2] RFC: zswap tree use xarray instead of RB tree
To: Chris Li <chrisl@kernel.org>
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
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 10:01=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> That's a long CC list for sure :)
>
> On Wed, Jan 17, 2024 at 7:06=E2=80=AFPM Chris Li <chrisl@kernel.org> wrot=
e:
> >
> > The RB tree shows some contribution to the swap fault
> > long tail latency due to two factors:
> > 1) RB tree requires re-balance from time to time.
> > 2) The zswap RB tree has a tree level spin lock protecting
> > the tree access.
> >
> > The swap cache is using xarray. The break down the swap
> > cache access does not have the similar long time as zswap
> > RB tree.
>
> I think the comparison to the swap cache may not be valid as the swap
> cache has many trees per swapfile, while zswap has a single tree.
>
> >
> > Moving the zswap entry to xarray enable read side
> > take read RCU lock only.
>
> Nice.
>
> >
> > The first patch adds the xarray alongside the RB tree.
> > There is some debug check asserting the xarray agrees with
> > the RB tree results.
> >
> > The second patch removes the zwap RB tree.
>
> The breakdown looks like something that would be a development step,
> but for patch submission I think it makes more sense to have a single
> patch replacing the rbtree with an xarray.
>
> >
> > I expect to merge the zswap rb tree spin lock with the xarray
> > lock in the follow up changes.
>
> Shouldn't this simply be changing uses of tree->lock to use
> xa_{lock/unlock}? We also need to make sure we don't try to lock the
> tree when operating on the xarray if the caller is already holding the
> lock, but this seems to be straightforward enough to be done as part
> of this patch or this series at least.
>
> Am I missing something?

Also, I assume we will only see performance improvements after the
tree lock in its current form is removed so that we get loads
protected only by RCU. Can we get some performance numbers to see how
the latency improves with the xarray under contention (unless
Chengming is already planning on testing this for his multi-tree
patches).

