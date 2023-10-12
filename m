Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E697C6C3E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347167AbjJLLZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343840AbjJLLZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:25:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA07C0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 04:25:54 -0700 (PDT)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S5nKH4Q9Qz9tJ0;
        Thu, 12 Oct 2023 19:21:55 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 12 Oct 2023 19:25:51 +0800
Subject: Re: [PATCH RFC] ubi: gluebi: Fix NULL pointer dereference caused by
 ftl notifier
To:     ZhaoLong Wang <wangzhaolong1@huawei.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>
References: <20231010142925.545238-1-wangzhaolong1@huawei.com>
 <9f96baf1-962e-d595-0e4f-797315cd0348@huawei.com>
 <b972f615-3882-18cf-5b44-7ec021f92e0a@huawei.com>
 <a8a2dc17-7a7a-e725-8ae2-e7e0146150f0@huawei.com>
 <d089e4ff-26dc-22e4-58b3-8756f8ebaabc@huawei.com>
 <2d04fa9e-e594-705c-339b-3090cb7d6fbd@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <f1b27408-6eae-4195-4c97-c286c4ad04db@huawei.com>
Date:   Thu, 12 Oct 2023 19:25:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2d04fa9e-e594-705c-339b-3090cb7d6fbd@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

在 2023/10/12 17:31, ZhaoLong Wang 写道:
> 
>>>
>>>> 3.         P1                    P2
>>>>     gluebi_create -> mtd_device_register -> add_mtd_device:
>>>>     device_register   // dev/mtd1 is visible
>>>>
>>>>                       fd = open(/dev/mtd1, O_WRONLY)
>>>>                        gluebi_get_device
>>>>                         gluebi->desc = ubi_open_volume
>>>>
>>>>     ftl_add_mtd
>>>>      mtd_read
>>>>       gluebi_read
>>>>        gluebi->desc is not ERR_PTR/NULL
>>>>
>>>>                      close(fd)
>>>>                       gluebi_put_device
>>>>                        ubi_close_volume
>>>>                         kfree(desc)
>>>>        ubi_read(gluebi->desc)   // UAF  (×)
>>>>
>>>
>>> Yes, it's also a problem. Perhaps it should be set to NULL after
>>> destroying gluebi->desc.
>>
>> The key point is that 'gluebi->desc' check & usage is not atomic in 
>> gluebi_read. So following patch still can't handle situation 3.
>>
> 
> Setting the desc to NULL works because
> mutex_lock "mtd_table_mutex" is held on all paths where
> ftl_add_mtd() is called.
> 

Oh, you're right. Just one nit below:


 > @@ -154,9 +159,26 @@ static int gluebi_read(struct mtd_info *mtd, loff_t
 > from, size_t len,
 >                  size_t *retlen, unsigned char *buf)
 >   {
 >       int err = 0, lnum, offs, bytes_left;
 > -    struct gluebi_device *gluebi;
 > +    struct gluebi_device *gluebi = container_of(mtd, struct 
gluebi_device,
 > +                            mtd);
 > +    int isnt_get = unlikely(gluebi->desc == NULL) ? 1 : 0;

This 'unlikey' can be removed.

Rename 'isnt_get' as 'has_desc' ?

 > +    /**
 > +     * In normal case, the UBI volume desc has been initialized by
 > +     * ->_get_device(). However, in the ftl notifier process, the
 > +     * ->_get_device() is not executed in advance and the MTD device
 > +     * is directly scanned  which cause null pointe dereference.
 > +     * Therefore, try to get the MTD device here.
 > +     */
 > +    if (unlikely(isnt_get)) {
 > +        err = __get_mtd_device(mtd);
 > +        if (err) {
 > +            err_msg("cannot get MTD device %d, UBI device %d, volume
 > %d, error %d",
 > +                mtd->index, gluebi->ubi_num, gluebi->vol_id, err);
 > +            return err;
 > +        }
 > +    }

