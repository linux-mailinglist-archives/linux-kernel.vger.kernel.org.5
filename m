Return-Path: <linux-kernel+bounces-51480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75542848BBB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3EB9B21845
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097C88C02;
	Sun,  4 Feb 2024 07:00:47 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B8479DE;
	Sun,  4 Feb 2024 07:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707030046; cv=none; b=sjZ6AuQBtOdzAtehGpZSaOP82wIKX3ZYw0JU448zoBbDpYoV9zvDrCi49iMGUF6vZ0eSJf0VuRWqKaHTOCdU0MD0O53yzozuBIKR9QjrZ4lqf+FAJnXQRVOstvgwuDMAnzu32cFWmHLtvuSitdiSn1jIavcAjUa1UELlbM23GnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707030046; c=relaxed/simple;
	bh=IgfnIw9LZ75C5zpZcE/8fxep8Sy5yka52TeorhRVWp8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nKbJDV4li98Z5cyq84nNwxM6idBqFLcf3I8gmwrykcqsROtbwKMLm1/Lsa1Fj2v09rfUYxNA7SxE4FF1Lvohi4f8cHwBqMU+38TmyQtu4Ye/f+4WHqPtgY5Z3lXydSNQxT0Xscn8SYwIpA88nTlZfktZJKgT63JySsIhcEQ/JsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TSL4g0NSzz4f3jMv;
	Sun,  4 Feb 2024 15:00:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6012A1A016E;
	Sun,  4 Feb 2024 15:00:39 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g4TNr9lhWy1Cw--.55446S3;
	Sun, 04 Feb 2024 15:00:37 +0800 (CST)
Subject: Re: [PATCH v5 00/14] dm-raid/md/raid: fix v6.7 regressions
To: Yu Kuai <yukuai1@huaweicloud.com>,
 Benjamin Marzinski <bmarzins@redhat.com>
Cc: mpatocka@redhat.com, heinzm@redhat.com, xni@redhat.com,
 blazej.kucman@linux.intel.com, agk@redhat.com, snitzer@kernel.org,
 dm-devel@lists.linux.dev, song@kernel.org, jbrassow@f14.redhat.com,
 neilb@suse.de, shli@fb.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
 <Zb2wxIpf7uYV6Vya@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
 <528ce926-6f17-c1ea-8e77-c7d5d7f56022@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <00390b5b-44a1-72d1-794d-3e1a7b3ffe05@huaweicloud.com>
Date: Sun, 4 Feb 2024 15:00:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <528ce926-6f17-c1ea-8e77-c7d5d7f56022@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g4TNr9lhWy1Cw--.55446S3
X-Coremail-Antispam: 1UD129KBjvJXoW3uFWkWr13Gr4UCw18XF4xZwb_yoWDAFyfpF
	Z3K3WUtr95Cwn3XrnFyw18XFyUtF15J395Jws5GF48ArWUuwn2qrs3Xr1vgFnxtrZ5W3Wj
	qr4UJry7uF12gFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/02/04 9:35, Yu Kuai 写道:
