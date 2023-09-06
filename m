Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0400793ADE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238324AbjIFLPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237140AbjIFLPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:15:11 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EC6A8;
        Wed,  6 Sep 2023 04:15:06 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Rgfp81mp8zMl5s;
        Wed,  6 Sep 2023 19:11:44 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 6 Sep 2023 19:15:03 +0800
Message-ID: <7ec75e40-671b-e080-9e7b-2afd5edb25db@huawei.com>
Date:   Wed, 6 Sep 2023 19:15:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH v2 00/18] scsi: scsi_error: Introduce new error handle
 mechanism
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     Hannes Reinecke <hare@suse.de>, <linux-kernel@vger.kernel.org>,
        <louhongxiang@huawei.com>, <lixiaokeng@huawei.com>
References: <20230901094127.2010873-1-haowenchao2@huawei.com>
 <b8350de1-6ac8-4d5f-aaa7-7b03e2f7aa93@oracle.com>
From:   "haowenchao (C)" <haowenchao2@huawei.com>
In-Reply-To: <b8350de1-6ac8-4d5f-aaa7-7b03e2f7aa93@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2023/9/6 8:22, Mike Christie wrote:
> On 9/1/23 4:41 AM, Wenchao Hao wrote:
>> It's unbearable for systems with large scale scsi devices share HBAs to
>> block all devices' IOs when handle error commands, we need a new error
>> handle mechanism to address this issue.
>>
>> I consulted about this issue a year ago, the discuss link can be found in
>> refenence. Hannes replied about why we have to block the SCSI host
>> then perform error recovery kindly. I think it's unnecessary to block
>> SCSI host for all drivers and can try a small level recovery(LUN based for
>> example) first to avoid block the SCSI host.
>>
>> The new error handle mechanism introduced in this patchset has been
>> developed and tested with out self developed hardware since one year
>> ago, now we want this mechanism can be used by more drivers.
>>
>> Drivers can decide if using the new error handle mechanism and how to
>> handle error commands when scsi_device are scanned,the new mechanism
>> makes SCSI error handle more flexible.
>>
>> SCSI error recovery strategy after blocking host's IO is mainly
>> following steps:
>>
>> - LUN reset
>> - Target reset
>> - Bus reset
>> - Host reset
>>
>> Some drivers did not implement callbacks for host reset, it's unnecessary
>> to block host's IO for these drivers. For example, smartpqi only registered
>> device reset, if device reset failed, it's meaningless to fallback to target
>> reset, bus reset or host reset any more, because these steps would also
>> failed.
>>
>> Here are some drivers we concerned:(there are too many kinds of drivers
>> to figure out, so here I just list some drivers I am familiar with)
>>
>> +-------------+--------------+--------------+-----------+------------+
>> |  drivers    | device_reset | target_reset | bus_reset | host_reset |
>> +-------------+--------------+--------------+-----------+------------+
>> | mpt3sas     |     Y        |     Y        |    N      |    Y       |
>> +-------------+--------------+--------------+-----------+------------+
>> | smartpqi    |     Y        |     N        |    N      |    N       |
>> +-------------+--------------+--------------+-----------+------------+
>> | megaraidsas |     N        |     Y        |    N      |    Y       |
>> +-------------+--------------+--------------+-----------+------------+
>> | virtioscsi  |     Y        |     N        |    N      |    N       |
>> +-------------+--------------+--------------+-----------+------------+
>> | iscsi_tcp   |     Y        |     Y        |    N      |    N       |
>> +-------------+--------------+--------------+-----------+------------+
>> | hisisas     |     Y        |     Y        |    N      |    N       |
>> +-------------+--------------+--------------+-----------+------------+
>>
>> For LUN based error handle, when scsi command is classified as error,
>> we would block the scsi device's IO and try to recover this scsi
>> device, if still can not recover all error commands, it might
>> fallback to target or host level recovery.
>>
>> It's same for target based error handle, but target based error handle
>> would block the scsi target's IO then try to recover the error commands
>> of this target.
>>
>> The first patch defines basic framework to support LUN/target based error
>> handle mechanism, three key operations are abstracted which are:
>>   - add error command
>>   - wake up error handle
>>   - block IOs when error command is added and recoverying.
>>
>> Drivers can implement these three function callbacks and setup to SCSI
>> middle level; I also add a general LUN/target based error handle strategy
>> which can be called directly from drivers to implement LUN/tartget based
>> error handle.
>>
>> The changes of SCSI middle level's error handle are tested with scsi_debug
>> which support single LUN error injection, the scsi_debug patches can be
>> found in reference, following scenarios are tested.
>>
>> Scenario1: LUN based error handle is enabled:
>> +-----------+---------+-------------------------------------------------------+
>> | lun reset | TUR     | Desired result                                        |
>> + --------- + ------- + ------------------------------------------------------+
>> | success   | success | retry or finish with  EIO(may offline disk)           |
>> + --------- + ------- + ------------------------------------------------------+
>> | success   | fail    | fallback to host  recovery, retry or finish with      |
>> |           |         | EIO(may offline disk)                                 |
> 
> 
> I didn't get this part about when we offline the disk now. For this LUN case, is
> it if the driver has called scsi_device_setup_eh with the fallback arg with false?
> If so why doesn't it just try target reset -> bus reset -> host reset like before?
> 
> 

