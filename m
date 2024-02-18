Return-Path: <linux-kernel+bounces-70155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361DD85941D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 03:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677BE1C20C75
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 02:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572CD1848;
	Sun, 18 Feb 2024 02:34:17 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F953376;
	Sun, 18 Feb 2024 02:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708223656; cv=none; b=cI0wssEi3g2mxdupSM1m6Ndq/2f+STnV//+lwJfOTmDd0u4RQzyxTp8kLH9dDlMj0WmjRZ+87t22rwsqe/sTH9iflyWjGfNIBDsI2umNVmPqMTv6VIrVtKmFEtQVw318G75po7h+V8UenARmkOpOb9K/Uq1CmetRcqLkCvr9Hbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708223656; c=relaxed/simple;
	bh=Ugvg8t9WYayZSxLRPxos4Dl4AVqyS7pRUpFqPxEHeII=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ESbnFrteVq8sKURPi9hwUuUX/YIOpW9emjNyrVIM9GY6TFQTb88Ei4bq8EzGnrddIo3qawFEILj168vB5jNzybYCG4SWdclaRy7fANp6d6WWEYignPz/X7QhuE0imXd32wqBU5RK3h2I5L1tMTBsqC5wprQy2cOdX6f1JTFCWNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TcqVj5TcGz4f3jsp;
	Sun, 18 Feb 2024 10:34:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9926D1A027B;
	Sun, 18 Feb 2024 10:34:10 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RGgbNFlAXhqEQ--.56890S3;
	Sun, 18 Feb 2024 10:34:10 +0800 (CST)
Subject: Re: [PATCH v5 01/14] md: don't ignore suspended array in
 md_check_recovery()
To: Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: mpatocka@redhat.com, heinzm@redhat.com, blazej.kucman@linux.intel.com,
 agk@redhat.com, snitzer@kernel.org, dm-devel@lists.linux.dev,
 song@kernel.org, jbrassow@f14.redhat.com, neilb@suse.de, shli@fb.com,
 akpm@osdl.org, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
 <20240201092559.910982-2-yukuai1@huaweicloud.com>
 <CALTww2-ZhRBJOD3jXs=xKFaD=iR=dtoC9h2rUQi5Stpi+tJ9Bw@mail.gmail.com>
 <64d27757-9387-09dc-48e8-a9eedd67f075@huaweicloud.com>
 <CALTww28E=k6fXJURG77KwHb7M2OByLrcE8g7GNkQDTtcOV48hQ@mail.gmail.com>
 <d4a2689e-b5cc-f268-9fb2-84c10e5eb0f4@huaweicloud.com>
 <CALTww28bUzmQASme3XOz0CY=o86f1EUU23ENmnf42UVyuGzQ4Q@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c1195efd-dd83-317e-3067-cd4891ae013e@huaweicloud.com>
Date: Sun, 18 Feb 2024 10:34:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALTww28bUzmQASme3XOz0CY=o86f1EUU23ENmnf42UVyuGzQ4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+RGgbNFlAXhqEQ--.56890S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1kJr48uryUJFy7tr48Crg_yoW8Xryfpa
	48ta1rKr4UAr17Aw12va10q34Sya1FgrWUAr97tr18C3s8Za4fAFWSqFW5AFyDGFZ3GanI
	9w4Utwn5uw4UZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
	Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUQvtAUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/02/18 10:27, Xiao Ni 写道:
> On Sun, Feb 18, 2024 at 9:46 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> 在 2024/02/18 9:33, Xiao Ni 写道:
>>> The deadlock problem mentioned in this patch should not be right?
>>
>> No, I think it's right. Looks like you are expecting other problems,
>> like mentioned in patch 6, to be fixed by this patch.
> 
> Hi Kuai
> 
> Could you explain why step1 and step2 from this comment can happen
> simultaneously? From the log, the process should be
> The process is :
> dev_remove->dm_destroy->__dm_destroy->dm_table_postsuspend_targets(raid_postsuspend)
> -> dm_table_destroy(raid_dtr).
> After suspending the array, it calls raid_dtr. So these two functions
> can't happen simultaneously.

You're removing the target directly, however, dm can suspend the disk
directly, you can simplily:

1) dmsetup suspend xxx
2) dmsetup remove xxx

Please also take a look at other patches, why step 1) can't stop sync
thread.

Thanks,
Kuai

> 
> 
>>
>> Noted that this patch just fix one case that MD_RECOVERY_RUNNING can't
>> be cleared, I you are testing this patch alone, please make sure that
>> you still triggered the exactly same case:
>>
>> - MD_RCOVERY_RUNNING can't be cleared while array is suspended.
> 
> I'm not testing this patch. I want to understand the patch well. So I
> need to understand the issue first. I can't understand how this
> deadlock (step1,step2) happens.
> 
> Regards
> Xiao
>>
>> Thanks,
>> Kuai
>>
> 
> .
> 