> Hi,
> 
> 在 2024/02/03 11:19, Benjamin Marzinski 写道:
>> On Thu, Feb 01, 2024 at 05:25:45PM +0800, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>> I apply this patchset on top of v6.8-rc1, and run lvm2 tests suite with
>>> folling cmd for 24 round(for about 2 days):
>>>
>>> for t in `ls test/shell`; do
>>>          if cat test/shell/$t | grep raid &> /dev/null; then
>>>                  make check T=shell/$t
>>>          fi
>>> done
>>>
>>> failed count                             failed test
>>>        1 ###       failed: [ndev-vanilla] shell/dmsecuretest.sh
>>>        1 ###       failed: [ndev-vanilla] 
>>> shell/dmsetup-integrity-keys.sh
>>>        1 ###       failed: [ndev-vanilla] shell/dmsetup-keyring.sh
>>>        5 ###       failed: [ndev-vanilla] shell/duplicate-pvs-md0.sh
>>>        1 ###       failed: [ndev-vanilla] shell/duplicate-vgid.sh
>>>        2 ###       failed: [ndev-vanilla] shell/duplicate-vgnames.sh
>>>        1 ###       failed: [ndev-vanilla] shell/fsadm-crypt.sh
>>>        1 ###       failed: [ndev-vanilla] shell/integrity.sh
>>>        6 ###       failed: [ndev-vanilla] 
>>> shell/lvchange-raid1-writemostly.sh
>>>        2 ###       failed: [ndev-vanilla] shell/lvchange-rebuild-raid.sh
>>>        5 ###       failed: [ndev-vanilla] 
>>> shell/lvconvert-raid-reshape-stripes-load-reload.sh
>>>        4 ###       failed: [ndev-vanilla] 
>>> shell/lvconvert-raid-restripe-linear.sh
>>>        1 ###       failed: [ndev-vanilla] 
>>> shell/lvconvert-raid1-split-trackchanges.sh
>>>       20 ###       failed: [ndev-vanilla] shell/lvconvert-repair-raid.sh
>>>       20 ###       failed: [ndev-vanilla] shell/lvcreate-large-raid.sh
>>>       24 ###       failed: [ndev-vanilla] shell/lvextend-raid.sh
>>>
>>> And I ramdomly pick some tests verified by hand that these test will
>>> fail in v6.6 as well(not all tests):
>>>
>>> shell/lvextend-raid.sh
>>> shell/lvcreate-large-raid.sh
>>> shell/lvconvert-repair-raid.sh
>>> shell/lvchange-rebuild-raid.sh
>>> shell/lvchange-raid1-writemostly.sh
>>
>> In my testing with this patchset on top of the head of linus's tree
>> (5c24e4e9e708) I am seeing failures in
>> shell/lvconvert-raid-reshape-stripes-load-reload.sh and
>> shell/lvconvert-repair-raid.sh in about 20% of my runs. I have never
>> seen either of these these fail running on the 6.6 kernel (ffc253263a13).
> 
> This sounds quite different in my testing, as I said, the test
> 
> shell/lvconvert-repair-raid.sh is very likely to fail in v6.6 already,
> I don't know why it never fail in your testing, test log in v6.6:
> 
> | [ 1:38.162] #lvconvert-repair-raid.sh:1+ aux teardown
> | [ 1:38.162] ## teardown.......## removing stray mapped devices with 
> names beginning with LVMTEST3474:
> | [ 1:39.207] .set +vx; STACKTRACE; set -vx
> | [ 1:41.448] ##lvconvert-repair-raid.sh:1+ set +vx
> | [ 1:41.448] ## - /mnt/test/lvm2/test/shell/lvconvert-repair-raid.sh:1
> | [ 1:41.449] ## 1 STACKTRACE() called from 
> /mnt/test/lvm2/test/shell/lvconvert-repair-raid.sh:1
> | [ 1:41.449] ## ERROR: The test started dmeventd (3718) unexpectedly.
> 
> And the same in v6.8-rc1. Perhaps do you know how to fix this error?
> 
> Thanks,
> Kuai
> 
>>
>> lvconvert-repair-raid.sh creates a raid array and then disables one if
>> its drives before there's enough time to finish the initial sync and
>> tries to repair it. This is supposed to fail (it uses dm-delay devices
>> to slow down the sync). When the test succeeds, I see things like this:
>>
>> [ 0:13.469] #lvconvert-repair-raid.sh:161+ lvcreate --type raid10 -m 1 
>> -i 2 -L 64 -n LV1 LVMTEST191946vg 
>> /tmp/LVMTEST191946.ImUMG6dyqB/dev/mapper/LVMTEST191946pv1 
>> /tmp/LVMTEST191946.ImUMG6dyqB/dev/mapper/LVMTEST191946pv2 
>> /tmp/LVMTEST191946.ImUMG6dyqB/dev/mapper/LVMTEST191946pv3 
>> /tmp/LVMTEST191946.ImUMG6dyqB/dev/mapper/LVMTEST191946pv4
>> [ 0:13.469]   Using default stripesize 64.00 KiB.
>> [ 0:13.483]   Logical volume "LV1" created.
>> [ 0:14.042] 6,8908,1194343108,-;device-mapper: raid: Superblocks 
>> created for new raid set
>> [ 0:14.042] 5,8909,1194348704,-;md/raid10:mdX: not clean -- starting 
>> background reconstruction
>> [ 0:14.042] 6,8910,1194349443,-;md/raid10:mdX: active with 4 out of 4 
>> devices
>> [ 0:14.042] 4,8911,1194459161,-;mdX: bitmap file is out of date, doing 
>> full recovery
>> [ 0:14.042] 6,8912,1194563810,-;md: resync of RAID array mdX
>> [ 0:14.042]   WARNING: This metadata update is NOT backed up.
>> [ 0:14.042] aux disable_dev "$dev4"
>> [ 0:14.058] #lvconvert-repair-raid.sh:163+ aux disable_dev 
>> /tmp/LVMTEST191946.ImUMG6dyqB/dev/mapper/LVMTEST191946pv4
>> [ 0:14.058] Disabling device 
>> /tmp/LVMTEST191946.ImUMG6dyqB/dev/mapper/LVMTEST191946pv4 (253:5)
>> [ 0:14.101] not lvconvert -y --repair $vg/$lv1
>>
>> When it fails, I see:
>>
>> [ 0:13.831] #lvconvert-repair-raid.sh:161+ lvcreate --type raid10 -m 1 
>> -i 2 -L 64 -n LV1 LVMTEST192248vg 
>> /tmp/LVMTEST192248.ATcecgSGfE/dev/mapper/LVMTEST192248pv1 
>> /tmp/LVMTEST192248.ATcecgSGfE/dev/mapper/LVMTEST192248pv2 
>> /tmp/LVMTEST192248.ATcecgSGfE/dev/mapper/LVMTEST192248pv3 
>> /tmp/LVMTEST192248.ATcecgSGfE/dev/mapper/LVMTEST192248pv4
>> [ 0:13.831]   Using default stripesize 64.00 KiB.
>> [ 0:13.847]   Logical volume "LV1" created.
>> [ 0:14.499]   WARNING: This metadata update is NOT backed up.
>> [ 0:14.499] 6,8925,1187444256,-;device-mapper: raid: Superblocks 
>> created for new raid set
>> [ 0:14.499] 5,8926,1187449525,-;md/raid10:mdX: not clean -- starting 
>> background reconstruction
>> [ 0:14.499] 6,8927,1187450148,-;md/raid10:mdX: active with 4 out of 4 
>> devices
>> [ 0:14.499] 6,8928,1187452472,-;md: resync of RAID array mdX
>> [ 0:14.499] 6,8929,1187453016,-;md: mdX: resync done.
>> [ 0:14.499] 4,8930,1187555486,-;mdX: bitmap file is out of date, doing 
>> full recovery
>> [ 0:14.499] aux disable_dev "$dev4"
>> [ 0:14.515] #lvconvert-repair-raid.sh:163+ aux disable_dev 
>> /tmp/LVMTEST192248.AT
>> cecgSGfE/dev/mapper/LVMTEST192248pv4
>> [ 0:14.515] Disabling device 
>> /tmp/LVMTEST192248.ATcecgSGfE/dev/mapper/LVMTEST192
>> 248pv4 (253:5)
>> [ 0:14.554] not lvconvert -y --repair $vg/$lv1
>>
>> To me the important looking difference (and I admit, I'm no RAID 
>> expert), is that in the
>> case where the test passes (where lvconvert fails as expected), I see
>>
>> [ 0:14.042] 4,8911,1194459161,-;mdX: bitmap file is out of date, doing 
>> full recovery
>> [ 0:14.042] 6,8912,1194563810,-;md: resync of RAID array mdX
>>
>> When it fails I see:
>>
>> [ 0:14.499] 6,8928,1187452472,-;md: resync of RAID array mdX
>> [ 0:14.499] 6,8929,1187453016,-;md: mdX: resync done.
>> [ 0:14.499] 4,8930,1187555486,-;mdX: bitmap file is out of date, doing 
>> full recovery
>>
>> Which appears to show a resync that takes no time, presumable because 
>> it happens before
>> the device notices that the bitmaps are wrong and schedules a full 
>> recovery.
>>
>>
>> lvconvert-raid-reshape-stripes-load-reload.sh repeatedly reloads the
>> device table during a raid reshape, and then tests the filesystem for
>> corruption afterwards. With this patchset, the filesystem is
>> occasionally corrupted.  I do not see this with the 6.6 kernel.

