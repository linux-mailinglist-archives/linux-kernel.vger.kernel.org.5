Return-Path: <linux-kernel+bounces-82512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCE78685A1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0AA286B27
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB4A4C6D;
	Tue, 27 Feb 2024 01:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzaEeX4U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D424A21
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708996422; cv=none; b=SN6S1STm0J7q6x3qJKEF4zJ2ai4EK+4uXhKrRRdk8rOLLebwfRYwhwAw7pMkXbChO7CGoH1n6kYuTbZnzEVteLe3sNAVnTI2qKjI47Pf7aqoORhkocPL2+7wdKKbTRML8B192dZIXGw7+SVbqESOdDJLpKWgMYobVNeYT3TOtmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708996422; c=relaxed/simple;
	bh=5PDnWAX4phBCOwS98U0hZVMe7Y5bjQHTEVxEgZmGQLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suXtjW6u4qJaSawUTiL0aN4cpD51wGlXf5cNzXPzs6M3OtPQE8xxKog/U6blUZrj+rhYHX462Sqg3TUB2uedTfpKSyvn/QENxikjsEwTHiIQEad2n/NH914Fr8KzmakLH4aqgtfzP6xYSNLDduZOAQ7ZWZrMMYAz6gvxTqcspAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzaEeX4U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E9CC433F1;
	Tue, 27 Feb 2024 01:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708996421;
	bh=5PDnWAX4phBCOwS98U0hZVMe7Y5bjQHTEVxEgZmGQLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QzaEeX4U6DGk4Oc2KOe2Mh3QpYN9uWdFBH8WFYrpqPb5zgM0igI+2dq/QOlIdkWDB
	 ncNdyn4+9FrMkJc9RPrROepm83uKiY8OTcWgpfg1Mf1SqwhRrOMj28RJRaZsDv2WMi
	 VpnIseD6XXb5arpLY27XkrpXokarc9PbIu6jNkQ64tA2P32Q8ZbIYm7YJzXeqqmx8Z
	 nYM7SZacYwhNQI7Pp5WObE7TpFXYDYHipWdAJvlQ/vM8u7yuMhc1xKceooJfeDRRyz
	 wJWqZ9TvUxLVyJfBbRyAyOjJCUvp/xv4oMIWj4yyjjipVOQJOGYMTTsqSeUJC6k726
	 PAb1oz+UAQwiA==
Date: Mon, 26 Feb 2024 17:13:40 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: Chao Yu <chao@kernel.org>, Zhiguo Niu <zhiguo.niu@unisoc.com>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
	hongyu.jin@unisoc.com
Subject: Re: [PATCH v2 0/4] f2fs: fix panic issue in small capacity device
Message-ID: <Zd03RHMKBqv1f6GF@google.com>
References: <1707271264-5551-1-git-send-email-zhiguo.niu@unisoc.com>
 <88459a22-a21c-4c3d-8371-31d7d713b536@kernel.org>
 <CAHJ8P3KYY27M3v=9Lu-yD2ufxU1fdG-bg=G92AbpnLUx0zLz3g@mail.gmail.com>
 <f36ef5d0-8922-449e-b19c-de009c89e712@kernel.org>
 <CAHJ8P3KS2YAXm=GND8DknZqvGqTvm38Nv_9z1nEq4cTJjir-sA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHJ8P3KS2YAXm=GND8DknZqvGqTvm38Nv_9z1nEq4cTJjir-sA@mail.gmail.com>

On 02/26, Zhiguo Niu wrote:
> Dear Chao,
> 
> On Fri, Feb 23, 2024 at 10:38 AM Chao Yu <chao@kernel.org> wrote:
> >
> > On 2024/2/23 10:01, Zhiguo Niu wrote:
> > >
> > >
> > > On Thu, Feb 22, 2024 at 8:30 PM Chao Yu <chao@kernel.org <mailto:chao@kernel.org>> wrote:
> > >
> > >     On 2024/2/7 10:01, Zhiguo Niu wrote:
> > >      > A panic issue happened in a reboot test in small capacity device
> > >      > as following:
> > >      > 1.The device size is 64MB, and main area has 24 segments, and
> > >      > CONFIG_F2FS_CHECK_FS is not enabled.
> > >      > 2.There is no any free segments left shown in free_segmap_info,
> > >      > then another write request cause get_new_segment get a out-of-bound
> > >      > segment with segno 24.
> > >      > 3.panic happen in update_sit_entry because access invalid bitmap
> > >      > pointer.
> > >
> > >     Zhiguo,
> > >
> > >     Can you please try below patch to see whether it can fix your problem?
> > >
> > >     https://lore.kernel.org/linux-f2fs-devel/20240222121851.883141-3-chao@kernel.org <https://lore.kernel.org/linux-f2fs-devel/20240222121851.883141-3-chao@kernel.org>
> > >
> > >     Thanks,
> > >
> > >
> > > Dear Chao,
> > > I need to coordinate the testing resources. The previous testing has been stopped because it was fixed with the current patch. In addition, this requires stability testing to reproduce, so it will take a certain amount of time. If there is any situation, I will tell you in time.
> >
> > Zhiguo, thank you!
> 
> We tested this patch  this weekend on the previous version with
> problem, and it can not reproduce panic issues,
> so this patch should fix the original issue.
> thanks！

Hey, do you guys please point out which patches were tested without what?
IOWs, which patches should I remove and keep Chao's patch?

> 
> >
> > BTW, I've tested this patch for a while, and it looks there is no issue w/
> > FAULT_NO_SEGMENT fault injection is on.
> >
> > > btw, Why can’t I see this patch on your branch^^?
> > > https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/log/?h=dev-test <https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/log/?h=dev-test>
> >
> > Too lazy to push patches in time, will do it in this weekend. :P
> >
> > > thanks！
> > >
> > >
> > >      >
> > >      > More detail shown in following patch sets.
> > >      > The three patches are splited here because the modifications are
> > >      > relatively independent and more readable.
> > >      >
> > >      > ---
> > >      > Changes of v2: stop checkpoint when get a out-of-bound segment
> > >      > ---
> > >      >
> > >      > Zhiguo Niu (4):
> > >      >    f2fs: correct counting methods of free_segments in __set_inuse
> > >      >    f2fs: fix panic issue in update_sit_entry
> > >      >    f2fs: enhance judgment conditions of GET_SEGNO
> > >      >    f2fs: stop checkpoint when get a out-of-bounds segment
> > >      >
> > >      >   fs/f2fs/file.c          |  7 ++++++-
> > >      >   fs/f2fs/segment.c       | 21 ++++++++++++++++-----
> > >      >   fs/f2fs/segment.h       |  7 ++++---
> > >      >   include/linux/f2fs_fs.h |  1 +
> > >      >   4 files changed, 27 insertions(+), 9 deletions(-)
> > >      >
> > >

