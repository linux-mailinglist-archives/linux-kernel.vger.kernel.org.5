Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7A27D8D62
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 05:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjJ0DXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 23:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0DXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 23:23:40 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B67B4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 20:23:38 -0700 (PDT)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SGntn4ZhpzpWQB;
        Fri, 27 Oct 2023 11:18:41 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 27 Oct 2023 11:23:34 +0800
Subject: Re: [PATCH v3] mtd: Fix gluebi NULL pointer dereference caused by ftl
 notifier
To:     ZhaoLong Wang <wangzhaolong1@huawei.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <Artem.Bityutskiy@nokia.com>, <dpervushin@embeddedalley.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>
References: <20231027012033.50280-1-wangzhaolong1@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <04a142af-a4e6-bb2c-fb92-61fc1df8ed98@huawei.com>
Date:   Fri, 27 Oct 2023 11:23:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20231027012033.50280-1-wangzhaolong1@huawei.com>
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

在 2023/10/27 9:20, ZhaoLong Wang 写道:
> If both flt.ko and gluebi.ko are loaded, the notiier of ftl
> triggers NULL pointer dereference when trying to access
> ‘gluebi->desc’ in gluebi_read().
>
> ubi_gluebi_init
>    ubi_register_volume_notifier
>      ubi_enumerate_volumes
>        ubi_notify_all
>          gluebi_notify    nb->notifier_call()
>            gluebi_create
>              mtd_device_register
>                mtd_device_parse_register
>                  add_mtd_device
>                    blktrans_notify_add   not->add()
>                      ftl_add_mtd         tr->add_mtd()
>                        scan_header
>                          mtd_read
>                            mtd_read_oob
>                              mtd_read_oob_std
>                                gluebi_read   mtd->read()
>                                  gluebi->desc - NULL
>
> Detailed reproduction information available at the link[1],
>
> The solution for the gluebi module is to run jffs2 on the UBI
> volume without considering working with ftl or mtdblock.[2].
> Therefore, this problem can be avoided by preventing gluebi
> from creating mtdblock devices.
>
> Fixes: 2ba3d76a1e29 ("UBI: make gluebi a separate module")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217992 [1]
> Link: https://lore.kernel.org/lkml/441107100.23734.1697904580252.JavaMail.zimbra@nod.at/ [2]
> Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
> ---
>   drivers/mtd/mtd_blkdevs.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>


