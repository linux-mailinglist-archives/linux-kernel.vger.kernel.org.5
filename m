Return-Path: <linux-kernel+bounces-57644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FA884DBC0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF185287000
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9236A8B5;
	Thu,  8 Feb 2024 08:44:44 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7F86A354;
	Thu,  8 Feb 2024 08:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381884; cv=none; b=c5VqnMJUfkwmgsQgOAs6ucDy33xakW/t72suetOgPijmPpcXhI8KlRHQkQFE4C+dO1c2Tn/EKhYHuoHzVl8cjFTUXf9v8AKlGg4+ZW1k8J/fAZmdfRD8NOW8tJuB+4H22YJkWqHcJdzmdw7NiRKJRtiJT4WsR08IKXM8/ZAd/1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381884; c=relaxed/simple;
	bh=EhlFipOy96RVlNZ4H7qLDNCbp4auRS9QP+coSjkWbHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Svy9AddDFV1M6Hg/x22urpiG+luTdKUtG4IkXSaoP2sCkBs7UY9+qiyxDV4B/UP2a2BDa0PXQH3x0LKWXeH4HM0HCU7q6F+LXUV3wa75mu05mCPj+4/MvAsT0HEkh7GypneH+h4pArSMOpuM335g1OXb0aonPRr9KGWRElawpXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TVrBm37HPz4f3jcs;
	Thu,  8 Feb 2024 16:44:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E70251A0392;
	Thu,  8 Feb 2024 16:44:36 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP2 (Coremail) with SMTP id Syh0CgBHaw5vlMRlv+eUDQ--.36837S3;
	Thu, 08 Feb 2024 16:44:35 +0800 (CST)
Message-ID: <6849835d-a3ac-e840-09e9-8539e7953fe4@huaweicloud.com>
Date: Thu, 8 Feb 2024 16:44:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] block: fix deadlock between bd_link_disk_holder and
 partition scan
To: Song Liu <song@kernel.org>, linan666@huaweicloud.com
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
 houtao1@huawei.com, yangerkun@huawei.com
References: <20240207092756.2087888-1-linan666@huaweicloud.com>
 <CAPhsuW74hLiW_KTv3xohwMAcPZ9gp2TvLST4tY7H3O8cA26TTg@mail.gmail.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <CAPhsuW74hLiW_KTv3xohwMAcPZ9gp2TvLST4tY7H3O8cA26TTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHaw5vlMRlv+eUDQ--.36837S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAFyfurykKF17tF47Zr1kKrg_yoW5Zw13pF
	W7t3ZxKw47JFs8W3yDta4xZF1rKa1kK3y7tFy3G34ay3ZF9rnY9F1ag3y5uFyqkF4xAF9F
	qF1UXa47Ww1IyrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
	M4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/



在 2024/2/8 14:50, Song Liu 写道:
> On Wed, Feb 7, 2024 at 1:32 AM <linan666@huaweicloud.com> wrote:
>>
>> From: Li Nan <linan122@huawei.com>
>>
>> 'open_mutex' of gendisk is used to protect open/close block devices. But
>> in bd_link_disk_holder(), it is used to protect the creation of symlink
>> between holding disk and slave bdev, which introduces some issues.
>>
>> When bd_link_disk_holder() is called, the driver is usually in the process
>> of initialization/modification and may suspend submitting io. At this
>> time, any io hold 'open_mutex', such as scanning partitions, can cause
>> deadlocks. For example, in raid:
>>
>> T1                              T2
>> bdev_open_by_dev
>>   lock open_mutex [1]
>>   ...
>>    efi_partition
>>    ...
>>     md_submit_bio
>>                                  md_ioctl mddev_syspend
>>                                    -> suspend all io
>>                                   md_add_new_disk
>>                                    bind_rdev_to_array
>>                                     bd_link_disk_holder
>>                                      try lock open_mutex [2]
>>      md_handle_request
>>       -> wait mddev_resume
>>
>> T1 scan partition, T2 add a new device to raid. T1 waits for T2 to resume
>> mddev, but T2 waits for open_mutex held by T1. Deadlock occurs.
>>
>> Fix it by introducing a local mutex 'holder_mutex' to replace 'open_mutex'.
> 
> Is this to fix [1]? Do we need some Fixes and/or Closes tags?
> 

No. Just use another way to fix [2], and both [2] and this patch can fix
the issue. I am not sure about the root cause of [1] yet.

[2] https://patchwork.kernel.org/project/linux-raid/list/?series=812045

> Could you please add steps to reproduce this issue?

We need to modify the kernel, add sleep in md_submit_bio() and md_ioctl()
as below, and then:
   1. mdadm -CR /dev/md0 -l1 -n2 /dev/sd[bc]  #create a raid
   2. echo 1 > /sys/module/md_mod/parameters/error_inject  #enable sleep
   3. 'mdadm --add /dev/md0 /dev/sda'  #add a disk to raid
   4. submit ioctl BLKRRPART to raid within 10s.


Changes of kernel:
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 350f5b22ba6f..ce16d319edf2 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -76,6 +76,8 @@ static DEFINE_SPINLOCK(pers_lock);

  static const struct kobj_type md_ktype;

+static bool error_inject = false;
+
  struct md_cluster_operations *md_cluster_ops;
  EXPORT_SYMBOL(md_cluster_ops);
  static struct module *md_cluster_mod;
@@ -372,6 +374,8 @@ static bool is_suspended(struct mddev *mddev, struct 
bio *bio)

  void md_handle_request(struct mddev *mddev, struct bio *bio)
  {
+       if (error_inject)
+               ssleep(10);
  check_suspended:
         if (is_suspended(mddev, bio)) {
                 DEFINE_WAIT(__wait);
@@ -7752,6 +7756,8 @@ static int md_ioctl(struct block_device *bdev, 
blk_mode_t mode,
                  */
                 if (mddev->pers) {
                         mdu_disk_info_t info;
+                       if (error_inject)
+                               ssleep(10);
                         if (copy_from_user(&info, argp, sizeof(info)))
                                 err = -EFAULT;
                         else if (!(info.state & (1<<MD_DISK_SYNC)))
@@ -10120,6 +10126,7 @@ module_param_call(start_ro, set_ro, get_ro, NULL, 
S_IRUSR|S_IWUSR);
  module_param(start_dirty_degraded, int, S_IRUGO|S_IWUSR);
  module_param_call(new_array, add_named_array, NULL, NULL, S_IWUSR);
  module_param(create_on_open, bool, S_IRUSR|S_IWUSR);
+module_param(error_inject, bool, S_IRUSR|S_IWUSR);

  MODULE_LICENSE("GPL");
  MODULE_DESCRIPTION("MD RAID framework");


-- 
Thanks,
Nan


