Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2207D7CBE46
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbjJQI6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbjJQI6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:58:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9378193;
        Tue, 17 Oct 2023 01:58:19 -0700 (PDT)
Received: from dggpemm500011.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S8nnm1864zvQH1;
        Tue, 17 Oct 2023 16:53:32 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 dggpemm500011.china.huawei.com (7.185.36.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 17 Oct 2023 16:58:15 +0800
Message-ID: <907c4906-3595-aa6d-8cba-5daa7133b17f@huawei.com>
Date:   Tue, 17 Oct 2023 16:58:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH] block: fix ioctl return error with GENHD_FL_NO_PART
To:     Li Wang <li.wang@windriver.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231017080900.842241-1-li.wang@windriver.com>
From:   Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <20231017080900.842241-1-li.wang@windriver.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.155]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

I don't think so.

GENHD_FL_NO_PART means "partition support is disabled". If users try to 
add or resize partition on the disk with this flag, kernel should remind 
them that the parameter of device is wrong.
So I think it's appropriate to return -EINVAL.

Thanks.

在 2023/10/17 16:09, Li Wang 写道:
> GENHD_FL_NO_PART means no device(-ENXIO), not parameter error(-EINVAL).
>
> test case with parted command:
> @dd if=/dev/zero of=./blk-file bs=1M count=200
> @losetup /dev/loop0 ./blk-file
> @parted -s /dev/loop0 mklabel MSDOS
> Error: Partition(s) 1, ..., 64 on /dev/loop0 have been written,
> but we have been unable to inform the kernel of the change,
> probably because it/they are in use. As a result,
> the old partition(s) will remain in use. You should reboot now
> before making further changes.
> @echo $?
> 1
>
> Fixes: 1a721de8489f ("block: don't add or resize partition on the disk with GENHD_FL_NO_PART")
> Signed-off-by: Li Wang <li.wang@windriver.com>
> ---
>   block/ioctl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/ioctl.c b/block/ioctl.c
> index d5f5cd61efd7..701c64cd67e8 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -21,7 +21,7 @@ static int blkpg_do_ioctl(struct block_device *bdev,
>   	long long start, length;
>   
>   	if (disk->flags & GENHD_FL_NO_PART)
> -		return -EINVAL;
> +		return -ENXIO;
>   	if (!capable(CAP_SYS_ADMIN))
>   		return -EACCES;
>   	if (copy_from_user(&p, upart, sizeof(struct blkpg_partition)))
