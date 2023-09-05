Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B49792B8E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245415AbjIEQzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244862AbjIEBc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 21:32:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF5CCC6;
        Mon,  4 Sep 2023 18:32:23 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rfny22qK6zrSbh;
        Tue,  5 Sep 2023 09:30:34 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 5 Sep 2023 09:32:20 +0800
Message-ID: <2e307135-4dba-497a-14ec-bc6f03fb4f97@huawei.com>
Date:   Tue, 5 Sep 2023 09:32:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH v2 00/18] scsi: scsi_error: Introduce new error handle
 mechanism
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Mike Christie <michael.christie@oracle.com>
CC:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        John Garry <john.g.garry@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <louhongxiang@huawei.com>
References: <20230901094127.2010873-1-haowenchao2@huawei.com>
From:   "haowenchao (C)" <haowenchao2@huawei.com>
In-Reply-To: <20230901094127.2010873-1-haowenchao2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/1 17:41, Wenchao Hao wrote:
> It's unbearable for systems with large scale scsi devices share HBAs to
> block all devices' IOs when handle error commands, we need a new error
> handle mechanism to address this issue.
> 
> I consulted about this issue a year ago, the discuss link can be found in
> refenence. Hannes replied about why we have to block the SCSI host
> then perform error recovery kindly. I think it's unnecessary to block
> SCSI host for all drivers and can try a small level recovery(LUN based for
> example) first to avoid block the SCSI host.
> 
> The new error handle mechanism introduced in this patchset has been
> developed and tested with out self developed hardware since one year
> ago, now we want this mechanism can be used by more drivers.
> 
> Drivers can decide if using the new error handle mechanism and how to
> handle error commands when scsi_device are scanned,the new mechanism
> makes SCSI error handle more flexible.

Hi, Hannes and Mike, would you help take a look at these changes?

