Return-Path: <linux-kernel+bounces-76122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92CD85F32D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D608D1C21659
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0518B2BB13;
	Thu, 22 Feb 2024 08:41:09 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE1323747;
	Thu, 22 Feb 2024 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708591268; cv=none; b=MhkccryESj4qwEPG7puvTJYXWUX1Otovvb0ZwQUs083sXP6mQAdhHFf8f0uLNBqfCA1ckxH8admXkgT+kAp/IYTRcZbW1N81M7SkoauHTelL2qykk3NwWGsUCnjMb1moFwP4vCAiN6AfrlqPykjdpcCE+IN8lZ3lCH6rcMGupTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708591268; c=relaxed/simple;
	bh=TbRVf8ynVgsHZ+Wp/hCEtdL4LRmFBkpDygR/AhIMEtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lnm34596D4vW7MLWRO+ouKnbFxp8QF1QluWMc19HBcYXh+PPu2/h/89LoHw8oBAJO31k7fI2UgqupAVRT4sni3RvcCqDzX/fkSxVD/O/ewm9al8V5RfNHz4A5slBCa0JTUOPOQtGS3PF5T+ajpn7Z1scr8tRgE3pDgTJebfjhIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.6] (ip5f5af3d6.dynamic.kabel-deutschland.de [95.90.243.214])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0D13E61E5FE04;
	Thu, 22 Feb 2024 09:40:08 +0100 (CET)
Message-ID: <34b04a5f-7ef8-4e00-b1c6-c4e692281499@molgen.mpg.de>
Date: Thu, 22 Feb 2024 09:40:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH md-6.9 00/10] md/raid1: refactor read_balance() and some
 minor fix
Content-Language: en-US
To: Kuai Yu <yukuai1@huaweicloud.com>,
 Paul E Luse <paul.e.luse@linux.intel.com>
Cc: song@kernel.org, neilb@suse.com, shli@fb.com, linux-raid@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
 yangerkun@huawei.com
References: <20240222075806.1816400-1-yukuai1@huaweicloud.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240222075806.1816400-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Kuai, dear Paul,


Thank you for your work. Some nits and request for benchmarks below.


Am 22.02.24 um 08:57 schrieb Yu Kuai:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> The orignial idea is that Paul want to optimize raid1 read

original

> performance([1]), however, we think that the orignial code for

original

> read_balance() is quite complex, and we don't want to add more
> complexity. Hence we decide to refactor read_balance() first, to make
> code cleaner and easier for follow up.
> 
> Before this patchset, read_balance() has many local variables and many
> braches, it want to consider all the scenarios in one iteration. The

branches

> idea of this patch is to devide them into 4 different steps:

divide

> 1) If resync is in progress, find the first usable disk, patch 5;
> Otherwise:
> 2) Loop through all disks and skipping slow disks and disks with bad
> blocks, choose the best disk, patch 10. If no disk is found:
> 3) Look for disks with bad blocks and choose the one with most number of
> sectors, patch 8. If no disk is found:
> 4) Choose first found slow disk with no bad blocks, or slow disk with
> most number of sectors, patch 7.
> 
> Note that step 3) and step 4) are super code path, and performance
> should not be considered.
> 
> And after this patchset, we'll continue to optimize read_balance for
> step 2), specifically how to choose the best rdev to read.

Is there a change in performance with the current patch set? Is radi1 
well enough covered by the test suite?


Kind regards,

Paul


> [1] https://lore.kernel.org/all/20240102125115.129261-1-paul.e.luse@linux.intel.com/
> 
> Yu Kuai (10):
>    md: add a new helper rdev_has_badblock()
>    md: record nonrot rdevs while adding/removing rdevs to conf
>    md/raid1: fix choose next idle in read_balance()
>    md/raid1-10: add a helper raid1_check_read_range()
>    md/raid1-10: factor out a new helper raid1_should_read_first()
>    md/raid1: factor out read_first_rdev() from read_balance()
>    md/raid1: factor out choose_slow_rdev() from read_balance()
>    md/raid1: factor out choose_bb_rdev() from read_balance()
>    md/raid1: factor out the code to manage sequential IO
>    md/raid1: factor out helpers to choose the best rdev from
>      read_balance()
> 
>   drivers/md/md.c       |  28 ++-
>   drivers/md/md.h       |  12 ++
>   drivers/md/raid1-10.c |  69 +++++++
>   drivers/md/raid1.c    | 454 ++++++++++++++++++++++++------------------
>   drivers/md/raid10.c   |  66 ++----
>   drivers/md/raid5.c    |  35 ++--
>   6 files changed, 402 insertions(+), 262 deletions(-)

