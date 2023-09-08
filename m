Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26ED798A7E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 18:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjIHQLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 12:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238765AbjIHQLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:11:30 -0400
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A431FDF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 09:11:23 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id ee4jq6ujawJ7Jee4jqw3bA; Fri, 08 Sep 2023 18:11:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1694189481;
        bh=+6AindnLA3kWmbjcoqncg4z08JP7Gi43jNm6msbfoQY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=tAot1hcjXjpXglcWx3paiok/8diihH91pXTsmoFf7sgUWJhzeZaC5APrenWuK2Mmg
         yLu4aW8kA12gzpqQ4KpA0ELuzd7rHjPfkKkF2ZcHRDexhrXxgLkFu3s8mZgiY5lTcY
         LExo1GnajVVNP+dpIXsMvksBogoGkiUx/76aaBfJzVAvzzHMwDGeXTBjEqRKtrbzNW
         Eo7XwpL6m0agMxiMwATj277M/bMFKie+SyEsSVLVjjPBxJfBum99TdpJfdyF8blivf
         YsJoOEFkb7EmRj9JoJI2YHZSRcUXYhcdgR6qmYYlGyBqUjyngk53p4cfY4qxpmzPuT
         MlWyGnqPDD2WA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 08 Sep 2023 18:11:21 +0200
X-ME-IP: 86.243.2.178
Message-ID: <492ae2a2-3364-f13c-4d93-0175221483a9@wanadoo.fr>
Date:   Fri, 8 Sep 2023 18:11:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] crypto: hisilicon/hpre - Fix a erroneous check after
 snprintf()
Content-Language: fr, en-US
To:     liulongfang <liulongfang@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Zaibo Xu <xuzaibo@huawei.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-crypto@vger.kernel.org
References: <73534cb1713f58228d54ea53a8a137f4ef939bad.1693858632.git.christophe.jaillet@wanadoo.fr>
 <ZPaSCOX1F9b36rxV@gondor.apana.org.au>
 <00bdcfec-6cc1-e521-ceaa-d16d6341ca16@wanadoo.fr>
 <ZPbkJOPsx4as96D/@gondor.apana.org.au>
 <f4379fee-22c2-3b94-1725-70a317cc9baf@huawei.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <f4379fee-22c2-3b94-1725-70a317cc9baf@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 06/09/2023 à 04:04, liulongfang a écrit :
> On 2023/9/5 16:17, Herbert Xu wrote:
>> On Tue, Sep 05, 2023 at 07:27:47AM +0200, Marion & Christophe JAILLET wrote:
>>>
>>> Some debugfs dir of file way be left around. Is it what your are talking
>>> about?
>>
>> Yes all allocated resources should be freed on the error path.
>>
>>>> The other snprintf in the same file also looks suspect.
>>>
>>> It looks correct to me.
>>>
>>> And HPRE_DBGFS_VAL_MAX_LEN being 20, it doesn't really matter. The string
>>> can't be truncated with just a "%u\n".
>>
>> Well if you're going to go with that line of reasoning then this
>> case ("cluster%d") can't overflow either, no?
>>
> 
> First, I checked the calling code of the snprintf function in all driver files in
> the hisilicon directory. Only here is the processing of return value judgment.
> This treatment is indeed problematic and needs to be modified.
> 
> Then, I don't quite agree with your modification plan.
> The modification of this solution is not complete.
> As Herbert said, ("cluster%d") may still have overflow problems.

Herbert said the contrary, and I agree with him.

HPRE_DBGFS_VAL_MAX_LEN is 20.

cluster%u will be at max:
	strlen("cluster") + strlen("4294967295") + 1 = 17

(unless some system have 64 bits int?)

I do agree that it is safe to remove the test after snprintf(), but 
there is no need from my POV to turn "i" into a u8.

CJ

> 
> In the end, my proposed modification scheme is this:
> ...
> 	int ret;
> 	u8 i;
> 
> 	for (i = 0; i < clusters_num; i++) {
> 		snprintf(buf, HPRE_DBGFS_VAL_MAX_LEN, "cluster%u", i);
> 		tmp_d = debugfs_create_dir(buf, qm->debug.debug_root);
> 		...
> 	}
> ...
> 
> Thanks,
> Longfang.
> 
>> Cheers,
>>
> 

