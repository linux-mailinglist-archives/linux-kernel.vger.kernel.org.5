Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217877807EF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352740AbjHRJFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359037AbjHRJEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:04:30 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C3C3C17;
        Fri, 18 Aug 2023 02:04:26 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RRwnm4fXdztSD2;
        Fri, 18 Aug 2023 17:00:44 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 18 Aug 2023 17:04:22 +0800
Message-ID: <71b9f3c2-0228-b52d-3f6e-25b8b21df5a7@huawei.com>
Date:   Fri, 18 Aug 2023 17:04:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 0/9] scsi:scsi_debug: Add error injection for single
 device
Content-Language: en-US
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <louhongxiang@huawei.com>
References: <20230815122316.4129333-1-haowenchao2@huawei.com>
From:   "haowenchao (C)" <haowenchao2@huawei.com>
In-Reply-To: <20230815122316.4129333-1-haowenchao2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/15 20:23, Wenchao Hao wrote:
> The original error injection mechanism was based on scsi_host which
> could not inject fault for a single SCSI device.
> 
> This patchset provides the ability to inject errors for a single
> SCSI device. Now we supports inject timeout errors, queuecommand
> errors, and hostbyte, driverbyte, statusbyte, and sense data for
> specific SCSI Command. Two new error injection is defined to make
> abort command or reset LUN failed.
> 
> Besides error injection for single device, this patchset add a
> new interface to make reset target failed for each scsi_target.
> 
> The first two patch add an debugfs interface to add and inquiry single
> device's error injection info; the third patch defined how to remove
> an injection which has been added. The following 5 patches use the
> injection info and generate the related error type. The last one just
> Add a new interface to make reset target failed.
> 

Friendly ping...

> V4:
>    - Fix BUG_ON triggered by schedule in atomic context when rmmod scsi_debug
>      Closes: https://lore.kernel.org/oe-lkp/202308031027.5941ce5f-oliver.sang@intel.com
> 
> V3:
>    - Add two more error types to fail abort command and lun reset
>    - Fix memleak when rmmod scsi_debug without clearing errors injected
>    - Fix memkeak because did not implement release in sdebug_error_fops
>    - Fix possible NULL point access in scsi_debug_slave_destroy
>    - Move specific error type's description to each single patch which
>      implement this error type
>    - Add interface to make target reset fail
> 
> V2:
>    - Using debugfs rather than sysfs attribute interface to manage error
> 
> Wenchao Hao (9):
>    scsi:scsi_debug: create scsi_debug directory in the debugfs filesystem
>    scsi:scsi_debug: Add interface to manage single device's error inject
>    scsi:scsi_debug: Define grammar to remove added error injection
>    scsi:scsi_debug: timeout command if the error is injected
>    scsi:scsi_debug: Return failed value if the error is injected
>    scsi:scsi_debug: set command's result and sense data if the error is injected
>    scsi:scsi_debug: Add new error injection abort failed
>    scsi:scsi_debug: Add new error injection reset lun failed
>    scsi:scsi_debug: Add debugfs interface to fail target reset
> 
>   drivers/scsi/scsi_debug.c | 512 +++++++++++++++++++++++++++++++++++++-
>   1 file changed, 507 insertions(+), 5 deletions(-)
> 

