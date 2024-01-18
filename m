Return-Path: <linux-kernel+bounces-29634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E9983110E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F12D1C2069E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41116FBC;
	Thu, 18 Jan 2024 01:49:59 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7D16104;
	Thu, 18 Jan 2024 01:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705542599; cv=none; b=QNAZcfoh1AVHR6o3DikVn7PrKyMOC2siWd5klFlw/4bfS9vs3CdiL61N8KyFkVug0xqT6cdCDJUkWRpEpKkRlBPAdnDLBL0Vb7ERJ/EblkrR0OdUoY7byCPK1L6NiJyKVzKusIDx6ZJijOj6gNWx6aNP6RtrE9LbZH8UxvKuBSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705542599; c=relaxed/simple;
	bh=/2EcgLIdjLkuVOwnCVBDIsmvCmTGxn7eKXilJfkoMRk=;
	h=Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo; b=Fmvu1EaGu/2joDI7ExlbUcG6MxjfScEEzuUPb38GAJbm7jUFtoyvgYh4VfliOveXDevhmtSFL+sYyDZF9BLbSomnNaiyNkQA+T6snteIS1d61gfVL4q0NmPTC+nq9BdXZfzKh9rFOBkjMyp4LcpOdYxkTCxqxr/P3GBenswfjf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TFlzx67Qcz4f3jHy;
	Thu, 18 Jan 2024 09:49:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 9747F1A0A10;
	Thu, 18 Jan 2024 09:49:53 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP2 (Coremail) with SMTP id Syh0CgDH6w68g6hlTIu5BA--.57019S3;
	Thu, 18 Jan 2024 09:49:52 +0800 (CST)
Message-ID: <19ff9020-043c-ffc1-c09c-3c40814620b2@huaweicloud.com>
Date: Thu, 18 Jan 2024 09:49:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] md: Don't clear MD_CLOSING when the raid is about to stop
To: Yu Kuai <yukuai1@huaweicloud.com>,
 Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>, linan666@huaweicloud.com
Cc: song@kernel.org, zlliu@suse.com, neilb@suse.com, shli@fb.com,
 linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20231211081714.1923567-1-linan666@huaweicloud.com>
 <20231211105620.00001753@linux.intel.com>
 <f0ab24e5-eb0a-d564-19d4-b72ecedff34f@huaweicloud.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <f0ab24e5-eb0a-d564-19d4-b72ecedff34f@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDH6w68g6hlTIu5BA--.57019S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCw1UGr13WF4xJryUtr4fKrg_yoW5Gryfpa
	97JF13tan0k348Gw4jqw1DJFyYqwn3JFWDAry8WF95Aa4vyryjgr4Sg390gr4DWFWfKF4U
	K3W5J3ZrZr4vgw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/



在 2023/12/12 11:21, Yu Kuai 写道:
> Hi,
> 
> 在 2023/12/11 17:56, Mariusz Tkaczyk 写道:
>> On Mon, 11 Dec 2023 16:17:14 +0800
>> linan666@huaweicloud.com wrote:
>>
>>> From: Li Nan <linan122@huawei.com>
>>>
>>> The raid should not be opened anymore when it is about to be stopped.
>>> However, other processes can open it again if the flag MD_CLOSING is
>>> cleared before exiting. From now on, this flag will not be cleared when
>>> the raid will be stopped.
>>>
>>> Fixes: 065e519e71b2 ("md: MD_CLOSING needs to be cleared after called
>>> md_set_readonly or do_md_stop") Signed-off-by: Li Nan 
>>> <linan122@huawei.com>
>>
>> Hello Li Nan,
>> I was there when I needed to fix this:
>> https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git/commit/?h=md-next&id=c8870379a21fbd9ad14ca36204ccfbe9d25def43 
>>
>>
>> For sure, you have to consider applying same solution for array_store 
>> "clear".
>> Minor nit below.
>>
>> Thanks,
>> Mariusz
>>
>>> ---
>>>   drivers/md/md.c | 8 +++-----
>>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>>> index 4e9fe5cbeedc..ebdfc9068a60 100644
>>> --- a/drivers/md/md.c
>>> +++ b/drivers/md/md.c
>>> @@ -6238,7 +6238,6 @@ static void md_clean(struct mddev *mddev)
>>>       mddev->persistent = 0;
>>>       mddev->level = LEVEL_NONE;
>>>       mddev->clevel[0] = 0;
>>> -    mddev->flags = 0;
>>
>> I recommend (safety recommendation):
>>     mddev->flags = MD_CLOSING;
> 
> Taking a look I think both MD_CLOSING and MD_DELETED should not be
> cleared, however, there is no guarantee that MD_CLOSING will be set
> before md_clean, because mdadm can be removed without running. Hence I
> think just set MD_CLOSING is werid.
> 
> I think the proper way is to keep MD_CLOSING and MD_DELETED if they are
> set. However, there is no such api to clear other bits at once. Since
> we're not expecting anyone else to write flags, following maybe
> acceptable:
> 
> mddev->flags &= BIT_ULL_MASK(MD_CLOSING) | BIT_ULL_MASK(MD_DELETED);
> 

MD_DELETED is only set after mddev->active is put to 0. We need to open 
mddev and get it before stropping raid, so the active must not be 0 and
MD_DELETED  will not be set in md_clean.

> Or after making sure other flags cannot race, this patch is ok.
> 
> Thanks,
> Kuai
> 
>>
>> Unless you can prove that other flags cannot race.
>>
>>>       mddev->sb_flags = 0;
>>>       mddev->ro = MD_RDWR;
>>>       mddev->metadata_type[0] = 0;
>>
>> .
>>
> 
> 
> .

-- 
Thanks,
Nan


