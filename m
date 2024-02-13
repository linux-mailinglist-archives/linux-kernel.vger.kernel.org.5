Return-Path: <linux-kernel+bounces-64482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33593853F08
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 169C4B2937A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3760462808;
	Tue, 13 Feb 2024 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQz7qO0k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AD3627F2
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707864397; cv=none; b=fdW7fTnlBSoOKahRdLHhZjjjYYt4xL0+7b4F1YMwYYxZfeLzxRQ5/wkVOGvhnELFbfNnTY4VHVH0kcChwx65O0VxsW9+jIYvq/sR37tcm7nou4GV6YLhCHEH9axcIaOSvBw4RBfDgTmXOXW1zquZaTbyhS02XSiQojnSaSW+hcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707864397; c=relaxed/simple;
	bh=XjqRzsF19RiJZQ94exeXbfezzXzSTHX9xuRbZPegwrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OxtjPXv2lfEqI4F1KNqyYTJyKYewhXRY48aBVtrQBNDhs90lVM+dsyFxFLzc3ZAiu2jKamyazib3Ed1LQ4NOieLCPWtp8BwuLx3z9g6UfbI4BREH/RsstgK+ye5z+uSR4tvcl9SpQ/ph8mE8uQWT3MP2+apbaTk3m5k9XbvVqU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQz7qO0k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9212C43142
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707864396;
	bh=XjqRzsF19RiJZQ94exeXbfezzXzSTHX9xuRbZPegwrw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZQz7qO0keuO3YBKuMiI6KXcCqx9cI7pjeeHkzz5Loe+3FFlUpsnwbf0FeufA6JIu+
	 aadbOvzuTwI35MOLhuxbseNVDV982//3cGoDKPlRFHUQl00zVDksBlkKkuckkrVi70
	 z+F+8f6qrSTaM5YUi2STL5Stpm1FEhK7wDee7vhsziEfXqa616anElLlvn4UXjpu3S
	 WoX6i4zfUPCZ7uRa33VkbpRcJaDLugxR3WMw2HE1CC6Sn3Oje0UylRy9vVThvCD+8G
	 8Zn9QopcaxvIdj0F0lQW+h2/1qJ3L/Wtjo7FGlzOKmF1UW6SuDzNbNbssGdLori5pQ
	 1kFreN6hWxC0Q==
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-363c2edac5aso17508375ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:46:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW7E8CCT24EKxa4WtKlBFUi1p7Pcs52J3HVfB2r//g5gvNUUN91FXumQCD1E9fWT4Dwaws1wjYZlg89m1qiPrliOjktQHqAmVTjfKcz
X-Gm-Message-State: AOJu0YwOVbekoBIMWjnpYuBHWDQtJSVk39iAp7Rk+vIzEMaZR51MPmk1
	YrxkY68aGrtMwQ3JBd+BfycyLGSCdc6/fh/tzDOjwkd9I2KZS/tE/PTZ2DFvY1TPhA9Qm3n6grE
	+j4YZSrPR35B+GmYoj6w5vIkOcqOe0jWpftl8
X-Google-Smtp-Source: AGHT+IFDbwtLxTV96mDLQjJ8ZBY9w+mfkppY90pVw7B1ds6Yr0F4l0ShfF4c2W1GGX2TgYNR2LWQoU0aY0TH7Vb+0NY=
X-Received: by 2002:a92:c945:0:b0:364:21ba:c4d2 with SMTP id
 i5-20020a92c945000000b0036421bac4d2mr1294135ilq.17.1707864395938; Tue, 13 Feb
 2024 14:46:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131-async-free-v2-1-525f03e07184@kernel.org>
 <87sf2ceoks.fsf@yhuang6-desk2.ccr.corp.intel.com> <7f19b4d69ff20efe8260a174c7866b4819532b1f.camel@linux.intel.com>
 <CAF8kJuNvB8gXv3kj2nkN5j2ny0ZjJoVEdkeDDWSuWxySkKE=1g@mail.gmail.com>
 <1fa1da19b0b929efec46bd02a6fc358fef1b9c42.camel@linux.intel.com>
 <CAF8kJuMz+HCHkPUQhum32EPB7E1uVvN-E-TffOS7SSHxJNwNmQ@mail.gmail.com>
 <a869aff64f69bd1e1318653559f4c32e9f0a4c08.camel@linux.intel.com>
 <CAF8kJuNC1D0sy90GoSt6yiA7T0Htsu_-gXsbTkmK5GAdO4udgA@mail.gmail.com> <4f1d0c0369e3b08cb0c8d2271396277df6e1d37e.camel@linux.intel.com>
In-Reply-To: <4f1d0c0369e3b08cb0c8d2271396277df6e1d37e.camel@linux.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 13 Feb 2024 14:46:23 -0800
X-Gmail-Original-Message-ID: <CAF8kJuPMJCzbWGP1oypp4_ubZ0D-bnhVnVeL5CTz4zvyOh93wA@mail.gmail.com>
Message-ID: <CAF8kJuPMJCzbWGP1oypp4_ubZ0D-bnhVnVeL5CTz4zvyOh93wA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: swap: async free swap slot cache entries
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	=?UTF-8?B?V2VpIFh177+8?= <weixugc@google.com>, 
	=?UTF-8?B?WXUgWmhhb++/vA==?= <yuzhao@google.com>, 
	Greg Thelen <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>, 
	=?UTF-8?Q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
	=?UTF-8?B?WW9zcnkgQWhtZWTvv7w=?= <yosryahmed@google.com>, 
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 9:52=E2=80=AFAM Tim Chen <tim.c.chen@linux.intel.com=
> wrote:
> > Yes, it will have the long tail latency due to batch freeing 64 entries=
.
> > My point is not that I don't care about heavy swap behavior.
> > My point is that the app will suffer from the swap strom anyway, it is
> > unavoidable. That will be the dominant factor shadowing the batch free
> > optimization effect.
>
> The original optimization introducing swap_slots target such heavy
> swap use cases when we have fast swap backend to allow higher sustainable
> swap throughput.  We should not ignore it.  And I am afraid your current
> patch as is will hurt that performance.  If you change the direct free
> path to free all entries, that could maintain the throughput and I'll
> be okay with that.

That is great. Thanks for the confirmation. I will send out the V3 soon.
In V3, I changed the direct free path to free all entries. I also add the
/sys/kernel/swap/swap_slot_async_free to enable the async free behavior.

>
> >
> > Or do I miss your point as you want to purpose the swap cache double
> > buffer  so it can perform better under swap storm situations?
> >
>
> I am not actually proposing doubling the buffer as that proposal have
> its own downside.

Ack

Chris

