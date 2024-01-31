Return-Path: <linux-kernel+bounces-45854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 118AB843716
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC996289EC4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81583DB91;
	Wed, 31 Jan 2024 07:06:31 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3D436AF6;
	Wed, 31 Jan 2024 07:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706684791; cv=none; b=UvaQ5vbUzfI4xUEpdRVJJt3D+RrHjVLJVlfGChrFD0WB03+/R+lt0313Qdfr+Xx8cse9/4+WoTRP6bLu5nzf0CsE8gsjOAzULTeO/cYKnHEGqlf1TzSDCvLaE4anplk0egu8lP0y+RNhbxpicz0Tt9iBwMVd1PTA2j5yXJMt1s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706684791; c=relaxed/simple;
	bh=ePrxLsyof1iG0a5hvUPsWfvv7x996zr4hJPGZ3OD2mw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qsG3XzG/adEuoF/DN3A28slbZK9HKndAni/xeieoOjgG5b27iCfSd99iY603DFJ7Xl8gccbF0lZRnZsG/P+4t/WIhUjv5Jrf3SPP6utZtSByVchx1UKlhS1jGokq1HC1dhSLCR6DBo77P3W5XLDELr0jbe9dNo7q0pPckmO53Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TPtP83yKmz4f3kFd;
	Wed, 31 Jan 2024 15:06:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B2CB31A027B;
	Wed, 31 Jan 2024 15:06:24 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBFu8bllDM0ZCg--.16829S3;
	Wed, 31 Jan 2024 15:06:24 +0800 (CST)
Subject: Re: [PATCH v4 00/14] dm-raid: fix v6.7 regressions
To: Yu Kuai <yukuai1@huaweicloud.com>, Xiao Ni <xni@redhat.com>
Cc: mpatocka@redhat.com, heinzm@redhat.com, agk@redhat.com,
 snitzer@kernel.org, dm-devel@lists.linux.dev, song@kernel.org,
 jbrassow@f14.redhat.com, neilb@suse.de, shli@fb.com, akpm@osdl.org,
 linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240130021843.3608859-1-yukuai1@huaweicloud.com>
 <CALTww29QO5kzmN6Vd+jT=-8W5F52tJjHKSgrfUc1Z1ZAeRKHHA@mail.gmail.com>
 <78016a94-737a-af4d-446b-c9fbef967895@huaweicloud.com>
 <CALTww29UKCJcvJB2BvGTbCcpvD4Y-J+Bg1WgE0nOijLNMv=RGg@mail.gmail.com>
 <6f8ca5f8-c958-8769-1433-a19c4067b074@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <08300170-aa41-79d1-09b4-a5c9f006007c@huaweicloud.com>
Date: Wed, 31 Jan 2024 15:06:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6f8ca5f8-c958-8769-1433-a19c4067b074@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBFu8bllDM0ZCg--.16829S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KFy8GFW5uF4DKry3Cr4fuFg_yoW8XF4xpF
	Z3J3W3trWDKa10qwsFq348Xa4Fvr1xuw10vw15Gr4UCrZYqrySqr4Iqr409r1UtrWku3WD
	ua18Jry3Zr1fWw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUQvtAUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/01/31 10:52, Yu Kuai 写道:
> Hi,
> 
> 在 2024/01/31 9:28, Xiao Ni 写道:
>> On Wed, Jan 31, 2024 at 9:25 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>>
>>> Hi, Xiao Ni!
>>>
>>> 在 2024/01/31 8:29, Xiao Ni 写道:
>>>> In my environment, the lvm2 regression test has passed. There are only
>>>> three failed cases which also fail in kernel 6.6.
>>>>
>>>> ###       failed: [ndev-vanilla] shell/lvresize-fs-crypt.sh
>>>> ###       failed: [ndev-vanilla] shell/pvck-dump.sh
>>>> ###       failed: [ndev-vanilla] shell/select-report.sh
>>>> ### 426 tests: 346 passed, 70 skipped, 0 timed out, 7 warned, 3 failed
>>>>     in 89:26.073
>>>
>>> Thanks for the test, this is greate news.
>>>
>>> Kuai
>>>
>>
>> Hi Kuai
>>
>> Have you run mdadm regression tests based on this patch set?

BTW, I just make sure there are no new failed tests, however, there
looks like some tests are broken. For example:

04update-metadata:

++ /root/mdadm/mdadm --quiet -CR --assume-clean -e 0.90 /dev/md0 --level 
linear -n 4 -c 64 /dev/loop0 /dev/loop1 /dev/loop2 /dev/loop3 --auto=yes
++ rv=1
++ case $* in
++ cat /var/tmp/stderr
mdadm: RUN_ARRAY failed: Invalid argument

04r1update:

++ /root/mdadm/mdadm --quiet -A /dev/md0 -U resync /dev/loop0 /dev/loop1
++ rv=1
++ case $* in
++ cat /var/tmp/stderr
mdadm: --update=resync not understood for 1.x metadata

Thanks,
Kuai

> 
> Of course, I'm runing in my VM with loop devices.
> 
> Thanks,
> Kuai
> 
>>
>> Regards
>> Xiao
>>
>> .
>>
> 
> .
> 


