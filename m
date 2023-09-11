Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A6879A118
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 03:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjIKB7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 21:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjIKB7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 21:59:04 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23551130;
        Sun, 10 Sep 2023 18:59:00 -0700 (PDT)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RkVD43BPrzMl8R;
        Mon, 11 Sep 2023 09:55:32 +0800 (CST)
Received: from [10.67.121.110] (10.67.121.110) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 11 Sep 2023 09:58:57 +0800
Subject: Re: [PATCH] crypto: hisilicon/hpre - Fix a erroneous check after
 snprintf()
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Zaibo Xu <xuzaibo@huawei.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-crypto@vger.kernel.org>
References: <73534cb1713f58228d54ea53a8a137f4ef939bad.1693858632.git.christophe.jaillet@wanadoo.fr>
 <ZPaSCOX1F9b36rxV@gondor.apana.org.au>
 <00bdcfec-6cc1-e521-ceaa-d16d6341ca16@wanadoo.fr>
 <71bf9b84-462f-405e-91aa-fb21fc6ffbd5@moroto.mountain>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <258d6883-f572-9ac7-f6c6-73c34b9d5b63@huawei.com>
Date:   Mon, 11 Sep 2023 09:58:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <71bf9b84-462f-405e-91aa-fb21fc6ffbd5@moroto.mountain>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.110]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

On 2023/9/7 19:15, Dan Carpenter wrote:
> On Tue, Sep 05, 2023 at 07:27:47AM +0200, Marion & Christophe JAILLET wrote:
>>>
>>> The other snprintf in the same file also looks suspect.
>>
>> It looks correct to me.
>>
>> And HPRE_DBGFS_VAL_MAX_LEN being 20, it doesn't really matter. The string
>> can't be truncated with just a "%u\n".
>>
> 
> drivers/crypto/hisilicon/hpre/hpre_main.c
>    884          ret = snprintf(tbuf, HPRE_DBGFS_VAL_MAX_LEN, "%u\n", val);
>    885          return simple_read_from_buffer(buf, count, pos, tbuf, ret);
> 
> You can't pass the return value from snprintf() to simple_read_from_buffer().
> Otherwise the snprintf() checking turned a sprintf() write overflow into
> a read overflow, which is less bad but not ideal.  It needs to be
> scnprintf().
>

Here only one "%u" data is written to buf, the return value ret cannot exceed 10,
and the length of tbuf is 20.
How did the overflow you mentioned occur?

Thanks,
Longfang.
> regards,
> dan carpenter
> 
> 
> .
> 
