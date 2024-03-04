Return-Path: <linux-kernel+bounces-89956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8815086F818
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 02:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81875B20B64
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 01:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55C217C8;
	Mon,  4 Mar 2024 01:07:33 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B76399;
	Mon,  4 Mar 2024 01:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709514453; cv=none; b=e8FzTLT2fPN4kc8PCADzz+aVLIBYA6B4YaI37J35g7eTqY3iOuIv/y10B4sxaxPMi4YJroaiUIwcaitUam8wNN8qFEFz/v27aWAZCFFLkOS5hyJShTtJrp4evLzsBCczSNapyW0XXRirTtlTjSiZGYl0D9C6YYwiYZHdxjk/JX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709514453; c=relaxed/simple;
	bh=OeOQ9qXRKo1gUGHgjeGD/3w7HENXksQQj7EJPsDWECg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=sb5DBQ4/y6Ph2PwhrRJ2BTEYHLfG590ggnbUv1B70cjbVSq/AHl7lrswvjgi08ZwMjwRO7s3DEiRhXfLKwIUFfiESGhCEmZH/P08jvkQTm/hnAdT4kUj7H8qURAuE2DwoT44kni+RJ3/cYS4IXNMHunvSDonkEroAtaOOOJ/b1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tp0sY2TF3z4f3lVg;
	Mon,  4 Mar 2024 09:07:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C422E1A0172;
	Mon,  4 Mar 2024 09:07:20 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RG+HuVlfU98Fw--.60504S3;
	Mon, 04 Mar 2024 09:07:12 +0800 (CST)
Subject: Re: [PATCH -next 0/9] dm-raid, md/raid: fix v6.7 regressions part2
To: Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: zkabelac@redhat.com, agk@redhat.com, snitzer@kernel.org,
 mpatocka@redhat.com, dm-devel@lists.linux.dev, song@kernel.org,
 heinzm@redhat.com, neilb@suse.de, jbrassow@redhat.com,
 linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240301095657.662111-1-yukuai1@huaweicloud.com>
 <CALTww2-GV-YBX1ey4juaVHjHz-wNS0xRBqBn=ucDXEb4WNbSOg@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <0091f7d1-2273-16ff-8285-5fa3f7e2e0f7@huaweicloud.com>
Date: Mon, 4 Mar 2024 09:07:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALTww2-GV-YBX1ey4juaVHjHz-wNS0xRBqBn=ucDXEb4WNbSOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RG+HuVlfU98Fw--.60504S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWw48AFWrtF4Dur47CFy5CFg_yoW5XrWfpa
	9xGa1av3yvkF13Xrsxta4jqFyYyw4fG3y5A3sxJw4rAryUXr92yFsrKr15uas8Ar1rZw47
	Kr4Uta45WF1jqFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/03/03 21:16, Xiao Ni 写道:
> Hi all
> 
> There is a error report from lvm regression tests. The case is
> lvconvert-raid-reshape-stripes-load-reload.sh. I saw this error when I
> tried to fix dmraid regression problems too. In my patch set,  after
> reverting ad39c08186f8a0f221337985036ba86731d6aafe (md: Don't register
> sync_thread for reshape directly), this problem doesn't appear.

How often did you see this tes failed? I'm running the tests for over
two days now, for 30+ rounds, and this test never fail in my VM.

Thanks,
Kuai

> 
> I put the log in the attachment.
> 
> On Fri, Mar 1, 2024 at 6:03 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> link to part1: https://lore.kernel.org/all/CAPhsuW7u1UKHCDOBDhD7DzOVtkGemDz_QnJ4DUq_kSN-Q3G66Q@mail.gmail.com/
>>
>> part1 contains fixes for deadlocks for stopping sync_thread
>>
>> This set contains fixes:
>>   - reshape can start unexpected, cause data corruption, patch 1,5,6;
>>   - deadlocks that reshape concurrent with IO, patch 8;
>>   - a lockdep warning, patch 9;
>>
>> I'm runing lvm2 tests with following scripts with a few rounds now,
>>
>> for t in `ls test/shell`; do
>>          if cat test/shell/$t | grep raid &> /dev/null; then
>>                  make check T=shell/$t
>>          fi
>> done
>>
>> There are no deadlock and no fs corrupt now, however, there are still four
>> failed tests:
>>
>> ###       failed: [ndev-vanilla] shell/lvchange-raid1-writemostly.sh
>> ###       failed: [ndev-vanilla] shell/lvconvert-repair-raid.sh
>> ###       failed: [ndev-vanilla] shell/lvcreate-large-raid.sh
>> ###       failed: [ndev-vanilla] shell/lvextend-raid.sh
>>
>> And failed reasons are the same:
>>
>> ## ERROR: The test started dmeventd (147856) unexpectedly
>>
>> I have no clue yet, and it seems other folks doesn't have this issue.
>>
>> Yu Kuai (9):
>>    md: don't clear MD_RECOVERY_FROZEN for new dm-raid until resume
>>    md: export helpers to stop sync_thread
>>    md: export helper md_is_rdwr()
>>    md: add a new helper reshape_interrupted()
>>    dm-raid: really frozen sync_thread during suspend
>>    md/dm-raid: don't call md_reap_sync_thread() directly
>>    dm-raid: add a new helper prepare_suspend() in md_personality
>>    dm-raid456, md/raid456: fix a deadlock for dm-raid456 while io
>>      concurrent with reshape
>>    dm-raid: fix lockdep waring in "pers->hot_add_disk"
>>
>>   drivers/md/dm-raid.c | 93 ++++++++++++++++++++++++++++++++++----------
>>   drivers/md/md.c      | 73 ++++++++++++++++++++++++++--------
>>   drivers/md/md.h      | 38 +++++++++++++++++-
>>   drivers/md/raid5.c   | 32 ++++++++++++++-
>>   4 files changed, 196 insertions(+), 40 deletions(-)
>>
>> --
>> 2.39.2
>>


