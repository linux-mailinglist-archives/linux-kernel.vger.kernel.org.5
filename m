Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD06782A89
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbjHUNb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjHUNb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:31:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE06A8F;
        Mon, 21 Aug 2023 06:31:23 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RTtcw27jQzrSxK;
        Mon, 21 Aug 2023 21:29:52 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 21 Aug 2023 21:31:19 +0800
Message-ID: <1a141fc4-b362-4f05-8881-abeed34396c2@huawei.com>
Date:   Mon, 21 Aug 2023 21:31:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 00/13] scsi: Support LUN/target based error handle
Content-Language: en-US
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <error27@gmail.com>, <louhongxiang@huawei.com>
References: <20230723234422.1629194-1-haowenchao2@huawei.com>
From:   "haowenchao (C)" <haowenchao2@huawei.com>
In-Reply-To: <20230723234422.1629194-1-haowenchao2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/24 7:44, Wenchao Hao wrote:
> The origin error handle would set host to recovery state and perform
> error recovery operations, and makes all LUNs which share a same host
> can not handle IOs. This phenomenon is unbearable for systems which
> deploy many LUNs in one HBA.
> 
> This patchset introduce support for LUN/target based error handle,
> drivers can chose if to implement it. They can implement LUN, target or
> both of LUN and target based error handle by their own error handle
> strategy. The first patch defined this framework, it abstract three
> key operations which are: add error command, wake up error handle, block
> ios when error command is added and recoverying. Drivers should
> implement these three function callbacks and setup to SCSI middle level.
> 

Ping...

Is anyone reviewing these changes?

> Besides the basic framework, this patchset also add a basic LUN/target
> based error handle strategy.
> 
> For LUN based eh, it would try check sense, start unit and reset LUN,
> if all above steps can not recovery all error commands, fallback to
> further recovery like tartget based (if implemented) or host based error
> handle.
> 
> It's same for tartget based eh, it would try check sense, start unit,
> reset LUN and reset target. If all above steps can not recovery all error
> commands, fallback to further recovery which is host based error handle.
> 
> This patchset is tested by scsi_debug which support single LUN error
> injection, the scsi_debug patches is here:
> 
> https://lore.kernel.org/linux-scsi/20230723234105.1628982-1-haowenchao2@huawei.com/T/#t
> 
> Wenchao Hao (13):
>    scsi: Define basic framework for driver LUN/target based error handle
>    scsi:scsi_error: Move complete variable eh_action from shost to sdevice
>    scsi:scsi_error: Check if to do reset in scsi_try_xxx_reset
>    scsi:scsi_error: Add helper scsi_eh_sdev_stu to do START_UNIT
>    scsi:scsi_error: Add helper scsi_eh_sdev_reset to do lun reset
>    scsi:scsi_error: Add flags to mark error handle steps has done
>    scsi:scsi_error: Define helper to perform LUN based error handle
>    scsi:scsi_error: Add LUN based error handler based previous helper
>    scsi:core: increase/decrease target_busy without check can_queue
>    scsi:scsi_error: Define helper to perform target based error handle
>    scsi:scsi_error: Add target based error handler based previous helper
>    scsi:scsi_debug: Add param to control if setup LUN based error handle
>    scsi:scsi_debug: Add param to control if setup target based error handle
> 
>   drivers/scsi/scsi_debug.c  |  19 +
>   drivers/scsi/scsi_error.c  | 705 ++++++++++++++++++++++++++++++++++---
>   drivers/scsi/scsi_lib.c    |  23 +-
>   drivers/scsi/scsi_priv.h   |  20 ++
>   include/scsi/scsi_device.h |  97 +++++
>   include/scsi/scsi_eh.h     |   4 +
>   include/scsi/scsi_host.h   |   2 -
>   7 files changed, 813 insertions(+), 57 deletions(-)
> 

