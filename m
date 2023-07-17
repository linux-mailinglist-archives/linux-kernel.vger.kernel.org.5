Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF74B7558FB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 03:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjGQBKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 21:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjGQBKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 21:10:51 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CD21AD;
        Sun, 16 Jul 2023 18:10:50 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R43tG4TBfz4f3kKw;
        Mon, 17 Jul 2023 09:10:46 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBn0LMVlbRknj+UOA--.49234S3;
        Mon, 17 Jul 2023 09:10:47 +0800 (CST)
Subject: Re: [PATCH] md: raid1: fix potential OOB in raid1_remove_disk()
To:     Zhang Shurong <zhang_shurong@foxmail.com>, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <tencent_59C6505725F46EF26BE7B6E8C0363C2A1509@qq.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <84626f1f-d8ae-4d60-81f1-9e4656f8dcf6@huaweicloud.com>
Date:   Mon, 17 Jul 2023 09:10:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <tencent_59C6505725F46EF26BE7B6E8C0363C2A1509@qq.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBn0LMVlbRknj+UOA--.49234S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKFykKryUJrW8Cw1rCF1kAFb_yoWkAFgEga
        4UZa4fXr4Iqryvyw47Ww1fZr9Fy3s5Wws5ZayFgF98Was8uw4Fgry8u348WasIkry2vr47
        Ar1UWw10yrn3ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbzkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
        I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
        0EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/07/16 0:11, Zhang Shurong Ð´µÀ:
> If rddev->raid_disk is greater than mddev->raid_disks, there will be
> an out-of-bounds in raid1_remove_disk(). We have already found
> similar reports as follows:
> 
> 1) commit d17f744e883b ("md-raid10: fix KASAN warning")
> 2) commit 1ebc2cec0b7d ("dm raid: fix KASAN warning in raid5_remove_disk")
> 
> Fix this bug by checking whether the "number" variable is
> valid.
> 
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> ---
>   drivers/md/raid1.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index dd25832eb045..3e294dc408fa 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -1829,6 +1829,10 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
>   	struct r1conf *conf = mddev->private;
>   	int err = 0;
>   	int number = rdev->raid_disk;
> +
> +	if (unlikely(number >= mddev->raid_disks))
> +		goto abort;
> +
This looks correct, but I prefer to use conf->raid_disks directly.

Thanks,
Kuai

>   	struct raid1_info *p = conf->mirrors + number;
>   
>   	if (rdev != p->rdev)
> 