I tried this and I see lots of following in dmesg:

[ 1341.409813] dm-raid456: io failed across reshape position while 
reshape can't make progress

Hence this test is reading the array(raid5) while reshape is
interrupted, and this IO error is added in patch 12. I think
it's related however I'm not sure yet if this IO error is the reason
the test failed.

In v6.6, this test is reading across reshape position and user
might read wrong data;

In v6.8-rc1, this test will deadlock while reading across reshape
position;

In v6.8-rc1 with this patchset, reading across reshape position will
get IO error;

Can you take a look if fsck can be ran while reshape is interupted in
the test? If so, can we change the test so that fsck can only be used
while reshape is running(MD_RECOVERY_RUNNING) or after reshape is done?

Thanks,
Kuai

>>
>> -Ben
>>> Xiao Ni also test the last version on a real machine, see [1].
>>>
>>> [1] 
>>> https://lore.kernel.org/all/CALTww29QO5kzmN6Vd+jT=-8W5F52tJjHKSgrfUc1Z1ZAeRKHHA@mail.gmail.com/ 
>>>
>>>
>>> Yu Kuai (14):
>>>    md: don't ignore suspended array in md_check_recovery()
>>>    md: don't ignore read-only array in md_check_recovery()
>>>    md: make sure md_do_sync() will set MD_RECOVERY_DONE
>>>    md: don't register sync_thread for reshape directly
>>>    md: don't suspend the array for interrupted reshape
>>>    md: fix missing release of 'active_io' for flush
>>>    md: export helpers to stop sync_thread
>>>    md: export helper md_is_rdwr()
>>>    dm-raid: really frozen sync_thread during suspend
>>>    md/dm-raid: don't call md_reap_sync_thread() directly
>>>    dm-raid: add a new helper prepare_suspend() in md_personality
>>>    md/raid456: fix a deadlock for dm-raid456 while io concurrent with
>>>      reshape
>>>    dm-raid: fix lockdep waring in "pers->hot_add_disk"
>>>    dm-raid: remove mddev_suspend/resume()
>>>
>>>   drivers/md/dm-raid.c |  78 +++++++++++++++++++--------
>>>   drivers/md/md.c      | 126 +++++++++++++++++++++++++++++--------------
>>>   drivers/md/md.h      |  16 ++++++
>>>   drivers/md/raid10.c  |  16 +-----
>>>   drivers/md/raid5.c   |  61 +++++++++++----------
>>>   5 files changed, 192 insertions(+), 105 deletions(-)
>>>
>>> -- 
>>> 2.39.2
>>>
>>
>> .
>>
> 
> 
> .
> 


