Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B69793388
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 04:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238245AbjIFCFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 22:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjIFCFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 22:05:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447BC1A7;
        Tue,  5 Sep 2023 19:05:02 -0700 (PDT)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RgQbz2ZR6zVkdx;
        Wed,  6 Sep 2023 10:02:07 +0800 (CST)
Received: from [10.67.121.110] (10.67.121.110) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 6 Sep 2023 10:04:43 +0800
Subject: Re: [PATCH] crypto: hisilicon/hpre - Fix a erroneous check after
 snprintf()
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     "David S. Miller" <davem@davemloft.net>,
        Zaibo Xu <xuzaibo@huawei.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-crypto@vger.kernel.org>
References: <73534cb1713f58228d54ea53a8a137f4ef939bad.1693858632.git.christophe.jaillet@wanadoo.fr>
 <ZPaSCOX1F9b36rxV@gondor.apana.org.au>
 <00bdcfec-6cc1-e521-ceaa-d16d6341ca16@wanadoo.fr>
 <ZPbkJOPsx4as96D/@gondor.apana.org.au>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <f4379fee-22c2-3b94-1725-70a317cc9baf@huawei.com>
Date:   Wed, 6 Sep 2023 10:04:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ZPbkJOPsx4as96D/@gondor.apana.org.au>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.110]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/5 16:17, Herbert Xu wrote:
> On Tue, Sep 05, 2023 at 07:27:47AM +0200, Marion & Christophe JAILLET wrote:
>>
>> Some debugfs dir of file way be left around. Is it what your are talking
>> about?
> 
> Yes all allocated resources should be freed on the error path.
> 
>>> The other snprintf in the same file also looks suspect.
>>
>> It looks correct to me.
>>
>> And HPRE_DBGFS_VAL_MAX_LEN being 20, it doesn't really matter. The string
>> can't be truncated with just a "%u\n".
> 
> Well if you're going to go with that line of reasoning then this
> case ("cluster%d") can't overflow either, no?
>

First, I checked the calling code of the snprintf function in all driver files in
the hisilicon directory. Only here is the processing of return value judgment.
This treatment is indeed problematic and needs to be modified.

Then, I don't quite agree with your modification plan.
The modification of this solution is not complete.
As Herbert said, ("cluster%d") may still have overflow problems.

In the end, my proposed modification scheme is this:
...
	int ret;
	u8 i;

	for (i = 0; i < clusters_num; i++) {
		snprintf(buf, HPRE_DBGFS_VAL_MAX_LEN, "cluster%u", i);
		tmp_d = debugfs_create_dir(buf, qm->debug.debug_root);
		...
	}
...

Thanks,
Longfang.

> Cheers,
> 
