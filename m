Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717017BD42E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 09:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345376AbjJIHTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 03:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbjJIHTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 03:19:30 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D82CA4;
        Mon,  9 Oct 2023 00:19:28 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4S3r1z3WFVz1M9Gb;
        Mon,  9 Oct 2023 15:16:55 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 9 Oct 2023 15:19:25 +0800
Message-ID: <89365bd3-b4b0-de2d-f863-afbaad118649@huawei.com>
Date:   Mon, 9 Oct 2023 15:19:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 10/10] scsi: scsi_debug: Add param to control sdev's
 allow_restart
Content-Language: en-US
To:     <dgilbert@interlog.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <louhongxiang@huawei.com>
References: <20230922092906.2645265-1-haowenchao2@huawei.com>
 <20230922092906.2645265-11-haowenchao2@huawei.com>
 <d61e88d3-e1b7-44e0-ba9b-f633be0b5b30@interlog.com>
From:   Wenchao Hao <haowenchao2@huawei.com>
In-Reply-To: <d61e88d3-e1b7-44e0-ba9b-f633be0b5b30@interlog.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000012.china.huawei.com (7.193.23.142)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/9 7:17, Douglas Gilbert wrote:
> On 2023-09-22 05:29, Wenchao Hao wrote:
>> Add new module param "allow_restart" to control if setup
>> scsi_device's allow_restart flag. This is used to test scsi
>> command finished with sense_key 0x6, asc 0x4 and ascq 0x2
>>
>> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
> 
> Hi,
> Looked at this and verified that the allow_restart flag of scsi_debug
> devices (disks ?) is usually 0 and when the scsi_debug module is
> started with allow_restart=1 then the allow_restart flag does indeed
> change to 1. For example:
>     # cat /sys/class/scsi_disk/1\:0\:0\:0/allow_restart
>     1
> 
> That ASC/ASCQ code means: "Logical unit not ready, initializing command
> required" according to my library. Played around with sg_start but didn't
> see any change in how it reacts. According to scsi_device.h that flag's
> description is: "issue START_UNIT in error handler" which implies it
> changes how the EH handler reacts.
> 
> Perhaps the 3 line patch description could say a little more about how
> to use this new parameter...

Sorry I did not write in detail. As you mentioned above, this is to
determine if to trigger error. I would update the commit message to
following lines:

Add new module param "allow_restart" to control if setup scsi_device's
allow_restart flag, this flag determines if trigger EH after command
finished with sense_key 0x6, asc 0x4 and ascq 0x2, EH would be triggered
if allow_restart=1 in this condition.

The new param can be used with error inject added in patch6 to test how
commands finished with sense_key 0x6, asc 0x4 and ascq 0x2 are handled.

> 
> Tested-by: Douglas Gilbert <dgilbert@interlog.com>
> 
> <snip>
> 
> 
> 
> 
> 