> 
> SCSI error recovery strategy after blocking host's IO is mainly
> following steps:
> 
> - LUN reset
> - Target reset
> - Bus reset
> - Host reset
> 
> Some drivers did not implement callbacks for host reset, it's unnecessary
> to block host's IO for these drivers. For example, smartpqi only registered
> device reset, if device reset failed, it's meaningless to fallback to target
> reset, bus reset or host reset any more, because these steps would also
> failed.
> 
> Here are some drivers we concerned:(there are too many kinds of drivers
> to figure out, so here I just list some drivers I am familiar with)
> 
> +-------------+--------------+--------------+-----------+------------+
> |  drivers    | device_reset | target_reset | bus_reset | host_reset |
> +-------------+--------------+--------------+-----------+------------+
> | mpt3sas     |     Y        |     Y        |    N      |    Y       |
> +-------------+--------------+--------------+-----------+------------+
> | smartpqi    |     Y        |     N        |    N      |    N       |
> +-------------+--------------+--------------+-----------+------------+
> | megaraidsas |     N        |     Y        |    N      |    Y       |
> +-------------+--------------+--------------+-----------+------------+
> | virtioscsi  |     Y        |     N        |    N      |    N       |
> +-------------+--------------+--------------+-----------+------------+
> | iscsi_tcp   |     Y        |     Y        |    N      |    N       |
> +-------------+--------------+--------------+-----------+------------+
> | hisisas     |     Y        |     Y        |    N      |    N       |
> +-------------+--------------+--------------+-----------+------------+
> 
> For LUN based error handle, when scsi command is classified as error,
> we would block the scsi device's IO and try to recover this scsi
> device, if still can not recover all error commands, it might
> fallback to target or host level recovery.
> 
> It's same for target based error handle, but target based error handle
> would block the scsi target's IO then try to recover the error commands
> of this target.
> 
> The first patch defines basic framework to support LUN/target based error
> handle mechanism, three key operations are abstracted which are:
>   - add error command
>   - wake up error handle
>   - block IOs when error command is added and recoverying.
> 
> Drivers can implement these three function callbacks and setup to SCSI
> middle level; I also add a general LUN/target based error handle strategy
> which can be called directly from drivers to implement LUN/tartget based
> error handle.
> 
> The changes of SCSI middle level's error handle are tested with scsi_debug
> which support single LUN error injection, the scsi_debug patches can be
> found in reference, following scenarios are tested.
> 
> Scenario1: LUN based error handle is enabled:
> +-----------+---------+-------------------------------------------------------+
> | lun reset | TUR     | Desired result                                        |
> + --------- + ------- + ------------------------------------------------------+
> | success   | success | retry or finish with  EIO(may offline disk)           |
> + --------- + ------- + ------------------------------------------------------+
> | success   | fail    | fallback to host  recovery, retry or finish with      |
> |           |         | EIO(may offline disk)                                 |
> + --------- + ------- + ------------------------------------------------------+
> | fail      | NA      | fallback to host  recovery, retry or finish with      |
> |           |         | EIO(may offline disk)                                 |
> + --------- + ------- + ------------------------------------------------------+
> 
> Scenario2: target based error handle is enabled:
> +-----------+---------+--------------+---------+------------------------------+
> | lun reset | TUR     | target reset | TUR     | Desired result               |
> +-----------+---------+--------------+---------+------------------------------+
> | success   | success | NA           | NA      | retry or finish with         |
> |           |         |              |         | EIO(may offline disk)        |
> +-----------+---------+--------------+---------+------------------------------+
> | success   | fail    | success      | success | retry or finish with         |
> |           |         |              |         | EIO(may offline disk)        |
> +-----------+---------+--------------+---------+------------------------------+
> | fail      | NA      | success      | success | retry or finish with         |
> |           |         |              |         | EIO(may offline disk)        |
> +-----------+---------+--------------+---------+------------------------------+
> | fail      | NA      | success      | fail    | fallback to host recovery,   |
> |           |         |              |         | retry or finish with EIO(may |
> |           |         |              |         | offline disk)                |
> +-----------+---------+--------------+---------+------------------------------+
> | fail      | NA      | fail         | NA      | fallback to host  recovery,  |
> |           |         |              |         | retry or finish with EIO(may |
> |           |         |              |         | offline disk)                |
> +-----------+---------+--------------+---------+------------------------------+
> 
> Scenario3: both LUN and target based error handle are enabled:
> +-----------+---------+--------------+---------+------------------------------+
> | lun reset | TUR     | target reset | TUR     | Desired result               |
> +-----------+---------+--------------+---------+------------------------------+
> | success   | success | NA           | NA      | retry or finish with         |
> |           |         |              |         | EIO(may offline disk)        |
> +-----------+---------+--------------+---------+------------------------------+
> | success   | fail    | success      | success | lun recovery fallback to     |
> |           |         |              |         | target recovery, retry or    |
> |           |         |              |         | finish with EIO(may offline  |
> |           |         |              |         | disk                         |
> +-----------+---------+--------------+---------+------------------------------+
> | fail      | NA      | success      | success | lun recovery fallback to     |
> |           |         |              |         | target recovery, retry or    |
> |           |         |              |         | finish with EIO(may offline  |
> |           |         |              |         | disk                         |
> +-----------+---------+--------------+---------+------------------------------+
> | fail      | NA      | success      | fail    | lun recovery fallback to     |
> |           |         |              |         | target recovery, then fall   |
> |           |         |              |         | back to host recovery, retry |
> |           |         |              |         | or fhinsi with EIO(may       |
> |           |         |              |         | offline disk)                |
> +-----------+---------+--------------+---------+------------------------------+
> | fail      | NA      | fail         | NA      | lun recovery fallback to     |
> |           |         |              |         | target recovery, then fall   |
> |           |         |              |         | back to host recovery, retry |
> |           |         |              |         | or fhinsi with EIO(may       |
> |           |         |              |         | offline disk)                |
> +-----------+---------+--------------+---------+------------------------------+
> 
> References: https://lore.kernel.org/linux-scsi/20230815122316.4129333-1-haowenchao2@huawei.com/
> References: https://lore.kernel.org/linux-scsi/71e09bb4-ff0a-23fe-38b4-fe6425670efa@huawei.com/
> 
> Wenchao Hao (19):
>    scsi: scsi_error: Define framework for LUN/target based error handle
>    scsi: scsi_error: Move complete variable eh_action from shost to sdevice
>    scsi: scsi_error: Check if to do reset in scsi_try_xxx_reset
>    scsi: scsi_error: Add helper scsi_eh_sdev_stu to do START_UNIT
>    scsi: scsi_error: Add helper scsi_eh_sdev_reset to do lun reset
>    scsi: scsi_error: Add flags to mark error handle steps has done
>    scsi: scsi_error: Add helper to handle scsi device's error command list
>    scsi: scsi_error: Add a general LUN based error handler
>    scsi: core: increase/decrease target_busy without check can_queue
>    scsi: scsi_error: Add helper to handle scsi target's error command list
>    scsi: scsi_error: Add a general target based error handler
>    scsi: scsi_debug: Add param to control LUN bassed error handler
>    scsi: scsi_debug: Add param to control target based error handle
>    scsi: mpt3sas: Add param to control LUN based error handle
>    scsi: mpt3sas: Add param to control target based error handle
>    scsi: smartpqi: Add param to control LUN based error handle
>    scsi: megaraid_sas: Add param to control target based error handle
>    scsi: virtio_scsi: Add param to control LUN based error handle
>    scsi: iscsi_tcp: Add param to control LUN based error handle
> 
>   drivers/scsi/iscsi_tcp.c                  |  20 +
>   drivers/scsi/megaraid/megaraid_sas_base.c |  20 +
>   drivers/scsi/mpt3sas/mpt3sas_scsih.c      |  28 +
>   drivers/scsi/scsi_debug.c                 |  24 +
>   drivers/scsi/scsi_error.c                 | 756 ++++++++++++++++++++--
>   drivers/scsi/scsi_lib.c                   |  23 +-
>   drivers/scsi/scsi_priv.h                  |  18 +
>   drivers/scsi/smartpqi/smartpqi_init.c     |  14 +
>   drivers/scsi/virtio_scsi.c                |  16 +-
>   include/scsi/scsi_device.h                |  97 +++
>   include/scsi/scsi_eh.h                    |   8 +
>   include/scsi/scsi_host.h                  |   2 -
>   12 files changed, 963 insertions(+), 63 deletions(-)
> 

