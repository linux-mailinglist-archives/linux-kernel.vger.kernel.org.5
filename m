Return-Path: <linux-kernel+bounces-32257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A7F835920
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95AB51C21772
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 01:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B7EEA4;
	Mon, 22 Jan 2024 01:19:26 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA7836B;
	Mon, 22 Jan 2024 01:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705886365; cv=none; b=Y/6f7xX56TWbzHUxqFyqAwweQRlF5HZiPzsYZGtt8QKumE+G0CKSautvFG/+PZ5WRmCOzFP8OJuiv2wDb6XLEOk5HlIbzbGcOuZiNhY50FMW2lfqR7Nz2aEd2E1df8l9/sjZfqyg7LivxCLkTV5hXTfl2JsnTF3r8squEB9/+2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705886365; c=relaxed/simple;
	bh=zVK7nTI8nxKwUnzW9JfiUrl1UGCv4eWxbRSAefPPUn4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Xf0qdkcVFTdUBGXABSVES2wc/EYruA8LjE1kuq08AI3U8SW66uOZHUsujm03F0k+JYHepkzoHWD3M6OKocmAobCqJXwmslvey5dQHUHYyOXRQbSNIRfIJvCYb++TxtiXK0XVQbCUSdVEzL5hD/0gZQdq3HhrPVutjSGKJiPv15E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TJC6f6Vwfz4f3jrq;
	Mon, 22 Jan 2024 09:19:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C10A31A0171;
	Mon, 22 Jan 2024 09:19:10 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxCMwq1l_PdQBg--.64769S3;
	Mon, 22 Jan 2024 09:19:10 +0800 (CST)
Subject: Re: [PATCH 0/5] md: fix/prevent dm-raid regressions
To: Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 Mikulas Patocka <mpatocka@redhat.com>
Cc: dm-devel@lists.linux.dev, msnitzer@redhat.com, heinzm@redhat.com,
 linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240120103734.4155446-1-yukuai1@huaweicloud.com>
 <CAPhsuW7trizGqWcBWQ1R1mrxyA6sNTuwXOK-0vxtCHO6fqcTbQ@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <2e1e8e5d-b1c6-efc9-c783-06ce728cd12e@huaweicloud.com>
Date: Mon, 22 Jan 2024 09:19:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPhsuW7trizGqWcBWQ1R1mrxyA6sNTuwXOK-0vxtCHO6fqcTbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxCMwq1l_PdQBg--.64769S3
X-Coremail-Antispam: 1UD129KBjvJXoWxur4DJF1rAr4xJrW7ArWfGrg_yoW5Xr4xpa
	y3Ja4akr4DJrsFkrn3tFy8XFyFkFWrJrWrGr13Kry8A345Xryj9FWxKw48Wr98Cr9aq3WY
	kF48Gr93Ga4jva7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/01/21 12:41, Song Liu 写道:
> On Sat, Jan 20, 2024 at 2:41 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> There are some problems that we fixed in md/raid, and some apis is changed.
>> However, dm-raid rely the old apis(noted that old apis is problematic in
>> corner cases), and now there are regressions in lvm2 testsuite.
>>
>> This patchset fix some regressions(patch 1-3), and revert changes to
>> prevent regressions(patch 4,5). Noted that the problems in patch 4,5 is
>> not clear yet, and I'm not able to locate the root cause ASAP, hence I
>> decide to revert changes to prevent regressions first.
> 
> Thanks for looking into this!
> 
> Patch 1-3 look good to me. But since we need to back port these fixes
> to 6.7 kernels, let's make it very clear what issues are being fixed.
> Please:
> 1. Test on both Linus' master branch and 6.7.y, and explain which tests
> are failing before the fixes. (From my tests, the two branches don't have
> the same test results). We can put these results in the cover letter and
> include them in a merge commit.
> 2. If possible, add Fixes tag to all patches.
> 3. Add more details in the commit log, so it is clear what is being fixed.
> 4. Add "reported-by" and maybe also "closes" tag.
> 

Will do this is the next version. I verified that the following tests
will pass now in my VM:

shell/integrity-caching.sh
shell/lvconvert-raid-reshape.sh

> For patch 4-5, especially 5, I wonder whether the same issue also
> happens with md. We can probably ship 4-5 now, with the same
> improvements as patch 1-3.

With patch 1-3, the test lvconvert-raid-reshape.sh won't hang anymore,
however it still fails and complain that ext4 is corrupted, and I'm
still trying to understand how reshape works in dm-raid. :(
> 
> I will run more tests on my side.

Notice that the problem Mykulas mentioned in the patch md: partially
revert "md/raid6: use valid sector values to determine if an I/O should
wait on the reshape" still exist. And again, I'm stll trying to
understand how raid5 works in detail.
> 
> Mykulas, please also review and test these patches.
> 
> Thanks,
> Song
> 
> 
> 
>>
>> Yu Kuai (5):
>>    md: don't ignore suspended array in md_check_recovery()
>>    md: don't ignore read-only array in md_check_recovery()
>>    md: make sure md_do_sync() will set MD_RECOVERY_DONE
>>    md: revert commit fa2bbff7b0b4 ("md: synchronize flush io with array
>>      reconfiguration") for dm-raid
>>    md: use md_reap_sync_thread() directly for dm-raid
>>
>>   drivers/md/md.c | 58 ++++++++++++++++++++++++++++++-------------------
>>   1 file changed, 36 insertions(+), 22 deletions(-)
>>
>> --
>> 2.39.2
>>
>>
> .
> 


