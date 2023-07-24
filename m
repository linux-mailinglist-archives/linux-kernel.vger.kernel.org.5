Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D6375E9BA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 04:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjGXC3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 22:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjGXC3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 22:29:33 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163D6180;
        Sun, 23 Jul 2023 19:29:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R8NvS0qN1z4f3jq6;
        Mon, 24 Jul 2023 10:11:48 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHoZTj3b1kkguwOg--.21875S3;
        Mon, 24 Jul 2023 10:11:48 +0800 (CST)
Subject: Re: [PATCH v2] md: raid1: fix potential OOB in raid1_remove_disk()
To:     Zhang Shurong <zhang_shurong@foxmail.com>, song@kernel.org,
        yukuai1@huaweicloud.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <tencent_0D24426FAC6A21B69AC0C03CE4143A508F09@qq.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d8fde5d9-3ac5-0945-dc8e-315092a67528@huaweicloud.com>
Date:   Mon, 24 Jul 2023 10:11:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <tencent_0D24426FAC6A21B69AC0C03CE4143A508F09@qq.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHoZTj3b1kkguwOg--.21875S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XrWfJw15Ww47KFykWryrCrg_yoWktrcE9F
        yjva4rXF4IqryIkw47Ww1fZr9Ika4kWa1rZayFgF98Wa4Duw4Fgryku348XasxKryaqr17
        Ar1DW348Ars3ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUU
        UU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2023/07/22 15:53, Zhang Shurong Ð´µÀ:
> If rddev->raid_disk is greater than mddev->raid_disks, there will be
> an out-of-bounds in raid1_remove_disk(). We have already found
> similar reports as follows:
> 
> 1) commit d17f744e883b ("md-raid10: fix KASAN warning")
> 2) commit 1ebc2cec0b7d ("dm raid: fix KASAN warning in raid5_remove_disk")
> 
> Fix this bug by checking whether the "number" variable is
> valid.

LGTM

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> 
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> ---
> Changes in v2:
>   - Using conf->raid_disks instead of mddev->raid_disks.
> 
>   drivers/md/raid1.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index dd25832eb045..80aeee63dfb7 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -1829,6 +1829,10 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
>   	struct r1conf *conf = mddev->private;
>   	int err = 0;
>   	int number = rdev->raid_disk;
> +
> +	if (unlikely(number >= conf->raid_disks))
> +		goto abort;
> +
>   	struct raid1_info *p = conf->mirrors + number;
>   
>   	if (rdev != p->rdev)
> 

