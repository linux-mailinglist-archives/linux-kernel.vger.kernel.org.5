Return-Path: <linux-kernel+bounces-48078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8FA8456F1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 511391C209E3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561CF15D5D2;
	Thu,  1 Feb 2024 12:07:53 +0000 (UTC)
Received: from new-mail.astralinux.ru (new-mail.astralinux.ru [51.250.53.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9778915D5AF
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 12:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.53.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789272; cv=none; b=Sg4K04amruNTLyuW/ZsPK66oVZFotcT+969MRRn8Wr6vu3EfFox2hi1f59yVs8SheOH/e61hAOsJ4RWkUESNpb8Is7tbbmIOl0hHXkJE0z1KAjDW9piAgzZFhWx34ytQdzeT5IgF5WckxVE/76JQfhc+lXjqW785a0yAFv2dygQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789272; c=relaxed/simple;
	bh=Xb32RFnnxd0YWCMLvOL0X89QJ5gFB+ifVMyQBccQwes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sv+hC9ZL4ZmRf8I+eCRWZLr7NcfH75B6W5eM7JFXbKXaMQjtiUsbaEV8vlgYwVHkT1N8BzxYbwsj/YCfDGloUT7S6SZ7dn9wg+IX+XJFZb2GMEouZ1xrLPH8XjVaDereBrl9kDoJjEi1V0G+fFNk2oCLHXvErLjEvWzbmpwRW0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=51.250.53.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from [192.168.50.99] (unknown [62.217.188.159])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4TQcvq4z5pzsRjW;
	Thu,  1 Feb 2024 15:01:59 +0300 (MSK)
Message-ID: <b4d8649c-5cda-42da-8b6c-058bd42b3484@astralinux.ru>
Date: Thu, 1 Feb 2024 15:01:20 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: RuPost Desktop
Subject: Re: [PATCH] qnx4: add upcasting to avoid overflow
Content-Language: ru
To: Anders Larsen <al@alarsen.net>
Cc: linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20231123100627.20739-1-abelova@astralinux.ru>
From: =?UTF-8?B?0JDQvdCw0YHRgtCw0YHQuNGPINCb0Y7QsdC40LzQvtCy0LA=?=
 <abelova@astralinux.ru>
In-Reply-To: <20231123100627.20739-1-abelova@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: -100
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttderjeenucfhrhhomheptehhrggtthgrtgippicupiipieipmhhouegruceorggsvghlohhvrgesrghsthhrrghlihhnuhigrdhruheqnecuggftrfgrthhtvghrnhepueegueduvddtffetieekgfeggfeitddvjeduieevfefhkeeggfdvvdeluedtveeinecuffhomhgrihhnpehlihhnuhigthgvshhtihhnghdrohhrghenucfkphepiedvrddvudejrddukeekrdduheelnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedrhedtrdellegnpdhinhgvthepiedvrddvudejrddukeekrdduheelmeehkedvuddpmhgrihhlfhhrohhmpegrsggvlhhovhgrsegrshhtrhgrlhhinhhugidrrhhupdhnsggprhgtphhtthhopeefpdhrtghpthhtoheprghlsegrlhgrrhhsvghnrdhnvghtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhvtgdqphhrohhjvggttheslhhinhhugihtvghsthhinhhgrdhorhhg
X-DrWeb-SpamVersion: Vade Retro 01.423.251#02 AS+AV+AP Profile: DRWEB; Bailout: 300
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.61.08090, Virus records: 12290912, Updated: 2024-Feb-01 10:21:37 UTC]

Just a friendly reminder.

23/11/23 13:06, Anastasia Belova пишет:
> To avoid possible integer overflow in qnx4_statfs
> cast literal to unsigned long. Otherwise multiplication
> of two u32 may give a value that is outside of the range.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>   fs/qnx4/inode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
> index 6eb9bb369b57..4be8dba60567 100644
> --- a/fs/qnx4/inode.c
> +++ b/fs/qnx4/inode.c
> @@ -133,7 +133,7 @@ static int qnx4_statfs(struct dentry *dentry, struct kstatfs *buf)
>   
>   	buf->f_type    = sb->s_magic;
>   	buf->f_bsize   = sb->s_blocksize;
> -	buf->f_blocks  = le32_to_cpu(qnx4_sb(sb)->BitMap->di_size) * 8;
> +	buf->f_blocks  = le32_to_cpu(qnx4_sb(sb)->BitMap->di_size) * 8ul;
>   	buf->f_bfree   = qnx4_count_free_blocks(sb);
>   	buf->f_bavail  = buf->f_bfree;
>   	buf->f_namelen = QNX4_NAME_MAX;



