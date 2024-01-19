Return-Path: <linux-kernel+bounces-30683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AE18322F8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6185B22AF4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC113C37;
	Fri, 19 Jan 2024 01:27:43 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842E9322A;
	Fri, 19 Jan 2024 01:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705627663; cv=none; b=M+wt7//DanQ/X6bcorKVcObg4cpEuPdHTs8HtH+KUBNcAfPW+RYLEQK5u7Ix2BQN+MwDd5gncfBackCQQFnsrjT6LsT8ttrndmDr3Ac4EIOIXc1SVcLRSnlEGtvd0gsVSbynefq/3Zkq4JjQ8Ru9C3e0Ezeo+rXhBmh7uw/GyFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705627663; c=relaxed/simple;
	bh=T2KrNq+0FoKIbhPTRgYchgT5nfKU6YqP1rVxIQBzJns=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KFOZFLc6r5Jh9/GOfbIBVYMXSPeRWTO1S7nkaAecqgULuCMuWWjAUbRMCF1WijhvN9Mx6tJTPytulAQyynBnO152UFgk9NZA7UdRsg6SSJQWnrAu72mMTWT2X7x4U/L4wmq+tHNJE0t+XiDDjyTnRfMhaXmSgeXIL1vBFvqKjgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TGMRm6mc0z4f3kF5;
	Fri, 19 Jan 2024 09:27:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B52B71A0172;
	Fri, 19 Jan 2024 09:27:36 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBEG0Klly7QUBQ--.22293S3;
	Fri, 19 Jan 2024 09:27:36 +0800 (CST)
Subject: Re: [PATCH] block: Move checking GENHD_FL_NO_PART to
 bdev_add_partition()
To: Jens Axboe <axboe@kernel.dk>, Li Lingfeng <lilingfeng@huaweicloud.com>,
 allison.karlitskaya@redhat.com, hch@infradead.org, yukuai1@huaweicloud.com
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 houtao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240118130401.792757-1-lilingfeng@huaweicloud.com>
 <f6e687cc-debd-4864-901a-fb35be9f2adc@kernel.dk>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <00c59648-bbf3-7ae4-4cea-aeccbb2bfe0c@huaweicloud.com>
Date: Fri, 19 Jan 2024 09:27:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f6e687cc-debd-4864-901a-fb35be9f2adc@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnOBEG0Klly7QUBQ--.22293S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw47trWkZr18Cw13JF4xZwb_yoW3CrX_Zw
	1FkwnrJr4xJa4SgF40krWayryY9ayUW347ZrsrJrsxXrykA34kCFZagwna93yxXFs7Krn8
	CrnxWr4DZa1IvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
	3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/01/18 23:20, Jens Axboe 写道:
> On 1/18/24 6:04 AM, Li Lingfeng wrote:
>> From: Li Lingfeng <lilingfeng3@huawei.com>
>>
>> Commit 1a721de8489f ("block: don't add or resize partition on the disk
>> with GENHD_FL_NO_PART") prevented all operations about partitions on disks
>> with GENHD_FL_NO_PART in blkpg_do_ioctl() since they are meaningless.
>> However, it changed error code in some scenarios. So move checking
>> GENHD_FL_NO_PART to bdev_add_partition() to eliminate impact.
> 
> This looks fine, but it's identical to the one sent out by Yu two days
> ago. Hmm? Who's the proper author?

Lingfeng is my collegue and I told him that he should send a fix for his
formal patch. Sorry for the confusion :)

Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> 
> Adding Yu.
> 


