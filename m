Return-Path: <linux-kernel+bounces-70156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85731859421
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 03:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 160D2B2164C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 02:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7C1184F;
	Sun, 18 Feb 2024 02:35:40 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6906937E;
	Sun, 18 Feb 2024 02:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708223740; cv=none; b=vDJ8ZbkBaxpDPlznjfldVmdpqxY4Z8BXJ3Pvj+uu/X78mrhoNdLenRCVZEFaWNmimvdmYcLkJfdQSok327Y8n/K/1tpzbMt8L6nw48dPs5gw3Nri2pkYHcEVdCodfpC+kv3S6aQvGywjPRaTL6fPkji+oPvJ8ol7cFj2QshPV6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708223740; c=relaxed/simple;
	bh=leGPgphqqZKQDrdYTRKl8IRvjfFKKgpBNV7tyP95ofc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DqrbYctuIknY6WU98oxURQQuaqBiyEO+11hiZCQw3bryC23hyr8RTR92hoB/0bCn9peJkKRs72bLc0YEwe1ZWtW8BrrdwONc1d70tLB9WBMUia2v+Ort/VrdNxDFz5o7R59p1CtpdPI/3vG6LU0C5+qMPIkZy+1L+UxBMe1muLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TcqXM6ldsz4f3jpq;
	Sun, 18 Feb 2024 10:35:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0702C1A0232;
	Sun, 18 Feb 2024 10:35:35 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RH1bNFlhJJqEQ--.29270S3;
	Sun, 18 Feb 2024 10:35:34 +0800 (CST)
Subject: Re: [PATCH v5 07/14] md: export helpers to stop sync_thread
To: Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: mpatocka@redhat.com, heinzm@redhat.com, xni@redhat.com,
 blazej.kucman@linux.intel.com, agk@redhat.com, snitzer@kernel.org,
 dm-devel@lists.linux.dev, jbrassow@f14.redhat.com, neilb@suse.de,
 shli@fb.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
 <20240201092559.910982-8-yukuai1@huaweicloud.com>
 <CAPhsuW6+Sc9VSWoyQ=ydEo+PPNV1Z+1VOBJqhZ3GZTY0UrPKig@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <eaf89e12-85d0-972a-9271-e034d29fa1b2@huaweicloud.com>
Date: Sun, 18 Feb 2024 10:35:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6+Sc9VSWoyQ=ydEo+PPNV1Z+1VOBJqhZ3GZTY0UrPKig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RH1bNFlhJJqEQ--.29270S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1fKFWDKF48ZF1rXw45GFg_yoW8Jw17pr
	WxtFZ0yr4YyFZ5Zr42q3ZruayFvw1jgFyDtrW3GF1fJF93KFs7JF1Y9ryUCFykAa4I9F4U
	tay0qFZxZry8WF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWU
	JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUF0eHDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/02/16 6:27, Song Liu 写道:
> On Thu, Feb 1, 2024 at 1:30 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
> [...]
>> +
>>   static void idle_sync_thread(struct mddev *mddev)
>>   {
>>          mutex_lock(&mddev->sync_mutex);
>> -       clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>
>>          if (mddev_lock(mddev)) {
>>                  mutex_unlock(&mddev->sync_mutex);
>>                  return;
>>          }
>>
>> +       clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>          stop_sync_thread(mddev, false, true);
>>          mutex_unlock(&mddev->sync_mutex);
>>   }
>> @@ -4936,13 +4965,13 @@ static void idle_sync_thread(struct mddev *mddev)
>>   static void frozen_sync_thread(struct mddev *mddev)
>>   {
>>          mutex_lock(&mddev->sync_mutex);
>> -       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>
>>          if (mddev_lock(mddev)) {
>>                  mutex_unlock(&mddev->sync_mutex);
>>                  return;
>>          }
>>
>> +       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>>          stop_sync_thread(mddev, false, false);
>>          mutex_unlock(&mddev->sync_mutex);
>>   }
> 
> The two changes above (moving set_bit) don't seem to belong
> to this patch. If they are still needed, please submit a separate
> patch.

Yes, they are not needed in this patchset. I forgot to remove them while
solving conflicts with other patches locally.

Thanks,
Kuai

> 
> Thanks,
> Song
> 
> .
> 


