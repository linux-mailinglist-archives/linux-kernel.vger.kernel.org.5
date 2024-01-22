Return-Path: <linux-kernel+bounces-32509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8B1835C7F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5561F27B33
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BB820DF6;
	Mon, 22 Jan 2024 08:24:11 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6137320DE1;
	Mon, 22 Jan 2024 08:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705911851; cv=none; b=Pv0JWAexf7VX9BNIBLIB9TUjRMfdaDEviFL1UT+Gx3zcm6s6ujboqufljAhXYBRHG104ruFJN0ON/g0UKFR1ctobb9KH3OJ7i/xc6w0DU6NpwIt8Yj8u1Z8n2dQJoTz25g5mtDrG86T1I7vIO3Y34Jl2jDNvtxZQCry+CfSr5ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705911851; c=relaxed/simple;
	bh=K5hQWVKenRGzozuAEV67IBXdrdoUFoxHuQ7gXOfXmuo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mSap37JI/NIkmbvEw+aUrUkkKaDY9gLxEmgrnnkFxt8o464DOxLeYKMzfl4GIil/BKEO+voynxDkIwxMboDTa8XTFBEmBhLmufEcsAkiLD58hIGi06+uP7ETALE47DtZ3jIxG3wDyoBDx1LY3w2eDh4yjfWL1JoFrErmZlTzzIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TJNXy1N1Vz4f3jJD;
	Mon, 22 Jan 2024 16:24:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1358A1A027B;
	Mon, 22 Jan 2024 16:24:06 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g4kJq5lFSVwBg--.15908S3;
	Mon, 22 Jan 2024 16:24:05 +0800 (CST)
Subject: Re: [PATCH 0/5] md: fix/prevent dm-raid regressions
To: Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 Mikulas Patocka <mpatocka@redhat.com>
Cc: dm-devel@lists.linux.dev, msnitzer@redhat.com, heinzm@redhat.com,
 linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240120103734.4155446-1-yukuai1@huaweicloud.com>
 <CAPhsuW7trizGqWcBWQ1R1mrxyA6sNTuwXOK-0vxtCHO6fqcTbQ@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <354941c2-17bd-ce04-f8c8-645d7c4de4cc@huaweicloud.com>
Date: Mon, 22 Jan 2024 16:24:03 +0800
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
X-CM-TRANSID:cCh0CgAX5g4kJq5lFSVwBg--.15908S3
X-Coremail-Antispam: 1UD129KBjvJXoWxur4DJF1rAr4xJrW7ArWfGrg_yoWrGF15pF
	ZxGa4avrW8AF4xtrnxJ3W8XFyFyr1fJFZ3Cay3Gry0yrZxGryktFs3Kw1Uuas0kr1S93W2
	vayUJwn5GF18WFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl
	6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
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

I'm attaching my test result here, before I send the next version.

The tested patched add following changes for patch 5:

@@ -9379,6 +9387,15 @@ static void md_start_sync(struct work_struct *ws)
         suspend ? mddev_suspend_and_lock_nointr(mddev) :
                   mddev_lock_nointr(mddev);

+       if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
+               /*
+                * dm-raid calls md_reap_sync_thread() directly to 
unregister
+                * sync_thread, and md/raid should never trigger this.
+                */
+               WARN_ON_ONCE(mddev->gendisk);
+               goto not_running;;
+       }
+
         if (!md_is_rdwr(mddev)) {

Failed tests for v6.6:
###       failed: [ndev-vanilla] shell/duplicate-vgid.sh
###       failed: [ndev-vanilla] shell/fsadm-crypt.sh
###       failed: [ndev-vanilla] shell/lvchange-raid1-writemostly.sh
###       failed: [ndev-vanilla] shell/lvconvert-cache-abort.sh
###       failed: [ndev-vanilla] shell/lvconvert-repair-raid.sh
###       failed: [ndev-vanilla] shell/lvcreate-large-raid.sh
###       failed: [ndev-vanilla] shell/lvextend-raid.sh
###       failed: [ndev-vanilla] shell/select-report.sh

Failed tests for next-20240117(latest linux-next, between v6.7 to v6.8-rc1)
###       failed: [ndev-vanilla] shell/duplicate-vgid.sh
###       failed: [ndev-vanilla] shell/fsadm-crypt.sh
###       failed: [ndev-vanilla] shell/lvchange-raid1-writemostly.sh
###       failed: [ndev-vanilla] shell/lvconvert-repair-raid.sh
###       failed: [ndev-vanilla] shell/lvextend-raid.sh
###       failed: [ndev-vanilla] shell/select-report.sh

Please noted that the test lvconvert-raid-reshape.sh is still possible
to fail due to commit c467e97f079f ("md/raid6: use valid sector values
to determine if an I/O should wait on the reshape").

Thanks,
Kuai

> 1. Test on both Linus' master branch and 6.7.y, and explain which tests
> are failing before the fixes. (From my tests, the two branches don't have
> the same test results). We can put these results in the cover letter and
> include them in a merge commit.
> 2. If possible, add Fixes tag to all patches.
> 3. Add more details in the commit log, so it is clear what is being fixed.
> 4. Add "reported-by" and maybe also "closes" tag.
> 
> For patch 4-5, especially 5, I wonder whether the same issue also
> happens with md. We can probably ship 4-5 now, with the same
> improvements as patch 1-3.
> 
> I will run more tests on my side.
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


