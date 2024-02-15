Return-Path: <linux-kernel+bounces-66213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFEC85588E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 02:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4DE1F28FC9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E36E137E;
	Thu, 15 Feb 2024 01:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsGLiLbz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7701EEC7
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 01:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707959042; cv=none; b=kU4awFzrtEyfOCGIFLArfcidYDtn8MCi+TNn6IvGKhH0sQHqbMMFnyD48HumL+rApc3PhkWIFj93inttX648QFvpJTFqWgS5g+OOfEqQzdbjklO43+Reg6ZdbQMeV+aLXB2+2O0I75Io74/T6Bx8RG7ZmR+ld0gxTdL45+cp5vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707959042; c=relaxed/simple;
	bh=AFIEZrspV5zSanxweZKG4w8pZtq/hNqIYlVJ0DALHqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F2XKYNDmd4gCNjv/SkGis/+QEck8ZxYJHtqi7i6wfMltdzuI5aRzmJyVpLZInC31RmqpYcPaJmMxG/zoc2PsEaCTbf0+sQH6fnslvR/3jQwrDca8jk/cajKkFyRoPGy8QIdx1m0667PDPvs2fTQp8TycHkM+QMluSLMUyAfhr2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsGLiLbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE8BC43330
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 01:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707959041;
	bh=AFIEZrspV5zSanxweZKG4w8pZtq/hNqIYlVJ0DALHqc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IsGLiLbzJ+zhnBeG5NmJHr/PpUHwifpxlBZycv2a2cRHUOoo0rkQ2UTcCXORRKVdP
	 fCrY2Bvhcr53qqSM54Oz4V/WhZEbefWmXxhSm7oct3ILAGi2KAQ9M+7mEfGdSchUO4
	 Qe7s0595qgzhIbrmJkndjGHWoNkQBbE/A6vJUTOFfnHQxND7DxPymHLgSd5Cfqvpui
	 hBDrJ5gxLyVUom1NxmnqQkib6E1b8tArHQbRi1x8udxFA5R8d0B8pbEasP+2SqZ9Rt
	 SyafFj5vTCF8u+OuJBBvLO1WfCEgnUTNIOasrfhw1Vg3aWciikHEF/+SPSdJx3JD3o
	 8hagbhvi9PrYA==
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-363cd34bf13so1198785ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:04:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0XoMPCL1RCPxSw87Qv1sRGjC2GXCproJHtX2nW48uA4jXDW1M7l4wGJnUngDl5Niz9tL9CXci0M7gXqp+g8rUWL+yscMY3McFZ54v
X-Gm-Message-State: AOJu0YyPWbH3T1SC0CovGkXmOZtThZhFtHAycy2iLM614wnDmQuSVAXC
	x3D5cd2VFnJJkWOmX6zSk0JpFXlKq6kcsp89amwa6t3f1lQP2Zzf09xiHNfTXyotvpPNuk6TFHm
	8MuNsPYPUK3o+6GtZDkwUkEL4GhpqD5boiGLD
X-Google-Smtp-Source: AGHT+IGhz74aPmK7rKmScOst/rNBWBrM/czpuZT6ISx4KY0n+9nVENJQgM3AzCqF/bkf4YNEsYZ6Op+Clpvr/RGTdiU=
X-Received: by 2002:a05:6e02:5aa:b0:364:26a6:cca6 with SMTP id
 k10-20020a056e0205aa00b0036426a6cca6mr211380ils.5.1707959041056; Wed, 14 Feb
 2024 17:04:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213-async-free-v3-1-b89c3cc48384@kernel.org>
 <c4ae18fb13ab1c63cdd34da9fe7b1e0f1a91c909.camel@linux.intel.com>
 <CAF8kJuMXjp1A1kdS_x-S_dyst8MLHwjuAEt-SfGERKVYZNmRww@mail.gmail.com> <f495b4844ffd9ad4340051edf8744d9d5584747b.camel@linux.intel.com>
In-Reply-To: <f495b4844ffd9ad4340051edf8744d9d5584747b.camel@linux.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 14 Feb 2024 17:03:48 -0800
X-Gmail-Original-Message-ID: <CAF8kJuM8609V48u6gz3tXiB67LofFghE1xEQU0q8t9o+sSiJdg@mail.gmail.com>
Message-ID: <CAF8kJuM8609V48u6gz3tXiB67LofFghE1xEQU0q8t9o+sSiJdg@mail.gmail.com>
Subject: Re: [PATCH v3] mm: swap: async free swap slot cache entries
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Wei Xu <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Greg Thelen <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, Kairui Song <kasong@tencent.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 2:54=E2=80=AFPM Tim Chen <tim.c.chen@linux.intel.co=
m> wrote:
>
> On Wed, 2024-02-14 at 10:56 -0800, Chris Li wrote:
> > On Tue, Feb 13, 2024 at 4:08=E2=80=AFPM Tim Chen <tim.c.chen@linux.inte=
l.com> wrote:
> > >
> > >
> > > >
> > > >  extern bool swap_slot_cache_enabled;
> > > > +extern uint8_t slot_cache_async_free __read_mostly;
> > >
> > > Why wouldn't you enable the async_free always?
> > > Otherwise the patch looks fine to me.
> >
> > Thanks for the feedback.
> >
> > Just in case someone doesn't care about this optimization and wants to
> > opt out this behavior?
> > Anyway, I am happy to update the patch without the sysfs control file a=
s well.
> >
>
> At least I couldn't see a downside to enable it always in the latest
> patch.  I think adding an extra sysfs is unnecessary.

Thanks, I just sent out V4 to remove the sysfs control file.

Chris

