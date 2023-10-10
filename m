Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656717BF0B8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 04:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441851AbjJJCPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 22:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441824AbjJJCPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 22:15:17 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D777F93
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 19:15:15 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S4KBs75ZHzNp1M;
        Tue, 10 Oct 2023 10:11:17 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 10 Oct 2023 10:15:13 +0800
Message-ID: <f0e99e45-d374-199b-4fd2-1700d2f843ec@huawei.com>
Date:   Tue, 10 Oct 2023 10:15:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 0/4] SCSI: Fix issues between removing device and error
 handle
Content-Language: en-US
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <louhongxiang@huawei.com>
References: <20230928073543.3496394-1-haowenchao2@huawei.com>
From:   Wenchao Hao <haowenchao2@huawei.com>
In-Reply-To: <20230928073543.3496394-1-haowenchao2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000012.china.huawei.com (7.193.23.142)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
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
> Three issues are found:
> 1. statistic info printed at beginning of scsi_error_handler is wrong
> 2. device reset is not triggered
> 3. IO requeued to request_queue would be hang after error handle
> 

Hi Martin, would you help review these patches?

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

