Return-Path: <linux-kernel+bounces-93364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD15872E89
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C72281A3F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A63E1BDCD;
	Wed,  6 Mar 2024 06:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhYOG1XZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DEC1B7FB
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 06:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709704907; cv=none; b=Xa7/ssN9PyYj6uKmDR5y9yOjSaFMv0GNMnRLenNeQje7GEF3FPkaDYz8D0gx+AMY7z8z3Ho1uHjseJMGBRXaaLi2yKngeFox7H9T9Hx8OMPoLenTtRqJvOOSdeq6LWOLGGXkC7bRXoJc8oObQNywn0Q0PquZMy6tg6l8642BO20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709704907; c=relaxed/simple;
	bh=N+SgGvSCwByLSnQR1Rh3deKeagcMHHdrJ7YxgUIVkd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OAT2mPsIt0blfvkPO4HmNFmS4WI67l4ICbucmRxs5vnbIL/p5S1YHB9IGEOWEb3OdPcnL1z+G8/CqD40ahJt9uRzTThf5DvHZMtID4eYPmGhzIfimWNJPRFl/I3NihrYDW/lz/krW/syTA5ROwy+wUeJxe9cchlNA9rWgGePoPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhYOG1XZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69601C433C7;
	Wed,  6 Mar 2024 06:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709704906;
	bh=N+SgGvSCwByLSnQR1Rh3deKeagcMHHdrJ7YxgUIVkd4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qhYOG1XZWFyNBL2vtFMaIu2qy+cTMl79RAJ1/+UlpH3XizkL5N6v4SAVKTm+Dps++
	 Jb9eeTBH0aPJFDbRTHeY1qpq2JCCGbBAAna5W7AorR1NfS8/93tWfmjCFvWPpfHBSv
	 fQGdSLingiJ/8ApsiB1sEPxzr3FJlAqsdCxKDbuZJzHfceYLltgKOS34jcB8tXPUoz
	 nf3vTJXyPetEa7Kb7AyrLvgPblL1wgCG6Ij1xoIBpCkW97BGy2H8FTQjv3UJHZ3O8t
	 chzKWBj6zUoLrGWQZj1qpjnZe5yxMSYjbsE5ZOVlDToG+F2Wz/2pMUAy2LbdFuXeGT
	 xOQUark0HeHdQ==
Message-ID: <7cd469b2-ce64-4799-90db-c08df7ab6174@kernel.org>
Date: Wed, 6 Mar 2024 14:01:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] f2fs: compress: fix reserve_cblocks counting error
 when out of space
Content-Language: en-US
To: Xiuhong Wang <xiuhong.wang@unisoc.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: hongyu.jin.cn@gmail.com, niuzhiguo84@gmail.com, ke.wang@unisoc.com,
 xiuhong.wang.cn@gmail.com
References: <20240306034746.3722986-1-xiuhong.wang@unisoc.com>
 <20240306034746.3722986-2-xiuhong.wang@unisoc.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240306034746.3722986-2-xiuhong.wang@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/6 11:47, Xiuhong Wang wrote:
> When a file only needs one direct_node, performing the following
> operations will cause the file to be unrepairable:
> 
> unisoc # ./f2fs_io compress test.apk
> unisoc #df -h | grep dm-48
> /dev/block/dm-48 112G 112G 1.2M 100% /data
> 
> unisoc # ./f2fs_io release_cblocks test.apk
> 924
> unisoc # df -h | grep dm-48
> /dev/block/dm-48 112G 112G 4.8M 100% /data
> 
> unisoc # dd if=/dev/random of=file4 bs=1M count=3
> 3145728 bytes (3.0 M) copied, 0.025 s, 120 M/s
> unisoc # df -h | grep dm-48
> /dev/block/dm-48 112G 112G 1.8M 100% /data
> 
> unisoc # ./f2fs_io reserve_cblocks test.apk
> F2FS_IOC_RESERVE_COMPRESS_BLOCKS failed: No space left on device
> 
> adb reboot
> unisoc # df -h  | grep dm-48
> /dev/block/dm-48             112G 112G   11M 100% /data
> unisoc # ./f2fs_io reserve_cblocks test.apk
> 0
> 
> This is because the file has only one direct_node. After returning
> to -ENOSPC, reserved_blocks += ret will not be executed. As a result,
> the reserved_blocks at this time is still 0, which is not the real
> number of reserved blocks. Therefore, fsck cannot be set to repair
> the file.
> 
> After this patch, the fsck flag will be set to fix this problem.
> 
> unisoc # df -h | grep dm-48
> /dev/block/dm-48             112G 112G  1.8M 100% /data
> unisoc # ./f2fs_io reserve_cblocks test.apk
> F2FS_IOC_RESERVE_COMPRESS_BLOCKS failed: No space left on device
> 
> adb reboot then fsck will be executed
> unisoc # df -h  | grep dm-48
> /dev/block/dm-48             112G 112G   11M 100% /data
> unisoc # ./f2fs_io reserve_cblocks test.apk
> 924
> 
> Fixes: c75488fb4d82 ("f2fs: introduce F2FS_IOC_RESERVE_COMPRESS_BLOCKS")
> Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

