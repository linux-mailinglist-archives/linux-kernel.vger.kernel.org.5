Return-Path: <linux-kernel+bounces-133842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F93489A9A0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 09:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2065B21EA9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 07:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F7A2374E;
	Sat,  6 Apr 2024 07:57:34 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280CD22EED;
	Sat,  6 Apr 2024 07:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712390253; cv=none; b=u7eARA/f9fFccO5xSbD2zSBkp1ybjJuBcQjCijX7SuafK798Z3UDjjdaSaXl/NqwFRAIZXEJ8bFOb4mCFas4kdNVWuSGIp7JDPKAX8IRBEUZ23A4fKxpEA3XWUCw+7SBX/L3b9vjrL2GZATOmtgn635rjJQOkeT5Ky92t448IZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712390253; c=relaxed/simple;
	bh=THI3tmLsG+soDseJVPejbNFfCFRp6+BOKn+OLvM+bI0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VooV4MOxsToHq85Be6v07ejtEzuEMOOQqkxoQTCs98HCVFFurCnfkyKvLtSv5xZq3ewISpDTNFcEuyG+gMr/4qDCLuSyVU2/i5STsrLL65JMU1AmdbeFCKw/BoYJlGe7kLOVL7i0bdHBiEHubKeXlsvTXg7dgk2hUAwJg9AHiDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VBSPR0yhdz4f3lCm;
	Sat,  6 Apr 2024 15:57:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 990B11A016E;
	Sat,  6 Apr 2024 15:57:23 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g5bABFmRrnjJA--.19824S3;
	Sat, 06 Apr 2024 15:57:16 +0800 (CST)
Subject: Re: [PATCH 0/2] block: support to account io_ticks precisely
To: Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com, hch@lst.de,
 bvanassche@acm.org, axboe@kernel.dk, mpatocka@redhat.com, snitzer@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240323035959.1397382-1-yukuai1@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <513db882-ebe1-7287-99dd-3783c2c9b90f@huaweicloud.com>
Date: Sat, 6 Apr 2024 15:57:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240323035959.1397382-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g5bABFmRrnjJA--.19824S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZF47JFyUury5Gw45tr47Jwb_yoWkGFc_uF
	yvyFy8Gr4fXa1fuFnFkFyUJrZ7Kw4UJr9xX34DXFW7Jr97XFyUJr4rtr4DX3sxXan8Ww1r
	Aws7Zry7Crn2qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
	04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0D
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi, Jens!
Hi, Ming!
Hi, Christoph!
Hi, Bart!

Friendly ping ...

The 'util' reported by iostat is very important for users, they don't
have much choise to get disk status, while 'util' has been inaccurate
for a long time unnecessarily. I really think patch 1 is meaningful.

Patch 2 also tries to fix a problem by our customer that util can
sometimes be huge. The root cause is that 'inflight' is account from
blk_mq_start_request() while 'io_ticks' is account from
blk_account_io_start(), there is a gap. I let 'inflight' to be account
from blk_account_io_start() as well, please let me know if this is not
good.

Thanks!
Kuai

ÔÚ 2024/03/23 11:59, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Yu Kuai (2):
>    block: support to account io_ticks precisely
>    block: remove blk_mq_in_flight() and blk_mq_in_flight_rw()
> 
>   block/blk-core.c  |  9 +++++----
>   block/blk-merge.c |  2 ++
>   block/blk-mq.c    | 36 ++++--------------------------------
>   block/blk-mq.h    |  5 -----
>   block/blk.h       |  1 +
>   block/genhd.c     | 20 ++++----------------
>   6 files changed, 16 insertions(+), 57 deletions(-)
> 


