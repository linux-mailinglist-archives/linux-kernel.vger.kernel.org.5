Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E3C7C69AD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbjJLJbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjJLJbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:31:16 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373E091
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:31:14 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4S5kpY2whvz1M9NF;
        Thu, 12 Oct 2023 17:28:37 +0800 (CST)
Received: from [10.174.178.209] (10.174.178.209) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 12 Oct 2023 17:31:11 +0800
Message-ID: <2d04fa9e-e594-705c-339b-3090cb7d6fbd@huawei.com>
Date:   Thu, 12 Oct 2023 17:31:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH RFC] ubi: gluebi: Fix NULL pointer dereference caused by
 ftl notifier
To:     Zhihao Cheng <chengzhihao1@huawei.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>
References: <20231010142925.545238-1-wangzhaolong1@huawei.com>
 <9f96baf1-962e-d595-0e4f-797315cd0348@huawei.com>
 <b972f615-3882-18cf-5b44-7ec021f92e0a@huawei.com>
 <a8a2dc17-7a7a-e725-8ae2-e7e0146150f0@huawei.com>
 <d089e4ff-26dc-22e4-58b3-8756f8ebaabc@huawei.com>
From:   ZhaoLong Wang <wangzhaolong1@huawei.com>
In-Reply-To: <d089e4ff-26dc-22e4-58b3-8756f8ebaabc@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.209]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>
>>> 3.         P1                    P2
>>>     gluebi_create -> mtd_device_register -> add_mtd_device:
>>>     device_register   // dev/mtd1 is visible
>>>
>>>                       fd = open(/dev/mtd1, O_WRONLY)
>>>                        gluebi_get_device
>>>                         gluebi->desc = ubi_open_volume
>>>
>>>     ftl_add_mtd
>>>      mtd_read
>>>       gluebi_read
>>>        gluebi->desc is not ERR_PTR/NULL
>>>
>>>                      close(fd)
>>>                       gluebi_put_device
>>>                        ubi_close_volume
>>>                         kfree(desc)
>>>        ubi_read(gluebi->desc)   // UAF  (×)
>>>
>>
>> Yes, it's also a problem. Perhaps it should be set to NULL after
>> destroying gluebi->desc.
> 
> The key point is that 'gluebi->desc' check & usage is not atomic in 
> gluebi_read. So following patch still can't handle situation 3.
> 

Setting the desc to NULL works because
mutex_lock "mtd_table_mutex" is held on all paths where
ftl_add_mtd() is called.


ubi_gluebi_init
   ubi_register_volume_notifier
     ubi_enumerate_volumes
       ubi_notify_all
         gluebi_notify    nb->notifier_call()
           gluebi_create
             mtd_device_register
               mtd_device_parse_register
                 add_mtd_device
                   mutex_lock(&mtd_table_mutex);
                   blktrans_notify_add   not->add()
                     ftl_add_mtd         tr->add_mtd()
                       scan_header
                         mtd_read
                           mtd_read
                             mtd_read_oob
                               gluebi_read   mtd->read()
                                 gluebi->desc - NULL
                   mutex_unlock(&mtd_table_mutex);

ubi_cdev_ioctl
   ubi_create_volume
     ubi_volume_notify
       blocking_notifier_call_chain  [kernel/notifier.c]
         notifier_call_chain
           gluebi_notify   nb->notifier_call()
             gluebi_create
               mtd_device_register
                 mtd_device_parse_register
                   add_mtd_device
                     mutex_lock(&mtd_table_mutex);
                     blktrans_notify_add   not->add()
                       ftl_add_mtd     tr->add_mtd()
                         scan_header
                           mtd_read(part->mbd.mtd,
                             mtd_read_oob
                               gluebi_read   mtd->read()
                                 ubi_read(gluebi->desc
                     mutex_unlock(&mtd_table_mutex);

load_module ftl
   register_mtd_blktrans
     mutex_lock(&mtd_table_mutex);
     ftl_add_mtd  not->add()
       scan_header
         mtd_read(part->mbd.mtd,
           mtd_read_oob
             gluebi_read   mtd->read()
               ubi_read(gluebi->desc
     mutex_unlock(&mtd_table_mutex);

This lock is also held during the process of closing the file.

close(fd)
   mtdchar_close
     put_mtd_device
       mutex_lock(&mtd_table_mutex);
       __put_mtd_device
         gluebi_put_device
           ubi_close_volume
             kfree(desc)
             // desc == NULL
       mutex_unlock(&mtd_table_mutex);


