Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB4E7D2AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjJWHJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWHJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:09:45 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30BB8F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:09:41 -0700 (PDT)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SDR6J1gtnzMmC4;
        Mon, 23 Oct 2023 15:05:28 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 23 Oct 2023 15:09:38 +0800
Subject: Re: [PATCH v2] ubi: gluebi: Fix NULL pointer dereference caused by
 ftl notifier
To:     Richard Weinberger <richard@nod.at>
CC:     ZhaoLong Wang <wangzhaolong1@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        dpervushin <dpervushin@embeddedalley.com>,
        Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        yi zhang <yi.zhang@huawei.com>,
        yangerkun <yangerkun@huawei.com>
References: <20231018121618.778385-1-wangzhaolong1@huawei.com>
 <1381458025.20897.1697747248632.JavaMail.zimbra@nod.at>
 <891e554b-c133-6378-3a65-836fc9147e54@huawei.com>
 <441107100.23734.1697904580252.JavaMail.zimbra@nod.at>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <93b2d5ab-e36c-be08-7343-ef4ca16f991d@huawei.com>
Date:   Mon, 23 Oct 2023 15:09:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <441107100.23734.1697904580252.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000013.china.huawei.com (7.193.23.81)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/10/22 0:09, Richard Weinberger 写道:
> ----- Ursprüngliche Mail -----
>> Von: "chengzhihao1" <chengzhihao1@huawei.com>
>>>> Such a modification currently works because the mutex "mtd_table_mutex"
>>>> is held on all necessary paths, including the ftl_add_mtd() call path,
>>>> open and close paths. Therefore, many race condition can be avoided.
>>>
>>> I see the problem, but I'm not really satisfied by the solution.
>>> Adding this hack to gluebi_read() is not nice at all.
>>
>> Yes, it's jsut a workaround. At the begining, I prefer that increasing
>> volume refcnt (by ubi_open_volume) in gluebi_create and releasing volume
>> refcnt in gluebi_remove. It looks more reasonable that holding a refcnt
>> of UBI volume when gluebi is alive. After looking through the code, the
>> creation/destroying of gluebi is triggered by volume
>> actions(UBI_VOLUME_ADDED/UBI_VOLUME_REMOVED), which means that:
>> 1. gluebi_remove is depended on UBI_VOLUME_REMOVED(triggered by
>> ubi_remove_volume)
>> 2. ubi_remove_volume won't be executed until the refcnt of volume
>> becomes 0(released by gluebi_remove)
>>
>> If we add new ioctls to control creation/destroying of gluebi, then
>> gluebi mtd won't be automatically created when UBI volume is added. I'm
>> not certain whether this change will effect existing startup process
>> that depends on gluebi.
> 
> Let's take a stack back. The sole purpose of gluebi is providing
> a way to run JFFS2 on top of UBI.

Is it possible that someone runs ext4 on mtdblock based on gluebi, for 
the advantage of wear-leveling?

> IMHO there is no need to run an FTL on top of UBI or even mtdblock.
> This kind of stacking does not make sense.
> 
> So, I'd go so far and propose the following:
> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> index ff18636e08897..b362a64411ebd 100644
> --- a/drivers/mtd/mtd_blkdevs.c
> +++ b/drivers/mtd/mtd_blkdevs.c
> @@ -463,7 +463,7 @@ static void blktrans_notify_add(struct mtd_info *mtd)
>   {
>          struct mtd_blktrans_ops *tr;
>   
> -       if (mtd->type == MTD_ABSENT)
> +       if (mtd->type == MTD_ABSENT || mtd->type == MTD_UBIVOLUME)
>                  return;
>   
>          list_for_each_entry(tr, &blktrans_majors, list)
> 
> IOW, no mtdblock (hence, also no FTLs) on top of gluebi.
> 
> What do you guys think?
> 
> Thanks,
> //richard
> 
> .
> 

