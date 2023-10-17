Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D657CC1B1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343523AbjJQLVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbjJQLVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:21:12 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B64CA2;
        Tue, 17 Oct 2023 04:21:08 -0700 (PDT)
Received: from dggpemm500011.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4S8rzJ0CpBzMlDw;
        Tue, 17 Oct 2023 19:17:00 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 dggpemm500011.china.huawei.com (7.185.36.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 17 Oct 2023 19:21:04 +0800
Message-ID: <4d67d297-62bd-f791-8b99-38059777010c@huawei.com>
Date:   Tue, 17 Oct 2023 19:21:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH] block: fix ioctl return error with GENHD_FL_NO_PART
To:     "Wang, Li" <li.wang@windriver.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231017080900.842241-1-li.wang@windriver.com>
 <907c4906-3595-aa6d-8cba-5daa7133b17f@huawei.com>
 <3039396d-1dea-8b77-453a-7beebf5c6348@windriver.com>
From:   Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <3039396d-1dea-8b77-453a-7beebf5c6348@windriver.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.155]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500011.china.huawei.com (7.185.36.110)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"-ENXIO" return by bdev_del_partition() may indicate that the disk being 
operated now do not has the specific partition, and it's different from 
blkpg_do_ioctl().

Thanks.

在 2023/10/17 17:26, Wang, Li 写道:
> refer to previous codes without GENHD_FL_NO_PART, bdev_del_partition() 
> return -ENXIO:
>
> Thanks.
>
> vim block/ioctl.c +35
>
> static int blkpg_do_ioctl(struct block_device *bdev,
>                           struct blkpg_partition __user *upart, int op)
> {
> ...
>         if (disk->flags & GENHD_FL_NO_PART)
>                 return -EINVAL;
> ...
>         if (op == BLKPG_DEL_PARTITION)
>                 return bdev_del_partition(disk, p.pno);
>
> block/partitions/core.c:479
>
> int bdev_del_partition(struct gendisk *disk, int partno)
> {
>         struct block_device *part = NULL;
>         int ret = -ENXIO;
>
>         mutex_lock(&disk->open_mutex);
>         part = xa_load(&disk->part_tbl, partno);
>         if (!part)
>                 goto out_unlock;
>
>         ret = -EBUSY;
>         if (part->bd_openers)
>                 goto out_unlock;
>
>         delete_partition(part);
>         ret = 0;
> out_unlock:
>         mutex_unlock(&disk->open_mutex);
>         return ret;
> }
>
> On 10/17/2023 16:58, Li Lingfeng wrote:
>> I don't think so.
>>
>> GENHD_FL_NO_PART means "partition support is disabled". If users try 
>> to add or resize partition on the disk with this flag, kernel should 
>> remind them that the parameter of device is wrong.
>> So I think it's appropriate to return -EINVAL.
>>
>> Thanks.
>>
>> 在 2023/10/17 16:09, Li Wang 写道:
>>> GENHD_FL_NO_PART means no device(-ENXIO), not parameter error(-EINVAL).
>>>
>>> test case with parted command:
>>> @dd if=/dev/zero of=./blk-file bs=1M count=200
>>> @losetup /dev/loop0 ./blk-file
>>> @parted -s /dev/loop0 mklabel MSDOS
>>> Error: Partition(s) 1, ..., 64 on /dev/loop0 have been written,
>>> but we have been unable to inform the kernel of the change,
>>> probably because it/they are in use. As a result,
>>> the old partition(s) will remain in use. You should reboot now
>>> before making further changes.
>>> @echo $?
>>> 1
>>>
>>> Fixes: 1a721de8489f ("block: don't add or resize partition on the 
>>> disk with GENHD_FL_NO_PART")
>>> Signed-off-by: Li Wang <li.wang@windriver.com>
>>> ---
>>>   block/ioctl.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/block/ioctl.c b/block/ioctl.c
>>> index d5f5cd61efd7..701c64cd67e8 100644
>>> --- a/block/ioctl.c
>>> +++ b/block/ioctl.c
>>> @@ -21,7 +21,7 @@ static int blkpg_do_ioctl(struct block_device *bdev,
>>>       long long start, length;
>>>         if (disk->flags & GENHD_FL_NO_PART)
>>> -        return -EINVAL;
>>> +        return -ENXIO;
>>>       if (!capable(CAP_SYS_ADMIN))
>>>           return -EACCES;
>>>       if (copy_from_user(&p, upart, sizeof(struct blkpg_partition)))
