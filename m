Return-Path: <linux-kernel+bounces-152080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 772F58AB887
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 03:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A892823E8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 01:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E83D6FB1;
	Sat, 20 Apr 2024 01:49:52 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475F5A40;
	Sat, 20 Apr 2024 01:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713577791; cv=none; b=GY+7xnWqVDOFdZnYQ+tOfaRq7D8mbyMAH4W7n9cUO+myVzOiUAMVZDzQIVnc0BnVvSQEck7+ddr/hQR4PulsU/cbovt8olERk+joGygtW9CLQ0g9I6A4hCVesx5lptHG8grhT62ahWLIO3/a+7QDkYg6Z12HhIS9GIQaZqw98dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713577791; c=relaxed/simple;
	bh=tXadrWt4we1Qx2fPtTUbKpg39DTpHVxgYlkY7mfv4CE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LADjvPI15BgwXHsAjyH83/P0+GEiNSc5Wdm1/lUnSLfWluCqoc/xzAqqcDXBGQw3tQwJXIxGnK0Os6QbsS4gcrg5hCZr0z8YDLZ2Ybj2+nLhR0ryuGxo9p3l5uoKoheHxTQapdKwNFo7ysxMkmD7nRrb4JG+U5qVZkTYF2XNrS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VLvZp6sFVz4f3kFQ;
	Sat, 20 Apr 2024 09:49:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 475A11A0175;
	Sat, 20 Apr 2024 09:49:46 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxA5HyNmnXrIKQ--.17328S3;
	Sat, 20 Apr 2024 09:49:46 +0800 (CST)
Subject: Re: [PATCH 0/2] block: support to account io_ticks precisely
To: Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com, hch@lst.de,
 bvanassche@acm.org, axboe@kernel.dk, mpatocka@redhat.com, snitzer@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240323035959.1397382-1-yukuai1@huaweicloud.com>
 <513db882-ebe1-7287-99dd-3783c2c9b90f@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <7d044376-0ef9-ffdf-87c6-781259f3d388@huaweicloud.com>
Date: Sat, 20 Apr 2024 09:49:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <513db882-ebe1-7287-99dd-3783c2c9b90f@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxA5HyNmnXrIKQ--.17328S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWDuFyUWFWktr15Xry5Jwb_yoW8JFykpF
	s3Jay3ur4Dur9YgF47ta17Xr10yw4ktw15Jr15tryfAr1jkrWaqr18Wr4vyr909FZ7Gr4k
	Ww1UKF98AF4jk37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWU
	JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUF9a9DUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/04/06 15:57, Yu Kuai 写道:
> Hi, Jens!
> Hi, Ming!
> Hi, Christoph!
> Hi, Bart!
> 
> Friendly ping ...
> 
> The 'util' reported by iostat is very important for users, they don't
> have much choise to get disk status, while 'util' has been inaccurate
> for a long time unnecessarily. I really think patch 1 is meaningful.
> 
> Patch 2 also tries to fix a problem by our customer that util can
> sometimes be huge. The root cause is that 'inflight' is account from
> blk_mq_start_request() while 'io_ticks' is account from
> blk_account_io_start(), there is a gap. I let 'inflight' to be account
> from blk_account_io_start() as well, please let me know if this is not
> good.

Friendly ping ...
> 
> Thanks!
> Kuai
> 
> 在 2024/03/23 11:59, Yu Kuai 写道:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Yu Kuai (2):
>>    block: support to account io_ticks precisely
>>    block: remove blk_mq_in_flight() and blk_mq_in_flight_rw()
>>
>>   block/blk-core.c  |  9 +++++----
>>   block/blk-merge.c |  2 ++
>>   block/blk-mq.c    | 36 ++++--------------------------------
>>   block/blk-mq.h    |  5 -----
>>   block/blk.h       |  1 +
>>   block/genhd.c     | 20 ++++----------------
>>   6 files changed, 16 insertions(+), 57 deletions(-)
>>
> 
> .
> 


