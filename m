Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39FA7D2AF1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbjJWHMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjJWHMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:12:22 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE50D5B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:12:20 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SDRBt3rNcz15NT2;
        Mon, 23 Oct 2023 15:09:26 +0800 (CST)
Received: from [10.174.178.209] (10.174.178.209) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 23 Oct 2023 15:12:15 +0800
Message-ID: <739480f1-4899-6da7-c9ac-9d4fd26c2474@huawei.com>
Date:   Mon, 23 Oct 2023 15:12:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] ubi: gluebi: Fix NULL pointer dereference caused by
 ftl notifier
To:     Richard Weinberger <richard@nod.at>
CC:     chengzhihao1 <chengzhihao1@huawei.com>,
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
 <9b543be7-a858-c982-3fcf-408701ae4ac9@huawei.com>
 <1141312317.29142.1698043564332.JavaMail.zimbra@nod.at>
From:   ZhaoLong Wang <wangzhaolong1@huawei.com>
In-Reply-To: <1141312317.29142.1698043564332.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.209]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> ----- Ursprüngliche Mail -----
>> Von: "ZhaoLong Wang" <wangzhaolong1@huawei.com>
>> An: "richard" <richard@nod.at>, "chengzhihao1" <chengzhihao1@huawei.com>
>> CC: "Miquel Raynal" <miquel.raynal@bootlin.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, "dpervushin"
>> <dpervushin@embeddedalley.com>, "Artem Bityutskiy" <Artem.Bityutskiy@nokia.com>, "linux-mtd"
>> <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "yi zhang" <yi.zhang@huawei.com>,
>> "yangerkun" <yangerkun@huawei.com>
>> Gesendet: Montag, 23. Oktober 2023 08:41:12
>> Betreff: Re: [PATCH v2] ubi: gluebi: Fix NULL pointer dereference caused by ftl notifier
> 
>>>
>>> IOW, no mtdblock (hence, also no FTLs) on top of gluebi.
>>>
>>> What do you guys think?
>>>
>>> Thanks,
>>> //richard
>>>
>>
>>
>> JFFS2 needs to work on the block device, so the mtdblock needs to work
>> on the top of gluebi.
>>
>> This is directly reflected in the jffs2 mount command, such as
>>
>>    # mount -t jffs2 /dev/mtdblockX /mnt/jffs2
> 
> The limitation is long gone. It comes from the dark and old times
> where Linux was only able to mount block devices.
> 
> You can do: mount -t jffs2 mtdX /mnt/jffs2
> 
> Thanks,
> //richard
> 

Yes, I tried it and it worked. Thanks for the reminder.

But this modification rejects this usage. and rejects other block device
file systems (such as ext4) from working on gluebi.

Thank you.
Zhaolong
