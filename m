Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2A3809D0E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573236AbjLHH3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbjLHH3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:29:33 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7755171E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:29:39 -0800 (PST)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SmjRq5zG7zWj96;
        Fri,  8 Dec 2023 15:28:39 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 15:29:36 +0800
Subject: Re: [PATCH] ubi: block: fix null-pointer-dereference in
 ubiblock_create()
To:     <linan666@huaweicloud.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linan122@huawei.com>, <yukuai3@huawei.com>, <yi.zhang@huawei.com>,
        <houtao1@huawei.com>, <yangerkun@huawei.com>
References: <20231208071317.1268465-1-linan666@huaweicloud.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <a1e3aa71-d89e-0579-b55f-125c17b45f29@huawei.com>
Date:   Fri, 8 Dec 2023 15:29:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20231208071317.1268465-1-linan666@huaweicloud.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000013.china.huawei.com (7.193.23.81)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2023/12/8 15:13, linan666@huaweicloud.com Ð´µÀ:
> From: Li Nan <linan122@huawei.com>
>
> If idr_alloc() fails, dev->gd will be put after goto out_cleanup_disk in
> ubiblock_create(), but dev->gd has not been assigned yet at this time, and
> accessing it will trigger a null-pointer-dereference issue. Fix it by put
> gd directly.
Function 'put_disk()' checks disk whether is NULL, so I think it's a 
'memleak' problem, not a null-ptr-deref problem.
>
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/mtd/ubi/block.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
> index 309a42aeaa4c..654bd7372cd8 100644
> --- a/drivers/mtd/ubi/block.c
> +++ b/drivers/mtd/ubi/block.c
> @@ -434,7 +434,7 @@ int ubiblock_create(struct ubi_volume_info *vi)
>   	list_del(&dev->list);
>   	idr_remove(&ubiblock_minor_idr, gd->first_minor);
>   out_cleanup_disk:
> -	put_disk(dev->gd);
> +	put_disk(gd);

For memleak solution:

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

>   out_free_tags:
>   	blk_mq_free_tag_set(&dev->tag_set);
>   out_free_dev:


