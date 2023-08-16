Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331B777E000
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238720AbjHPLIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244268AbjHPLIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:08:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBA3E56
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:08:09 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQlgD5kYHzVk9b;
        Wed, 16 Aug 2023 19:06:00 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 19:08:04 +0800
Subject: Re: Fwd: ubi: fastmap: Fix a series of wear leveling problems
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Linux MTD <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <44f5a8f7-0bf4-c986-a0dc-dc12d0cb30ca@gmail.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <1ee21a88-0969-47f5-fa87-b5090fc7718f@huawei.com>
Date:   Wed, 16 Aug 2023 19:08:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <44f5a8f7-0bf4-c986-a0dc-dc12d0cb30ca@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/8/16 17:56, Bagas Sanjaya 写道:
Hi,
> Hi,
> 
> I notice a bug report with proposed fixes on Bugzilla [1]. Quoting from it
> (only the first problem that is quoted):
> 
>> Problem 1: large erase counter for single fastmap data PEB
>>
>> Config:
>> x86_64 qemu
>> flash: nandsim
>> CONFIG_MTD_UBI_WL_THRESHOLD=128
>> CONFIG_MTD_UBI_FASTMAP=y
>> ubi->beb_rsvd_pebs=0
>>
>> Running fsstress on ubifs for 3h(fastmap data PEB has large erase counter than others):
>> =========================================================
>> from              to     count      min      avg      max
>> ---------------------------------------------------------
>> 0        ..        9:        0        0        0        0
>> 10       ..       99:      532       84       92       99
>> 100      ..      999:    15787      100      147      229
>> 1000     ..     9999:       64     4699     4765     4826
>> 10000    ..    99999:        0        0        0        0
>> 100000   ..      inf:        1   272935   272935   272935
>> ---------------------------------------------------------
>> Total               :    16384       84      180   272935
>> PEB 8031(ec=272935) is always taken for fastmap data.
>>
>> After fix, running fsstress on ubifs for 12h(no pool reservation), no individual peb has big erase counter:
>> =========================================================
>> from              to     count      min      avg      max
>> ---------------------------------------------------------
>> 0        ..        9:        0        0        0        0
>> 10       ..       99:        0        0        0        0
>> 100      ..      999:    16320      609      642      705
>> 1000     ..     9999:        0        0        0        0
>> 10000    ..    99999:       64    18176    18234    18303
>> 100000   ..      inf:        0        0        0        0
>> ---------------------------------------------------------
>> Total               :    16384      609      710    18303
> 
> See Bugzilla for the full thread (with other problems mentioned) and
> attached patch series that fixes them.
> 
> Zhihao: I asked you on BZ to send your patches to linux-mtd list,
> but you didn't respond there. Would you like to send them for
> review?
> 

Sorry for the delayed response. Yes, I have sent the fix patches in 
https://patchwork.ozlabs.org/project/linux-mtd/list/?series=368534.
Any suggestions are welcomed.


> Thanks.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217787
> 