There are two scenarios to offline disk when LUN reset succeed and TUR failed:

1. The driver has called scsi_device_setup_eh with the fallback arg with false.
    Drivers who did not implement eh_xxx_reset for target reset, bus reset and
    host reset should set fallback to false because these steps would failed,
    so it's meaningless to try target reset -> bus reset -> host reset any more.

2. The disk would also be offlined by sd_eh_action() defined in sd.c when error
    recovery succeed but command times out contiuously.

int sd_eh_action(struct scsi_cmnd *scmd, int eh_disp) {
	...
	/*
	* If the device keeps failing read/write commands but TEST UNIT
	* READY always completes successfully we assume that medium
	* access is no longer possible and take the device offline.
	*/
	if (sdkp->medium_access_timed_out >= sdkp->max_medium_access_timeouts) {
			scmd_printk(KERN_ERR, scmd,
						"Medium access timeout failure. Offlining disk!\n");
			mutex_lock(&sdev->state_mutex);
			scsi_device_set_state(sdev, SDEV_OFFLINE);
			mutex_unlock(&sdev->state_mutex);

			return SUCCESS;
	}
	...
}

>>From a high level I have the following questions/comments:
> 
> 1. The modparam and drivers calling scsi_device_setup_eh/scsi_device_clear_eh
> seem uneeded.
> 
> If the driver supports performing multiple TMFs/resets in parallel then why
> not always enable it?
> 

Not all hardware/drivers support performing multiple TMFs/resets in parallel,
so I think it is necessary to call scsi_device_setup_eh/scsi_device_clear_eh
in specific drivers.
As to modparam, my original intention is let administrators determine whether
to enable LUN/target based error handle since it's a feature for host with
large scale of scsi devices.
If most users think the modparam is unnecessary, I would remove it.

> 2. You probably need to work more closely for some of the drivers. For the iscsi
> patch, we would want to allocate a tmf per device and per target, or if a cmd
> timesout on a second lun, that will always fail since the iscsi host has only
> one tmf preallocated and it would be in use by the first reset.
> 

Sorry I did not check iscsi's device/target reset in detail.

> For the other drivers, did you review what they support? If so, how many drivers
> can you just turn this on for? Or what drivers did you test so far?
> 
I reviewed the drivers changed in this patchset briefly, and it seems ok for
these drivers to turn this on. The tests are in progress but not finished now.
I would post the results in future.

My intention of posting this patchset is want people discuss about this new
error recovery mechanism. As to drivers, we would test drivers one by one, and
we are welcome others join us to analyze and test more drivers with these
