Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B796792683
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbjIEQEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351854AbjIEF17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 01:27:59 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C40CCF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 22:27:55 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id dObLqMhXKyoREdObLqvYW2; Tue, 05 Sep 2023 07:27:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693891673;
        bh=fc7UsU95zQsQlPFIsQq5CGy7XFtuPx0VRlseRiLjyWk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ZTcnkZLbqoSNSU+t4WKF6rZhBLRXayHen8UVP/HiXefCK2r6YV2YaoOmDVbiwhmi/
         pL6EerMqzvKPsvFYnyE3OEq9EyLixV+EVphMNpQOsnac3otc+xHZNGnbFfxUNhah+3
         J93Lq8s3m1aUPdyxBe/9y+YKerdABdST93g9BUSI84g4yuPnlBTOYPcCkZRemh8XTA
         D23SnaLJZwrNquo6rv9ksE/7Lq3vpEiWtOSCr3hgl70d7MsqmOo9+Z+RbVXdEApWNO
         ip5dyaxPioGlQzSZVOEZgbA+x1Es2Xpul8Ht3Ym5mcN/Yi6qxYpQbVzz+z7PYqaMuU
         UZECZHO8vvAjg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 05 Sep 2023 07:27:53 +0200
X-ME-IP: 86.243.2.178
Message-ID: <00bdcfec-6cc1-e521-ceaa-d16d6341ca16@wanadoo.fr>
Date:   Tue, 5 Sep 2023 07:27:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] crypto: hisilicon/hpre - Fix a erroneous check after
 snprintf()
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Longfang Liu <liulongfang@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Zaibo Xu <xuzaibo@huawei.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-crypto@vger.kernel.org
References: <73534cb1713f58228d54ea53a8a137f4ef939bad.1693858632.git.christophe.jaillet@wanadoo.fr>
 <ZPaSCOX1F9b36rxV@gondor.apana.org.au>
Content-Language: fr, en-US
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <ZPaSCOX1F9b36rxV@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 05/09/2023 à 04:27, Herbert Xu a écrit :
> On Mon, Sep 04, 2023 at 10:17:29PM +0200, Christophe JAILLET wrote:
>> This error handling looks really strange.
>> Check if the string has been truncated instead.
>>
>> Fixes: 02ab994635eb ("crypto: hisilicon - Fixed some tiny bugs of HPRE")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/crypto/hisilicon/hpre/hpre_main.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
>> index 39297ce70f44..db44d889438a 100644
>> --- a/drivers/crypto/hisilicon/hpre/hpre_main.c
>> +++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
>> @@ -1033,7 +1033,7 @@ static int hpre_cluster_debugfs_init(struct hisi_qm *qm)
>>   
>>   	for (i = 0; i < clusters_num; i++) {
>>   		ret = snprintf(buf, HPRE_DBGFS_VAL_MAX_LEN, "cluster%d", i);
>> -		if (ret < 0)
>> +		if (ret >= HPRE_DBGFS_VAL_MAX_LEN)
>>   			return -EINVAL;
>>   		tmp_d = debugfs_create_dir(buf, qm->debug.debug_root);
> Who is going to free the allocated memory in case of error?

Not sure to understand.

The memory is allocated with devm_kzalloc(), so it will be freed by the 
framework.

Some debugfs dir of file way be left around. Is it what your are talking 
about?

>
> The other snprintf in the same file also looks suspect.

It looks correct to me.

And HPRE_DBGFS_VAL_MAX_LEN being 20, it doesn't really matter. The 
string can't be truncated with just a "%u\n".

CJ

>
> Thanks,
