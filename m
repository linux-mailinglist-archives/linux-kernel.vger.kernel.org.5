Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063827D0679
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 04:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346857AbjJTC2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 22:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbjJTC2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 22:28:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E3512F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 19:28:14 -0700 (PDT)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SBT0C5RDSzvQCn;
        Fri, 20 Oct 2023 10:23:23 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 20 Oct 2023 10:28:09 +0800
Subject: Re: [PATCH v2] ubi: gluebi: Fix NULL pointer dereference caused by
 ftl notifier
To:     Richard Weinberger <richard@nod.at>,
        ZhaoLong Wang <wangzhaolong1@huawei.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <dpervushin@embeddedalley.com>,
        Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        yi zhang <yi.zhang@huawei.com>,
        yangerkun <yangerkun@huawei.com>
References: <20231018121618.778385-1-wangzhaolong1@huawei.com>
 <1381458025.20897.1697747248632.JavaMail.zimbra@nod.at>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <891e554b-c133-6378-3a65-836fc9147e54@huawei.com>
Date:   Fri, 20 Oct 2023 10:27:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1381458025.20897.1697747248632.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000013.china.huawei.com (7.193.23.81)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/10/20 4:27, Richard Weinberger 写道:
> ----- Ursprüngliche Mail -----
>> Von: "ZhaoLong Wang" <wangzhaolong1@huawei.com>
>> An: "richard" <richard@nod.at>, "Miquel Raynal" <miquel.raynal@bootlin.com>, "Vignesh Raghavendra" <vigneshr@ti.com>,
>> dpervushin@embeddedalley.com, "Artem Bityutskiy" <Artem.Bityutskiy@nokia.com>
>> CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "chengzhihao1"
>> <chengzhihao1@huawei.com>, "ZhaoLong Wang" <wangzhaolong1@huawei.com>, "yi zhang" <yi.zhang@huawei.com>, "yangerkun"
>> <yangerkun@huawei.com>
>> Gesendet: Mittwoch, 18. Oktober 2023 14:16:18
>> Betreff: [PATCH v2] ubi: gluebi: Fix NULL pointer dereference caused by ftl notifier
> 
>> If both flt.ko and gluebi.ko are loaded, the notiier of ftl
>> triggers NULL pointer dereference when trying to access
>> ‘gluebi->desc’ in gluebi_read().
>>
>> ubi_gluebi_init
>>   ubi_register_volume_notifier
>>     ubi_enumerate_volumes
>>       ubi_notify_all
>>         gluebi_notify    nb->notifier_call()
>>           gluebi_create
>>             mtd_device_register
>>               mtd_device_parse_register
>>                 add_mtd_device
>>                   blktrans_notify_add   not->add()
>>                     ftl_add_mtd         tr->add_mtd()
>>                       scan_header
>>                         mtd_read
>>                           mtd_read
>>                             mtd_read_oob
>>                               gluebi_read   mtd->read()
>>                                 gluebi->desc - NULL
>>
>> Detailed reproduction information available at the link[1],
>>
>> In the normal case, obtain gluebi->desc in the gluebi_get_device(),
>> and accesses gluebi->desc in the gluebi_read(). However,
>> gluebi_get_device() is not executed in advance in the
>> ftl_add_mtd() process, which leads to NULL pointer dereference.
>>
>> The value of gluebi->desc may also be a negative error code, which
>> triggers the page fault error.
>>
>> This patch has the following modifications:
>>
>> 1. Do not assign gluebi->desc to the error code. Use the NULL instead.
>>
>> 2. Always check the validity of gluebi->desc in gluebi_read() If the
>>    gluebi->desc is NULL, try to get MTD device.
>>
>> Such a modification currently works because the mutex "mtd_table_mutex"
>> is held on all necessary paths, including the ftl_add_mtd() call path,
>> open and close paths. Therefore, many race condition can be avoided.
> 
> I see the problem, but I'm not really satisfied by the solution.
> Adding this hack to gluebi_read() is not nice at all.

Yes, it's jsut a workaround. At the begining, I prefer that increasing 
volume refcnt (by ubi_open_volume) in gluebi_create and releasing volume 
refcnt in gluebi_remove. It looks more reasonable that holding a refcnt 
of UBI volume when gluebi is alive. After looking through the code, the 
creation/destroying of gluebi is triggered by volume 
actions(UBI_VOLUME_ADDED/UBI_VOLUME_REMOVED), which means that:
1. gluebi_remove is depended on UBI_VOLUME_REMOVED(triggered by 
ubi_remove_volume)
2. ubi_remove_volume won't be executed until the refcnt of volume 
becomes 0(released by gluebi_remove)

If we add new ioctls to control creation/destroying of gluebi, then 
gluebi mtd won't be automatically created when UBI volume is added. I'm 
not certain whether this change will effect existing startup process 
that depends on gluebi.

> 
> Is there a strong reason why have to defer ubi_open_volume() to
> gluebi_get_device()?
> 
> Miquel, what do you think?
> 
> Thanks,
> //richard
> 
> .
> 

