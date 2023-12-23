Return-Path: <linux-kernel+bounces-10504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E26881D52A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 17:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D6A1F21F40
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 16:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6415012E59;
	Sat, 23 Dec 2023 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvOUNsUM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A4512E47
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 16:52:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B2BC433AB
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 16:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703350331;
	bh=+K5tE5gSoZn3PYmx70RdeXc/KcbTC2vmPiJ01c+ezxw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TvOUNsUM1LyZy2DwzlsvSO71ZwMwGC48uctGlFAMwWZDvq2/4U8Gewa0o1sLkl+7k
	 1fhl9gc4FYpUu8rd2gh1m0t7j9tFJ4xmQ8MaRxBx6XtJYMuLkaqr2QEAhGTGkYkvUn
	 jhEsjkyt38yGjitZZbkUbaJzsym4ZPVUtf0cJ2Bk2hmvBvBVs7MSSJSHigpo+KEgCl
	 Ijt5HoR1l0IAxk0UplwzEo3hD9VJKN0W6esWhdCCp5tu3BZXbVS/SpG5Jr7gbUWe2G
	 mpClwJ/3X6Ek55zMB8TddDyRLb3iJL1ic1aU/mc+QInBg4LrsIHUov1pTqdZ+DSE5Z
	 6vu76k00Gcqlg==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5945ba54d54so310163eaf.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 08:52:11 -0800 (PST)
X-Gm-Message-State: AOJu0YzlRMihcS2WcwVXD3zQzNYBGOZDrS/biVKutDJoDFKPM+pOzoKO
	2/IqrwmWbgv/iZl8+Ol3jDBWOGZ0KlcCA8+Ax5k10UwdPbOo
X-Google-Smtp-Source: AGHT+IHGr1NXGE+6bcTT77D/W9kyCjBJC80rwyNqmEFBeF0Ds/jR4ANmw/sWgFJ4OcmyXbgAtPn0yp4o2mol5yL6Mig=
X-Received: by 2002:a05:6358:7e56:b0:170:ec2e:4373 with SMTP id
 p22-20020a0563587e5600b00170ec2e4373mr3329466rwm.6.1703350330241; Sat, 23 Dec
 2023 08:52:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221-async-free-v1-1-94b277992cb0@kernel.org>
 <20231222115208.ab4d2aeacdafa4158b14e532@linux-foundation.org>
 <ZYYY1VBKdLHH-Kl3@google.com> <f6bf2c8d-c37a-dab7-8ef8-38a35240edb6@google.com>
In-Reply-To: <f6bf2c8d-c37a-dab7-8ef8-38a35240edb6@google.com>
From: Chris Li <chrisl@kernel.org>
Date: Sat, 23 Dec 2023 08:51:58 -0800
X-Gmail-Original-Message-ID: <CAF8kJuOafpWhKSR96Lsdig_HqtLA79eeHUx9MxBzFGi95XyzuA@mail.gmail.com>
Message-ID: <CAF8kJuOafpWhKSR96Lsdig_HqtLA79eeHUx9MxBzFGi95XyzuA@mail.gmail.com>
Subject: Re: [PATCH] mm: swap: async free swap slot cache entries
To: David Rientjes <rientjes@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Wei Xu <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Greg Thelen <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Barry Song <v-songbaohua@oppo.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Fri, Dec 22, 2023 at 10:11=E2=80=AFPM David Rientjes <rientjes@google.co=
m> wrote:
>
> How do you quantify the impact of the delayed swap_entry_free()?
>
> Since the free and memcg uncharge are now delayed, is there not the
> possibility that we stay under memory pressure for longer?  (Assuming at
> least some users are swapping because of memory pressure.)
>
> I would assume that since the free and uncharge itself is delayed that in
> the pathological case we'd actually be swapping *more* until the async
> worker can run.

Thanks for raising this interesting question.

First of all, the swap_entry_free() does not impact "memory.current".
It reduces "memory.swap.current". Technically it is the swap pressure
not memory pressure that suffers the extra delay.

Secondly, we are talking about delaying up to 64 swap entries for a
few microseconds. Where the swap slot cache itself delays the freeing
of the entries for an arbitrary amount of time. It is not freed until
the cache is full of 64 entries. This delay can be seconds or even
minutes. Adding a few microseconds of  extra delay to existing seconds
delay really makes no difference from the swap pressure point of view.

Chris

