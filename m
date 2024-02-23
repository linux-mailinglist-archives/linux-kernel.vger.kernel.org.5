Return-Path: <linux-kernel+bounces-77682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF89F8608E6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAE811C21982
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A909BA5F;
	Fri, 23 Feb 2024 02:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CB3OS1l5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06851FA4
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 02:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708655921; cv=none; b=RXUSjtfnYz4GpZXlQ+C6AApEymuuXj+NeqrjC1exK/ToF4FvwZnVD4ryT7i1PXI775HeCz8CDGXDOZS4pW0pxkdQaYdlPiISNzTZb2bUhO03nmi/QguEfGVhIcZgxY4iMWF3Hqu54lScieuakT4jxveJ0RdrGaOSkWOTRcWnIbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708655921; c=relaxed/simple;
	bh=u4CAj8sqPpsO1plOvaGWAsNP8nAL9KNoDdlV99PxpRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sj0n/qH/VjZ4bii50B82SDC2ihyl5AN+WTup20xN8n3nSwtt+x436r4NOQswRVAO5OOq5EegfqgySTGL5dDtMs2LFXSj0mP0P8kVqgRrIdgGJZrUKlvSGbs0mLpoy7fSNqaSnFuL9SU3NjjQNU7M9pwhUclPzKWe00cv7Ha3iFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CB3OS1l5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B60C433F1;
	Fri, 23 Feb 2024 02:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708655921;
	bh=u4CAj8sqPpsO1plOvaGWAsNP8nAL9KNoDdlV99PxpRk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CB3OS1l5TfQmtklsN35xYI83P6r24Ec8ZrO1IHQ2xyfzlH5BYLoMd9yeXUwOK42Q9
	 y7iXT9xHM/84XrAhKauLE04M362XjtnY9v6E1OU2QReHVPLHrhVsviSDAOXUD24pB3
	 YRXwcdm3IE7ITmFjLub3N6mTPCue6I40cisN+bFI2jUeeFvMmMWUvcLFuQ+udSJWQo
	 3Gl5b5nYdRQnUXOnnpkuHYrzqbougwQx8KB/gH80v9MNNqmXp4w9ZsHSlOEM8p8gMO
	 JNrjWIT+YI+OKRAIRUXgmJ+eT226EfjPwSjHAsRwf/mouF77shN57XIXgy+YAJp+uW
	 H9r6X6jqn/ZVA==
Message-ID: <f36ef5d0-8922-449e-b19c-de009c89e712@kernel.org>
Date: Fri, 23 Feb 2024 10:38:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] f2fs: fix panic issue in small capacity device
Content-Language: en-US
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 ke.wang@unisoc.com, hongyu.jin@unisoc.com
References: <1707271264-5551-1-git-send-email-zhiguo.niu@unisoc.com>
 <88459a22-a21c-4c3d-8371-31d7d713b536@kernel.org>
 <CAHJ8P3KYY27M3v=9Lu-yD2ufxU1fdG-bg=G92AbpnLUx0zLz3g@mail.gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3KYY27M3v=9Lu-yD2ufxU1fdG-bg=G92AbpnLUx0zLz3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/2/23 10:01, Zhiguo Niu wrote:
> 
> 
> On Thu, Feb 22, 2024 at 8:30 PM Chao Yu <chao@kernel.org <mailto:chao@kernel.org>> wrote:
> 
>     On 2024/2/7 10:01, Zhiguo Niu wrote:
>      > A panic issue happened in a reboot test in small capacity device
>      > as following:
>      > 1.The device size is 64MB, and main area has 24 segments, and
>      > CONFIG_F2FS_CHECK_FS is not enabled.
>      > 2.There is no any free segments left shown in free_segmap_info,
>      > then another write request cause get_new_segment get a out-of-bound
>      > segment with segno 24.
>      > 3.panic happen in update_sit_entry because access invalid bitmap
>      > pointer.
> 
>     Zhiguo,
> 
>     Can you please try below patch to see whether it can fix your problem?
> 
>     https://lore.kernel.org/linux-f2fs-devel/20240222121851.883141-3-chao@kernel.org <https://lore.kernel.org/linux-f2fs-devel/20240222121851.883141-3-chao@kernel.org>
> 
>     Thanks,
> 
> 
> Dear Chao,
> I need to coordinate the testing resources. The previous testing has been stopped because it was fixed with the current patch. In addition, this requires stability testing to reproduce, so it will take a certain amount of time. If there is any situation, I will tell you in time.

Zhiguo, thank you!

BTW, I've tested this patch for a while, and it looks there is no issue w/
FAULT_NO_SEGMENT fault injection is on.

> btw, Why can’t I see this patch on your branch^^?
> https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/log/?h=dev-test <https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/log/?h=dev-test>

Too lazy to push patches in time, will do it in this weekend. :P

> thanks！
> 
> 
>      >
>      > More detail shown in following patch sets.
>      > The three patches are splited here because the modifications are
>      > relatively independent and more readable.
>      >
>      > ---
>      > Changes of v2: stop checkpoint when get a out-of-bound segment
>      > ---
>      >
>      > Zhiguo Niu (4):
>      >    f2fs: correct counting methods of free_segments in __set_inuse
>      >    f2fs: fix panic issue in update_sit_entry
>      >    f2fs: enhance judgment conditions of GET_SEGNO
>      >    f2fs: stop checkpoint when get a out-of-bounds segment
>      >
>      >   fs/f2fs/file.c          |  7 ++++++-
>      >   fs/f2fs/segment.c       | 21 ++++++++++++++++-----
>      >   fs/f2fs/segment.h       |  7 ++++---
>      >   include/linux/f2fs_fs.h |  1 +
>      >   4 files changed, 27 insertions(+), 9 deletions(-)
>      >
> 

