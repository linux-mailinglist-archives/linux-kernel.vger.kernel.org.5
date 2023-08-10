Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05817771D0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjHJHp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjHJHp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:45:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A92610F6;
        Thu, 10 Aug 2023 00:45:54 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RLzR2095YztS7B;
        Thu, 10 Aug 2023 15:42:22 +0800 (CST)
Received: from [10.69.136.139] (10.69.136.139) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 15:45:51 +0800
Message-ID: <7c44c161-9c86-8c60-f031-6d77d6c28c20@huawei.com>
Date:   Thu, 10 Aug 2023 15:45:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     <shaojijie@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH net] net: hns3: fix strscpy causing content truncation
 issue
To:     Leon Romanovsky <leon@kernel.org>
References: <20230809020902.1941471-1-shaojijie@huawei.com>
 <20230809070302.GR94631@unreal>
From:   Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20230809070302.GR94631@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.136.139]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


on 2023/8/9 15:03, Leon Romanovsky wrote:
> On Wed, Aug 09, 2023 at 10:09:02AM +0800, Jijie Shao wrote:
>> From: Hao Chen <chenhao418@huawei.com>
>>
>> hns3_dbg_fill_content()/hclge_dbg_fill_content() is aim to integrate some
>> items to a string for content, and we add '\n' and '\0' in the last
>> two bytes of content.
>>
>> strscpy() will add '\0' in the last byte of destination buffer(one of
>> items), it result in finishing content print ahead of schedule and some
>> dump content truncation.
>>
>> One Error log shows as below:
>> cat mac_list/uc
>> UC MAC_LIST:
>>
>> Expected:
>> UC MAC_LIST:
>> FUNC_ID  MAC_ADDR            STATE
>> pf       00:2b:19:05:03:00   ACTIVE
>>
>> The destination buffer is length-bounded and not required to be
>> NUL-terminated, so just change strscpy() to memcpy() to fix it.
> I think that you should change to strtomem() and not use plain memcpy().
>
> Thanks

Hi:

We tried to replace memcpy with strtomem, but errors was reported during 
compilation:
/kernel/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c: In 
function ‘hclge_dbg_fill_content.part.0’:
/kernel/include/linux/compiler_types.h:397:38: error: call to 
‘__compiletime_assert_519’ declared with attribute error: BUILD_BUG_ON 
failed: !__builtin_constant_p(_dest_len) || _dest_len == (size_t)-1
   397 |  _compiletime_assert(condition, msg, __compiletime_assert_, 
__COUNTER__)
       |                                      ^
/kernel/include/linux/compiler_types.h:378:4: note: in definition of 
macro ‘__compiletime_assert’
   378 |    prefix ## suffix();    \
       |    ^~~~~~
/kernel/include/linux/compiler_types.h:397:2: note: in expansion of 
macro ‘_compiletime_assert’
   397 |  _compiletime_assert(condition, msg, __compiletime_assert_, 
__COUNTER__)
       |  ^~~~~~~~~~~~~~~~~~~
/kernel/include/linux/build_bug.h:39:37: note: in expansion of macro 
‘compiletime_assert’
    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), 
msg)
       |                                     ^~~~~~~~~~~~~~~~~~
/kernel/include/linux/build_bug.h:50:2: note: in expansion of macro 
‘BUILD_BUG_ON_MSG’
    50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
       |  ^~~~~~~~~~~~~~~~
/kernel/include/linux/string.h:302:2: note: in expansion of macro 
‘BUILD_BUG_ON’
   302 |  BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||  \
       |  ^~~~~~~~~~~~
/kernel/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:115:4: 
note: in expansion of macro ‘strtomem’
   115 |    strtomem(pos, result[i]);
       |    ^~~~~~~~

In the strtomem macro, __builtin_object_size is used to calculate the 
_dest_len.
We tried to print the _dest_len directly, and the result was -1.
How can we solve this?

Regards
Jijie Shao

