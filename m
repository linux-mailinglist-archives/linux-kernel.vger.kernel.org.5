Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEE777D844
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 04:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241223AbjHPCPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 22:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241208AbjHPCOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 22:14:43 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35CEC1;
        Tue, 15 Aug 2023 19:14:41 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RQWrb2Cc2z1GDY1;
        Wed, 16 Aug 2023 10:13:19 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 10:14:38 +0800
Message-ID: <78ad90a8-79f1-7930-302e-28072aedd0fe@huawei.com>
Date:   Wed, 16 Aug 2023 10:14:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 00/13] scsi: Support LUN/target based error handle
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <error27@gmail.com>, <louhongxiang@huawei.com>
References: <20230723234422.1629194-1-haowenchao2@huawei.com>
 <1eb055e9-6343-260c-de04-c08d8fb24789@huawei.com>
 <bbf42f55-1f85-9d9f-db72-1d1c08d254ea@acm.org>
From:   "haowenchao (C)" <haowenchao2@huawei.com>
In-Reply-To: <bbf42f55-1f85-9d9f-db72-1d1c08d254ea@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/15 23:48, Bart Van Assche wrote:
> On 8/15/23 07:17, haowenchao (C) wrote:
>> We can reduce probability of blocking whole host when handle error
>> commands with this patchset, which is important for servers which
>> deploy large scale disks. And the new error handler is not enabled
>> default, so it would not affect drivers which do not need it.
> 
> Which drivers need this new error handler? I don't see any changes for
> SCSI drivers in this patch series other than scsi_debug. Has this patch
> series perhaps been developed for a pass-through driver between virtual
> machine guests and their host? If so, has it been considered to
> configure pass-through such that there is one disk per SCSI host instead
> of multiple?
> 

I tested the error hander with our private hardware(the driver code was
not pushed in mainline), as discussed, megaraid_sas, mpt3sas, smartpqi,
hiraid and hisi_sas need this new error handler too, while hisi_sas
needs more steps to using it because it is tightly coupled with
libsas/libata. I want the basic frame to be reviewed first, so just
modify the scsi_debug, which is accessible for everyone and easy to
simulate various kind of error.

I do not know how pass-through driver between virtual machine guests
and their host work, do you mean virtio-scsi in guests OS?
Can you describe more?

Thanks.

> Thanks,
> 
> Bart.
> 
> 

