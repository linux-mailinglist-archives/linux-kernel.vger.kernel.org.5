Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C56778E99A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 11:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243061AbjHaJjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 05:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjHaJjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:39:17 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D605CCF7;
        Thu, 31 Aug 2023 02:39:10 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rbwxc2TsyztS9b;
        Thu, 31 Aug 2023 17:35:16 +0800 (CST)
Received: from [10.67.121.249] (10.67.121.249) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 31 Aug 2023 17:39:08 +0800
Message-ID: <aa6c291a-d9f0-1e2a-63df-e53dfcefba53@huawei.com>
Date:   Thu, 31 Aug 2023 17:39:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/4] crypto: hisilicon/zip - Remove driver
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     Linus Torvalds <torvalds@linux-foundation.org>, <ardb@kernel.org>,
        <kees@kernel.org>, <linux-kernel@vger.kernel.org>,
        <enlin.mu@unisoc.com>, <ebiggers@google.com>,
        <gpiccoli@igalia.com>, <willy@infradead.org>,
        <yunlong.xing@unisoc.com>, <yuxiaozhang@google.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        <qat-linux@intel.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Zhou Wang <wangzhou1@hisilicon.com>
References: <ZO8ULhlJSrJ0Mcsx@gondor.apana.org.au>
 <E1qbI7v-009Bvf-CA@formenos.hmeau.com>
 <8a73f9cb-b1e8-3b54-4b6c-7cfb19244560@huawei.com>
 <ZPAoRvMYbsoNfnLk@gondor.apana.org.au>
From:   Yang Shen <shenyang39@huawei.com>
In-Reply-To: <ZPAoRvMYbsoNfnLk@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.249]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/31 13:42, Herbert Xu 写道:
> On Thu, Aug 31, 2023 at 10:21:52AM +0800, Yang Shen wrote:
>> It's a pity to see that there is no user in the kernel of zlib-deflate.
>> However, there may still be hidden
>> users in the current kernel who may be using the zlib-deflate algorithm.
>> Such as zswap, it can use
>> user-specified algorithm. So there are still some benefits to be gained from
>> zlib hardware.
> Perhaps you should try reconstructing the zlib header in your
> driver so that it becomes capable of handling "deflate" data as
> is rather than adding the non-standard "zlib-deflate" algorithm?
>
> There is no way of getting the checksum without decompressing
> the data first but perhaps your hardware could ignore checksum
> errors?


OK, I'm sorry I got missunderstand about the purpose of the patch. The 
hardware also
support the deflate algorithm. I can change the driver to register the 
deflate interface and
remove the zlib-deflate. Is this plan acceptable? If yes, please don't 
remove the hisilicon
zip driver and I'll send the fix patch as soon as possible. It may take 
me a week to adapt
and verify the driver.

Thanks,
Yang

>
>> What's more, hisilicon zip driver also does other work besides supporting
>> the zlib-deflate:
>> 1.Support gzip algorithm.
> We don't even have a generic "gzip" implementation so this should
> never have gone into the kernel.
>
>> 2.Support a user space cdev hisi-zip which can accelerate user space process
>> via uacce subsystem.
> Feel free to resubmit this as a new driver but it doesn't belong
> in drivers/crypto.
>
> Cheers,

