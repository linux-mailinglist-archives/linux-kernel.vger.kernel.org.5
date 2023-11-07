Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764067E3F4D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbjKGMyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbjKGMxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:53:54 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269666F8F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 04:39:19 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VvuU5zg_1699360752;
Received: from 30.25.227.158(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VvuU5zg_1699360752)
          by smtp.aliyun-inc.com;
          Tue, 07 Nov 2023 20:39:16 +0800
Message-ID: <32abf57d-d3bc-d812-c70f-bba8356162ff@linux.alibaba.com>
Date:   Tue, 7 Nov 2023 20:39:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH -next,V2] fscache: support to disable assert macro
To:     Zizhi Wo <wozizhi@huawei.com>, dhowells@redhat.com
Cc:     linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        yangerkun@huawei.com
References: <20231101163414.2105727-1-wozizhi@huawei.com>
 <d3a50c46-93c9-4b60-8609-9465e1605f77@huawei.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <d3a50c46-93c9-4b60-8609-9465e1605f77@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.3 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/7 18:16, Zizhi Wo wrote:
> friendly ping
> 
> 在 2023/11/2 0:34, WoZ1zh1 写道:
>> In fs/fscache/internal.h, ASSERT macro is enabled by default and can not
>> be disabled, then assert failure will crash the kernel as the BUG() is
>> included in the ASSERT macro. Therefore, add FSCACHE_ASSERT to control it.

Personally it looks good to me, yet we could also turn
them into WARN_ON_ONCE case by case? Anyway, it depends
on how David thinks...

Thanks,
Gao Xiang

>>
>> Signed-off-by: WoZ1zh1 <wozizhi@huawei.com>
>> ---
>>   fs/fscache/Kconfig    | 10 ++++++++++
>>   fs/fscache/internal.h |  2 +-
>>   2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/fscache/Kconfig b/fs/fscache/Kconfig
>> index b313a978ae0a..7ff844038bc3 100644
>> --- a/fs/fscache/Kconfig
>> +++ b/fs/fscache/Kconfig
>> @@ -38,3 +38,13 @@ config FSCACHE_DEBUG
>>         enabled by setting bits in /sys/modules/fscache/parameter/debug.
>>         See Documentation/filesystems/caching/fscache.rst for more information.
>> +
>> +config FSCACHE_ASSERT
>> +    bool "FSCACHE asserts"
>> +    default n
>> +    depends on FSCACHE
>> +    help
>> +      Support the ASSERT mode for failure behavior.
>> +      Say N here to disable the ASSERT by default.
>> +      Say Y to add assertion checks in some places. But the assertion
>> +      failure will result in fatal errors that BUG() the kernel.
>> diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
>> index 1336f517e9b1..951166ed772f 100644
>> --- a/fs/fscache/internal.h
>> +++ b/fs/fscache/internal.h
>> @@ -225,7 +225,7 @@ do {                        \
>>   /*
>>    * assertions
>>    */
>> -#if 1 /* defined(__KDEBUGALL) */
>> +#ifdef CONFIG_FSCACHE_ASSERT
>>   #define ASSERT(X)                            \
>>   do {                                    \
