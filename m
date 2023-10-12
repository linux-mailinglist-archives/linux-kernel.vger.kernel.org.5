Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1827C6C60
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378556AbjJLLbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378431AbjJLLbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:31:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAB2E6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 04:31:20 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S5nRZ1c26z9tJ9;
        Thu, 12 Oct 2023 19:27:22 +0800 (CST)
Received: from [10.174.178.209] (10.174.178.209) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 12 Oct 2023 19:31:18 +0800
Message-ID: <e1e25755-432d-fd8d-c3f6-7752f68e037e@huawei.com>
Date:   Thu, 12 Oct 2023 19:31:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH RFC] ubi: gluebi: Fix NULL pointer dereference caused by
 ftl notifier
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>
References: <20231010142925.545238-1-wangzhaolong1@huawei.com>
From:   ZhaoLong Wang <wangzhaolong1@huawei.com>
In-Reply-To: <20231010142925.545238-1-wangzhaolong1@huawei.com>
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

Friendly ping ...

> If both flt.ko and gluebi.ko are loaded, the notiier of ftl
> triggers NULL pointer dereference when trying to visit
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
>                            mtd_read
>                              mtd_read_oob
>                                gluebi_read   mtd->read()
>                                  gluebi->desc - NULL
> 
> Detailed reproduction information available at the link[1],
> 
> In the normal case, obtain gluebi->desc in the gluebi_get_device(),
> and accesses gluebi->desc in the gluebi_read(). However,
> gluebi_get_device() is not executed in advance in the
> ftl_add_mtd() process, which leads to null pointer dereference.

