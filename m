Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D661F7DB62F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjJ3Jc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjJ3Jc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:32:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20782C1;
        Mon, 30 Oct 2023 02:32:26 -0700 (PDT)
Received: from kwepemm000002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SJny15KZ4zVlw4;
        Mon, 30 Oct 2023 17:28:25 +0800 (CST)
Received: from [10.174.178.159] (10.174.178.159) by
 kwepemm000002.china.huawei.com (7.193.23.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 30 Oct 2023 17:32:22 +0800
Message-ID: <53e9d294-46dc-90ae-c0ef-af09c658a80e@huawei.com>
Date:   Mon, 30 Oct 2023 17:32:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] block: Fix minor range check in device_add_disk()
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        zhongjinghua <zhongjinghua@huaweicloud.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, "yukuai (C)" <yukuai3@huawei.com>
References: <20231025084621.2338604-1-zhongjinghua@huaweicloud.com>
 <119b7314-10a9-4d62-b40f-19462dc68009@I-love.SAKURA.ne.jp>
 <26bafe93-345d-2696-8ee7-7d1baa0e7eb7@huaweicloud.com>
 <df52b8a2-dff1-3973-b2bf-ca915c3f44d3@huaweicloud.com>
From:   zhongjinghua <zhongjinghua@huawei.com>
In-Reply-To: <df52b8a2-dff1-3973-b2bf-ca915c3f44d3@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.159]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000002.china.huawei.com (7.193.23.144)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/10/30 17:26, Yu Kuai 写道:
> Hi,
>
> 在 2023/10/26 16:52, zhongjinghua 写道:
>>
>> 在 2023/10/25 18:06, Tetsuo Handa 写道:
>>> On 2023/10/25 17:46, Zhong Jinghua wrote:
>>>> Checks added in patch:
>>>> commit e338924bd05d ("block: check minor range in device_add_disk()")
>>>> ignore the problem of first_minore < 0 and disk->minors < 0.
>>> What is the problem of first_minor < 0 or disk->minors < 0 ?
>>> Are negative values legal/illegal ?
>>
>> These two values are used as the secondary device number and the 
>> maximum number of partitions, which is illegal if negative. Then 
>> first_minore and disk->minors are signed numbers, and the sum may be 
>> less than MINORMASK to bypass the check.
>
> Let me complement it, first_minor and minors can be set by driver, and
> driver allow set them throuhh ioctl/sysfs from user parameters, for
> example:
>
> If user pass in -1, and each disk support 8 partitions, driver will
> usually set:
>
> disk->first_minor = -1 * 8 = -8;
> disk->minors = 8;
>
> Then first_minor + minors = 0, then the following condition can't detect
> this case:
>
> if (disk->first_minor + disk->minors > MINORMASK + 1)
>
> By the way, we never limit how first_minor and minors is set by driver,
> and it's illegal if driver set first_minor = -4, and minors = 8.
>
> Thanks,
> Kuai
>
>>
>> .
>>
>
Kuai, Thank for your explanation.

Jinghua

