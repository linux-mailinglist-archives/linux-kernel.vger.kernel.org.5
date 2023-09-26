Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495B27AE333
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 03:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjIZBIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 21:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjIZBIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 21:08:17 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0B495
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 18:08:10 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RvhNB6WwVzMlt2;
        Tue, 26 Sep 2023 09:04:26 +0800 (CST)
Received: from [10.174.178.209] (10.174.178.209) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 09:08:07 +0800
Message-ID: <bd8c4e2b-2538-11d9-ed5c-34cd302703e2@huawei.com>
Date:   Tue, 26 Sep 2023 09:08:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [RFC] mtd: Fix error code loss in mtdchar_read() function.
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chengzhihao1 <chengzhihao1@huawei.com>,
        yi zhang <yi.zhang@huawei.com>,
        yangerkun <yangerkun@huawei.com>
References: <20230923005856.2538223-1-wangzhaolong1@huawei.com>
 <1131184426.81026.1695650583370.JavaMail.zimbra@nod.at>
 <20230925163727.7ecebe9a@xps-13>
 <488305749.81257.1695653971403.JavaMail.zimbra@nod.at>
 <20230925170642.089e543b@xps-13>
From:   ZhaoLong Wang <wangzhaolong1@huawei.com>
In-Reply-To: <20230925170642.089e543b@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.209]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> richard@nod.at wrote on Mon, 25 Sep 2023 16:59:31 +0200 (CEST):
>
>> ----- Ursprüngliche Mail -----
>>> Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
>>>> Given this a second thought. I don't think a NAND driver is allowed to return
>>>> less than requests bytes and setting EBADMSG.
>>>> UBI's IO path has a comment on that:
>>>>
>>>>                  /*
>>>>                   * The driver should never return -EBADMSG if it failed to read
>>>>                   * all the requested data. But some buggy drivers might do
>>>>                   * this, so we change it to -EIO.
>>>>                   */
>>>>                  if (read != len && mtd_is_eccerr(err)) {
>>>>                          ubi_assert(0);
>>>>                          err = -EIO;
>>>>                  }
>>> Interesting. Shall we add this check to the mtd_read() path as well?
>>>
>>> Maybe with a WARN_ON()?
>> WARN_ON_ONCE(), please. But yes, let's add it.
> Zhaolong, can you take care of it?
>
>> Thanks,
>> //richard
>
> Thanks,
> Miquèl


Yes！That is a good idea, and I am pleased to do this.

Thanks,
Zhaolong

