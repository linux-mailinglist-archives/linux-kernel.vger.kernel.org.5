Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF51B7B00C4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjI0Jlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjI0Jlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:41:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98ADC0;
        Wed, 27 Sep 2023 02:41:47 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RwWm21jq5zrTBX;
        Wed, 27 Sep 2023 17:39:30 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 27 Sep 2023 17:41:45 +0800
Message-ID: <98ea6e9b-cbfb-0485-6452-e3d979aaed54@huawei.com>
Date:   Wed, 27 Sep 2023 17:41:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH v2 00/18] scsi: scsi_error: Introduce new error handle
 mechanism
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Mike Christie <michael.christie@oracle.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <louhongxiang@huawei.com>, <lixiaokeng@huawei.com>
References: <20230901094127.2010873-1-haowenchao2@huawei.com>
 <ZRGfc73BSW0yyUtI@infradead.org>
 <47bed3cb-f307-ec55-5c28-051687dab1ea@huawei.com>
 <a92f5e0c-1976-4fc6-ba48-7ff49546318a@oracle.com>
 <06268327-cfed-f266-34a7-fda69411ef2a@huawei.com>
 <c3763949-c810-4a1f-87cc-e2248bfdc40b@suse.de>
From:   Wenchao Hao <haowenchao2@huawei.com>
In-Reply-To: <c3763949-c810-4a1f-87cc-e2248bfdc40b@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000012.china.huawei.com (7.193.23.142)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/27 15:59, Hannes Reinecke wrote:
> On 9/26/23 14:57, Wenchao Hao wrote:
>> On 2023/9/26 1:54, Mike Christie wrote:
>>> On 9/25/23 10:07 AM, Wenchao Hao wrote:
>>>> On 2023/9/25 22:55, Christoph Hellwig wrote:
>>>>> Before we add another new error handling mechanism we need to fix the
>>>>> old one first.  Hannes' work on not passing the scsi_cmnd to the various
>>>>> reset handlers hasn't made a lot of progress in the last five years and
>>>>> we'll need to urgently fix that first before adding even more
>>>>> complexity.
>>>>>
>>>> I observed Hannes's patches posted about one year ago, it has not been
>>>> applied yet. I don't know if he is still working on it.
>>>>
>>>> My patches do not depend much on that work, I think the conflict can be
>>>> solved fast between two changes.
>>>
>>> I think we want to figure out Hannes's patches first.
>>>
>>> For a new EH design we will want to be able to do multiple TMFs in parallel
>>> on the same host/target right?
>>>
>>
>> It's not necessary to do multiple TMFs in parallel, it's ok to make sure
>> each TMFs do not affect each other.
>>
>> For example, we have two devices: 0:0:0:0 and 0:0:0:1
>>
>> Both of them request device reset, they do not happened in parallel, but
>> would in serial. If 0:0:0:0 is performing device reset in progress, 0:0:0:1
>> just wait 0:0:0:0 to finish.
>>
> Well, not quite. Any higher-order TMFs are serialized by virtue of SCSI-EH, but command aborts (which also devolve down to TMFs on certain drivers) do run in parallel, and there we will be requiring multiple TMFs.
> 

It's best that multiple  TMFs can run in parallel, again, looking forwarding
to your changes.

> Cheers,
> 
> Hannes

