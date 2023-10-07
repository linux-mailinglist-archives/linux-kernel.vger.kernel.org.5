Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F887BC681
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 11:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbjJGJqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 05:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbjJGJqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 05:46:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9485AC2;
        Sat,  7 Oct 2023 02:46:08 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S2gLW6p4czNnyw;
        Sat,  7 Oct 2023 17:42:11 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 7 Oct 2023 17:46:05 +0800
Message-ID: <ac995e80-f71b-4b98-7264-56ce55e61cc3@huawei.com>
Date:   Sat, 7 Oct 2023 17:46:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 0/4] SCSI: Fix issues between removing device and error
 handle
Content-Language: en-US
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <louhongxiang@huawei.com>
References: <20230928073543.3496394-1-haowenchao2@huawei.com>
From:   Wenchao Hao <haowenchao2@huawei.com>
In-Reply-To: <20230928073543.3496394-1-haowenchao2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000012.china.huawei.com (7.193.23.142)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/28 15:35, Wenchao Hao wrote:
> I am testing SCSI error handle with my previous scsi_debug error
> injection patches, and found some issues when removing device and
> error handler happened together.
> 
> These issues are triggered because devices in removing would be skipped
> when calling shost_for_each_device().
> 

ping...

> Three issues are found:
> 1. statistic info printed at beginning of scsi_error_handler is wrong
> 2. device reset is not triggered
> 3. IO requeued to request_queue would be hang after error handle
> 
> V2:
>    - Fix IO hang by run all devices' queue after error handler
>    - Do not modify shost_for_each_device() directly but add a new
>      helper to iterate devices but do not skip devices in removing
> 
> Wenchao Hao (4):
>    scsi: core: Add new helper to iterate all devices of host
>    scsi: scsi_error: Fix wrong statistic when print error info
>    scsi: scsi_error: Fix device reset is not triggered
>    scsi: scsi_core:  Fix IO hang when device removing
> 
>   drivers/scsi/scsi.c        | 43 +++++++++++++++++++++++++-------------
>   drivers/scsi/scsi_error.c  |  4 ++--
>   drivers/scsi/scsi_lib.c    |  2 +-
>   include/scsi/scsi_device.h | 25 +++++++++++++++++++---
>   4 files changed, 53 insertions(+), 21 deletions(-)
> 

